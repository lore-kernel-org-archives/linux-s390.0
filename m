Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406078AbfHILBU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Aug 2019 07:01:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79Avlkq010772
        for <linux-s390@vger.kernel.org>; Fri, 9 Aug 2019 07:01:19 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u94f67hue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 09 Aug 2019 07:01:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 9 Aug 2019 12:01:16 +0100
Date: Fri, 9 Aug 2019 13:01:10 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.3-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01565348470-ext-7484@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.3-rc4.

Thank you,
Vasily

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-5

for you to fetch changes up to 404861e15b5fa7edbab22400f9174c1a21fde731:

  s390/vdso: map vdso also for statically linked binaries (2019-08-09 11:03:28 +0200)

----------------------------------------------------------------
s390 updates for 5.3-rc4

 - Map vdso also for statically linked binaries like all other
   architectures.

 - Fix no .bss usage compile-time check to account common objects with the
   help of binutils size tool. Top level Makefile change acked-by
   Masahiro.

 - A fix to make perf happy with _etext symbol type.

 - Fix dump_pagetables which is broken since p*d_offset implementation
   change to comply with mm/gup.c expectations.

 - Revert memory sharing for diag calls in protected virtualization, since
   this is not required after all.

 - Couple of other minor code cleanups.

----------------------------------------------------------------
Heiko Carstens (1):
      s390/vdso: map vdso also for statically linked binaries

Vasily Gorbik (8):
      s390/protvirt: avoid memory sharing for diag 308 set/store
      s390/mm: fix dump_pagetables top level page table walking
      s390/setup: adjust start_code of init_mm to _text
      s390/unwind: remove stack recursion warning
      s390/head64: cleanup unused labels
      s390: put _stext and _etext into .text section
      kbuild: add OBJSIZE variable for the size tool
      s390/build: use size command to perform empty .bss check

 Makefile                          |  7 ++++---
 arch/s390/boot/ipl_parm.c         |  2 --
 arch/s390/kernel/dumpstack.c      |  6 +-----
 arch/s390/kernel/head64.S         |  7 -------
 arch/s390/kernel/ipl.c            |  9 ---------
 arch/s390/kernel/setup.c          |  3 +--
 arch/s390/kernel/vdso.c           |  5 -----
 arch/s390/kernel/vmlinux.lds.S    | 10 ++++------
 arch/s390/mm/dump_pagetables.c    | 12 ++++++------
 arch/s390/scripts/Makefile.chkbss |  3 +--
 10 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/Makefile b/Makefile
index 23cdf1f41364..01683ba84d4c 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ NM		= $(CROSS_COMPILE)nm
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
+OBJSIZE		= $(CROSS_COMPILE)size
 PAHOLE		= pahole
 LEX		= flex
 YACC		= bison
@@ -475,9 +476,9 @@ GCC_PLUGINS_CFLAGS :=
 CLANG_FLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
