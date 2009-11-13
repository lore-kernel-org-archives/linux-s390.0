Return-Path: <linux-kernel-owner+w=401wt.eu-S1757118AbZKMPQP@vger.kernel.org>
Message-Id: <20091113150912.436719118@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/52] [PATCH] zcrypt: use definitions for cex3
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=117-cex3-use-def.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Ralph Wuerthner <ralph.wuerthner@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

New definitions are added for CEX3 device types. They will be set
in the according probe functions. CEX3 device types will be handled
in the same modules as CEX2 device types. In the first step they are
the same as CEX2 types, but they can be adjusted for further
characteristics of CEX3 easily.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_api.h    |    2 +
 drivers/s390/crypto/zcrypt_cex2a.c  |   69 +++++++++++++++++++++++-------------
 drivers/s390/crypto/zcrypt_pcixcc.c |   22 +++++++++--
 3 files changed, 66 insertions(+), 27 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/zcrypt_api.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_api.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_api.h	2009-11-13 16:08:16.000000000 +0100
@@ -71,6 +71,8 @@
 #define ZCRYPT_PCIXCC_MCL3	4
 #define ZCRYPT_CEX2C		5
 #define ZCRYPT_CEX2A		6
+#define ZCRYPT_CEX3C		7
+#define ZCRYPT_CEX3A		8
 
 /**
  * Large random numbers are pulled in 4096 byte chunks from the crypto cards
Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:16.000000000 +0100
@@ -39,13 +39,20 @@
 
 #define CEX2A_MIN_MOD_SIZE	  1	/*    8 bits	*/
 #define CEX2A_MAX_MOD_SIZE	256	/* 2048 bits	*/
+#define CEX3A_MIN_MOD_SIZE	CEX2A_MIN_MOD_SIZE
+#define CEX3A_MAX_MOD_SIZE	CEX2A_MAX_MOD_SIZE
 
 #define CEX2A_SPEED_RATING	970
+#define CEX3A_SPEED_RATING	1100
 
 #define CEX2A_MAX_MESSAGE_SIZE	0x390	/* sizeof(struct type50_crb2_msg)    */
 #define CEX2A_MAX_RESPONSE_SIZE 0x110	/* max outputdatalength + type80_hdr */
 
+#define CEX3A_MAX_MESSAGE_SIZE	CEX2A_MAX_MESSAGE_SIZE
+#define CEX3A_MAX_RESPONSE_SIZE	CEX2A_MAX_RESPONSE_SIZE
+
 #define CEX2A_CLEANUP_TIME	(15*HZ)
+#define CEX3A_CLEANUP_TIME	CEX2A_CLEANUP_TIME
 
 static struct ap_device_id zcrypt_cex2a_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2A) },
@@ -375,31 +382,45 @@
  */
 static int zcrypt_cex2a_probe(struct ap_device *ap_dev)
 {
-	struct zcrypt_device *zdev;
-	int rc;
+	struct zcrypt_device *zdev = NULL;
+	int rc = 0;
 
-	zdev = zcrypt_device_alloc(CEX2A_MAX_RESPONSE_SIZE);
-	if (!zdev)
-		return -ENOMEM;
-	zdev->ap_dev = ap_dev;
-	zdev->ops = &zcrypt_cex2a_ops;
-	zdev->online = 1;
-	zdev->user_space_type = ZCRYPT_CEX2A;
-	zdev->type_string = "CEX2A";
-	zdev->min_mod_size = CEX2A_MIN_MOD_SIZE;
-	zdev->max_mod_size = CEX2A_MAX_MOD_SIZE;
-	zdev->short_crt = 1;
-	zdev->speed_rating = CEX2A_SPEED_RATING;
-	ap_dev->reply = &zdev->reply;
-	ap_dev->private = zdev;
-	rc = zcrypt_device_register(zdev);
-	if (rc)
-		goto out_free;
-	return 0;
-
-out_free:
-	ap_dev->private = NULL;
-	zcrypt_device_free(zdev);
+	switch (ap_dev->device_type) {
+	case AP_DEVICE_TYPE_CEX2A:
+		zdev = zcrypt_device_alloc(CEX2A_MAX_RESPONSE_SIZE);
+		if (!zdev)
+			return -ENOMEM;
+		zdev->user_space_type = ZCRYPT_CEX2A;
+		zdev->type_string = "CEX2A";
+		zdev->min_mod_size = CEX2A_MIN_MOD_SIZE;
+		zdev->max_mod_size = CEX2A_MAX_MOD_SIZE;
+		zdev->short_crt = 1;
+		zdev->speed_rating = CEX2A_SPEED_RATING;
+		break;
+	case AP_DEVICE_TYPE_CEX3A:
+		zdev = zcrypt_device_alloc(CEX3A_MAX_RESPONSE_SIZE);
+		if (!zdev)
+			return -ENOMEM;
+		zdev->user_space_type = ZCRYPT_CEX3A;
+		zdev->type_string = "CEX3A";
+		zdev->min_mod_size = CEX3A_MIN_MOD_SIZE;
+		zdev->max_mod_size = CEX3A_MAX_MOD_SIZE;
+		zdev->short_crt = 1;
+		zdev->speed_rating = CEX3A_SPEED_RATING;
+		break;
+	}
+	if (zdev != NULL) {
+		zdev->ap_dev = ap_dev;
+		zdev->ops = &zcrypt_cex2a_ops;
+		zdev->online = 1;
+		ap_dev->reply = &zdev->reply;
+		ap_dev->private = zdev;
+		rc = zcrypt_device_register(zdev);
+	}
+	if (rc) {
+		ap_dev->private = NULL;
+		zcrypt_device_free(zdev);
+	}
 	return rc;
 }
 
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:15.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:16.000000000 +0100
@@ -43,10 +43,13 @@
 #define PCIXCC_MIN_MOD_SIZE	 16	/*  128 bits	*/
 #define PCIXCC_MIN_MOD_SIZE_OLD	 64	/*  512 bits	*/
 #define PCIXCC_MAX_MOD_SIZE	256	/* 2048 bits	*/
