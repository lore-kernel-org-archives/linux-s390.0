From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH 07/10] vfio: ccw: Introduce the INIT event
Date: Thu, 19 Apr 2018 16:48:10 +0200
Message-ID: <1524149293-12658-8-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

The VFIO_CCW_EVENT_INIT event allows to export the initial state
into the FSM.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 26 +++++++++++---------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 21 +++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     | 11 -----------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 4 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1c9422a..f6e7def1 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -116,31 +116,27 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
 	if (!private)
 		return -ENOMEM;
+
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 	mutex_init(&private->state_mutex);
-
-	spin_lock_irq(sch->lock);
-	private->state = VFIO_CCW_STATE_NOT_OPER;
-	sch->isc = VFIO_CCW_ISC;
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	spin_unlock_irq(sch->lock);
-	if (ret)
-		goto out_free;
+	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
+	INIT_WORK(&private->event_work, vfio_ccw_sch_event_todo);
+	atomic_set(&private->avail, 1);
 
 	ret = vfio_ccw_mdev_reg(sch);
 	if (ret)
-		goto out_disable;
+		goto out_free;
 
-	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
-	INIT_WORK(&private->event_work, vfio_ccw_sch_event_todo);
-	atomic_set(&private->avail, 1);
-	private->state = VFIO_CCW_STATE_STANDBY;
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INIT);
+	ret = -EFAULT;
+	if (private->state != VFIO_CCW_STATE_STANDBY)
+		goto out_unreg;
 
 	return 0;
 
-out_disable:
-	cio_disable_subchannel(sch);
+out_unreg:
+	vfio_ccw_mdev_unreg(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
 	kfree(private);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index d85bcfc..e8fe1e6 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -9,6 +9,7 @@
 
 #include <linux/vfio.h>
 #include <linux/mdev.h>
+#include <asm/isc.h>
 
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
@@ -167,35 +168,55 @@ static int fsm_sch_event(struct vfio_ccw_private *private)
 	return ret;
 }
 
+static int fsm_init(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch = private->sch;
+	int ret = VFIO_CCW_STATE_STANDBY;
+
+	spin_lock_irq(sch->lock);
+	sch->isc = VFIO_CCW_ISC;
+	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+		ret = VFIO_CCW_STATE_NOT_OPER;
+	spin_unlock_irq(sch->lock);
+
+	return ret;
+}
+
+
 /*
  * Device statemachine
  */
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	[VFIO_CCW_STATE_NOT_OPER] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_init,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index dac8ce4..78d1925 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -111,14 +111,10 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if (private->state == VFIO_CCW_STATE_NOT_OPER)
-		return -ENODEV;
-
 	if (atomic_dec_if_positive(&private->avail) < 0)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_IDLE;
 
 	return 0;
 }
@@ -128,13 +124,6 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_mdev_reset(mdev))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
-
 	private->mdev = NULL;
 	atomic_inc(&private->avail);
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index cf197cf..cacf677 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -76,6 +76,7 @@ enum vfio_ccw_state {
  * Asynchronous events of the device statemachine.
  */
 enum vfio_ccw_event {
+	VFIO_CCW_EVENT_INIT,
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_SSCH_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
-- 
2.7.4
