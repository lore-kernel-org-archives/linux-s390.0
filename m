From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/3] vfio: ccw: handle chp event
Date: Thu, 11 Jan 2018 04:04:21 +0100
Message-ID: <20180111030421.31418-4-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This adds channel path related event handler for vfio-ccw.
This also signals userland when there is a chp event.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 51 +++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_fsm.c     | 22 ++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  3 +++
 3 files changed, 76 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0b2894..5f01f3e6742d 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -17,6 +17,7 @@
 
 #include <asm/isc.h>
 
+#include "chp.h"
 #include "ioasm.h"
 #include "css.h"
 #include "vfio_ccw_private.h"
@@ -88,6 +89,15 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		private->state = VFIO_CCW_STATE_IDLE;
 }
 
+static void vfio_ccw_sch_chp_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private =
+		container_of(work, struct vfio_ccw_private, chp_work);
+
+	if (private->chp_trigger)
+		eventfd_signal(private->chp_trigger, 1);
+}
+
 /*
  * Css driver callbacks
  */
@@ -130,6 +140,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 		goto out_disable;
 
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
+	INIT_WORK(&private->chp_work, vfio_ccw_sch_chp_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -202,6 +213,45 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 	return 0;
 }
 
+static int vfio_ccw_sch_chp_event(struct subchannel *sch,
+				  struct chp_link *link, int event)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	int mask = chp_ssd_get_mask(&sch->ssd_info, link);
+
+	/* move these checks around? */
+	if (!private || !mask)
+		return 0;
+
+	if (cio_update_schib(sch))
+		return -ENODEV;
+
+	switch (event) {
+	case CHP_VARY_OFF:
+		sch->opm &= ~mask;
+		sch->lpm &= ~mask;
+		/* TODO: terminate current I/O on path. */
+		break;
+	case CHP_VARY_ON:
+		sch->opm |= mask;
+		sch->lpm |= mask;
+		break;
+	case CHP_OFFLINE:
+		/* TODO: terminate current I/O on path. */
+		break;
+	case CHP_ONLINE:
+		sch->lpm |= mask & sch->opm;
+		break;
+	default:
+		/* Not possible? */
+		return 0;
+	}
+
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_UPDATE_CHP);
+
+	return 0;
+}
+
 static struct css_device_id vfio_ccw_sch_ids[] = {
 	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
 	{ /* end of list */ },
@@ -219,6 +269,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.remove = vfio_ccw_sch_remove,
 	.shutdown = vfio_ccw_sch_shutdown,
 	.sch_event = vfio_ccw_sch_event,
+	.chp_event = vfio_ccw_sch_chp_event,
 };
 
 static int __init vfio_ccw_sch_init(void)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index be081ccabea3..c400021134cb 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -188,6 +188,23 @@ static void fsm_update_subch(struct vfio_ccw_private *private,
 	       sizeof(sch->schib));
 }
 
+static void fsm_update_chp(struct vfio_ccw_private *private,
+			   enum vfio_ccw_event event)
+{
+	queue_work(vfio_ccw_work_q, &private->chp_work);
+
+}
+
+static void fsm_update_chp_busy(struct vfio_ccw_private *private,
+				enum vfio_ccw_event event)
+{
+	/*
+	 * TODO:
+	 * If we are having I/O on the current path, do
+	 * extra handling?
+	 */
+}
+
 /*
  * Device statemachine
  */
@@ -197,29 +214,34 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
 		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
+		[VFIO_CCW_EVENT_UPDATE_CHP]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
+		[VFIO_CCW_EVENT_UPDATE_CHP]	= fsm_update_chp,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
+		[VFIO_CCW_EVENT_UPDATE_CHP]	= fsm_update_chp,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
+		[VFIO_CCW_EVENT_UPDATE_CHP]	= fsm_update_chp,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
+		[VFIO_CCW_EVENT_UPDATE_CHP]	= fsm_update_chp_busy,
 	},
 };
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index da86f82dd7b9..e3bdb90555fb 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -35,6 +35,7 @@
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @chp_trigger: eventfd ctx for signaling userspace chp event
  * @io_work: work for deferral process of I/O handling
+ * @chp_work: work for deferral process of chp event
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -53,6 +54,7 @@ struct vfio_ccw_private {
 	struct eventfd_ctx	*io_trigger;
 	struct eventfd_ctx	*chp_trigger;
 	struct work_struct	io_work;
+	struct work_struct	chp_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
@@ -81,6 +83,7 @@ enum vfio_ccw_event {
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
 	VFIO_CCW_EVENT_UPDATE_SUBCH,
+	VFIO_CCW_EVENT_UPDATE_CHP,
 	/* last element! */
 	NR_VFIO_CCW_EVENTS
 };
-- 
2.13.5
