Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390495AbfIVSrB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 22 Sep 2019 14:47:01 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 106/203] s390/kasan: provide uninstrumented __strlen
Date: Sun, 22 Sep 2019 14:42:12 -0400
Message-Id: <20190922184350.30563-106-sashal@kernel.org>
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit f45f7b5bdaa4828ce871cf03f7c01599a0de57a5 ]

s390 kasan code uses sclp_early_printk to report initialization
failures. The code doing that should not be instrumented, because kasan
shadow memory has not been set up yet. Even though sclp_early_core.c is
compiled with instrumentation disabled it uses strlen function, which
is instrumented and would produce shadow memory access if used. To
avoid that, introduce uninstrumented __strlen function to be used
instead.

Before commit 7e0d92f00246 ("s390/kasan: improve string/memory functions
checks") few string functions (including strlen) were escaping kasan
instrumentation due to usage of platform specific versions which are
implemented in inline assembly.

Fixes: 7e0d92f00246 ("s390/kasan: improve string/memory functions checks")
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/string.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 70d87db54e627..4c0690fc5167e 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -71,11 +71,16 @@ extern void *__memmove(void *dest, const void *src, size_t n);
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
 #define memmove(dst, src, len) __memmove(dst, src, len)
 #define memset(s, c, n) __memset(s, c, n)
+#define strlen(s) __strlen(s)
+
+#define __no_sanitize_prefix_strfunc(x) __##x
 
 #ifndef __NO_FORTIFY
 #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
 #endif
 
+#else
+#define __no_sanitize_prefix_strfunc(x) x
 #endif /* defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__) */
 
 void *__memset16(uint16_t *s, uint16_t v, size_t count);
@@ -163,8 +168,8 @@ static inline char *strcpy(char *dst, const char *src)
 }
 #endif
 
-#ifdef __HAVE_ARCH_STRLEN
-static inline size_t strlen(const char *s)
+#if defined(__HAVE_ARCH_STRLEN) || (defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__))
+static inline size_t __no_sanitize_prefix_strfunc(strlen)(const char *s)
 {
 	register unsigned long r0 asm("0") = 0;
 	const char *tmp = s;
-- 
2.20.1
