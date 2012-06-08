Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1339194367.30984.18.camel@x61.thuisdomein>
Subject: [PATCH] crypto: s390 - clean up DES code a bit more
From: Paul Bolle <pebolle@tiscali.nl>
Date: Sat, 09 Jun 2012 00:26:07 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Herbert Xu <herbert@gondor.hengli.com.au>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit 98971f8439b1bb9a61682fe24a865ddd25167a6b ("crypto: s390 - cleanup
DES code") should have also removed crypto_des.h. That file is unused
and unneeded since that commit. So let's clean up that file too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Ought to be correct.

 arch/s390/crypto/crypto_des.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)
 delete mode 100644 arch/s390/crypto/crypto_des.h

diff --git a/arch/s390/crypto/crypto_des.h b/arch/s390/crypto/crypto_des.h
deleted file mode 100644
index 6210457..0000000
--- a/arch/s390/crypto/crypto_des.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Cryptographic API.
- *
- * Function for checking keys for the DES and Tripple DES Encryption
- * algorithms.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#ifndef __CRYPTO_DES_H__
-#define __CRYPTO_DES_H__
-
-extern int crypto_des_check_key(const u8*, unsigned int, u32*);
-
-#endif /*__CRYPTO_DES_H__*/
-- 
1.7.7.6
