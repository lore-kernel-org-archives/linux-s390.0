Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/12] s390: don't build vdso32 with clang
Date: Mon,  8 Apr 2019 23:26:15 +0200
Message-Id: <20190408212648.2407234-2-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

clang does not support 31 bit object files on s390, so skip
the 32-bit vdso here, and only build it when using gcc to compile
the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig         |  3 +++
 arch/s390/kernel/Makefile |  2 +-
 arch/s390/kernel/vdso.c   | 10 +++++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d0653002..8cd860cba4d1 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -388,6 +388,9 @@ config COMPAT
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
+config COMPAT_VDSO
+	def_bool COMPAT && !CC_IS_CLANG
+
 config SYSVIPC_COMPAT
 	def_bool y if COMPAT && SYSVIPC
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 8a62c7f72e1b..1222db6d4ee9 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -86,7 +86,7 @@ obj-$(CONFIG_TRACEPOINTS)	+= trace.o
 
 # vdso
 obj-y				+= vdso64/
-obj-$(CONFIG_COMPAT)		+= vdso32/
+obj-$(CONFIG_COMPAT_VDSO)	+= vdso32/
 
 chkbss := head64.o early_nobss.o
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index e7920a68a12e..243d8b1185bf 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -29,7 +29,7 @@
 #include <asm/vdso.h>
 #include <asm/facility.h>
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
 static unsigned int vdso32_pages;
@@ -55,7 +55,7 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 
 	vdso_pagelist = vdso64_pagelist;
 	vdso_pages = vdso64_pages;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	if (vma->vm_mm->context.compat_mm) {
 		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
@@ -76,7 +76,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	unsigned long vdso_pages;
 
 	vdso_pages = vdso64_pages;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	if (vma->vm_mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
 #endif
@@ -223,7 +223,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return 0;
 
 	vdso_pages = vdso64_pages;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	mm->context.compat_mm = is_compat_task();
 	if (mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
@@ -280,7 +280,7 @@ static int __init vdso_init(void)
 	int i;
 
 	vdso_init_data(vdso_data);
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	/* Calculate the size of the 32 bit vDSO */
 	vdso32_pages = ((&vdso32_end - &vdso32_start
 			 + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
-- 
2.20.0