-export CPP AR NM STRIP OBJCOPY OBJDUMP PAHOLE KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
-export MAKE LEX YACC AWK INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
-export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export CPP AR NM STRIP OBJCOPY OBJDUMP OBJSIZE PAHOLE LEX YACC AWK INSTALLKERNEL
+export PERL PYTHON PYTHON2 PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
+export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 3c49bde8aa5e..b8aa6a9f937b 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -48,9 +48,7 @@ void store_ipl_parmblock(void)
 {
 	int rc;
 
-	uv_set_shared(__pa(&ipl_block));
 	rc = __diag308(DIAG308_STORE, &ipl_block);
-	uv_remove_shared(__pa(&ipl_block));
 	if (rc == DIAG308_RC_OK &&
 	    ipl_block.hdr.version <= IPL_MAX_SUPPORTED_VERSION)
 		ipl_block_valid = 1;
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index ac06c3949ab3..34bdc60c0b11 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -114,12 +114,8 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	 * If it comes up a second time then there's something wrong going on:
 	 * just break out and report an unknown stack type.
 	 */
-	if (*visit_mask & (1UL << info->type)) {
-		printk_deferred_once(KERN_WARNING
-			"WARNING: stack recursion on stack type %d\n",
-			info->type);
+	if (*visit_mask & (1UL << info->type))
 		goto unknown;
-	}
 	*visit_mask |= 1UL << info->type;
 	return 0;
 unknown:
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index 5aea1a527443..f384a18e6c26 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -60,12 +60,5 @@ ENTRY(startup_continue)
 
 	.align	16
 .LPG1:
-.Lpcmsk:.quad	0x0000000180000000
-.L4malign:.quad 0xffffffffffc00000
-.Lscan2g:.quad	0x80000000 + 0x20000 - 8	# 2GB + 128K - 8
-.Lnop:	.long	0x07000700
-.Lparmaddr:
-	.quad	PARMAREA
-	.align	64
 .Ldw:	.quad	0x0002000180000000,0x0000000000000000
 .Laregs:.long	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 2c0a515428d6..6837affc19e8 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -31,7 +31,6 @@
 #include <asm/os_info.h>
 #include <asm/sections.h>
 #include <asm/boot_data.h>
-#include <asm/uv.h>
 #include "entry.h"
 
 #define IPL_PARM_BLOCK_VERSION 0
@@ -892,21 +891,15 @@ static void __reipl_run(void *unused)
 {
 	switch (reipl_type) {
 	case IPL_TYPE_CCW:
-		uv_set_shared(__pa(reipl_block_ccw));
 		diag308(DIAG308_SET, reipl_block_ccw);
-		uv_remove_shared(__pa(reipl_block_ccw));
 		diag308(DIAG308_LOAD_CLEAR, NULL);
 		break;
 	case IPL_TYPE_FCP:
-		uv_set_shared(__pa(reipl_block_fcp));
 		diag308(DIAG308_SET, reipl_block_fcp);
-		uv_remove_shared(__pa(reipl_block_fcp));
 		diag308(DIAG308_LOAD_CLEAR, NULL);
 		break;
 	case IPL_TYPE_NSS:
-		uv_set_shared(__pa(reipl_block_nss));
 		diag308(DIAG308_SET, reipl_block_nss);
-		uv_remove_shared(__pa(reipl_block_nss));
 		diag308(DIAG308_LOAD_CLEAR, NULL);
 		break;
 	case IPL_TYPE_UNKNOWN:
@@ -1176,9 +1169,7 @@ static struct kset *dump_kset;
 
 static void diag308_dump(void *dump_block)
 {
-	uv_set_shared(__pa(dump_block));
 	diag308(DIAG308_SET, dump_block);
-	uv_remove_shared(__pa(dump_block));
 	while (1) {
 		if (diag308(DIAG308_LOAD_NORMAL_DUMP, NULL) != 0x302)
 			break;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 2b94b0ad3588..253177900950 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1114,8 +1114,7 @@ void __init setup_arch(char **cmdline_p)
 
         ROOT_DEV = Root_RAM0;
 
-	/* Is init_mm really needed? */
-	init_mm.start_code = PAGE_OFFSET;
+	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = (unsigned long) _end;
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 243d8b1185bf..c6bc190f3c28 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -216,11 +216,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	if (!vdso_enabled)
 		return 0;
-	/*
-	 * Only map the vdso for dynamically linked elf binaries.
-	 */
-	if (!uses_interp)
-		return 0;
 
 	vdso_pages = vdso64_pages;
 #ifdef CONFIG_COMPAT_VDSO
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 49d55327de0b..7e0eb4020917 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -32,10 +32,9 @@ PHDRS {
 SECTIONS
 {
 	. = 0x100000;
-	_stext = .;		/* Start of text section */
 	.text : {
-		/* Text and read-only data */
-		_text = .;
+		_stext = .;		/* Start of text section */
+		_text = .;		/* Text and read-only data */
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
@@ -47,11 +46,10 @@ SECTIONS
 		*(.text.*_indirect_*)
 		*(.fixup)
 		*(.gnu.warning)
+		. = ALIGN(PAGE_SIZE);
+		_etext = .;		/* End of text section */
 	} :text = 0x0700
 
-	. = ALIGN(PAGE_SIZE);
-	_etext = .;		/* End of text section */
-
 	NOTES :text :note
 
 	.dummy : { *(.dummy) } :data
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 3b93ba0b5d8d..5d67b81c704a 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -161,9 +161,9 @@ static void walk_pmd_level(struct seq_file *m, struct pg_state *st,
 	}
 #endif
 
-	for (i = 0; i < PTRS_PER_PMD && addr < max_addr; i++) {
+	pmd = pmd_offset(pud, addr);
+	for (i = 0; i < PTRS_PER_PMD && addr < max_addr; i++, pmd++) {
 		st->current_address = addr;
-		pmd = pmd_offset(pud, addr);
 		if (!pmd_none(*pmd)) {
 			if (pmd_large(*pmd)) {
 				prot = pmd_val(*pmd) &
@@ -192,9 +192,9 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st,
 	}
 #endif
 
-	for (i = 0; i < PTRS_PER_PUD && addr < max_addr; i++) {
+	pud = pud_offset(p4d, addr);
+	for (i = 0; i < PTRS_PER_PUD && addr < max_addr; i++, pud++) {
 		st->current_address = addr;
-		pud = pud_offset(p4d, addr);
 		if (!pud_none(*pud))
 			if (pud_large(*pud)) {
 				prot = pud_val(*pud) &
@@ -222,9 +222,9 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st,
 	}
 #endif
 
-	for (i = 0; i < PTRS_PER_P4D && addr < max_addr; i++) {
+	p4d = p4d_offset(pgd, addr);
+	for (i = 0; i < PTRS_PER_P4D && addr < max_addr; i++, p4d++) {
 		st->current_address = addr;
-		p4d = p4d_offset(pgd, addr);
 		if (!p4d_none(*p4d))
 			walk_pud_level(m, st, p4d, addr);
 		else
diff --git a/arch/s390/scripts/Makefile.chkbss b/arch/s390/scripts/Makefile.chkbss
index 884a9caff5fb..f4f4c2c6dee9 100644
--- a/arch/s390/scripts/Makefile.chkbss
+++ b/arch/s390/scripts/Makefile.chkbss
@@ -11,8 +11,7 @@ chkbss: $(addprefix $(obj)/, $(chkbss-files))
 
 quiet_cmd_chkbss = CHKBSS  $<
       cmd_chkbss = \
-	if $(OBJDUMP) -h $< | grep -q "\.bss" && \
-	   ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
+	if ! $(OBJSIZE) --common $< | $(AWK) 'END { if ($$3) exit 1 }'; then \
 		echo "error: $< .bss section is not empty" >&2; exit 1; \
 	fi; \
 	touch $@;
