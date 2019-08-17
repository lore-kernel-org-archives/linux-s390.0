Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/7] crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit
Date: Sat, 17 Aug 2019 16:24:32 +0200
Message-Id: <20190817142435.8532-5-hdegoede@redhat.com>
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
References: <20190817142435.8532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Use get/put_unaligned_be32 in lib/crypto/sha256.c to load / store data
so that it can be used with unaligned buffers too, making it more generic.

And use memzero_explicit for better clearing of sensitive data.

Note unlike other patches in this series this commit actually makes
functional changes to the sha256 code as used by the purgatory code.

This fully aligns the lib/crypto/sha256.c sha256 implementation with the
one from crypto/sha256_generic.c allowing us to remove the latter in
further patches in this series.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Also switch to put_unaligned_be32 to store the hash
---
 lib/crypto/sha256.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index b8114028d06f..1458a20d53a5 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -14,7 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/string.h>
 #include <crypto/sha256.h>
-#include <asm/byteorder.h>
+#include <asm/unaligned.h>
 
 static inline u32 Ch(u32 x, u32 y, u32 z)
 {
@@ -33,7 +33,7 @@ static inline u32 Maj(u32 x, u32 y, u32 z)
 
 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
 {
-	W[I] = __be32_to_cpu(((__be32 *)(input))[I]);
+	W[I] = get_unaligned_be32((__u32 *)input + I);
 }
 
 static inline void BLEND_OP(int I, u32 *W)
@@ -201,7 +201,7 @@ static void sha256_transform(u32 *state, const u8 *input)
 
 	/* clear any sensitive info... */
 	a = b = c = d = e = f = g = h = t1 = t2 = 0;
-	memset(W, 0, 64 * sizeof(u32));
+	memzero_explicit(W, 64 * sizeof(u32));
 }
 
 int sha256_init(struct sha256_state *sctx)
@@ -270,7 +270,7 @@ int sha256_final(struct sha256_state *sctx, u8 *out)
 
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
-		dst[i] = cpu_to_be32(sctx->state[i]);
+		put_unaligned_be32(sctx->state[i], &dst[i]);
 
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(*sctx));
-- 
2.23.0.rc2