+#define CEX3C_MIN_MOD_SIZE	PCIXCC_MIN_MOD_SIZE
+#define CEX3C_MAX_MOD_SIZE	PCIXCC_MAX_MOD_SIZE
 
 #define PCIXCC_MCL2_SPEED_RATING	7870	/* FIXME: needs finetuning */
 #define PCIXCC_MCL3_SPEED_RATING	7870
 #define CEX2C_SPEED_RATING		8540
+#define CEX3C_SPEED_RATING		10000	/* FIXME: needs finetuning */
 
 #define PCIXCC_MAX_ICA_MESSAGE_SIZE 0x77c  /* max size type6 v2 crt message */
 #define PCIXCC_MAX_ICA_RESPONSE_SIZE 0x77c /* max size type86 v2 reply	    */
@@ -1026,14 +1029,15 @@
 static int zcrypt_pcixcc_probe(struct ap_device *ap_dev)
 {
 	struct zcrypt_device *zdev;
-	int rc;
+	int rc = 0;
 
 	zdev = zcrypt_device_alloc(PCIXCC_MAX_RESPONSE_SIZE);
 	if (!zdev)
 		return -ENOMEM;
 	zdev->ap_dev = ap_dev;
 	zdev->online = 1;
-	if (ap_dev->device_type == AP_DEVICE_TYPE_PCIXCC) {
+	switch (ap_dev->device_type) {
+	case AP_DEVICE_TYPE_PCIXCC:
 		rc = zcrypt_pcixcc_mcl(ap_dev);
 		if (rc < 0) {
 			zcrypt_device_free(zdev);
@@ -1051,13 +1055,25 @@
 			zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE;
 			zdev->max_mod_size = PCIXCC_MAX_MOD_SIZE;
 		}
-	} else {
+		break;
+	case AP_DEVICE_TYPE_CEX2C:
 		zdev->user_space_type = ZCRYPT_CEX2C;
 		zdev->type_string = "CEX2C";
 		zdev->speed_rating = CEX2C_SPEED_RATING;
 		zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE;
 		zdev->max_mod_size = PCIXCC_MAX_MOD_SIZE;
+		break;
+	case AP_DEVICE_TYPE_CEX3C:
+		zdev->user_space_type = ZCRYPT_CEX3C;
+		zdev->type_string = "CEX3C";
+		zdev->speed_rating = CEX3C_SPEED_RATING;
+		zdev->min_mod_size = CEX3C_MIN_MOD_SIZE;
+		zdev->max_mod_size = CEX3C_MAX_MOD_SIZE;
+		break;
+	default:
+		goto out_free;
 	}
+
 	rc = zcrypt_pcixcc_rng_supported(ap_dev);
 	if (rc < 0) {
 		zcrypt_device_free(zdev);
