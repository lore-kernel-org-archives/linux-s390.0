Return-Path: <linux-kernel-owner+w=401wt.eu-S1761816AbXJDLku@vger.kernel.org>
Message-Id: <20071004112828.970680427@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/34] zcrypt: fix ap_reset_domain()
Content-Disposition: inline; filename=016-zcrypt-reset.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ralph Wuerthner <rwuerthn@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

Resetting of a all queues within a domain requires that a domain must 
be selected first.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -1231,8 +1231,9 @@ static void ap_reset_domain(void)
 {
 	int i;
 
-	for (i = 0; i < AP_DEVICES; i++)
-		ap_reset_queue(AP_MKQID(i, ap_domain_index));
+	if (ap_domain_index != -1)
+		for (i = 0; i < AP_DEVICES; i++)
+			ap_reset_queue(AP_MKQID(i, ap_domain_index));
 }
 
 static void ap_reset_all(void)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
