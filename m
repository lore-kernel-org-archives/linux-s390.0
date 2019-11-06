Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42078 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbfKFONe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 09:13:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so25959337wrf.9
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 06:13:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/10] linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
Date: Wed,  6 Nov 2019 15:13:04 +0100
Message-Id: <20191106141308.30535-7-rth@twiddle.net>
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org

We must not use the pointer output without validating the
success of the random read.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/linux/random.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index ea0e2f5f1ec5..d319f9a1e429 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -167,19 +167,19 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 #ifdef CONFIG_ARCH_RANDOM
 # include <asm/archrandom.h>
 #else
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
 	return false;
 }
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	return false;
 }
-- 
2.17.1
