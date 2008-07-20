Return-Path: <linux-kernel-owner+w=401wt.eu-S1754470AbYGUAIM@vger.kernel.org>
Subject: [PATCH 16/22] s390: Introducing asm/syscalls.h
From: Jaswinder Singh <jaswinder@infradead.org>
In-Reply-To: <1216597566.3679.135.camel@jaswinder.satnam>
References: <1216592500.3679.14.camel@jaswinder.satnam>
	 <1216592798.3679.22.camel@jaswinder.satnam>
	 <1216592879.3679.24.camel@jaswinder.satnam>
	 <1216593035.3679.27.camel@jaswinder.satnam>
	 <1216596035.3679.95.camel@jaswinder.satnam>
	 <1216596106.3679.98.camel@jaswinder.satnam>
	 <1216596325.3679.104.camel@jaswinder.satnam>
	 <1216596669.3679.112.camel@jaswinder.satnam>
	 <1216596749.3679.115.camel@jaswinder.satnam>
	 <1216596835.3679.117.camel@jaswinder.satnam>
	 <1216596932.3679.120.camel@jaswinder.satnam>
	 <1216597066.3679.123.camel@jaswinder.satnam>
	 <1216597151.3679.125.camel@jaswinder.satnam>
	 <1216597237.3679.128.camel@jaswinder.satnam>
	 <1216597352.3679.131.camel@jaswinder.satnam>
	 <1216597566.3679.135.camel@jaswinder.satnam>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 05:20:55 +0530
Message-Id: <1216597856.3679.139.camel@jaswinder.satnam>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, kernelnewbies <kernelnewbies@nl.linux.org>, David Woodhouse <dwmw2@infradead.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Declaring arch-dependent syscalls for s390 architecture

Signed-off-by: Jaswinder Singh <jaswinder@infradead.org>
---
 arch/s390/kernel/entry.h    |   18 ------------------
 arch/s390/kernel/process.c  |    1 +
 arch/s390/kernel/signal.c   |    1 +
 arch/s390/mm/fault.c        |    1 +
 include/asm-s390/syscalls.h |   38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 6b18963..c8b5dfd 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -25,36 +25,18 @@ void __init startup_init(void);
 void die(const char * str, struct pt_regs * regs, long err);
 
 struct new_utsname;
-struct mmap_arg_struct;
 struct fadvise64_64_args;
-struct old_sigaction;
-struct sel_arg_struct;
 
 long sys_pipe(unsigned long __user *fildes);
-long sys_mmap2(struct mmap_arg_struct __user  *arg);
-long old_mmap(struct mmap_arg_struct __user *arg);
-long sys_ipc(uint call, int first, unsigned long second,
-	     unsigned long third, void __user *ptr);
 long s390x_newuname(struct new_utsname __user *name);
 long s390x_personality(unsigned long personality);
 long s390_fadvise64(int fd, u32 offset_high, u32 offset_low,
 		    size_t len, int advice);
 long s390_fadvise64_64(struct fadvise64_64_args __user *args);
 long s390_fallocate(int fd, int mode, loff_t offset, u32 len_high, u32 len_low);
-long sys_fork(void);
-long sys_clone(void);
-long sys_vfork(void);
 void execve_tail(void);
-long sys_execve(void);
-int sys_sigsuspend(int history0, int history1, old_sigset_t mask);
-long sys_sigaction(int sig, const struct old_sigaction __user *act,
-		   struct old_sigaction __user *oact);
-long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss);
-long sys_sigreturn(void);
-long sys_rt_sigreturn(void);
 long sys32_sigreturn(void);
 long sys32_rt_sigreturn(void);
-long old_select(struct sel_arg_struct __user *arg);
 long sys_ptrace(long request, long pid, long addr, long data);
 
 #endif /* _ENTRY_H */
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 85defd0..5f6d7a8 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -38,6 +38,7 @@
 #include <linux/utsname.h>
 #include <linux/tick.h>
 #include <linux/elfcore.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index b976820..c73b369 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -24,6 +24,7 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
+#include <linux/syscalls.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/lowcore.h>
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4d53720..a5c5f66 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -29,6 +29,7 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
+#include <linux/syscalls.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
diff --git a/include/asm-s390/syscalls.h b/include/asm-s390/syscalls.h
index e69de29..439d6f8 100644
--- a/include/asm-s390/syscalls.h
+++ b/include/asm-s390/syscalls.h
@@ -0,0 +1,38 @@
+/*
+ * syscalls.h - Linux syscall interfaces (arch-specific)
+ *
+ * Copyright (c) 2008 Jaswinder Singh
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ *
+ * Please do not call me directly, include linux/syscalls.h
+ */
+
+#ifndef _ASM_S390_SYSCALLS_H
+#define _ASM_S390_SYSCALLS_H
+
+/* kernel/process.c */
+asmlinkage long sys_fork(void);
+asmlinkage long sys_clone(void);
+asmlinkage long sys_vfork(void);
+asmlinkage long sys_execve(void);
+
+/* kernel/signal.c */
+asmlinkage int sys_sigsuspend(int, int, old_sigset_t);
+asmlinkage long sys_sigaction(int,
+			      const struct old_sigaction __user *,
+			      struct old_sigaction __user *);
+asmlinkage long sys_sigaltstack(const stack_t __user *,
+				stack_t __user *);
+asmlinkage long sys_sigreturn(void);
+asmlinkage long sys_rt_sigreturn(void);
+
+/* kernel/sys_s390.c */
+struct mmap_arg_struct;
+asmlinkage long sys_mmap2(struct mmap_arg_struct __user  *);
+asmlinkage long old_mmap(struct mmap_arg_struct __user *);
+asmlinkage long sys_ipc(uint, int, unsigned long,
+			unsigned long, void __user *);
+
+#endif /* _ASM_S390_SYSCALLS_H */
-- 
1.5.5.1
