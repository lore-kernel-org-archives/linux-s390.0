Return-Path: <linux-arch-owner@vger.kernel.org>
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 05/10] linux/random.h: Use false with bool
Date: Fri, 10 Jan 2020 14:54:17 +0000
Message-Id: <20200110145422.49141-6-broonie@kernel.org>
In-Reply-To: <20200110145422.49141-1-broonie@kernel.org>
References: <20200110145422.49141-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Borislav Petkov <bp@alien8.de>, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, x86@kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, Richard Henderson <rth@twiddle.net>, Mark Brown <broonie@kernel.org>

From: Richard Henderson <richard.henderson@linaro.org>

Keep the generic fallback versions in sync with the other architecture
specific implementations and use the proper name for false.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/random.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 7fd0360908d2..ea0e2f5f1ec5 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -169,19 +169,19 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 #else
 static inline bool arch_get_random_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 static inline bool arch_get_random_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 static inline bool arch_get_random_seed_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 static inline bool arch_get_random_seed_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.20.1
