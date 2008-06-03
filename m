Return-Path: <linux-kernel-owner+w=401wt.eu-S1756011AbYFCRHW@vger.kernel.org>
Message-Id: <20080603170520.988639783@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/14] cio: remove lock from ccw_device_oper_notify.
Content-Disposition: inline; filename=110-cio-locking.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Remove unnecessary ccw device locking inside ccw_device_oper_notify.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>        
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>        
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -346,21 +346,15 @@ ccw_device_oper_notify(struct work_struc
 	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 	int ret;
-	unsigned long flags;
 
 	priv = container_of(work, struct ccw_device_private, kick_work);
 	cdev = priv->cdev;
 	ret = ccw_device_notify(cdev, CIO_OPER);
-	spin_lock_irqsave(cdev->ccwlock, flags);
 	if (ret) {
 		/* Reenable channel measurements, if needed. */
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
 		cmf_reenable(cdev);
-		spin_lock_irqsave(cdev->ccwlock, flags);
 		wake_up(&cdev->private->wait_q);
-	}
-	spin_unlock_irqrestore(cdev->ccwlock, flags);
-	if (!ret)
+	} else
 		/* Driver doesn't want device back. */
 		ccw_device_do_unreg_rereg(work);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
