From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 12/15] vfio: ccw: return I/O results asynchronously
Date: Thu, 12 Jan 2017 08:19:44 +0100
Message-ID: <20170112071947.98071-13-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Introduce a singlethreaded workqueue to handle the I/O interrupts.
With the work added to this queue, we store the I/O results to the
io_region of the subchannel, then signal the userspace program to
handle the results.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 58 ++++++++++++++++++++++---------------
 drivers/s390/cio/vfio_ccw_ops.c     |  3 --
 drivers/s390/cio/vfio_ccw_private.h |  7 ++---
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 595dcb4..56af313 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -24,6 +24,8 @@
 #include "css.h"
 #include "vfio_ccw_private.h"
 
+struct workqueue_struct *vfio_ccw_work_q;
+
 /*
  * Helpers
  */
@@ -56,6 +58,7 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 
 			spin_lock_irq(sch->lock);
 			private->completion = NULL;
+			flush_workqueue(vfio_ccw_work_q);
 			ret = cio_cancel_halt_clear(sch, &iretry);
 		};
 
@@ -67,18 +70,12 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 	return ret;
 }
 
-static int doing_io(struct vfio_ccw_private *private, u32 intparm)
-{
-	return (private->intparm == intparm);
-}
-
 static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch;
 	union orb *orb;
 	int ccode;
 	__u8 lpm;
-	u32 intparm;
 
 	sch = private->sch;
 
@@ -93,7 +90,7 @@ static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
-		break;
+		return 0;
 	case 1:		/* Status pending */
 	case 2:		/* Busy */
 		return -EBUSY;
@@ -113,15 +110,26 @@ static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
 	default:
 		return ccode;
 	}
+}
 
-	intparm = (u32)(addr_t)sch;
-	private->intparm = 0;
-	wait_event(private->wait_q, doing_io(private, intparm));
+static void vfio_ccw_sch_io_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+	struct subchannel *sch;
+	struct irb *irb;
 
-	if (scsw_is_solicited(&private->irb.scsw))
-		cp_update_scsw(&private->cp, &private->irb.scsw);
+	private = container_of(work, struct vfio_ccw_private, io_work);
+	irb = &private->irb;
+	sch = private->sch;
 
-	return 0;
+	if (scsw_is_solicited(&irb->scsw)) {
+		cp_update_scsw(&private->cp, &irb->scsw);
+		cp_free(&private->cp);
+	}
+	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
+
+	if (private->io_trigger)
+		eventfd_signal(private->io_trigger, 1);
 }
 
 /* Deal with the ccw command request from the userspace. */
@@ -130,7 +138,6 @@ int vfio_ccw_sch_cmd_request(struct vfio_ccw_private *private)
 	struct mdev_device *mdev = private->mdev;
 	union orb *orb;
 	union scsw *scsw = &private->scsw;
-	struct irb *irb = &private->irb;
 	struct ccw_io_region *io_region = &private->io_region;
 	int ret;
 
@@ -151,12 +158,8 @@ int vfio_ccw_sch_cmd_request(struct vfio_ccw_private *private)
 
 		/* Start channel program and wait for I/O interrupt. */
 		ret = vfio_ccw_sch_io_helper(private);
-		if (!ret) {
-			/* Get irb info and copy it to irb_area. */
-			memcpy(io_region->irb_area, irb, sizeof(*irb));
-		}
-
-		cp_free(&private->cp);
+		if (!ret)
+			cp_free(&private->cp);
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		/* XXX: Handle halt. */
 		ret = -EOPNOTSUPP;
@@ -233,8 +236,8 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
 
 	irb = this_cpu_ptr(&cio_irb);
 	memcpy(&private->irb, irb, sizeof(*irb));
-	private->intparm = (u32)(addr_t)sch;
-	wake_up(&private->wait_q);
+
+	queue_work(vfio_ccw_work_q, &private->io_work);
 
 	if (private->completion)
 		complete(private->completion);
@@ -273,7 +276,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_rm_group;
 
-	init_waitqueue_head(&private->wait_q);
+	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 
 	return 0;
 
@@ -370,10 +373,16 @@ static int __init vfio_ccw_sch_init(void)
 {
 	int ret;
 
+	vfio_ccw_work_q = create_singlethread_workqueue("vfio-ccw");
+	if (!vfio_ccw_work_q)
+		return -ENOMEM;
+
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
-	if (ret)
+	if (ret) {
 		isc_unregister(VFIO_CCW_ISC);
+		destroy_workqueue(vfio_ccw_work_q);
+	}
 
 	return ret;
 }
@@ -382,6 +391,7 @@ static void __exit vfio_ccw_sch_exit(void)
 {
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
+	destroy_workqueue(vfio_ccw_work_q);
 }
 module_init(vfio_ccw_sch_init);
 module_exit(vfio_ccw_sch_exit);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 3c47eb6..f1b17c4 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -203,9 +203,6 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if (region->ret_code != 0)
 		return region->ret_code;
 
-	if (private->io_trigger)
-		eventfd_signal(private->io_trigger, 1);
-
 	return count;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index d551d98..2e5ce86 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -16,6 +16,7 @@
 
 #include <linux/completion.h>
 #include <linux/eventfd.h>
+#include <linux/workqueue.h>
 #include <asm/vfio_ccw.h>
 
 #include "css.h"
@@ -28,12 +29,11 @@
  * @mdev: pointor to the mediated device
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
- * @wait_q: wait for interrupt
- * @intparm: record current interrupt parameter, used for wait interrupt
  * @cp: ccw program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
  * @io_trigger: eventfd ctx for signaling userspace I/O results
+ * @io_work: work for deferral process of I/O handling
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -42,13 +42,12 @@ struct vfio_ccw_private {
 	struct notifier_block	nb;
 	struct ccw_io_region	io_region;
 
-	wait_queue_head_t	wait_q;
-	u32			intparm;
 	struct ccwprogram	cp;
 	struct irb		irb;
 	union scsw		scsw;
 
 	struct eventfd_ctx	*io_trigger;
+	struct work_struct	io_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
-- 
2.8.4
