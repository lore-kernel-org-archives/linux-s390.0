Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfIAUf6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 1 Sep 2019 16:35:58 -0400
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/9] crypto: x86 - Rename functions to avoid conflict with crypto/sha256.h
Date: Sun,  1 Sep 2019 22:35:27 +0200
Message-Id: <20190901203532.2615-5-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Atul Gupta <atul.gupta@chelsio.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rename static / file-local functions so that they do not conflict with
the functions declared in crypto/sha256.h.

This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/crypto/sha256_ssse3_glue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 73867da3cbee..f9aff31fe59e 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -45,8 +45,8 @@ asmlinkage void sha256_transform_ssse3(u32 *digest, const char *data,
 				       u64 rounds);
 typedef void (sha256_transform_fn)(u32 *digest, const char *data, u64 rounds);
 
-static int sha256_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len, sha256_transform_fn *sha256_xform)
+static int _sha256_update(struct shash_desc *desc, const u8 *data,
+			  unsigned int len, sha256_transform_fn *sha256_xform)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
@@ -84,7 +84,7 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 static int sha256_ssse3_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return sha256_update(desc, data, len, sha256_transform_ssse3);
+	return _sha256_update(desc, data, len, sha256_transform_ssse3);
 }
 
 static int sha256_ssse3_finup(struct shash_desc *desc, const u8 *data,
@@ -151,7 +151,7 @@ asmlinkage void sha256_transform_avx(u32 *digest, const char *data,
 static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return sha256_update(desc, data, len, sha256_transform_avx);
+	return _sha256_update(desc, data, len, sha256_transform_avx);
 }
 
 static int sha256_avx_finup(struct shash_desc *desc, const u8 *data,
@@ -233,7 +233,7 @@ asmlinkage void sha256_transform_rorx(u32 *digest, const char *data,
 static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return sha256_update(desc, data, len, sha256_transform_rorx);
+	return _sha256_update(desc, data, len, sha256_transform_rorx);
 }
 
 static int sha256_avx2_finup(struct shash_desc *desc, const u8 *data,
@@ -313,7 +313,7 @@ asmlinkage void sha256_ni_transform(u32 *digest, const char *data,
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return sha256_update(desc, data, len, sha256_ni_transform);
+	return _sha256_update(desc, data, len, sha256_ni_transform);
 }
 
 static int sha256_ni_finup(struct shash_desc *desc, const u8 *data,
-- 
2.23.0
