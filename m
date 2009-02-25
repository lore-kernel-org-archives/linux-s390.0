Return-Path: <linux-kernel-owner+w=401wt.eu-S1764337AbZBYPWz@vger.kernel.org>
Message-Id: <20090225150837.137355598@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 36/46] qdio: Dont call qdio_shutdown in case qdio_activate fails
Content-Disposition: inline; filename=135-qdio-shutdown.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Remove the call to qdio_shutdown from qdio_activate since the upper-layer
drivers are responsible to call qdio_shutdown when qdio_activate returns
with an error.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -1404,9 +1404,8 @@ int qdio_activate(struct ccw_device *cde
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_STOPPED:
 	case QDIO_IRQ_STATE_ERR:
-		mutex_unlock(&irq_ptr->setup_mutex);
-		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
-		return -EIO;
+		rc = -EIO;
+		break;
 	default:
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
 		rc = 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
