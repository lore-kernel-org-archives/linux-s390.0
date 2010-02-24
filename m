Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084451.482641064@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/32] [PATCH] bug: use relative pointers in bug table entries
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=120-bug-pointers.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Reduces the size of the bug table entries by 50% on 64bit kernels.
Saves around 30kb on a defconfig kernel.
s390 version of b93a531e "allow bug table entries to use relative
pointers (and use it on x86-64)".

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig           |    3 +++
 arch/s390/include/asm/bug.h |   10 ++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/bug.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/bug.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/bug.h	2010-02-24 09:44:27.000000000 +0100
@@ -5,12 +5,6 @@
 
 #ifdef CONFIG_BUG
 
-#ifdef CONFIG_64BIT
-#define S390_LONG ".quad"
-#else
-#define S390_LONG ".long"
-#endif
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
 #define __EMIT_BUG(x) do {					\
@@ -21,7 +15,7 @@
 		"2:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
 		".section __bug_table,\"a\"\n"			\
-		"3:\t"	S390_LONG "\t1b,2b\n"			\
+		"3:	.long	1b-3b,2b-3b\n"			\
 		"	.short	%0,%1\n"			\
 		"	.org	3b+%2\n"			\
 		".previous\n"					\
@@ -37,7 +31,7 @@
 		"0:	j	0b+2\n"			\
 		"1:\n"					\
 		".section __bug_table,\"a\"\n"		\
-		"2:\t"	S390_LONG "\t1b\n"		\
+		"2:	.long	1b-2b\n"		\
 		"	.short	%0\n"			\
 		"	.org	2b+%1\n"		\
 		".previous\n"				\
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/Kconfig	2010-02-24 09:44:27.000000000 +0100
@@ -54,6 +54,9 @@
 	depends on BUG
 	default y
 
+config GENERIC_BUG_RELATIVE_POINTERS
+	def_bool y
+
 config NO_IOMEM
 	def_bool y
 
