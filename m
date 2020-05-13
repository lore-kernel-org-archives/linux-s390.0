Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388740AbgEMO3o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 10:29:44 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v2 1/4] vfio-ccw: Do not reset FSM state for unsolicited interrupts
Date: Wed, 13 May 2020 16:29:31 +0200
Message-Id: <20200513142934.28788-2-farman@linux.ibm.com>
In-Reply-To: <20200513142934.28788-1-farman@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

The interrupt handler in vfio_ccw_sch_io_todo() presumes that every
interrupt should reset the FSM state back to IDLE. But this means
that an unsolicited interrupt will cause the FSM to be reset, such
that an in-flight I/O (either still being built, or out on the wire)
will cause a solicited interrupt for which vfio-ccw is no longer
expecting.

Example IRB, while state=CP_PROCESSING:

  irb.w0=00c00011 irb.cpa=02f420f8 irb.w2=85000000

Simply check that the interrupt is solicited before touching the
FSM state.

Fixes: bbe37e4cb8970 ("vfio: ccw: introduce a finite state machine")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 339a6bc0339b..7dd3efa1ccb8 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -98,7 +98,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 	mutex_unlock(&private->io_mutex);
 
-	if (private->mdev && is_final)
+	if (private->mdev && scsw_is_solicited(&irb->scsw) && is_final)
 		private->state = VFIO_CCW_STATE_IDLE;
 
 	if (private->io_trigger)
-- 
2.17.1
