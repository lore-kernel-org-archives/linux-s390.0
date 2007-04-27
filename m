Return-Path: <linux-kernel-owner+w=401wt.eu-S1755920AbXD0OGf@vger.kernel.org>
Message-Id: <20070427140516.288791876@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/38] Use generic bug.
Content-Disposition: inline; filename=122-bug-output.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Generic bug implementation for s390. Will increase the value of the
console output on BUG() statements since registers r0-r5,r14 will
not be clobbered by a printk() call that was previously done before
the illegal instruction of BUG() was hit.
Also implements an architecture specific WARN_ON(). Output of that
could be increased but requires common code change.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Kconfig              |    5 ++
 arch/s390/defconfig            |    2 +
 arch/s390/kernel/module.c      |    4 +-
 arch/s390/kernel/traps.c       |   17 ++++++++--
 arch/s390/kernel/vmlinux.lds.S |   10 +++++
 include/asm-s390/bug.h         |   69 +++++++++++++++++++++++++++++++++--------
 6 files changed, 89 insertions(+), 18 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/defconfig	2007-04-27 16:04:56.000000000 +0200
@@ -12,6 +12,7 @@
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_BUG=y
 CONFIG_NO_IOMEM=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -705,6 +706,7 @@
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/Kconfig	2007-04-27 16:04:56.000000000 +0200
@@ -41,6 +41,11 @@
 config GENERIC_TIME
 	def_bool y
 
+config GENERIC_BUG
+	bool
+	depends on BUG
+	default y
+
 config NO_IOMEM
 	def_bool y
 
Index: quilt-2.6/arch/s390/kernel/module.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/module.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/module.c	2007-04-27 16:04:56.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/moduleloader.h>
+#include <linux/bug.h>
 
 #if 0
 #define DEBUGP printk
@@ -398,9 +399,10 @@
 		    struct module *me)
 {
 	vfree(me->arch.syminfo);
-	return 0;
+	return module_bug_finalize(hdr, sechdrs, me);
 }
 
 void module_arch_cleanup(struct module *mod)
 {
+	module_bug_cleanup(mod);
 }
Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c	2007-04-27 16:04:56.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/traps.c	2007-04-27 16:04:56.000000000 +0200
@@ -30,7 +30,7 @@
 #include <linux/kallsyms.h>
 #include <linux/reboot.h>
 #include <linux/kprobes.h>
-
+#include <linux/bug.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -297,6 +297,11 @@
 #endif
 }
 
+int is_valid_bugaddr(unsigned long addr)
+{
+	return 1;
+}
+
 static void __kprobes inline do_trap(long interruption_code, int signr,
 					char *str, struct pt_regs *regs,
 					siginfo_t *info)
@@ -323,8 +328,14 @@
                 fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
                 if (fixup)
                         regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
-                else
-                        die(str, regs, interruption_code);
+		else {
+			enum bug_trap_type btt;
+
+			btt = report_bug(regs->psw.addr & PSW_ADDR_INSN);
+			if (btt == BUG_TRAP_TYPE_WARN)
+				return;
+			die(str, regs, interruption_code);
+		}
         }
 }
 
Index: quilt-2.6/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vmlinux.lds.S	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/vmlinux.lds.S	2007-04-27 16:04:56.000000000 +0200
@@ -45,6 +45,8 @@
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
 
+  BUG_TABLE
+
   .data : {			/* Data */
 	*(.data)
 	CONSTRUCTORS
@@ -77,6 +79,12 @@
 	*(.init.text)
 	_einittext = .;
   }
+  /*
+   * .exit.text is discarded at runtime, not link time,
+   * to deal with references from __bug_table
+   */
+  .exit.text :	 { *(.exit.text) }
+
   .init.data : { *(.init.data) }
   . = ALIGN(256);
   __setup_start = .;
@@ -116,7 +124,7 @@
 
   /* Sections to be discarded */
   /DISCARD/ : {
-	*(.exit.text) *(.exit.data) *(.exitcall.exit)
+	*(.exit.data) *(.exitcall.exit)
 	}
 
   /* Stabs debugging sections.  */
Index: quilt-2.6/include/asm-s390/bug.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/bug.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/bug.h	2007-04-27 16:04:56.000000000 +0200
@@ -1,27 +1,70 @@
-#ifndef _S390_BUG_H
-#define _S390_BUG_H
+#ifndef _ASM_S390_BUG_H
+#define _ASM_S390_BUG_H
 
 #include <linux/kernel.h>
 
 #ifdef CONFIG_BUG
 
-static inline __attribute__((noreturn)) void __do_illegal_op(void)
-{
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
-	__builtin_trap();
+#ifdef CONFIG_64BIT
+#define S390_LONG ".quad"
 #else
-	asm volatile(".long 0");
+#define S390_LONG ".long"
 #endif
-}
 
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__do_illegal_op(); \
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#define __EMIT_BUG(x) do {					\
+	asm volatile(						\
+		"0:	j	0b+2\n"				\
+		"1:\n"						\
+		".section .rodata.str,\"aMS\",@progbits,1\n"	\
+		"2:	.asciz	\""__FILE__"\"\n"		\
+		".previous\n"					\
+		".section __bug_table,\"a\"\n"			\
+		"3:\t"	S390_LONG "\t1b,2b\n"			\
+		"	.short	%0,%1\n"			\
+		"	.org	3b+%2\n"			\
+		".previous\n"					\
+		: : "i" (__LINE__),				\
+		    "i" (x),					\
+		    "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
+#else /* CONFIG_DEBUG_BUGVERBOSE */
+
+#define __EMIT_BUG(x) do {				\
+	asm volatile(					\
+		"0:	j	0b+2\n"			\
+		"1:\n"					\
+		".section __bug_table,\"a\"\n"		\
+		"2:\t"	S390_LONG "\t1b\n"		\
+		"	.short	%0\n"			\
+		"	.org	2b+%1\n"		\
+		".previous\n"				\
+		: : "i" (x),				\
+		    "i" (sizeof(struct bug_entry)));	\
+} while (0)
+
+#endif /* CONFIG_DEBUG_BUGVERBOSE */
+
+#define BUG()	__EMIT_BUG(0)
+
+#define WARN_ON(x) ({					\
+	typeof(x) __ret_warn_on = (x);			\
+	if (__builtin_constant_p(__ret_warn_on)) {	\
+		if (__ret_warn_on)			\
+			__EMIT_BUG(BUGFLAG_WARNING);	\
+	} else {					\
+		if (unlikely(__ret_warn_on))		\
+			__EMIT_BUG(BUGFLAG_WARNING);	\
+	}						\
+	unlikely(__ret_warn_on);			\
+})
+
 #define HAVE_ARCH_BUG
-#endif
+#define HAVE_ARCH_WARN_ON
+#endif /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
 
-#endif
+#endif /* _ASM_S390_BUG_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
