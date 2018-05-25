From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH v2 07/10] vfio: ccw: FSM and mediated device initialization
Date: Fri, 25 May 2018 12:21:15 +0200
Message-ID: <1527243678-3140-8-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

When the physical device is probed it is existing but should
not be able to do any operations since no driver is available
until a guest is there.
Hence the state is set to VFIO_CCW_STATE_NOT_OPER.

When the mediated device is created, nothing is changed for
the device, it still stay not operational.

When the guest is starting the state machine recieves the
VFIO_CCW_EVENT_INIT event which statrts the fsm_init action
to bring the state to VFIO_CCW_STATE_STANDBY.

The VFIO_DEVICE_RESET command (not part of this patch)
will bring the FSM state to VFIO_CCW_STATE_IDLE.

Before the mediated device is opened by QEMU, the vfio_private
structure is not completely initialized.
Let's change the actions for the VFIO_CCW_STATE_NOT_OPER
to fsm_nop when vfio_private is not initialized.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 22 ++++++----------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 25 +++++++++++++++++++++++--
 drivers/s390/cio/vfio_ccw_ops.c     | 25 +++++++++++++------------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 4 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 98951d5..6fc7668 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -114,31 +114,21 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
 	if (!private)
 		return -ENOMEM;
+
+	private->state = VFIO_CCW_STATE_NOT_OPER;
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
-
-	ret = vfio_ccw_mdev_reg(sch);
-	if (ret)
-		goto out_disable;
-
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->event_work, vfio_ccw_sch_event_todo);
 	atomic_set(&private->avail, 1);
-	private->state = VFIO_CCW_STATE_STANDBY;
+
+	ret = vfio_ccw_mdev_reg(sch);
+	if (ret)
+		goto out_free;
 
 	return 0;
 
-out_disable:
-	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
 	kfree(private);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 077da23..20b909c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -9,6 +9,7 @@
 
 #include <linux/vfio.h>
 #include <linux/mdev.h>
+#include <asm/isc.h>
 
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
@@ -174,35 +175,55 @@ static int fsm_sch_event(struct vfio_ccw_private *private)
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
-		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
-		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_nop,
+		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_nop,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 0206101..ea8fd64 100644
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
 
@@ -146,11 +135,22 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	int ret;
 
 	private->nb.notifier_call = vfio_ccw_mdev_notifier;
 
-	return vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				      &events, &private->nb);
+	if (ret)
+		return ret;
+
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INIT);
+	if (private->state == VFIO_CCW_STATE_STANDBY)
+		return 0;
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &private->nb);
+	return -EFAULT;
 }
 
 static void vfio_ccw_mdev_release(struct mdev_device *mdev)
@@ -158,6 +158,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 241176c..c5455a9 100644
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
