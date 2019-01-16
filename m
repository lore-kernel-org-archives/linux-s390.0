Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/5] s390: autogenerate compat syscall wrappers
Date: Wed, 16 Jan 2019 14:15:22 +0100
Message-Id: <20190116131527.2071570-5-arnd@arndb.de>
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Any system call that takes a pointer argument on s390 requires
a wrapper function to do a 31-to-64 zero-extension, these are
currently generated in arch/s390/kernel/compat_wrapper.c.

On arm64 and x86, we already generate similar wrappers for all
system calls in the place of their definition, just for a different
purpose (they load the arguments from pt_regs).

We can do the same thing here, by adding an asm/syscall_wrapper.h
file with a copy of all the relevant macros to override the generic
version. Besides the addition of the compat entry point, these also
rename the entry points with a __s390_ or __s390x_ prefix, similar
to what we do on arm64 and x86. This in turn requires renaming
a few things, and adding a proper ni_syscall() entry point.

In order to still compile system call definitions that pass an
loff_t argument, the __SC_COMPAT_CAST() macro checks for that
and forces an -ENOSYS error, which was the best I could come up
with. Those functions must obviously not get called from user
space, but instead require hand-written compat_sys_*() handlers,
which fortunately already exist.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig                       |   1 +
 arch/s390/include/asm/syscall_wrapper.h | 136 ++++++++++++++++++++++++
 arch/s390/kernel/compat_wrapper.c       |  23 +---
 arch/s390/kernel/entry.S                |   4 +-
 arch/s390/kernel/sys_s390.c             |   5 +
 5 files changed, 148 insertions(+), 21 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 41cafd245bbc..b6e3d0653002 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -75,6 +75,7 @@ config S390
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..27ebe871692f
--- /dev/null
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - s390 specific wrappers to syscall definitions
+ *
+ */
+
+#ifndef _ASM_S390_SYSCALL_WRAPPER_H
+#define _ASM_S390_SYSCALL_WRAPPER_H
+
+#ifdef CONFIG_COMPAT
+#define __SC_COMPAT_TYPE(t, a) \
+	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
+
+#define __SC_COMPAT_CAST(t, a)						\
+({									\
+	long __ReS = a;							\
+									\
+	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
+		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&		\
+		     !__TYPE_IS_LL(t));					\
+	if (__TYPE_IS_L(t))						\
+		__ReS = (s32)a;						\
+	if (__TYPE_IS_UL(t))						\
+		__ReS = (u32)a;						\
+	if (__TYPE_IS_PTR(t))						\
+		__ReS = a & 0x7fffffff;					\
+	if (__TYPE_IS_LL(t))						\
+		return -ENOSYS;						\
+	(t)__ReS;							\
+})
+
+#define __S390_SYS_STUBx(x, name, ...)					\
+	asmlinkage long __s390_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
+	ALLOW_ERROR_INJECTION(__s390_sys##name, ERRNO);			\
+	asmlinkage long __s390_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
+	{								\
+		long ret = __s390x_sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		return ret;						\
+	}
+
+/*
+ * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
+ * named __s390x_sys_*()
+ */
+#define COMPAT_SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __s390_compat_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__s390_compat__sys_##sname, ERRNO);	\
+	asmlinkage long __s390_compat_sys_##sname(void)
+
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __s390x_sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
+	asmlinkage long __s390_sys_##sname(void)			\
+		__attribute__((alias(__stringify(__s390x_sys_##sname)))); \
+	asmlinkage long __s390x_sys_##sname(void)
+
+#define COND_SYSCALL(name)						\
+	cond_syscall(__s390x_sys_##name);				\
+	cond_syscall(__s390_sys_##name)
+
+#define SYS_NI(name)							\
+	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);		\
+	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers)
+
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
+	__diag_push();								\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long __s390_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __s390_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
+	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{									\
+		long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		return ret;							\
+	}									\
+	__diag_pop();								\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+/*
+ * As some compat syscalls may not be implemented, we need to expand
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
+ * kernel/time/posix-stubs.c to cover this case as well.
+ */
+#define COND_SYSCALL_COMPAT(name) 					\
+	cond_syscall(__s390_compat_sys_##name)
+
+#define COMPAT_SYS_NI(name)						\
+	SYSCALL_ALIAS(__s390_compat_sys_##name, sys_ni_posix_timers)
+
+#else /* CONFIG_COMPAT */
+
+#define __S390_SYS_STUBx(x, fullname, name, ...)
+
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __s390x_sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
+	asmlinkage long __s390x_sys_##sname(void)
+
+#define COND_SYSCALL(name)						\
+	cond_syscall(__s390x_sys_##name)				\
+	cond_syscall(__s390_sys_##name)
+
+#define SYS_NI(name)							\
+	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers);
+
+#endif /* CONFIG_COMPAT */
+
+#define __SYSCALL_DEFINEx(x, name, ...)						\
+	__diag_push();								\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long __s390x_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_sys##name))));		\
+	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	__S390_SYS_STUBx(x, name, __VA_ARGS__)					\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{									\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		return ret;							\
+	}									\
+	__diag_pop();								\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#endif /* _ASM_X86_SYSCALL_WRAPPER_H */
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index f54b7b73f316..9d07cd553fc7 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -25,21 +25,6 @@
 #define __SC_COMPAT_TYPE(t, a) \
 	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
 
-#define __SC_COMPAT_CAST(t, a)						\
-({									\
-	long __ReS = a;							\
-									\
-	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
-		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));		\
-	if (__TYPE_IS_L(t))						\
-		__ReS = (s32)a;						\
-	if (__TYPE_IS_UL(t))						\
-		__ReS = (u32)a;						\
-	if (__TYPE_IS_PTR(t))						\
-		__ReS = a & 0x7fffffff;					\
-	(t)__ReS;							\
-})
-
 /*
  * The COMPAT_SYSCALL_WRAP macro generates system call wrappers to be used by
  * compat tasks. These wrappers will only be used for system calls where only
@@ -53,11 +38,11 @@
  * the regular system call wrappers.
  */
 #define COMPAT_SYSCALL_WRAPx(x, name, ...)					\
-asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));			\
-asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));\
-asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))	\
+asmlinkage long __s390_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));		\
+asmlinkage long notrace __s390_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+asmlinkage long notrace __s390_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 {										\
-	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));		\
+	return __s390_sys##name(__MAP(x,__SC_ARGS,__VA_ARGS__));		\
 }
 
 COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 39191a0feed1..583d65ef5007 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1512,7 +1512,7 @@ cleanup_critical:
 	.quad   .Lsie_skip - .Lsie_entry
 #endif
 	.section .rodata, "a"
-#define SYSCALL(esame,emu)	.long esame
+#define SYSCALL(esame,emu)	.long __s390x_ ## esame
 	.globl	sys_call_table
 sys_call_table:
 #include "asm/syscall_table.h"
@@ -1520,7 +1520,7 @@ sys_call_table:
 
 #ifdef CONFIG_COMPAT
 
-#define SYSCALL(esame,emu)	.long emu
+#define SYSCALL(esame,emu)	.long __s390_ ## emu
 	.globl	sys_call_table_emu
 sys_call_table_emu:
 #include "asm/syscall_table.h"
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 6aa8fe00b39e..a8c2cc858864 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -93,3 +93,8 @@ SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
 
 	return ret;
 }
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}
-- 
2.20.0
