From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 01 Oct 2018 11:53:57 +0000
Subject: [PULL 1/2] s390/cio: Convert ccw_io_region to pointer
Message-Id: <20181001115358.5513-2-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

In the event that we want to change the layout of the ccw_io_region in the
future[1], it might be easier to work with it as a pointer within the
vfio_ccw_private struct rather than an embedded struct.

[1] https://patchwork.kernel.org/comment/22228541/

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20180921204013.95804-2-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 12 +++++++++++-
 drivers/s390/cio/vfio_ccw_fsm.c     |  6 +++---
 drivers/s390/cio/vfio_ccw_ops.c     |  4 ++--
 drivers/s390/cio/vfio_ccw_private.h |  2 +-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 770fa9cfc310..f48e6f84eefe 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -79,7 +79,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		cp_update_scsw(&private->cp, &irb->scsw);
 		cp_free(&private->cp);
 	}
-	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
+	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
@@ -114,6 +114,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
 	if (!private)
 		return -ENOMEM;
+
+	private->io_region = kzalloc(sizeof(*private->io_region),
+				     GFP_KERNEL | GFP_DMA);
+	if (!private->io_region) {
+		kfree(private);
+		return -ENOMEM;
+	}
+
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 
@@ -139,6 +147,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
+	kfree(private->io_region);
 	kfree(private);
 	return ret;
 }
@@ -153,6 +162,7 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	dev_set_drvdata(&sch->dev, NULL);
 
+	kfree(private->io_region);
 	kfree(private);
 
 	return 0;
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 797a82731159..f94aa01f9c36 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -93,13 +93,13 @@ static void fsm_io_error(struct vfio_ccw_private *private,
 			 enum vfio_ccw_event event)
 {
 	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
-	private->io_region.ret_code = -EIO;
+	private->io_region->ret_code = -EIO;
 }
 
 static void fsm_io_busy(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
-	private->io_region.ret_code = -EBUSY;
+	private->io_region->ret_code = -EBUSY;
 }
 
 static void fsm_disabled_irq(struct vfio_ccw_private *private,
@@ -126,7 +126,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 {
 	union orb *orb;
 	union scsw *scsw = &private->scsw;
-	struct ccw_io_region *io_region = &private->io_region;
+	struct ccw_io_region *io_region = private->io_region;
 	struct mdev_device *mdev = private->mdev;
 	char *errstr = "request";
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 41eeb57d68a3..f673e106c041 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -174,7 +174,7 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	region = &private->io_region;
+	region = private->io_region;
 	if (copy_to_user(buf, (void *)region + *ppos, count))
 		return -EFAULT;
 
@@ -196,7 +196,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if (private->state != VFIO_CCW_STATE_IDLE)
 		return -EACCES;
 
-	region = &private->io_region;
+	region = private->io_region;
 	if (copy_from_user((void *)region + *ppos, buf, count))
 		return -EFAULT;
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 78a66d96756b..078e46f9623d 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -41,7 +41,7 @@ struct vfio_ccw_private {
 	atomic_t		avail;
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
-	struct ccw_io_region	io_region;
+	struct ccw_io_region	*io_region;
 
 	struct channel_program	cp;
 	struct irb		irb;
-- 
2.14.4
