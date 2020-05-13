Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388837AbgEMO3n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 10:29:43 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v2 3/4] vfio-ccw: Expand SCSW usage to HALT and CLEAR
Date: Wed, 13 May 2020 16:29:33 +0200
Message-Id: <20200513142934.28788-4-farman@linux.ibm.com>
In-Reply-To: <20200513142934.28788-1-farman@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Expand the Activity Control flags to include HALT/CLEAR PENDING,
in the same way as is done for the START PENDING flag.

The POPS states that for HALT SUBCHANNEL:

> Condition code 2 is set, and no other action is
> taken, ... when a halt function or clear function is
> already in progress at the subchannel.

So take that into account in fsm_do_halt().

CLEAR SUBCHANNEL is the biggest hammer, and always gets to happen,
so no corresponding check is added to fsm_do_clear(). But it does
reset both START and HALT functions that may be active, which is
why it incorporates the resetting of the HALT bit on the interrupt
path.

FIXME: What happens if a guest hammers a bunch of CSCH in a row?
We clear this for the first interrupt; is that fine?

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c |  6 ++++++
 drivers/s390/cio/vfio_ccw_fsm.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ee153fa72a0f..55051972325f 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -101,6 +101,12 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	if (private->mdev && scsw_is_solicited(&irb->scsw) && is_final) {
 		private->state = VFIO_CCW_STATE_IDLE;
 		private->scsw.cmd.actl &= ~SCSW_ACTL_START_PEND;
+		if (scsw_fctl(&irb->scsw) & SCSW_FCTL_HALT_FUNC)
+			private->scsw.cmd.actl &= ~SCSW_ACTL_HALT_PEND;
+		if (scsw_fctl(&irb->scsw) & SCSW_FCTL_CLEAR_FUNC) {
+			private->scsw.cmd.actl &= ~SCSW_ACTL_HALT_PEND;
+			private->scsw.cmd.actl &= ~SCSW_ACTL_CLEAR_PEND;
+		}
 	}
 
 	if (private->io_trigger)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 258ce32549f3..d8075a56eb9b 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -86,6 +86,14 @@ static int fsm_do_halt(struct vfio_ccw_private *private)
 
 	sch = private->sch;
 
+	if (scsw_actl(&private->scsw) & (SCSW_ACTL_HALT_PEND | SCSW_ACTL_CLEAR_PEND)) {
+		VFIO_CCW_MSG_EVENT(2,
+				   "%pUl: actl %x pending\n",
+				   mdev_uuid(private->mdev),
+				   scsw_actl(&private->scsw));
+		return -EBUSY;
+	}
+
 	spin_lock_irqsave(sch->lock, flags);
 
 	VFIO_CCW_TRACE_EVENT(2, "haltIO");
@@ -102,6 +110,7 @@ static int fsm_do_halt(struct vfio_ccw_private *private)
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
+		private->scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
 		ret = 0;
 		break;
 	case 1:		/* Status pending */
@@ -143,6 +152,7 @@ static int fsm_do_clear(struct vfio_ccw_private *private)
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl = SCSW_ACTL_CLEAR_PEND;
+		private->scsw.cmd.actl |= SCSW_ACTL_CLEAR_PEND;
 		/* TODO: check what else we might need to clear */
 		ret = 0;
 		break;
@@ -246,7 +256,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	char *errstr = "request";
 	struct subchannel_id schid = get_schid(private);
 
-	if (scsw_actl(scsw) & SCSW_ACTL_START_PEND) {
+	if (scsw_actl(scsw) & (SCSW_ACTL_START_PEND | SCSW_ACTL_HALT_PEND | SCSW_ACTL_CLEAR_PEND)) {
 		io_region->ret_code = -EBUSY;
 		VFIO_CCW_MSG_EVENT(2,
 				   "%pUl (%x.%x.%04x): actl %x pending\n",
-- 
2.17.1
