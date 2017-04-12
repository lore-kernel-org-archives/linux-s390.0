From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 1/2] vfio: ccw: remove unnecessary NULL checks of a pointer
Date: Wed, 12 Apr 2017 11:08:15 +0200
Message-ID: <20170412090816.79108-2-bjsdjshi@linux.vnet.ibm.com>
References: <20170412090816.79108-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170412090816.79108-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, dan.carpenter@oracle.com
List-ID: <linux-s390.vger.kernel.org>

Remove several unnecessary checks for the @private pointer, since it
can never be NULL in these places.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c |  6 +-----
 drivers/s390/cio/vfio_ccw_ops.c | 17 -----------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 55b6cc5..80a0559c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -161,12 +161,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 static void fsm_irq(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
-	struct irb *irb;
+	struct irb *irb = this_cpu_ptr(&cio_irb);
 
-	if (!private)
-		return;
-
-	irb = this_cpu_ptr(&cio_irb);
 	memcpy(&private->irb, irb, sizeof(*irb));
 
 	queue_work(vfio_ccw_work_q, &private->io_work);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index b2e6154..55d0c87 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -19,9 +19,6 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
 	int ret;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (!private)
-		return -ENODEV;
-
 	sch = private->sch;
 	/*
 	 * TODO:
@@ -49,9 +46,6 @@ static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
 	struct vfio_ccw_private *private =
 		container_of(nb, struct vfio_ccw_private, nb);
 
-	if (!private)
-		return NOTIFY_STOP;
-
 	/*
 	 * Vendor drivers MUST unpin pages in response to an
 	 * invalidation.
@@ -134,9 +128,6 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	int ret;
 
-	if (!private)
-		goto out;
-
 	if ((private->state == VFIO_CCW_STATE_NOT_OPER) ||
 	    (private->state == VFIO_CCW_STATE_STANDBY))
 		goto out;
@@ -187,9 +178,6 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (!private)
-		return -ENODEV;
-
 	region = &private->io_region;
 	if (copy_to_user(buf, (void *)region + *ppos, count))
 		return -EFAULT;
@@ -209,8 +197,6 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (!private)
-		return -ENODEV;
 	if (private->state != VFIO_CCW_STATE_IDLE)
 		return -EACCES;
 
@@ -274,9 +260,6 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (!private)
-		return -ENODEV;
-
 	ctx = &private->io_trigger;
 
 	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
-- 
2.10.2
