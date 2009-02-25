Return-Path: <linux-kernel-owner+w=401wt.eu-S1763235AbZBYPR3@vger.kernel.org>
Message-Id: <20090225150839.317317892@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:07:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 44/46] use compiler builtin versions of strlen/strcpy/strcat
Content-Disposition: inline; filename=143-string-builtin.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use builtin variants if gcc 4 or newer is used to compile the kernel.
Generates better code than the asm variants.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/string.h |   12 ++++++++++++
 arch/s390/lib/string.c         |   12 ++++++++++++
 2 files changed, 24 insertions(+)

Index: quilt-2.6/arch/s390/include/asm/string.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/string.h
+++ quilt-2.6/arch/s390/include/asm/string.h
@@ -84,6 +84,7 @@ static inline void *memscan(void *s, int
 
 static inline char *strcat(char *dst, const char *src)
 {
+#if __GNUC__ < 4
 	register int r0 asm("0") = 0;
 	unsigned long dummy;
 	char *ret = dst;
@@ -96,10 +97,14 @@ static inline char *strcat(char *dst, co
 		: "=&a" (dummy), "+a" (dst), "+a" (src)
 		: "d" (r0), "0" (0) : "cc", "memory" );
 	return ret;
+#else
+	return __builtin_strcat(dst, src);
+#endif
 }
 
 static inline char *strcpy(char *dst, const char *src)
 {
+#if __GNUC__ < 4
 	register int r0 asm("0") = 0;
 	char *ret = dst;
 
@@ -109,10 +114,14 @@ static inline char *strcpy(char *dst, co
 		: "+&a" (dst), "+&a" (src) : "d" (r0)
 		: "cc", "memory");
 	return ret;
+#else
+	return __builtin_strcpy(dst, src);
+#endif
 }
 
 static inline size_t strlen(const char *s)
 {
+#if __GNUC__ < 4
 	register unsigned long r0 asm("0") = 0;
 	const char *tmp = s;
 
@@ -121,6 +130,9 @@ static inline size_t strlen(const char *
 		"	jo	0b"
 		: "+d" (r0), "+a" (tmp) :  : "cc");
 	return r0 - (unsigned long) s;
+#else
+	return __builtin_strlen(s);
+#endif
 }
 
 static inline size_t strnlen(const char * s, size_t n)
Index: quilt-2.6/arch/s390/lib/string.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/string.c
+++ quilt-2.6/arch/s390/lib/string.c
@@ -44,7 +44,11 @@ static inline char *__strnend(const char
  */
 size_t strlen(const char *s)
 {
+#if __GNUC__ < 4
 	return __strend(s) - s;
+#else
+	return __builtin_strlen(s);
+#endif
 }
 EXPORT_SYMBOL(strlen);
 
@@ -70,6 +74,7 @@ EXPORT_SYMBOL(strnlen);
  */
 char *strcpy(char *dest, const char *src)
 {
+#if __GNUC__ < 4
 	register int r0 asm("0") = 0;
 	char *ret = dest;
 
@@ -78,6 +83,9 @@ char *strcpy(char *dest, const char *src
 		      : "+&a" (dest), "+&a" (src) : "d" (r0)
 		      : "cc", "memory" );
 	return ret;
+#else
+	return __builtin_strcpy(dest, src);
+#endif
 }
 EXPORT_SYMBOL(strcpy);
 
@@ -132,6 +140,7 @@ EXPORT_SYMBOL(strncpy);
  */
 char *strcat(char *dest, const char *src)
 {
+#if __GNUC__ < 4
 	register int r0 asm("0") = 0;
 	unsigned long dummy;
 	char *ret = dest;
@@ -143,6 +152,9 @@ char *strcat(char *dest, const char *src
 		      : "=&a" (dummy), "+a" (dest), "+a" (src)
 		      : "d" (r0), "0" (0UL) : "cc", "memory" );
 	return ret;
+#else
+	return __builtin_strcat(dest, src);
+#endif
 }
 EXPORT_SYMBOL(strcat);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
