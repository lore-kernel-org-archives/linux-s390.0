Return-Path: <linux-kernel-owner+w=401wt.eu-S1764254AbXGJJ3c@vger.kernel.org>
Message-Id: <20070710093100.843981851@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/16] Fixed comment typo.
Content-Disposition: inline; filename=002-crypto-typo.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ralph Wuerthner <rwuerthn@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/crypt_s390.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/crypto/crypt_s390.h
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/crypt_s390.h
+++ quilt-2.6/arch/s390/crypto/crypt_s390.h
@@ -24,7 +24,7 @@
 #define CRYPT_S390_PRIORITY 300
 #define CRYPT_S390_COMPOSITE_PRIORITY 400
 
-/* s930 cryptographic operations */
+/* s390 cryptographic operations */
 enum crypt_s390_operations {
 	CRYPT_S390_KM   = 0x0100,
 	CRYPT_S390_KMC  = 0x0200,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
