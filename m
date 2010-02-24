Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084447.121436009@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:31 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/32] [PATCH] uaccess: implement strict user copy checks
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=100-strict-copy-user.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Same as on x86 and sparc, besides the fact that enabling the option
will just emit compile time warnings instead of errors.
Keeps allyesconfig kernels compiling.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig.debug         |   13 +++++++++++++
 arch/s390/include/asm/uaccess.h |   12 ++++++++++++
 arch/s390/lib/Makefile          |    2 +-
 arch/s390/lib/usercopy.c        |    8 ++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/uaccess.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/uaccess.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/uaccess.h	2010-02-24 09:44:22.000000000 +0100
@@ -265,6 +265,12 @@
 		return uaccess.copy_from_user(n, from, to);
 }
 
+extern void copy_from_user_overflow(void)
+#ifdef CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
+__compiletime_warning("copy_from_user() buffer size is not provably correct")
+#endif
+;
+
 /**
  * copy_from_user: - Copy a block of data from user space.
  * @to:   Destination address, in kernel space.
@@ -284,7 +290,13 @@
 static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	unsigned int sz = __compiletime_object_size(to);
+
 	might_fault();
+	if (unlikely(sz != -1 && sz < n)) {
+		copy_from_user_overflow();
+		return n;
+	}
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
 	else
Index: quilt-2.6/arch/s390/Kconfig.debug
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig.debug	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/Kconfig.debug	2010-02-24 09:44:22.000000000 +0100
@@ -6,4 +6,17 @@
 
 source "lib/Kconfig.debug"
 
+config DEBUG_STRICT_USER_COPY_CHECKS
+	bool "Strict user copy size checks"
+	---help---
+	  Enabling this option turns a certain set of sanity checks for user
+	  copy operations into compile time warnings.
+
+	  The copy_from_user() etc checks are there to help test if there
+	  are sufficient security checks on the length argument of
+	  the copy operation, by having gcc prove that the argument is
+	  within bounds.
+
+	  If unsure, or if you run an older (pre 4.4) gcc, say N.
+
 endmenu
Index: quilt-2.6/arch/s390/lib/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/lib/Makefile	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/lib/Makefile	2010-02-24 09:44:22.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for s390-specific library files..
 #
 
-lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
+lib-y += delay.o string.o uaccess_std.o uaccess_pt.o usercopy.o
 obj-$(CONFIG_32BIT) += div64.o qrnnd.o ucmpdi2.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
 lib-$(CONFIG_SMP) += spinlock.o
Index: quilt-2.6/arch/s390/lib/usercopy.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/lib/usercopy.c	2010-02-24 09:44:22.000000000 +0100
@@ -0,0 +1,8 @@
+#include <linux/module.h>
+#include <linux/bug.h>
+
+void copy_from_user_overflow(void)
+{
+	WARN(1, "Buffer overflow detected!\n");
+}
+EXPORT_SYMBOL(copy_from_user_overflow);
