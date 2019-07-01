Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727227AbfGAQYL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 12:24:11 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v1 4/4] vfio-ccw: Don't call cp_free if we are processing a channel program
Date: Mon,  1 Jul 2019 12:23:46 -0400
Message-Id: <31c3c29e3e9c4f0312f9363a1c3a5d22b74f68cb.1561997809.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

There is a small window where it's possible that we could be working
on an interrupt (queued in the workqueue) and setting up a channel
program (i.e allocating memory, pinning pages, translating address).
This can lead to allocating and freeing the channel program at the
same time and can cause memory corruption.

Let's not call cp_free if we are currently processing a channel program.
The only way we know for sure that we don't have a thread setting
up a channel program is when the state is set to VFIO_CCW_STATE_CP_PENDING.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 4e3a903..0357165 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -92,7 +92,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		if (is_final)
+		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
 			cp_free(&private->cp);
 	}
 	mutex_lock(&private->io_mutex);
-- 
2.7.4
