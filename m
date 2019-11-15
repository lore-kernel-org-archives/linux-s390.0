Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbfKOD1Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 22:27:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF39WLp182349
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 22:27:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jcm1fjs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 22:27:20 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 15 Nov 2019 02:56:25 -0000
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v1 10/10] vfio-ccw: Remove inline get_schid() routine
Date: Fri, 15 Nov 2019 03:56:20 +0100
In-Reply-To: <20191115025620.19593-1-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
Message-Id: <20191115025620.19593-11-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

This seems misplaced in the middle of FSM, returning the schid
field from inside the private struct.  We could move this macro
into vfio_ccw_private.h, but this doesn't seem to simplify things
that much.  Let's just remove it, and use the field directly.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 23e61aa638e4..c4c303645d7d 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -228,10 +228,6 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
 	 */
 	cio_disable_subchannel(sch);
 }
-inline struct subchannel_id get_schid(struct vfio_ccw_private *p)
-{
-	return p->sch->schid;
-}
 
 /*
  * Deal with the ccw command request from the userspace.
@@ -244,7 +240,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	struct ccw_io_region *io_region = private->io_region;
 	struct mdev_device *mdev = private->mdev;
 	char *errstr = "request";
-	struct subchannel_id schid = get_schid(private);
+	struct subchannel_id schid = private->sch->schid;
 
 	private->state = VFIO_CCW_STATE_CP_PROCESSING;
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
@@ -342,7 +338,7 @@ static void fsm_async_request(struct vfio_ccw_private *private,
 		cmd_region->ret_code = -EINVAL;
 	}
 
-	trace_vfio_ccw_fsm_async_request(get_schid(private),
+	trace_vfio_ccw_fsm_async_request(private->sch->schid,
 					 cmd_region->command,
 					 cmd_region->ret_code);
 }
-- 
2.17.1
