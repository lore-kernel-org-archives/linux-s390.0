Return-Path: <linux-kernel-owner+w=401wt.eu-S936564AbXLTPgv@vger.kernel.org>
Message-Id: <20071220152109.824576241@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/47] arch/s390: Add missing "space"
Content-Disposition: inline; filename=130-arch-whitespace.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/crypto/aes_s390.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/crypto/aes_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/aes_s390.c
+++ quilt-2.6/arch/s390/crypto/aes_s390.c
@@ -341,7 +341,7 @@ static int __init aes_init(void)
 		ecb_aes_alg.cra_u.blkcipher.max_keysize = AES_MIN_KEY_SIZE;
 		cbc_aes_alg.cra_u.blkcipher.max_keysize = AES_MIN_KEY_SIZE;
 		printk(KERN_INFO
-		       "aes_s390: hardware acceleration only available for"
+		       "aes_s390: hardware acceleration only available for "
 		       "128 bit keys\n");
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
