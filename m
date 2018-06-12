From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 4/8] vfio: ccw: Only accept SSCH as an IO request
Date: Tue, 12 Jun 2018 09:56:46 +0200
Message-ID: <1528790210-19535-5-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This patch simplifies the IO request handling to handle the only
implemented request: SSCH.
Other requests are invalid and get a return value of -ENOTSUP
as before.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 55 ++++++++++++++++-------------------------
 drivers/s390/cio/vfio_ccw_ops.c | 15 ++++++-----
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 94bf151..e672d14 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -122,50 +122,37 @@ static int fsm_io_request(struct vfio_ccw_private *private,
 			   enum vfio_ccw_event event)
 {
 	union orb *orb;
-	union scsw *scsw = &private->scsw;
 	struct ccw_io_region *io_region = &private->io_region;
 	struct mdev_device *mdev = private->mdev;
 
 	private->state = VFIO_CCW_STATE_BOXED;
 
-	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
-
-	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
-		orb = (union orb *)io_region->orb_area;
-
-		/* Don't try to build a cp if transport mode is specified. */
-		if (orb->tm.b) {
-			io_region->ret_code = -EOPNOTSUPP;
-			goto err_out;
-		}
-		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
-					      orb);
-		if (io_region->ret_code)
-			goto err_out;
-
-		io_region->ret_code = cp_prefetch(&private->cp);
-		if (io_region->ret_code) {
-			cp_free(&private->cp);
-			goto err_out;
-		}
-
-		/* Start channel program and wait for I/O interrupt. */
-		io_region->ret_code = fsm_io_helper(private);
-		if (io_region->ret_code) {
-			cp_free(&private->cp);
-			goto err_out;
-		}
-		return private->state;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
-		/* XXX: Handle halt. */
+	orb = (union orb *)io_region->orb_area;
+
+	/* Don't try to build a cp if transport mode is specified. */
+	if (orb->tm.b) {
 		io_region->ret_code = -EOPNOTSUPP;
 		goto err_out;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		/* XXX: Handle clear. */
-		io_region->ret_code = -EOPNOTSUPP;
+	}
+	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
+				      orb);
+	if (io_region->ret_code)
+		goto err_out;
+
+	io_region->ret_code = cp_prefetch(&private->cp);
+	if (io_region->ret_code) {
+		cp_free(&private->cp);
 		goto err_out;
 	}
 
+	/* Start channel program and wait for I/O interrupt. */
+	io_region->ret_code = fsm_io_helper(private);
+	if (io_region->ret_code) {
+		cp_free(&private->cp);
+		goto err_out;
+	}
+	return private->state;
+
 err_out:
 	return VFIO_CCW_STATE_IDLE;
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 41eeb57..af05932 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -188,25 +188,24 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 {
 	struct vfio_ccw_private *private;
 	struct ccw_io_region *region;
+	union scsw *scsw;
 
 	if (*ppos + count > sizeof(*region))
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (private->state != VFIO_CCW_STATE_IDLE)
-		return -EACCES;
 
 	region = &private->io_region;
 	if (copy_from_user((void *)region + *ppos, buf, count))
 		return -EFAULT;
 
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
-		return region->ret_code;
-	}
+	scsw = (union scsw *) &region->scsw_area;
+	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC)
+		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
+	else
+		return -EOPNOTSUPP;
 
-	return count;
+	return region->ret_code ? region->ret_code : count;
 }
 
 static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
-- 
2.7.4
