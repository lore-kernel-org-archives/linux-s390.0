Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] lib: Remove strnicmp
Date: Thu, 11 Dec 2014 10:39:32 +0100
Message-Id: <1418290772-5578-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now that all in-tree users of strnicmp have been converted to
strncasecmp, the wrapper can be removed.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Notes:
    For 3.20.
    
    The "#undef __HAVE_ARCH_STRNICMP" in arch/s390/include/asm/string.h is
    a no-op, so removing it should be ok. I'm less certain about the
    change in arch/frv/, so please speak up if it should stay. (The patch
    hunk doesn't show it, but it is in a !__KERNEL__ section, so doesn't
    affect kernel builds.)

 arch/frv/include/asm/string.h  | 1 -
 arch/s390/include/asm/string.h | 1 -
 include/linux/string.h         | 3 ---
 lib/string.c                   | 8 --------
 4 files changed, 13 deletions(-)

diff --git a/arch/frv/include/asm/string.h b/arch/frv/include/asm/string.h
index 5ed310f64b7e..1f6c35990439 100644
--- a/arch/frv/include/asm/string.h
+++ b/arch/frv/include/asm/string.h
@@ -33,7 +33,6 @@ extern void *memcpy(void *, const void *, __kernel_size_t);
 #define __HAVE_ARCH_STRNCAT 1
 #define __HAVE_ARCH_STRCMP 1
 #define __HAVE_ARCH_STRNCMP 1
-#define __HAVE_ARCH_STRNICMP 1
 #define __HAVE_ARCH_STRCHR 1
 #define __HAVE_ARCH_STRRCHR 1
 #define __HAVE_ARCH_STRSTR 1
diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 7e2dcd7c57ef..8662f5c8e17f 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -44,7 +44,6 @@ extern char *strstr(const char *, const char *);
 #undef __HAVE_ARCH_STRCHR
 #undef __HAVE_ARCH_STRNCHR
 #undef __HAVE_ARCH_STRNCMP
-#undef __HAVE_ARCH_STRNICMP
 #undef __HAVE_ARCH_STRPBRK
 #undef __HAVE_ARCH_STRSEP
 #undef __HAVE_ARCH_STRSPN
diff --git a/include/linux/string.h b/include/linux/string.h
index 2e22a2e58f3a..b9bc9a5d9e21 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -40,9 +40,6 @@ extern int strcmp(const char *,const char *);
 #ifndef __HAVE_ARCH_STRNCMP
 extern int strncmp(const char *,const char *,__kernel_size_t);
 #endif
-#ifndef __HAVE_ARCH_STRNICMP
-#define strnicmp strncasecmp
-#endif
 #ifndef __HAVE_ARCH_STRCASECMP
 extern int strcasecmp(const char *s1, const char *s2);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 10063300b830..3206d0178296 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -58,14 +58,6 @@ int strncasecmp(const char *s1, const char *s2, size_t len)
 }
 EXPORT_SYMBOL(strncasecmp);
 #endif
-#ifndef __HAVE_ARCH_STRNICMP
-#undef strnicmp
-int strnicmp(const char *s1, const char *s2, size_t len)
-{
-	return strncasecmp(s1, s2, len);
-}
-EXPORT_SYMBOL(strnicmp);
-#endif
 
 #ifndef __HAVE_ARCH_STRCASECMP
 int strcasecmp(const char *s1, const char *s2)
-- 
2.1.3
