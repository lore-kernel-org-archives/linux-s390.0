Return-Path: <linux-kernel-owner+w=401wt.eu-S1757080AbZKMPSx@vger.kernel.org>
Message-Id: <20091113150912.583825393@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/52] [PATCH] zcrypt: adjust speed rating between cex2 and pcixcc
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=118-zcrypt-speed-cex2c.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Cards with lower speed rating are prefered. Thus change adjust the
speed rating of cex2c adapters to be prefered before pcixcc, although
they should not appear in the same machine anyway.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_pcixcc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:16.000000000 +0100
@@ -46,9 +46,9 @@
 #define CEX3C_MIN_MOD_SIZE	PCIXCC_MIN_MOD_SIZE
 #define CEX3C_MAX_MOD_SIZE	PCIXCC_MAX_MOD_SIZE
 
-#define PCIXCC_MCL2_SPEED_RATING	7870	/* FIXME: needs finetuning */
+#define PCIXCC_MCL2_SPEED_RATING	7870
 #define PCIXCC_MCL3_SPEED_RATING	7870
-#define CEX2C_SPEED_RATING		8540
+#define CEX2C_SPEED_RATING		7000
 #define CEX3C_SPEED_RATING		10000	/* FIXME: needs finetuning */
 
 #define PCIXCC_MAX_ICA_MESSAGE_SIZE 0x77c  /* max size type6 v2 crt message */
