Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53929 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHPMf5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Aug 2019 08:35:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so3927638wmp.3
        for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2019 05:35:55 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] crypto: s390/xts-aes - invoke fallback for ciphertext stealing
Date: Fri, 16 Aug 2019 15:35:45 +0300
Message-Id: <20190816123545.22848-1-ard.biesheuvel@linaro.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, ebiggers@kernel.org, linux-s390@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

For correctness and compliance with the XTS-AES specification, we are
adding support for ciphertext stealing to XTS implementations, even
though no use cases are known that will be enabled by this.

Since the s390 implementation already has a fallback skcipher standby
for other purposes, let's use it for this purpose as well. If ciphertext
stealing use cases ever become a bottleneck, we can always revisit this.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/crypto/aes_s390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index dc0f72dd6e03..a34faadc757e 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -512,7 +512,7 @@ static int xts_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 	unsigned long fc;
 	int err;
 
-	err = xts_check_key(tfm, in_key, key_len);
+	err = xts_fallback_setkey(tfm, in_key, key_len);
 	if (err)
 		return err;
 
@@ -529,7 +529,7 @@ static int xts_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 	/* Check if the function code is available */
 	xts_ctx->fc = (fc && cpacf_test_func(&km_functions, fc)) ? fc : 0;
 	if (!xts_ctx->fc)
-		return xts_fallback_setkey(tfm, in_key, key_len);
+		return 0;
 
 	/* Split the XTS key into the two subkeys */
 	key_len = key_len / 2;
@@ -586,7 +586,7 @@ static int xts_aes_encrypt(struct blkcipher_desc *desc,
 	struct s390_xts_ctx *xts_ctx = crypto_blkcipher_ctx(desc->tfm);
 	struct blkcipher_walk walk;
 
-	if (unlikely(!xts_ctx->fc))
+	if (unlikely(!xts_ctx->fc || (nbytes % XTS_BLOCKSIZE) != 0))
 		return xts_fallback_encrypt(desc, dst, src, nbytes);
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
@@ -600,7 +600,7 @@ static int xts_aes_decrypt(struct blkcipher_desc *desc,
 	struct s390_xts_ctx *xts_ctx = crypto_blkcipher_ctx(desc->tfm);
 	struct blkcipher_walk walk;
 
-	if (unlikely(!xts_ctx->fc))
+	if (unlikely(!xts_ctx->fc || (nbytes % XTS_BLOCKSIZE) != 0))
 		return xts_fallback_decrypt(desc, dst, src, nbytes);
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
-- 
2.17.1
