Return-Path: <linux-kernel-owner+w=401wt.eu-S1757177AbZKMPQY@vger.kernel.org>
Message-Id: <20091113150912.274005906@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/52] [PATCH] zcrypt: add support for cex3 device types
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=116-cex3-device.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Ralph Wuerthner <ralph.wuerthner@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

This patch renames the CEX2C2 and CEX2A2 types to CEX3 device types.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.h        |    4 ++--
 drivers/s390/crypto/zcrypt_api.c    |    9 +++++++--
 drivers/s390/crypto/zcrypt_cex2a.c  |    2 +-
 drivers/s390/crypto/zcrypt_pcixcc.c |    2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.h	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/ap_bus.h	2009-11-13 16:08:15.000000000 +0100
@@ -97,8 +97,8 @@
 #define AP_DEVICE_TYPE_PCIXCC	5
 #define AP_DEVICE_TYPE_CEX2A	6
 #define AP_DEVICE_TYPE_CEX2C	7
-#define AP_DEVICE_TYPE_CEX2A2	8
-#define AP_DEVICE_TYPE_CEX2C2	9
+#define AP_DEVICE_TYPE_CEX3A	8
+#define AP_DEVICE_TYPE_CEX3C	9
 
 /*
  * AP reset flag states
Index: quilt-2.6/drivers/s390/crypto/zcrypt_api.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_api.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_api.c	2009-11-13 16:08:15.000000000 +0100
@@ -1009,6 +1009,10 @@
 		       zcrypt_count_type(ZCRYPT_CEX2C));
 	len += sprintf(resp_buff + len, "CEX2A count: %d\n",
 		       zcrypt_count_type(ZCRYPT_CEX2A));
+	len += sprintf(resp_buff + len, "CEX3C count: %d\n",
+		       zcrypt_count_type(ZCRYPT_CEX3C));
+	len += sprintf(resp_buff + len, "CEX3A count: %d\n",
+		       zcrypt_count_type(ZCRYPT_CEX3A));
 	len += sprintf(resp_buff + len, "requestq count: %d\n",
 		       zcrypt_requestq_count());
 	len += sprintf(resp_buff + len, "pendingq count: %d\n",
@@ -1017,7 +1021,7 @@
 		       atomic_read(&zcrypt_open_count));
 	zcrypt_status_mask(workarea);
 	len += sprinthx("Online devices: 1=PCICA 2=PCICC 3=PCIXCC(MCL2) "
-			"4=PCIXCC(MCL3) 5=CEX2C 6=CEX2A",
+			"4=PCIXCC(MCL3) 5=CEX2C 6=CEX2A 7=CEX3C 8=CEX3A",
 			resp_buff+len, workarea, AP_DEVICES);
 	zcrypt_qdepth_mask(workarea);
 	len += sprinthx("Waiting work element counts",
@@ -1095,8 +1099,9 @@
 		 * '0' for no device, '1' for PCICA, '2' for PCICC,
 		 * '3' for PCIXCC_MCL2, '4' for PCIXCC_MCL3,
 		 * '5' for CEX2C and '6' for CEX2A'
+		 * '7' for CEX3C and '8' for CEX3A
 		 */
-		if (*ptr >= '0' && *ptr <= '6')
+		if (*ptr >= '0' && *ptr <= '8')
 			j++;
 		else if (*ptr == 'd' || *ptr == 'D')
 			zcrypt_disable_card(j++);
Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:15.000000000 +0100
@@ -49,7 +49,7 @@
 
 static struct ap_device_id zcrypt_cex2a_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2A) },
-	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2A2) },
+	{ AP_DEVICE(AP_DEVICE_TYPE_CEX3A) },
 	{ /* end of list */ },
 };
 
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:15.000000000 +0100
@@ -72,7 +72,7 @@
 static struct ap_device_id zcrypt_pcixcc_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_PCIXCC) },
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2C) },
-	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2C2) },
+	{ AP_DEVICE(AP_DEVICE_TYPE_CEX3C) },
 	{ /* end of list */ },
 };
 
