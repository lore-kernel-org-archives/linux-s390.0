Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] s390/pkey/zcrypt: spelling s/crytp/crypt/
Date: Wed, 12 Feb 2020 09:46:22 +0100
Message-Id: <20200212084622.9219-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Fix typos in a comments.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index d4caf46ff9df1559..2afe2153b34e32e9 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -887,7 +887,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	/* empty pin tag */
 	*p++ = 0x04;
 	*p++ = 0;
-	/* encrytped key value tag and bytes */
+	/* encrypted key value tag and bytes */
 	p += asn1tag_write(p, 0x04, enckey, enckeysize);
 
 	/* reply cprb and payload */
@@ -1095,7 +1095,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 
 	/* Step 1: generate AES 256 bit random kek key */
 	rc = ep11_genaeskey(card, domain, 256,
-			    0x00006c00, /* EN/DECRYTP, WRAP/UNWRAP */
+			    0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
 			    kek, &keklen);
 	if (rc) {
 		DEBUG_ERR(
-- 
2.17.1
