Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388777AbgEMO3m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 10:29:42 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v2 4/4] vfio-ccw: Clean up how to react to a failed START
Date: Wed, 13 May 2020 16:29:34 +0200
Message-Id: <20200513142934.28788-5-farman@linux.ibm.com>
In-Reply-To: <20200513142934.28788-1-farman@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

This is a fixup to the previous commits, and should be merged
as such. It's just left out to show that vfio-ccw needs to tell
the difference between getting a CC2 from a SSCH instruction,
and creating a CC2 because there's another (probably asynchronous)
command still outstanding. Without it, the FSM state would be reset
to IDLE and things would be no better than before.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 6 +++++-
 drivers/s390/cio/vfio_ccw_ops.c | 5 +----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index d8075a56eb9b..7d1c7031079c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -264,7 +264,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 				   schid.ssid, schid.sch_no,
 				   scsw_actl(scsw));
 		errstr = "pending";
-		goto err_out;
+		goto err_out_nochange;
 	}
 
 	private->state = VFIO_CCW_STATE_CP_PROCESSING;
@@ -340,6 +340,10 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
+	private->scsw.cmd.actl &= ~SCSW_ACTL_START_PEND;
+	private->state = VFIO_CCW_STATE_IDLE;
+
+err_out_nochange:
 	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
 				      io_region->ret_code, errstr);
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index d2f9babb751c..d01d7abe6b00 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -269,10 +269,7 @@ static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
 	}
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
-		private->scsw.cmd.actl &= ~SCSW_ACTL_START_PEND;
-	}
+
 	ret = (region->ret_code != 0) ? region->ret_code : count;
 
 out_unlock:
-- 
2.17.1
