From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 7/8] vfio: ccw: Introduce the INIT event
Date: Tue, 12 Jun 2018 09:56:49 +0200
Message-ID: <1528790210-19535-8-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This patch introduce a new event: VFIO_CCW_EVENT_INIT.

This event is sent to the FSM during the open of the mediated
device, when a guest is about to take care of the real device.

At this moment the FSM state is VFIO_CCW_STATE_NOT_OPER,
nothing can be done with the device as no one is there
to take care of it.
The VFIO_CCW_STATE_NOT_OPER is the only state accepting
the VFIO_CCW_EVENT_INIT event.

In the FSM, when receiving the VFIO_CCW_EVENT_INIT event
the sub-channel is enabled and the next state is set to
VFIO_CCW_STATE_STANDBY.

This patch move part of the initialization to different
places:
- In the probe callback,  all driver private structures
  are initialized before registering the mediated device.
- The call to the FSM is done in the mediated device open
  callback.
- The enabling of the real device is moved inside the FSM
  fsm_init function called through the jump table during
  the mediated device open callback.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 21 ++++++---------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 20 ++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     | 26 +++++++++++++-------------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 98951d5..e1a9806 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -114,31 +114,22 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
 	if (!private)
 		return -ENOMEM;
+
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 	mutex_init(&private->state_mutex);
 
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
index 2d55742..5f1035c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -9,6 +9,7 @@
 
 #include <linux/vfio.h>
 #include <linux/mdev.h>
+#include <asm/isc.h>
 
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
@@ -187,35 +188,54 @@ static int fsm_sch_event(struct vfio_ccw_private *private)
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
 /*
  * Device statemachine
  */
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	[VFIO_CCW_STATE_NOT_OPER] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_init,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index af05932..e020a836 100644
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
-				      &events, &private->nb);
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &private->nb);
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
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index e3dc12c..f9e7570 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -76,6 +76,7 @@ enum vfio_ccw_state {
  * Asynchronous events of the device statemachine.
  */
 enum vfio_ccw_event {
+	VFIO_CCW_EVENT_INIT,
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
-- 
2.7.4
