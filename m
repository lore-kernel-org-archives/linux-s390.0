Return-Path: <linux-kernel-owner+w=401wt.eu-S1764008AbZBYPU6@vger.kernel.org>
Message-Id: <20090225150838.199361626@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:07:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 40/46] allow usage of string functions in linux/string.h
Content-Disposition: inline; filename=139-string-protos.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Rusty Russell <rusty@rustcorp.com.au>

In introducing a trivial "strstarts()" function in linux/string.h, we
hit the following error on s390:

In file included from include/linux/bitmap.h:8,
                 from include/linux/cpumask.h:142,
                 from include/linux/smp.h:12,
                 from /home/rusty/devel/kernel/patches/linux-2.6/arch/s390/include/asm/spinlock.h:14,
                 from include/linux/spinlock.h:88,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/s390/lib/string.c:13:
include/linux/string.h: In function 'strstarts':
include/linux/string.h:124: error: implicit declaration of function 'strlen'
include/linux/string.h:124: warning: incompatible implicit declaration of built-in function 'strlen'

Because when including asm/string.h from arch/s390/lib/string.c we
don't declare the string ops we are about to define, and
linux/string.h barfs.

The fix is to declare them in this IN_ARCH_STRING_C case, but in
general I wonder if there's a neater fix.

Reported-by: linux-next
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/string.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/string.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/string.h
+++ quilt-2.6/arch/s390/include/asm/string.h
@@ -135,7 +135,13 @@ static inline size_t strnlen(const char 
 		: "+a" (end), "+a" (tmp) : "d" (r0)  : "cc");
 	return end - s;
 }
-
+#else /* IN_ARCH_STRING_C */
+void *memchr(const void * s, int c, size_t n);
+void *memscan(void *s, int c, size_t n);
+char *strcat(char *dst, const char *src);
+char *strcpy(char *dst, const char *src);
+size_t strlen(const char *s);
+size_t strnlen(const char * s, size_t n);
 #endif /* !IN_ARCH_STRING_C */
 
 #endif /* __KERNEL__ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
