Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/12] s390: crypto: add SPDX identifiers to the remaining files
Date: Fri, 24 Nov 2017 15:00:34 +0100
Message-Id: <20171124140043.10062-4-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the arch/s390/crypto/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/crypto/aes_s390.c    | 1 +
 arch/s390/crypto/arch_random.c | 1 +
 arch/s390/crypto/crc32-vx.c    | 1 +
 arch/s390/crypto/des_s390.c    | 1 +
 arch/s390/crypto/ghash_s390.c  | 1 +
 arch/s390/crypto/paes_s390.c   | 1 +
 arch/s390/crypto/prng.c        | 1 +
 arch/s390/crypto/sha.h         | 1 +
 arch/s390/crypto/sha256_s390.c | 1 +
 arch/s390/crypto/sha512_s390.c | 1 +
 arch/s390/crypto/sha_common.c  | 1 +
 11 files changed, 11 insertions(+)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index b48e20dd94e9..5a7b60a65f96 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/arch_random.c b/arch/s390/crypto/arch_random.c
index 36aefc07d10c..7ad00354fb25 100644
--- a/arch/s390/crypto/arch_random.c
+++ b/arch/s390/crypto/arch_random.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * s390 arch random implementation.
  *
diff --git a/arch/s390/crypto/crc32-vx.c b/arch/s390/crypto/crc32-vx.c
index 992e630c227b..436865926c26 100644
--- a/arch/s390/crypto/crc32-vx.c
+++ b/arch/s390/crypto/crc32-vx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Crypto-API module for CRC-32 algorithms implemented with the
  * z/Architecture Vector Extension Facility.
diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index 0d296662bbf0..c871b1086408 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/ghash_s390.c b/arch/s390/crypto/ghash_s390.c
index 564616d48d8b..3b7f96c9eead 100644
--- a/arch/s390/crypto/ghash_s390.c
+++ b/arch/s390/crypto/ghash_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index a4e903ed7e21..53926a2b7285 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 3e47c4a0f18b..a97a1802cfb4 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright IBM Corp. 2006, 2015
  * Author(s): Jan Glauber <jan.glauber@de.ibm.com>
diff --git a/arch/s390/crypto/sha.h b/arch/s390/crypto/sha.h
index 10f200790079..19d344d49392 100644
--- a/arch/s390/crypto/sha.h
+++ b/arch/s390/crypto/sha.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 53c277999a28..4a31d6416d41 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
index 2f4caa1ef123..e22ed139d0b6 100644
--- a/arch/s390/crypto/sha512_s390.c
+++ b/arch/s390/crypto/sha512_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
diff --git a/arch/s390/crypto/sha_common.c b/arch/s390/crypto/sha_common.c
index c740f77285b2..d359ec7fdd6b 100644
--- a/arch/s390/crypto/sha_common.c
+++ b/arch/s390/crypto/sha_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
-- 
2.15.0
