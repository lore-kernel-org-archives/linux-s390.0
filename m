Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40017 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbfKFONc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 09:13:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so3493685wmc.5
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 06:13:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 05/10] linux/random.h: Use false with bool
Date: Wed,  6 Nov 2019 15:13:03 +0100
Message-Id: <20191106141308.30535-6-rth@twiddle.net>
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Keep the generic fallback versions in sync with the other architecture
specific implementations and use the proper name for false.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.17.1
