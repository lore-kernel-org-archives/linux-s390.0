Return-Path: <linux-kernel-owner+w=401wt.eu-S1757247AbZKMPR0@vger.kernel.org>
Message-Id: <20091113150909.435417205@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/52] [PATCH] Improve address space mode selection.
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=101-mm-user-mode.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce user_mode to replace the two variables switch_amode and
s390_noexec. There are three valid combinations of the old values:
  1) switch_amode == 0 && s390_noexec == 0
  2) switch_amode == 1 && s390_noexec == 0
  3) switch_amode == 1 && s390_noexec == 1
They get replaced by
  1) user_mode == HOME_SPACE_MODE
  2) user_mode == PRIMARY_SPACE_MODE
  3) user_mode == SECONDARY_SPACE_MODE
The new kernel parameter user_mode=[primary,secondary,home] lets
you choose the address space mode the user space processes should
use. In addition the CONFIG_S390_SWITCH_AMODE config option
is removed.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig                   |   15 ---------------
 arch/s390/defconfig                 |    1 -
 arch/s390/include/asm/mmu_context.h |    4 ++--
 arch/s390/include/asm/pgalloc.h     |    3 ++-
 arch/s390/include/asm/setup.h       |   17 ++++++-----------
 arch/s390/kernel/setup.c            |   36 ++++++++++++++++++++----------------
 arch/s390/kernel/vdso.c             |    9 +++++----
 arch/s390/kvm/Kconfig               |    1 -
 arch/s390/lib/uaccess_mvcos.c       |    4 ----
 arch/s390/mm/fault.c                |    4 ++--
 arch/s390/mm/pgtable.c              |    2 +-
 11 files changed, 38 insertions(+), 58 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/defconfig	2009-11-13 16:08:12.000000000 +0100
@@ -185,7 +185,6 @@
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
 CONFIG_AUDIT_ARCH=y
-CONFIG_S390_SWITCH_AMODE=y
 CONFIG_S390_EXEC_PROTECT=y
 
 #
Index: quilt-2.6/arch/s390/include/asm/mmu_context.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/mmu_context.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/mmu_context.h	2009-11-13 16:08:12.000000000 +0100
@@ -36,7 +36,7 @@
 		mm->context.has_pgste = 1;
 		mm->context.alloc_pgste = 1;
 	} else {
-		mm->context.noexec = s390_noexec;
+		mm->context.noexec = (user_mode == SECONDARY_SPACE_MODE);
 		mm->context.has_pgste = 0;
 		mm->context.alloc_pgste = 0;
 	}
@@ -58,7 +58,7 @@
 	pgd_t *pgd = mm->pgd;
 
 	S390_lowcore.user_asce = mm->context.asce_bits | __pa(pgd);
