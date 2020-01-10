Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:45970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgAJOyt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:49 -0500
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 10/10] s390x: Mark archrandom.h functions __must_check
Date: Fri, 10 Jan 2020 14:54:22 +0000
Message-Id: <20200110145422.49141-11-broonie@kernel.org>
In-Reply-To: <20200110145422.49141-1-broonie@kernel.org>
References: <20200110145422.49141-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Borislav Petkov <bp@alien8.de>, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, x86@kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Harald Freudenberger <freude@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>, Richard Henderson <rth@twiddle.net>, Mark Brown <broonie@kernel.org>

From: Richard Henderson <richard.henderson@linaro.org>

We must not use the pointer output without validating the
success of the random read.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/s390/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index 9a6835137a16..de61ce562052 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -21,17 +21,17 @@ extern atomic64_t s390_arch_random_counter;
 
 bool s390_arch_random_generate(u8 *buf, unsigned int nbytes);
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
@@ -39,7 +39,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
-- 
2.20.1
