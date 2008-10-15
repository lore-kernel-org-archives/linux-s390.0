From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/2] arch_setup_additional_pages arguments
Date: Wed, 15 Oct 2008 19:45:07 +0200
Message-ID: <20081015175304.782682524@de.ibm.com>
References: <20081015174506.107691579@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline; filename=100-vdso-dynobj.diff
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

arch_setup_additional_pages currently gets two arguments, the binary
format descripton and an indication if the process uses an executable
stack or not. The second argument is not used by anybody, it could
be removed without replacement.

What actually does make sense is to pass an indication if the process
uses the elf interpreter or not. The glibc code will not use anything
from the vdso if the process does not use the dynamic linker, so for
statically linked binaries the architecture backend can choose not
to map the vdso.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/powerpc/include/asm/elf.h     |    2 +-
 arch/powerpc/kernel/vdso.c         |    3 +--
 arch/sh/include/asm/elf.h          |    2 +-
 arch/sh/kernel/vsyscall/vsyscall.c |    3 +--
 arch/x86/vdso/vdso32-setup.c       |    2 +-
 arch/x86/vdso/vma.c                |    2 +-
 fs/binfmt_elf.c                    |    2 +-
 include/asm-x86/elf.h              |    2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

Index: quilt-2.6/arch/powerpc/include/asm/elf.h
===================================================================
--- quilt-2.6.orig/arch/powerpc/include/asm/elf.h
+++ quilt-2.6/arch/powerpc/include/asm/elf.h
@@ -267,7 +267,7 @@ extern int ucache_bsize;
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int executable_stack);
+				       int uses_interp);
 #define VDSO_AUX_ENT(a,b) NEW_AUX_ENT(a,b);
 
 #endif /* __KERNEL__ */
Index: quilt-2.6/arch/powerpc/kernel/vdso.c
===================================================================
--- quilt-2.6.orig/arch/powerpc/kernel/vdso.c
+++ quilt-2.6/arch/powerpc/kernel/vdso.c
@@ -184,8 +184,7 @@ static void dump_vdso_pages(struct vm_ar
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
  */
-int arch_setup_additional_pages(struct linux_binprm *bprm,
-				int executable_stack)
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	struct page **vdso_pagelist;
Index: quilt-2.6/arch/sh/include/asm/elf.h
===================================================================
--- quilt-2.6.orig/arch/sh/include/asm/elf.h
+++ quilt-2.6/arch/sh/include/asm/elf.h
@@ -202,7 +202,7 @@ extern int dump_task_fpu (struct task_st
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int executable_stack);
+				       int uses_interp);
 
 extern unsigned int vdso_enabled;
 extern void __kernel_vsyscall;
Index: quilt-2.6/arch/sh/kernel/vsyscall/vsyscall.c
===================================================================
--- quilt-2.6.orig/arch/sh/kernel/vsyscall/vsyscall.c
+++ quilt-2.6/arch/sh/kernel/vsyscall/vsyscall.c
@@ -59,8 +59,7 @@ int __init vsyscall_init(void)
 }
 
 /* Setup a VMA at program startup for the vsyscall page */
-int arch_setup_additional_pages(struct linux_binprm *bprm,
-				int executable_stack)
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
Index: quilt-2.6/arch/x86/vdso/vdso32-setup.c
===================================================================
--- quilt-2.6.orig/arch/x86/vdso/vdso32-setup.c
+++ quilt-2.6/arch/x86/vdso/vdso32-setup.c
@@ -310,7 +310,7 @@ int __init sysenter_setup(void)
 }
 
 /* Setup a VMA at program startup for the vsyscall page */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
Index: quilt-2.6/arch/x86/vdso/vma.c
===================================================================
--- quilt-2.6.orig/arch/x86/vdso/vma.c
+++ quilt-2.6/arch/x86/vdso/vma.c
@@ -98,7 +98,7 @@ static unsigned long vdso_addr(unsigned 
 
 /* Setup a VMA at program startup for the vsyscall page.
    Not called for compat tasks */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
Index: quilt-2.6/fs/binfmt_elf.c
===================================================================
--- quilt-2.6.orig/fs/binfmt_elf.c
+++ quilt-2.6/fs/binfmt_elf.c
@@ -949,7 +949,7 @@ static int load_elf_binary(struct linux_
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = arch_setup_additional_pages(bprm, executable_stack);
+	retval = arch_setup_additional_pages(bprm, !!elf_interpreter);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
 		goto out;
Index: quilt-2.6/include/asm-x86/elf.h
===================================================================
--- quilt-2.6.orig/include/asm-x86/elf.h
+++ quilt-2.6/include/asm-x86/elf.h
@@ -325,7 +325,7 @@ struct linux_binprm;
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int executable_stack);
+				       int uses_interp);
 
 extern int syscall32_setup_pages(struct linux_binprm *, int exstack);
 #define compat_arch_setup_additional_pages	syscall32_setup_pages

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
