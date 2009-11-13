Return-Path: <linux-kernel-owner+w=401wt.eu-S1757171AbZKMPTi@vger.kernel.org>
Message-Id: <20091113150912.741724849@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/52] [PATCH] zcrypt: adjust speed rating of cex3 adapters
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=119-zcrypt-speed-cex3.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Cex3 needs a lower speed rating. Otherwise cex2 adapters will be
prefered.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_cex2a.c  |    2 +-
 drivers/s390/crypto/zcrypt_pcixcc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:16.000000000 +0100
@@ -43,7 +43,7 @@
 #define CEX3A_MAX_MOD_SIZE	CEX2A_MAX_MOD_SIZE
 
 #define CEX2A_SPEED_RATING	970
-#define CEX3A_SPEED_RATING	1100
+#define CEX3A_SPEED_RATING	900 /* Fixme: Needs finetuning */
 
 #define CEX2A_MAX_MESSAGE_SIZE	0x390	/* sizeof(struct type50_crb2_msg)    */
 #define CEX2A_MAX_RESPONSE_SIZE 0x110	/* max outputdatalength + type80_hdr */
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:16.000000000 +0100
@@ -49,7 +49,7 @@
 #define PCIXCC_MCL2_SPEED_RATING	7870
 #define PCIXCC_MCL3_SPEED_RATING	7870
 #define CEX2C_SPEED_RATING		7000
-#define CEX3C_SPEED_RATING		10000	/* FIXME: needs finetuning */
+#define CEX3C_SPEED_RATING		6500	/* FIXME: needs finetuning */
 
 #define PCIXCC_MAX_ICA_MESSAGE_SIZE 0x77c  /* max size type6 v2 crt message */
 #define PCIXCC_MAX_ICA_RESPONSE_SIZE 0x77c /* max size type86 v2 reply	    */
