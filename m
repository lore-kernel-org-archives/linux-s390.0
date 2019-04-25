Return-Path: <SRS0=V8Ip=S3=vger.kernel.org=kvm-owner@kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 2/9] vfio-ccw: rework ssch state handling
Date: Thu, 25 Apr 2019 11:15:52 +0200
Message-Id: <20190425091559.15490-3-cohuck@redhat.com>
In-Reply-To: <20190425091559.15490-1-cohuck@redhat.com>
References: <20190425091559.15490-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The flow for processing ssch requests can be improved by splitting
the BUSY state:

- CP_PROCESSING: We reject any user space requests while we are in
  the process of translating a channel program and submitting it to
  the hardware. Use -EAGAIN to signal user space that it should
  retry the request.
- CP_PENDING: We have successfully submitted a request with ssch and
  are now expecting an interrupt. As we can't handle more than one
  channel program being processed, reject any further requests with
  -EBUSY. A final interrupt will move us out of this state.
  By making this a separate state, we make it possible to issue a
  halt or a clear while we're still waiting for the final interrupt
  for the ssch (in a follow-on patch).

It also makes a lot of sense not to preemptively filter out writes to
the io_region if we're in an incorrect state: the state machine will
handle this correctly.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 19 ++++++++++++++-----
 drivers/s390/cio/vfio_ccw_ops.c     |  2 --
 drivers/s390/cio/vfio_ccw_private.h |  3 ++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index e7c9877c9f1e..b4a141fbd1a8 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -28,7 +28,6 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	sch = private->sch;
 
 	spin_lock_irqsave(sch->lock, flags);
-	private->state = VFIO_CCW_STATE_BUSY;
 
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
 	if (!orb) {
@@ -46,6 +45,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
 		ret = 0;
+		private->state = VFIO_CCW_STATE_CP_PENDING;
 		break;
 	case 1:		/* Status pending */
 	case 2:		/* Busy */
@@ -107,6 +107,12 @@ static void fsm_io_busy(struct vfio_ccw_private *private,
 	private->io_region->ret_code = -EBUSY;
 }
 
+static void fsm_io_retry(struct vfio_ccw_private *private,
+			 enum vfio_ccw_event event)
+{
+	private->io_region->ret_code = -EAGAIN;
+}
+
 static void fsm_disabled_irq(struct vfio_ccw_private *private,
 			     enum vfio_ccw_event event)
 {
@@ -135,8 +141,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	struct mdev_device *mdev = private->mdev;
 	char *errstr = "request";
 
-	private->state = VFIO_CCW_STATE_BUSY;
-
+	private->state = VFIO_CCW_STATE_CP_PROCESSING;
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
 
 	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
@@ -181,7 +186,6 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
-	private->state = VFIO_CCW_STATE_IDLE;
 	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
 			       io_region->ret_code, errstr);
 }
@@ -221,7 +225,12 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 	},
-	[VFIO_CCW_STATE_BUSY] = {
+	[VFIO_CCW_STATE_CP_PROCESSING] = {
+		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
+		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_retry,
+		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+	},
+	[VFIO_CCW_STATE_CP_PENDING] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f673e106c041..3fdcc6dfe0bf 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -193,8 +193,6 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (private->state != VFIO_CCW_STATE_IDLE)
-		return -EACCES;
 
 	region = private->io_region;
 	if (copy_from_user((void *)region + *ppos, buf, count))
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 08e9a7dc9176..50c52efb4fcb 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -63,7 +63,8 @@ enum vfio_ccw_state {
 	VFIO_CCW_STATE_NOT_OPER,
 	VFIO_CCW_STATE_STANDBY,
 	VFIO_CCW_STATE_IDLE,
-	VFIO_CCW_STATE_BUSY,
+	VFIO_CCW_STATE_CP_PROCESSING,
+	VFIO_CCW_STATE_CP_PENDING,
 	/* last element! */
 	NR_VFIO_CCW_STATES
 };
-- 
2.17.2
