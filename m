Return-Path: <linux-kernel-owner+w=401wt.eu-S1753212AbXCZUxX@vger.kernel.org>
Message-Id: <20070326205254.130459124@de.ibm.com>
References: <20070326205225.438154546@de.ibm.com>
Date: Mon, 26 Mar 2007 22:52:31 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 6/6] zcrypt: Fix ap_poll_requests counter in lost requests error path.
Content-Disposition: inline; filename=006-zcrypt-req.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralph Wuerthner <rwuerthn@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

In the unlikely event that an AP device lost requests, don't forget to
update the ap_poll_requests counter too. Same must happen in case an AP
device is removed while there are still outstanding requests.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- linux-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ linux-2.6/drivers/s390/crypto/ap_bus.c
@@ -505,6 +505,9 @@ static int ap_device_remove(struct devic
 	spin_lock_bh(&ap_device_lock);
 	list_del_init(&ap_dev->list);
 	spin_unlock_bh(&ap_device_lock);
+	spin_lock_bh(&ap_dev->lock);
+	atomic_sub(ap_dev->queue_count, &ap_poll_requests);
+	spin_unlock_bh(&ap_dev->lock);
 	return 0;
 }
 
@@ -867,6 +870,7 @@ static int ap_poll_read(struct ap_device
 	case AP_RESPONSE_NO_PENDING_REPLY:
 		if (status.queue_empty) {
 			/* The card shouldn't forget requests but who knows. */
+			atomic_sub(ap_dev->queue_count, &ap_poll_requests);
 			ap_dev->queue_count = 0;
 			list_splice_init(&ap_dev->pendingq, &ap_dev->requestq);
 			ap_dev->requestq_count += ap_dev->pendingq_count;

-- 