-	if (switch_amode) {
+	if (user_mode != HOME_SPACE_MODE) {
 		/* Load primary space page table origin. */
 		pgd = mm->context.noexec ? get_shadow_table(pgd) : pgd;
 		S390_lowcore.user_exec_asce = mm->context.asce_bits | __pa(pgd);
Index: quilt-2.6/arch/s390/include/asm/pgalloc.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/pgalloc.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/pgalloc.h	2009-11-13 16:08:12.000000000 +0100
@@ -143,7 +143,8 @@
 	spin_lock_init(&mm->context.list_lock);
 	INIT_LIST_HEAD(&mm->context.crst_list);
 	INIT_LIST_HEAD(&mm->context.pgtable_list);
-	return (pgd_t *) crst_table_alloc(mm, s390_noexec);
+	return (pgd_t *)
+		crst_table_alloc(mm, user_mode == SECONDARY_SPACE_MODE);
 }
 #define pgd_free(mm, pgd) crst_table_free(mm, (unsigned long *) pgd)
 
Index: quilt-2.6/arch/s390/include/asm/setup.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/setup.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/setup.h	2009-11-13 16:08:12.000000000 +0100
@@ -49,17 +49,12 @@
 
 void detect_memory_layout(struct mem_chunk chunk[]);
 
-#ifdef CONFIG_S390_SWITCH_AMODE
-extern unsigned int switch_amode;
-#else
-#define switch_amode	(0)
-#endif
-
-#ifdef CONFIG_S390_EXEC_PROTECT
-extern unsigned int s390_noexec;
-#else
-#define s390_noexec	(0)
-#endif
+#define PRIMARY_SPACE_MODE	0
+#define ACCESS_REGISTER_MODE	1
+#define SECONDARY_SPACE_MODE	2
+#define HOME_SPACE_MODE		3
+
+extern unsigned int user_mode;
 
 /*
  * Machine features detected in head.S
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/Kconfig	2009-11-13 16:08:12.000000000 +0100
@@ -192,23 +192,8 @@
 	bool
 	default y
 
-config S390_SWITCH_AMODE
-	bool "Switch kernel/user addressing modes"
-	help
-	  This option allows to switch the addressing modes of kernel and user
-	  space. The kernel parameter switch_amode=on will enable this feature,
-	  default is disabled. Enabling this (via kernel parameter) on machines
-	  earlier than IBM System z9-109 EC/BC will reduce system performance.
-
-	  Note that this option will also be selected by selecting the execute
-	  protection option below. Enabling the execute protection via the
-	  noexec kernel parameter will also switch the addressing modes,
-	  independent of the switch_amode kernel parameter.
-
-
 config S390_EXEC_PROTECT
 	bool "Data execute protection"
-	select S390_SWITCH_AMODE
 	help
 	  This option allows to enable a buffer overflow protection for user
 	  space programs and it also selects the addressing mode option above.
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/setup.c	2009-11-13 16:08:12.000000000 +0100
@@ -305,9 +305,8 @@
 }
 early_param("mem", early_parse_mem);
 
-#ifdef CONFIG_S390_SWITCH_AMODE
-unsigned int switch_amode = 0;
-EXPORT_SYMBOL_GPL(switch_amode);
+unsigned int user_mode = HOME_SPACE_MODE;
+EXPORT_SYMBOL_GPL(user_mode);
 
 static int set_amode_and_uaccess(unsigned long user_amode,
 				 unsigned long user32_amode)
@@ -340,23 +339,29 @@
  */
 static int __init early_parse_switch_amode(char *p)
 {
-	switch_amode = 1;
+	if (user_mode != SECONDARY_SPACE_MODE)
+		user_mode = PRIMARY_SPACE_MODE;
 	return 0;
 }
 early_param("switch_amode", early_parse_switch_amode);
 
-#else /* CONFIG_S390_SWITCH_AMODE */
-static inline int set_amode_and_uaccess(unsigned long user_amode,
-					unsigned long user32_amode)
+static int __init early_parse_user_mode(char *p)
 {
+	if (p && strcmp(p, "primary") == 0)
+		user_mode = PRIMARY_SPACE_MODE;
+#ifdef CONFIG_S390_EXEC_PROTECT
+	else if (p && strcmp(p, "secondary") == 0)
+		user_mode = SECONDARY_SPACE_MODE;
+#endif
+	else if (!p || strcmp(p, "home") == 0)
+		user_mode = HOME_SPACE_MODE;
+	else
+		return 1;
 	return 0;
 }
-#endif /* CONFIG_S390_SWITCH_AMODE */
+early_param("user_mode", early_parse_user_mode);
 
 #ifdef CONFIG_S390_EXEC_PROTECT
-unsigned int s390_noexec = 0;
-EXPORT_SYMBOL_GPL(s390_noexec);
-
 /*
  * Enable execute protection?
  */
@@ -364,8 +369,7 @@
 {
 	if (!strncmp(p, "off", 3))
 		return 0;
-	switch_amode = 1;
-	s390_noexec = 1;
+	user_mode = SECONDARY_SPACE_MODE;
 	return 0;
 }
 early_param("noexec", early_parse_noexec);
@@ -373,7 +377,7 @@
 
 static void setup_addressing_mode(void)
 {
-	if (s390_noexec) {
+	if (user_mode == SECONDARY_SPACE_MODE) {
 		if (set_amode_and_uaccess(PSW_ASC_SECONDARY,
 					  PSW32_ASC_SECONDARY))
 			pr_info("Execute protection active, "
@@ -381,7 +385,7 @@
 		else
 			pr_info("Execute protection active, "
 				"mvcos not available\n");
-	} else if (switch_amode) {
+	} else if (user_mode == PRIMARY_SPACE_MODE) {
 		if (set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY))
 			pr_info("Address spaces switched, "
 				"mvcos available\n");
@@ -411,7 +415,7 @@
 	lc->restart_psw.mask = PSW_BASE_BITS | PSW_DEFAULT_KEY;
 	lc->restart_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
-	if (switch_amode)
+	if (user_mode != HOME_SPACE_MODE)
 		lc->restart_psw.mask |= PSW_ASC_HOME;
 	lc->external_new_psw.mask = psw_kernel_bits;
 	lc->external_new_psw.addr =
Index: quilt-2.6/arch/s390/kernel/vdso.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vdso.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/vdso.c	2009-11-13 16:08:12.000000000 +0100
@@ -86,7 +86,8 @@
 	unsigned int facility_list;
 
 	facility_list = stfl();
-	vd->ectg_available = switch_amode && (facility_list & 1);
+	vd->ectg_available =
+		user_mode != HOME_SPACE_MODE && (facility_list & 1);
 }
 
 #ifdef CONFIG_64BIT
@@ -114,7 +115,7 @@
 
 	lowcore->vdso_per_cpu_data = __LC_PASTE;
 
-	if (!switch_amode || !vdso_enabled)
+	if (user_mode == HOME_SPACE_MODE || !vdso_enabled)
 		return 0;
 
 	segment_table = __get_free_pages(GFP_KERNEL, SEGMENT_ORDER);
@@ -160,7 +161,7 @@
 	unsigned long segment_table, page_table, page_frame;
 	u32 *psal, *aste;
 
-	if (!switch_amode || !vdso_enabled)
+	if (user_mode == HOME_SPACE_MODE || !vdso_enabled)
 		return;
 
 	psal = (u32 *)(addr_t) lowcore->paste[4];
@@ -184,7 +185,7 @@
 
 static void vdso_init_cr5(void)
 {
-	if (switch_amode && vdso_enabled)
+	if (user_mode != HOME_SPACE_MODE && vdso_enabled)
 		on_each_cpu(__vdso_init_cr5, NULL, 1);
 }
 #endif /* CONFIG_64BIT */
Index: quilt-2.6/arch/s390/kvm/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/Kconfig	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/Kconfig	2009-11-13 16:08:12.000000000 +0100
@@ -20,7 +20,6 @@
 	depends on HAVE_KVM && EXPERIMENTAL
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
-	select S390_SWITCH_AMODE
 	---help---
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
Index: quilt-2.6/arch/s390/lib/uaccess_mvcos.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/uaccess_mvcos.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/lib/uaccess_mvcos.c	2009-11-13 16:08:12.000000000 +0100
@@ -162,7 +162,6 @@
 	return size;
 }
 
-#ifdef CONFIG_S390_SWITCH_AMODE
 static size_t strnlen_user_mvcos(size_t count, const char __user *src)
 {
 	char buf[256];
@@ -200,7 +199,6 @@
 	} while ((len_str == len) && (done < count));
 	return done;
 }
-#endif /* CONFIG_S390_SWITCH_AMODE */
 
 struct uaccess_ops uaccess_mvcos = {
 	.copy_from_user = copy_from_user_mvcos_check,
@@ -215,7 +213,6 @@
 	.futex_atomic_cmpxchg = futex_atomic_cmpxchg_std,
 };
 
-#ifdef CONFIG_S390_SWITCH_AMODE
 struct uaccess_ops uaccess_mvcos_switch = {
 	.copy_from_user = copy_from_user_mvcos,
 	.copy_from_user_small = copy_from_user_mvcos,
@@ -228,4 +225,3 @@
 	.futex_atomic_op = futex_atomic_op_pt,
 	.futex_atomic_cmpxchg = futex_atomic_cmpxchg_pt,
 };
-#endif
Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2009-11-13 16:08:12.000000000 +0100
@@ -112,7 +112,7 @@
 	if (trans_exc_code == 2)
 		/* Access via secondary space, set_fs setting decides */
 		return current->thread.mm_segment.ar4;
-	if (!switch_amode)
+	if (user_mode == HOME_SPACE_MODE)
 		/* User space if the access has been done via home space. */
 		return trans_exc_code == 3;
 	/*
@@ -168,7 +168,7 @@
 	 * terminate things with extreme prejudice.
 	 */
 	address = trans_exc_code & __FAIL_ADDR_MASK;
-	if (user_space_fault(trans_exc_code) == 0)
+	if (!user_space_fault(trans_exc_code))
 		printk(KERN_ALERT "Unable to handle kernel pointer dereference"
 		       " at virtual kernel address %p\n", (void *)address);
 	else
Index: quilt-2.6/arch/s390/mm/pgtable.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/pgtable.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/mm/pgtable.c	2009-11-13 16:08:12.000000000 +0100
@@ -269,7 +269,7 @@
 	struct mm_struct *mm, *old_mm;
 
 	/* Do we have switched amode? If no, we cannot do sie */
-	if (!switch_amode)
+	if (user_mode == HOME_SPACE_MODE)
 		return -EINVAL;
 
 	/* Do we have pgstes? if yes, we are done */
