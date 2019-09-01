Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbfIAUgV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 1 Sep 2019 16:36:21 -0400
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 9/9] crypto: sha256 - Remove sha256/224_init code duplication
Date: Sun,  1 Sep 2019 22:35:32 +0200
Message-Id: <20190901203532.2615-10-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Atul Gupta <atul.gupta@chelsio.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

lib/crypto/sha256.c and include/crypto/sha256_base.h define
99% identical functions to init a sha256_state struct for sha224 or
sha256 use.

This commit moves the functions from lib/crypto/sha256.c to
include/crypto/sha.h (making them static inline) and makes the
sha224/256_base_init static inline functions from
include/crypto/sha256_base.h wrappers around the now also
static inline include/crypto/sha.h functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/crypto/sha.h         | 30 ++++++++++++++++++++++++++++--
 include/crypto/sha256_base.h | 24 ++----------------------
 lib/crypto/sha256.c          | 32 --------------------------------
 3 files changed, 30 insertions(+), 56 deletions(-)

diff --git a/include/crypto/sha.h b/include/crypto/sha.h
index 535955c84187..5c2132c71900 100644
--- a/include/crypto/sha.h
+++ b/include/crypto/sha.h
@@ -123,12 +123,38 @@ extern int crypto_sha512_finup(struct shash_desc *desc, const u8 *data,
  * For details see lib/crypto/sha256.c
  */
 
-extern int sha256_init(struct sha256_state *sctx);
+static inline int sha256_init(struct sha256_state *sctx)
+{
+	sctx->state[0] = SHA256_H0;
+	sctx->state[1] = SHA256_H1;
+	sctx->state[2] = SHA256_H2;
+	sctx->state[3] = SHA256_H3;
+	sctx->state[4] = SHA256_H4;
+	sctx->state[5] = SHA256_H5;
+	sctx->state[6] = SHA256_H6;
+	sctx->state[7] = SHA256_H7;
+	sctx->count = 0;
+
+	return 0;
+}
 extern int sha256_update(struct sha256_state *sctx, const u8 *input,
 			 unsigned int length);
 extern int sha256_final(struct sha256_state *sctx, u8 *hash);
 
-extern int sha224_init(struct sha256_state *sctx);
+static inline int sha224_init(struct sha256_state *sctx)
+{
+	sctx->state[0] = SHA224_H0;
+	sctx->state[1] = SHA224_H1;
+	sctx->state[2] = SHA224_H2;
+	sctx->state[3] = SHA224_H3;
+	sctx->state[4] = SHA224_H4;
+	sctx->state[5] = SHA224_H5;
+	sctx->state[6] = SHA224_H6;
+	sctx->state[7] = SHA224_H7;
+	sctx->count = 0;
+
+	return 0;
+}
 extern int sha224_update(struct sha256_state *sctx, const u8 *input,
 			 unsigned int length);
 extern int sha224_final(struct sha256_state *sctx, u8 *hash);
diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index 59159bc944f5..b8af853690b9 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -19,34 +19,14 @@ static inline int sha224_base_init(struct shash_desc *desc)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
-	sctx->state[0] = SHA224_H0;
-	sctx->state[1] = SHA224_H1;
-	sctx->state[2] = SHA224_H2;
-	sctx->state[3] = SHA224_H3;
-	sctx->state[4] = SHA224_H4;
-	sctx->state[5] = SHA224_H5;
-	sctx->state[6] = SHA224_H6;
-	sctx->state[7] = SHA224_H7;
-	sctx->count = 0;
-
-	return 0;
+	return sha224_init(sctx);
 }
 
 static inline int sha256_base_init(struct shash_desc *desc)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
-	sctx->state[0] = SHA256_H0;
-	sctx->state[1] = SHA256_H1;
-	sctx->state[2] = SHA256_H2;
-	sctx->state[3] = SHA256_H3;
-	sctx->state[4] = SHA256_H4;
-	sctx->state[5] = SHA256_H5;
-	sctx->state[6] = SHA256_H6;
-	sctx->state[7] = SHA256_H7;
-	sctx->count = 0;
-
-	return 0;
+	return sha256_init(sctx);
 }
 
 static inline int sha256_base_do_update(struct shash_desc *desc,
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 220b74c2bbd8..66cb04b0cf4e 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -206,38 +206,6 @@ static void sha256_transform(u32 *state, const u8 *input)
 	memzero_explicit(W, 64 * sizeof(u32));
 }
 
-int sha256_init(struct sha256_state *sctx)
-{
-	sctx->state[0] = SHA256_H0;
-	sctx->state[1] = SHA256_H1;
-	sctx->state[2] = SHA256_H2;
-	sctx->state[3] = SHA256_H3;
-	sctx->state[4] = SHA256_H4;
-	sctx->state[5] = SHA256_H5;
-	sctx->state[6] = SHA256_H6;
-	sctx->state[7] = SHA256_H7;
-	sctx->count = 0;
-
-	return 0;
-}
-EXPORT_SYMBOL(sha256_init);
-
-int sha224_init(struct sha256_state *sctx)
-{
-	sctx->state[0] = SHA224_H0;
-	sctx->state[1] = SHA224_H1;
-	sctx->state[2] = SHA224_H2;
-	sctx->state[3] = SHA224_H3;
-	sctx->state[4] = SHA224_H4;
-	sctx->state[5] = SHA224_H5;
-	sctx->state[6] = SHA224_H6;
-	sctx->state[7] = SHA224_H7;
-	sctx->count = 0;
-
-	return 0;
-}
-EXPORT_SYMBOL(sha224_init);
-
 int sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	unsigned int partial, done;
-- 
2.23.0
