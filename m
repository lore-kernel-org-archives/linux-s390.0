Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 6/7] crypto: sha256 - Add sha224 support to sha256 library code
Date: Sat, 17 Aug 2019 16:24:34 +0200
Message-Id: <20190817142435.8532-7-hdegoede@redhat.com>
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
References: <20190817142435.8532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Add sha224 support to the lib/crypto/sha256 library code. This will allow
us to replace both the sha256 and sha224 parts of crypto/sha256_generic.c
when we remove the code duplication in further patches in this series.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/crypto/sha256.h |  5 +++++
 lib/crypto/sha256.c     | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/crypto/sha256.h b/include/crypto/sha256.h
index 9cbb3589b8b3..a75998d65a41 100644
--- a/include/crypto/sha256.h
+++ b/include/crypto/sha256.h
@@ -26,4 +26,9 @@ extern int sha256_update(struct sha256_state *sctx, const u8 *input,
 			 unsigned int length);
 extern int sha256_final(struct sha256_state *sctx, u8 *hash);
 
+extern int sha224_init(struct sha256_state *sctx);
+extern int sha224_update(struct sha256_state *sctx, const u8 *input,
+			 unsigned int length);
+extern int sha224_final(struct sha256_state *sctx, u8 *hash);
+
 #endif /* SHA256_H */
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index f2ed75ae6910..45ad87520769 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -221,6 +221,22 @@ int sha256_init(struct sha256_state *sctx)
 }
 EXPORT_SYMBOL(sha256_init);
 
+int sha224_init(struct sha256_state *sctx)
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
+EXPORT_SYMBOL(sha224_init);
+
 int sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	unsigned int partial, done;
@@ -252,7 +268,13 @@ int sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 }
 EXPORT_SYMBOL(sha256_update);
 
-int sha256_final(struct sha256_state *sctx, u8 *out)
+int sha224_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
+{
+	return sha256_update(sctx, data, len);
+}
+EXPORT_SYMBOL(sha224_update);
+
+static int __sha256_final(struct sha256_state *sctx, u8 *out, int digest_words)
 {
 	__be32 *dst = (__be32 *)out;
 	__be64 bits;
@@ -272,7 +294,7 @@ int sha256_final(struct sha256_state *sctx, u8 *out)
 	sha256_update(sctx, (const u8 *)&bits, sizeof(bits));
 
 	/* Store state in digest */
-	for (i = 0; i < 8; i++)
+	for (i = 0; i < digest_words; i++)
 		put_unaligned_be32(sctx->state[i], &dst[i]);
 
 	/* Zeroize sensitive information. */
@@ -280,4 +302,15 @@ int sha256_final(struct sha256_state *sctx, u8 *out)
 
 	return 0;
 }
+
+int sha256_final(struct sha256_state *sctx, u8 *out)
+{
+	return __sha256_final(sctx, out, 8);
+}
 EXPORT_SYMBOL(sha256_final);
+
+int sha224_final(struct sha256_state *sctx, u8 *out)
+{
+	return __sha256_final(sctx, out, 7);
+}
+EXPORT_SYMBOL(sha224_final);
-- 
2.23.0.rc2
