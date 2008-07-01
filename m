Return-Path: <linux-kernel-owner+w=401wt.eu-S1757224AbYGAMwh@vger.kernel.org>
Message-Id: <20080701125001.167460745@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/14] zcrypt: Add additional card IDs to CEX2C and CEX2A
Content-Disposition: inline; filename=133-crypto-y4.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>

Add support for new micro code load of CEX2C and CEX2A adapters,
which uses different IDs.  This patch just adds the IDs to the
existing drivers.

Signed-off-by: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.h        |    2 ++
 drivers/s390/crypto/zcrypt_cex2a.c  |    1 +
 drivers/s390/crypto/zcrypt_pcixcc.c |    1 +
 include/asm-s390/zcrypt.h           |    2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.h
+++ quilt-2.6/drivers/s390/crypto/ap_bus.h
@@ -92,6 +92,8 @@ struct ap_queue_status {
 #define AP_DEVICE_TYPE_PCIXCC	5
 #define AP_DEVICE_TYPE_CEX2A	6
 #define AP_DEVICE_TYPE_CEX2C	7
+#define AP_DEVICE_TYPE_CEX2A2	8
+#define AP_DEVICE_TYPE_CEX2C2	9
 
 /*
  * AP reset flag states
Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
@@ -49,6 +49,7 @@
 
 static struct ap_device_id zcrypt_cex2a_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2A) },
+	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2A2) },
 	{ /* end of list */ },
 };
 
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -72,6 +72,7 @@ struct response_type {
 static struct ap_device_id zcrypt_pcixcc_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_PCIXCC) },
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2C) },
+	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2C2) },
 	{ /* end of list */ },
 };
 
Index: quilt-2.6/include/asm-s390/zcrypt.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/zcrypt.h
+++ quilt-2.6/include/asm-s390/zcrypt.h
@@ -29,7 +29,7 @@
 
 #define ZCRYPT_VERSION 2
 #define ZCRYPT_RELEASE 1
-#define ZCRYPT_VARIANT 0
+#define ZCRYPT_VARIANT 1
 
 #include <linux/ioctl.h>
 #include <linux/compiler.h>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
