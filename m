Return-Path: <linux-kernel-owner+w=401wt.eu-S936787AbXLTPiL@vger.kernel.org>
Message-Id: <20071220152109.427130197@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/47] crypto: move s390 Kconfig options.
Content-Disposition: inline; filename=128-crypto-kconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jan Glauber <jan.glauber@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jan.glauber@de.ibm.com>

Move s390 crypto Kconfig options to drivers/crypto/Kconfig to have all
hardware crypto devices in one place.

This also makes messing up the kernel source tree easier for some people.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/crypto/Kconfig |   60 --------------------------------------------
 drivers/crypto/Kconfig   |   63 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 62 deletions(-)

Index: quilt-2.6/arch/s390/crypto/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/Kconfig
+++ /dev/null
@@ -1,60 +0,0 @@
-config CRYPTO_SHA1_S390
-	tristate "SHA1 digest algorithm"
-	depends on S390
-	select CRYPTO_ALGAPI
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
-
-config CRYPTO_SHA256_S390
-	tristate "SHA256 digest algorithm"
-	depends on S390
-	select CRYPTO_ALGAPI
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA256 secure hash standard (DFIPS 180-2).
-
-	  This version of SHA implements a 256 bit hash with 128 bits of
-	  security against collision attacks.
-
-config CRYPTO_DES_S390
-	tristate "DES and Triple DES cipher algorithms"
-	depends on S390
-	select CRYPTO_ALGAPI
-	select CRYPTO_BLKCIPHER
-	help
-	  This us the s390 hardware accelerated implementation of the
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
-
-config CRYPTO_AES_S390
-	tristate "AES cipher algorithms"
-	depends on S390
-	select CRYPTO_ALGAPI
-	select CRYPTO_BLKCIPHER
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
-	  algorithm.
-
-	  Rijndael appears to be consistently a very good performer in
-	  both hardware and software across a wide range of computing
-	  environments regardless of its use in feedback or non-feedback
-	  modes. Its key setup time is excellent, and its key agility is
-	  good. Rijndael's very low memory requirements make it very well
-	  suited for restricted-space environments, in which it also
-	  demonstrates excellent performance. Rijndael's operations are
-	  among the easiest to defend against power and timing attacks.
-
-	  On s390 the System z9-109 currently only supports the key size
-	  of 128 bit.
-
-config S390_PRNG
-	tristate "Pseudo random number generator device driver"
-	depends on S390
-	default "m"
-	help
-	  Select this option if you want to use the s390 pseudo random number
-	  generator. The PRNG is part of the cryptographic processor functions
-	  and uses triple-DES to generate secure random numbers like the
-	  ANSI X9.17 standard. The PRNG is usable via the char device
-	  /dev/prandom.
Index: quilt-2.6/drivers/crypto/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/crypto/Kconfig
+++ quilt-2.6/drivers/crypto/Kconfig
@@ -48,8 +48,6 @@ config CRYPTO_DEV_PADLOCK_SHA
 	  If unsure say M. The compiled module will be
 	  called padlock-sha.ko
 
-source "arch/s390/crypto/Kconfig"
-
 config CRYPTO_DEV_GEODE
 	tristate "Support for the Geode LX AES engine"
 	depends on X86_32 && PCI
@@ -83,4 +81,65 @@ config ZCRYPT_MONOLITHIC
 	  that contains all parts of the crypto device driver (ap bus,
 	  request router and all the card drivers).
 
+config CRYPTO_SHA1_S390
+	tristate "SHA1 digest algorithm"
+	depends on S390
+	select CRYPTO_ALGAPI
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+
+config CRYPTO_SHA256_S390
+	tristate "SHA256 digest algorithm"
+	depends on S390
+	select CRYPTO_ALGAPI
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA256 secure hash standard (DFIPS 180-2).
+
+	  This version of SHA implements a 256 bit hash with 128 bits of
+	  security against collision attacks.
+
+config CRYPTO_DES_S390
+	tristate "DES and Triple DES cipher algorithms"
+	depends on S390
+	select CRYPTO_ALGAPI
+	select CRYPTO_BLKCIPHER
+	help
+	  This us the s390 hardware accelerated implementation of the
+	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+
+config CRYPTO_AES_S390
+	tristate "AES cipher algorithms"
+	depends on S390
+	select CRYPTO_ALGAPI
+	select CRYPTO_BLKCIPHER
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
+	  algorithm.
+
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing
+	  environments regardless of its use in feedback or non-feedback
+	  modes. Its key setup time is excellent, and its key agility is
+	  good. Rijndael's very low memory requirements make it very well
+	  suited for restricted-space environments, in which it also
+	  demonstrates excellent performance. Rijndael's operations are
+	  among the easiest to defend against power and timing attacks.
+
+	  On s390 the System z9-109 currently only supports the key size
+	  of 128 bit.
+
+config S390_PRNG
+	tristate "Pseudo random number generator device driver"
+	depends on S390
+	default "m"
+	help
+	  Select this option if you want to use the s390 pseudo random number
+	  generator. The PRNG is part of the cryptographic processor functions
+	  and uses triple-DES to generate secure random numbers like the
+	  ANSI X9.17 standard. The PRNG is usable via the char device
+	  /dev/prandom.
+
 endif # CRYPTO_HW

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
