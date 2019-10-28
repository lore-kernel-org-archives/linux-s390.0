Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54838 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbfJ1VGG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 17:06:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so409210wmk.4
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 14:06:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] random: Mark CONFIG_ARCH_RANDOM functions __must_check
Date: Mon, 28 Oct 2019 22:05:54 +0100
Message-Id: <20191028210559.8289-2-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>, "H. Peter Anvin" <hpa@zytor.com>

We cannot use the pointer output without validating the
success of the random read.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org
---
 include/linux/random.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index f189c927fdea..84947b489649 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -167,11 +167,11 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 #ifdef CONFIG_ARCH_RANDOM
 # include <asm/archrandom.h>
 #else
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return 0;
 }
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return 0;
 }
@@ -179,11 +179,11 @@ static inline bool arch_has_random(void)
 {
 	return 0;
 }
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	return 0;
 }
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	return 0;
 }
-- 
2.17.1
