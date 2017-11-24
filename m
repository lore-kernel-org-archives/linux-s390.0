Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/12] s390: crypto: Remove redundant license text
Date: Fri, 24 Nov 2017 15:00:42 +0100
Message-Id: <20171124140043.10062-12-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all arch/s390/crypto/ files, that identifies
the license in a specific and legally-defined manner.  So the extra GPL
text wording can be removed as it is no longer needed at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/crypto/aes_s390.c    | 6 ------
 arch/s390/crypto/arch_random.c | 5 -----
 arch/s390/crypto/des_s390.c    | 6 ------
 arch/s390/crypto/paes_s390.c   | 5 -----
 arch/s390/crypto/sha.h         | 6 ------
 arch/s390/crypto/sha256_s390.c | 6 ------
 arch/s390/crypto/sha512_s390.c | 6 ------
 arch/s390/crypto/sha_common.c  | 6 ------
 8 files changed, 46 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 5a7b60a65f96..d60798737d86 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -12,12 +12,6 @@
  *		Harald Freudenberger <freude@de.ibm.com>
  *
  * Derived from "crypto/aes_generic.c"
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
  */
 
 #define KMSG_COMPONENT "aes_s390"
diff --git a/arch/s390/crypto/arch_random.c b/arch/s390/crypto/arch_random.c
index 7ad00354fb25..8720e9203ecf 100644
--- a/arch/s390/crypto/arch_random.c
+++ b/arch/s390/crypto/arch_random.c
@@ -4,11 +4,6 @@
  *
  * Copyright IBM Corp. 2017
  * Author(s): Harald Freudenberger <freude@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index c871b1086408..5346b5a80bb6 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -7,12 +7,6 @@
  * Copyright IBM Corp. 2003, 2011
  * Author(s): Thomas Spatzier
  *	      Jan Glauber (jan.glauber@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <linux/init.h>
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 53926a2b7285..003932db8d12 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -8,11 +8,6 @@
  *   Copyright IBM Corp. 2017
  *   Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  *		Harald Freudenberger <freude@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  */
 
 #define KMSG_COMPONENT "paes_s390"
diff --git a/arch/s390/crypto/sha.h b/arch/s390/crypto/sha.h
index 19d344d49392..d6f8258b44df 100644
--- a/arch/s390/crypto/sha.h
+++ b/arch/s390/crypto/sha.h
@@ -6,12 +6,6 @@
  *
  * Copyright IBM Corp. 2007
  * Author(s): Jan Glauber (jang@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
  */
 #ifndef _CRYPTO_ARCH_S390_SHA_H
 #define _CRYPTO_ARCH_S390_SHA_H
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 4a31d6416d41..944aa6b237cd 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -7,12 +7,6 @@
  * s390 Version:
  *   Copyright IBM Corp. 2005, 2011
  *   Author(s): Jan Glauber (jang@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
  */
 #include <crypto/internal/hash.h>
 #include <linux/init.h>
diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
index e22ed139d0b6..b17eded532b1 100644
--- a/arch/s390/crypto/sha512_s390.c
+++ b/arch/s390/crypto/sha512_s390.c
@@ -6,12 +6,6 @@
  *
  * Copyright IBM Corp. 2007
  * Author(s): Jan Glauber (jang@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
  */
 #include <crypto/internal/hash.h>
 #include <crypto/sha.h>
diff --git a/arch/s390/crypto/sha_common.c b/arch/s390/crypto/sha_common.c
index d359ec7fdd6b..cf0718d121bc 100644
--- a/arch/s390/crypto/sha_common.c
+++ b/arch/s390/crypto/sha_common.c
@@ -6,12 +6,6 @@
  *
  * Copyright IBM Corp. 2007
  * Author(s): Jan Glauber (jang@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
  */
 
 #include <crypto/internal/hash.h>
-- 
2.15.0
