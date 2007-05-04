Return-Path: <linux-kernel-owner+w=401wt.eu-S1031411AbXEDQyX@vger.kernel.org>
Message-Id: <20070504165241.404051202@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/9] aes-s390 key length.
Content-Disposition: inline; filename=002-aes-keylen.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jan Glauber <jan.glauber@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jan.glauber@de.ibm.com>

Register aes-s390 algorithms with the actual supported max keylen size

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/crypto/aes_s390.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

Index: quilt-2.6/arch/s390/crypto/aes_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/aes_s390.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/arch/s390/crypto/aes_s390.c	2007-05-04 18:50:14.000000000 +0200
@@ -119,7 +119,8 @@
 	.cra_name		=	"aes",
 	.cra_driver_name	=	"aes-s390",
 	.cra_priority		=	CRYPT_S390_PRIORITY,
-	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER |
+					CRYPTO_ALG_NEED_FALLBACK,
 	.cra_blocksize		=	AES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
 	.cra_module		=	THIS_MODULE,
@@ -206,7 +207,8 @@
 	.cra_name		=	"ecb(aes)",
 	.cra_driver_name	=	"ecb-aes-s390",
 	.cra_priority		=	CRYPT_S390_COMPOSITE_PRIORITY,
-	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER |
+					CRYPTO_ALG_NEED_FALLBACK,
 	.cra_blocksize		=	AES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
 	.cra_type		=	&crypto_blkcipher_type,
@@ -300,7 +302,8 @@
 	.cra_name		=	"cbc(aes)",
 	.cra_driver_name	=	"cbc-aes-s390",
 	.cra_priority		=	CRYPT_S390_COMPOSITE_PRIORITY,
-	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER |
+					CRYPTO_ALG_NEED_FALLBACK,
 	.cra_blocksize		=	AES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
 	.cra_type		=	&crypto_blkcipher_type,
@@ -333,10 +336,14 @@
 		return -EOPNOTSUPP;
 
 	/* z9 109 and z9 BC/EC only support 128 bit key length */
-	if (keylen_flag == AES_KEYLEN_128)
+	if (keylen_flag == AES_KEYLEN_128) {
+		aes_alg.cra_u.cipher.cia_max_keysize = AES_MIN_KEY_SIZE;
+		ecb_aes_alg.cra_u.blkcipher.max_keysize = AES_MIN_KEY_SIZE;
+		cbc_aes_alg.cra_u.blkcipher.max_keysize = AES_MIN_KEY_SIZE;
 		printk(KERN_INFO
 		       "aes_s390: hardware acceleration only available for"
 		       "128 bit keys\n");
+	}
 
 	ret = crypto_register_alg(&aes_alg);
 	if (ret)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
