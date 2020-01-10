Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:45824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgAJOye (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:34 -0500
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 03/10] s390: Remove arch_has_random, arch_has_random_seed
Date: Fri, 10 Jan 2020 14:54:15 +0000
Message-Id: <20200110145422.49141-4-broonie@kernel.org>
In-Reply-To: <20200110145422.49141-1-broonie@kernel.org>
References: <20200110145422.49141-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Borislav Petkov <bp@alien8.de>, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, x86@kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Mark Brown <broonie@kernel.org>

From: Richard Henderson <richard.henderson@linaro.org>

These symbols are currently part of the generic archrandom.h
interface, but are currently unused and can be removed.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/s390/include/asm/archrandom.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index c67b82dfa558..9a6835137a16 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -21,18 +21,6 @@ extern atomic64_t s390_arch_random_counter;
 
 bool s390_arch_random_generate(u8 *buf, unsigned int nbytes);
 
-static inline bool arch_has_random(void)
-{
-	return false;
-}
-
-static inline bool arch_has_random_seed(void)
-{
-	if (static_branch_likely(&s390_arch_random_available))
-		return true;
-	return false;
-}
-
 static inline bool arch_get_random_long(unsigned long *v)
 {
 	return false;
-- 
2.20.1
