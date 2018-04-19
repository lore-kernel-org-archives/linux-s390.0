From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ event
Date: Thu, 19 Apr 2018 16:48:07 +0200
Message-ID: <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This patch simplifies the IO request handling to handle the only
implemented request: SSCH.
Other request are invalid and get a return value of -EINVAL.

This patch change the event name to VFIO_CCW_EVENT_SSCH_REQ to reflect
what is done and prepare for future implementation of other requests.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 63 +++++++++++++------------------------
 drivers/s390/cio/vfio_ccw_ops.c     |  9 ++++--
 drivers/s390/cio/vfio_ccw_private.h |  2 +-
 3 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 13751b4..f9855cd 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -19,14 +19,9 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	union orb *orb;
 	int ccode;
 	__u8 lpm;
-	unsigned long flags;
 
 	sch = private->sch;
 
-	spin_lock_irqsave(sch->lock, flags);
-	private->state = VFIO_CCW_STATE_BUSY;
-	spin_unlock_irqrestore(sch->lock, flags);
-
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
 
 	/* Issue "Start Subchannel" */
@@ -118,44 +113,30 @@ static int fsm_io_request(struct vfio_ccw_private *private,
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
-		io_region->ret_code = -EOPNOTSUPP;
+	orb = (union orb *)io_region->orb_area;
+
+	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev), orb);
+	if (io_region->ret_code)
+		goto err_out;
+
+	io_region->ret_code = cp_prefetch(&private->cp);
+	if (io_region->ret_code) {
+		cp_free(&private->cp);
 		goto err_out;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		/* XXX: Handle clear. */
-		io_region->ret_code = -EOPNOTSUPP;
+	}
+
+	/* Start channel program and wait for I/O interrupt. */
+	io_region->ret_code = fsm_io_helper(private);
+	if (io_region->ret_code) {
+		cp_free(&private->cp);
 		goto err_out;
 	}
+	return VFIO_CCW_STATE_BUSY;
 
 err_out:
 	private->state = VFIO_CCW_STATE_IDLE;
@@ -179,7 +160,7 @@ static int fsm_irq(struct vfio_ccw_private *private,
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
-	return private->state;
+	return VFIO_CCW_STATE_IDLE;
 }
 
 /*
@@ -206,31 +187,31 @@ static int fsm_sch_event(struct vfio_ccw_private *private,
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	[VFIO_CCW_STATE_NOT_OPER] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 41eeb57..4da7b61 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -188,19 +188,22 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
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
+	scsw = (union scsw *) &region->scsw_area;
+	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) != SCSW_FCTL_START_FUNC)
+		return -EINVAL;
+
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
 	if (region->ret_code != 0) {
 		private->state = VFIO_CCW_STATE_IDLE;
 		return region->ret_code;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 3284e64..93aab87 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -76,7 +76,7 @@ enum vfio_ccw_state {
  */
 enum vfio_ccw_event {
 	VFIO_CCW_EVENT_NOT_OPER,
-	VFIO_CCW_EVENT_IO_REQ,
+	VFIO_CCW_EVENT_SSCH_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
 	VFIO_CCW_EVENT_SCH_EVENT,
 	/* last element! */
-- 
2.7.4
