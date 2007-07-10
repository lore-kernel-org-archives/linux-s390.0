Return-Path: <linux-kernel-owner+w=401wt.eu-S1764553AbXGJJbO@vger.kernel.org>
Message-Id: <20070710093117.082040828@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/16] Bogomips calculation for 64 bit.
Content-Disposition: inline; filename=008-bogomips.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The bogomips calculation triggered via reading from /proc/cpuinfo
can return incorrect values if the qrnnd assembly is called with a
pointer in %r2 with any of the upper 32 bits set.
Fix this by using 64 bit division / remainder operation provided by
gcc instead of calling the assembly.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/Makefile         |    4 ++--
 include/asm-s390/sfp-machine.h |    6 +++---
 include/asm-s390/sfp-util.h    |   11 +++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/lib/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/lib/Makefile
+++ quilt-2.6/arch/s390/lib/Makefile
@@ -4,7 +4,7 @@
 
 EXTRA_AFLAGS := -traditional
 
-lib-y += delay.o string.o uaccess_std.o uaccess_pt.o qrnnd.o
-obj-$(CONFIG_32BIT) += div64.o
+lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
+obj-$(CONFIG_32BIT) += div64.o qrnnd.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
 lib-$(CONFIG_SMP) += spinlock.o
Index: quilt-2.6/include/asm-s390/sfp-machine.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/sfp-machine.h
+++ quilt-2.6/include/asm-s390/sfp-machine.h
@@ -27,9 +27,9 @@
    
 
 #define _FP_W_TYPE_SIZE		32
-#define _FP_W_TYPE		unsigned long
-#define _FP_WS_TYPE		signed long
-#define _FP_I_TYPE		long
+#define _FP_W_TYPE		unsigned int
+#define _FP_WS_TYPE		signed int
+#define _FP_I_TYPE		int
 
 #define _FP_MUL_MEAT_S(R,X,Y)					\
   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
Index: quilt-2.6/include/asm-s390/sfp-util.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/sfp-util.h
+++ quilt-2.6/include/asm-s390/sfp-util.h
@@ -51,6 +51,16 @@
 	wl = __wl;					\
 })
 
+#ifdef __s390x__
+#define udiv_qrnnd(q, r, n1, n0, d)			\
+  do { unsigned long __n;				\
+       unsigned int __r, __d;				\
+    __n = ((unsigned long)(n1) << 32) + n0;		\
+    __d = (d);						\
+    (q) = __n / __d;					\
+    (r) = __n % __d;					\
+  } while (0)
+#else
 #define udiv_qrnnd(q, r, n1, n0, d)			\
   do { unsigned int __r;				\
     (q) = __udiv_qrnnd (&__r, (n1), (n0), (d));		\
@@ -58,6 +68,7 @@
   } while (0)
 extern unsigned long __udiv_qrnnd (unsigned int *, unsigned int,
 				   unsigned int , unsigned int);
+#endif
 
 #define UDIV_NEEDS_NORMALIZATION 0
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
