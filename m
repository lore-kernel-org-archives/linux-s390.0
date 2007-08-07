Return-Path: <linux-kernel-owner+w=401wt.eu-S934267AbXHGLWA@vger.kernel.org>
Message-Id: <20070807111848.751369939@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/18] zcrypt: make init/exit functions static.
Content-Disposition: inline; filename=106-zcrypt-static.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_mono.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/zcrypt_mono.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_mono.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_mono.c
@@ -45,7 +45,7 @@
 /**
  * The module initialization code.
  */
-int __init zcrypt_init(void)
+static int __init zcrypt_init(void)
 {
 	int rc;
 
@@ -86,7 +86,7 @@ out:
 /**
  * The module termination code.
  */
-void __exit zcrypt_exit(void)
+static void __exit zcrypt_exit(void)
 {
 	zcrypt_cex2a_exit();
 	zcrypt_pcixcc_exit();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
