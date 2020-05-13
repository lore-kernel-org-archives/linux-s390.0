Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388740AbgEMO3m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 10:29:42 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v2 2/4] vfio-ccw: Utilize scsw actl to serialize start operations
Date: Wed, 13 May 2020 16:29:32 +0200
Message-Id: <20200513142934.28788-3-farman@linux.ibm.com>
In-Reply-To: <20200513142934.28788-1-farman@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

We need a convenient way to manage the fact that a START SUBCHANNEL
command is synchronous, the HALT SUBCHANNEL and CLEAR SUBCHANNEL
commands are asynchronous, and the interrupts for all three are
also asynchronous and unstacked from a workqueue.

Fortunately, the POPS does provide a mechanism to serialize the
operations, in the form of the activity control flags of the SCSW.
Since we initialize the private->scsw from the guest io_region for
each new START (done under the protection of the io_mutex), and
then never touch it again, we can use that as a space to indicate
which commands are active at the device.

For a START SUBCHANNEL command, the POPS states:

> Condition code 2 is set, and no other action is
> taken, when a start, halt, or clear function is currently
> in progress at the subchannel

So, mark START PENDING in this copy of the SCSW Activity
Controls, and use it to track when a command has started
versus when its interrupt has been unstacked from the workqueue
and processed. It's a bit unnatural, in that this doesn't
transition the flags to Subchannel/Device Active once the
command has been accepted. Since this is only in our local
copy of the SCSW, and not the actual contents of the SCHIB,
this is fine enough.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c |  4 +++-
 drivers/s390/cio/vfio_ccw_fsm.c | 12 ++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c |  4 +++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 7dd3efa1ccb8..ee153fa72a0f 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -98,8 +98,10 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 	mutex_unlock(&private->io_mutex);
 
-	if (private->mdev && scsw_is_solicited(&irb->scsw) && is_final)
+	if (private->mdev && scsw_is_solicited(&irb->scsw) && is_final) {
 		private->state = VFIO_CCW_STATE_IDLE;
+		private->scsw.cmd.actl &= ~SCSW_ACTL_START_PEND;
+	}
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 23e61aa638e4..258ce32549f3 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -246,8 +246,20 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	char *errstr = "request";
 	struct subchannel_id schid = get_schid(private);
 
+	if (scsw_actl(scsw) & SCSW_ACTL_START_PEND) {
+		io_region->ret_code = -EBUSY;
+		VFIO_CCW_MSG_EVENT(2,
+				   "%pUl (%x.%x.%04x): actl %x pending\n",
+				   mdev_uuid(mdev), schid.cssid,
+				   schid.ssid, schid.sch_no,
+				   scsw_actl(scsw));
+		errstr = "pending";
+		goto err_out;
+	}
+
 	private->state = VFIO_CCW_STATE_CP_PROCESSING;
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
+	scsw->cmd.actl |= SCSW_ACTL_START_PEND;
 
 	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
 		orb = (union orb *)io_region->orb_area;
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f0d71ab77c50..d2f9babb751c 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -269,8 +269,10 @@ static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
 	}
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0)
+	if (region->ret_code != 0) {
 		private->state = VFIO_CCW_STATE_IDLE;
+		private->scsw.cmd.actl &= ~SCSW_ACTL_START_PEND;
+	}
 	ret = (region->ret_code != 0) ? region->ret_code : count;
 
 out_unlock:
-- 
2.17.1
