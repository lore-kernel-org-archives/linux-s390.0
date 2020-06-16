Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730183AbgFPTvB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 15:51:01 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v3 3/3] vfio-ccw: Check workqueue before doing START
Date: Tue, 16 Jun 2020 21:50:53 +0200
Message-Id: <20200616195053.99253-4-farman@linux.ibm.com>
In-Reply-To: <20200616195053.99253-1-farman@linux.ibm.com>
References: <20200616195053.99253-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

When an interrupt is received via the IRQ, the bulk of the work is
stacked on a workqueue for later processing. Which means that concurrent
START or a HALT/CLEAR operation (via the async_region) will race with
this process and require some serialization.

Once we have all our locks acquired, let's just look to see if we're
in a window where the process has been started from the IRQ, but not
yet picked up by vfio-ccw to clean up an I/O. If there is, mark the
request as BUSY so it can be redriven after we have a chance to breathe.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index f0952192480e..9dc5b4d549b3 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -28,6 +28,11 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 
 	spin_lock_irqsave(sch->lock, flags);
 
+	if (work_pending(&private->io_work)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
 	if (!orb) {
 		ret = -EIO;
-- 
2.17.1
