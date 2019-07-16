Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731690AbfGPKJY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jul 2019 06:09:24 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 4/5] vfio-ccw: Don't call cp_free if we are processing a channel program
Date: Tue, 16 Jul 2019 12:09:07 +0200
Message-Id: <20190716100908.3460-5-cohuck@redhat.com>
In-Reply-To: <20190716100908.3460-1-cohuck@redhat.com>
References: <20190716100908.3460-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.ibm.com>

There is a small window where it's possible that we could be working
on an interrupt (queued in the workqueue) and setting up a channel
program (i.e allocating memory, pinning pages, translating address).
This can lead to allocating and freeing the channel program at the
same time and can cause memory corruption.

Let's not call cp_free if we are currently processing a channel program.
The only way we know for sure that we don't have a thread setting
up a channel program is when the state is set to VFIO_CCW_STATE_CP_PENDING.

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <62e87bf67b38dc8d5760586e7c96d400db854ebe.1562854091.git.alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 2b90a5ecaeb9..9208c0e56c33 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -88,7 +88,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		if (is_final)
+		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
 			cp_free(&private->cp);
 	}
 	mutex_lock(&private->io_mutex);
-- 
2.20.1
