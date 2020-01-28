Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Jan 2020 17:54:09 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.6 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01580230449-ext-6884@work.hours>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes and features for 5.6.

Thank you,
Vasily

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-1

for you to fetch changes up to 17248ea0367465f4aaef728f6af661ed38e38cf1:

  s390: fix __EMIT_BUG() macro (2020-01-22 13:05:35 +0100)

----------------------------------------------------------------
s390 updates for the 5.6 merge window

- Add clang 10 build support.

- Fix BUG() implementation to contain precise bug address, which is
  relevant for kprobes.

- Make ftraced function appear in a stacktrace.

- Minor perf improvements and refactoring.

- Possible deadlock and recovery fixes in pci code.

----------------------------------------------------------------
Niklas Schnelle (2):
      s390/pci: Recover handle in clp_set_pci_fn()
      s390/pci: Fix possible deadlock in recover_store()

Sven Schnelle (1):
      s390: fix __EMIT_BUG() macro

Thomas Richter (3):
      s390/cpum_sf: Convert debug trace to common layout
      s390/cpum_sf: Use kzalloc and minor changes
      s390/cpum_sf: Use DIV_ROUND_UP

Vasily Gorbik (3):
      s390/jump_label: use "i" constraint for clang
      s390: adjust -mpacked-stack support check for clang 10
      s390/ftrace: generate traced function stack frame

 arch/s390/Makefile                 |  2 +-
 arch/s390/boot/head.S              |  2 +-
 arch/s390/include/asm/bug.h        | 16 ++++-----
 arch/s390/include/asm/jump_label.h |  4 ++-
 arch/s390/include/asm/pci.h        |  2 +-
 arch/s390/kernel/entry.h           |  1 +
 arch/s390/kernel/mcount.S          | 15 ++++++++-
 arch/s390/kernel/perf_cpum_sf.c    | 67 ++++++++++++++++++++------------------
 arch/s390/kernel/pgm_check.S       |  2 +-
 arch/s390/kernel/traps.c           | 41 ++++++++++++++++++++---
 arch/s390/pci/pci.c                |  2 +-
 arch/s390/pci/pci_clp.c            | 48 ++++++++++++++++-----------
 arch/s390/pci/pci_sysfs.c          | 63 +++++++++++++++++++++++------------
 13 files changed, 172 insertions(+), 93 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index ba8556bb0fb1..e0e3a465bbfd 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -69,7 +69,7 @@ cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 #
 cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
 
-ifeq ($(call cc-option-yn,-mpacked-stack),y)
+ifeq ($(call cc-option-yn,-mpacked-stack -mbackchain -msoft-float),y)
 cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
 aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
 endif
diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
index 4b86a8d3c121..dae10961d072 100644
--- a/arch/s390/boot/head.S
+++ b/arch/s390/boot/head.S
@@ -329,7 +329,7 @@ ENTRY(startup_kdump)
 	.quad	.Lduct			# cr5: primary-aste origin
 	.quad	0			# cr6:	I/O interrupts
 	.quad	0			# cr7:	secondary space segment table
-	.quad	0			# cr8:	access registers translation
+	.quad	0x0000000000008000	# cr8:	access registers translation
 	.quad	0			# cr9:	tracing off
 	.quad	0			# cr10: tracing off
 	.quad	0			# cr11: tracing off
diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index a2b11ac00f60..7725f8006fdf 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -10,15 +10,14 @@
 
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
-		"0:	j	0b+2\n"				\
-		"1:\n"						\
+		"0:	mc	0,0\n"				\
 		".section .rodata.str,\"aMS\",@progbits,1\n"	\
-		"2:	.asciz	\""__FILE__"\"\n"		\
+		"1:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
 		".section __bug_table,\"awM\",@progbits,%2\n"	\
-		"3:	.long	1b-3b,2b-3b\n"			\
+		"2:	.long	0b-2b,1b-2b\n"			\
 		"	.short	%0,%1\n"			\
-		"	.org	3b+%2\n"			\
+		"	.org	2b+%2\n"			\
 		".previous\n"					\
 		: : "i" (__LINE__),				\
 		    "i" (x),					\
@@ -29,12 +28,11 @@
 
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
-		"0:	j	0b+2\n"				\
-		"1:\n"						\
+		"0:	mc	0,0\n"				\
 		".section __bug_table,\"awM\",@progbits,%1\n"	\
-		"2:	.long	1b-2b\n"			\
+		"1:	.long	0b-1b\n"			\
 		"	.short	%0\n"				\
-		"	.org	2b+%1\n"			\
+		"	.org	1b+%1\n"			\
 		".previous\n"					\
 		: : "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 39f747d63758..dcb1bba4f406 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -10,7 +10,9 @@
 #define JUMP_LABEL_NOP_SIZE 6
 #define JUMP_LABEL_NOP_OFFSET 2
 
-#if __GNUC__ < 9
+#ifdef CONFIG_CC_IS_CLANG
+#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
+#elif __GNUC__ < 9
 #define JUMP_LABEL_STATIC_KEY_CONSTRAINT "X"
 #else
 #define JUMP_LABEL_STATIC_KEY_CONSTRAINT "jdd"
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 3a06c264ea53..b05187ce5dbd 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -180,7 +180,7 @@ void zpci_remove_reserved_devices(void);
 /* CLP */
 int clp_scan_pci_devices(void);
 int clp_rescan_pci_devices(void);
-int clp_rescan_pci_devices_simple(void);
+int clp_rescan_pci_devices_simple(u32 *fid);
 int clp_add_pci_device(u32, u32, int);
 int clp_enable_fh(struct zpci_dev *, u8);
 int clp_disable_fh(struct zpci_dev *);
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index b2956d49b6ad..1d3927e01a5f 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -45,6 +45,7 @@ void specification_exception(struct pt_regs *regs);
 void transaction_exception(struct pt_regs *regs);
 void translation_exception(struct pt_regs *regs);
 void vector_exception(struct pt_regs *regs);
+void monitor_event_exception(struct pt_regs *regs);
 
 void do_per_trap(struct pt_regs *regs);
 void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str);
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 9e1660a6b9db..3431b2d5e334 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -26,6 +26,12 @@ ENDPROC(ftrace_stub)
 #define STACK_PTREGS	  (STACK_FRAME_OVERHEAD)
 #define STACK_PTREGS_GPRS (STACK_PTREGS + __PT_GPRS)
 #define STACK_PTREGS_PSW  (STACK_PTREGS + __PT_PSW)
+#ifdef __PACK_STACK
+/* allocate just enough for r14, r15 and backchain */
+#define TRACED_FUNC_FRAME_SIZE	24
+#else
+#define TRACED_FUNC_FRAME_SIZE	STACK_FRAME_OVERHEAD
+#endif
 
 ENTRY(_mcount)
 	BR_EX	%r14
@@ -39,9 +45,16 @@ ENTRY(ftrace_caller)
 #if !(defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT))
 	aghi	%r0,MCOUNT_RETURN_FIXUP
 #endif
-	aghi	%r15,-STACK_FRAME_SIZE
+	# allocate stack frame for ftrace_caller to contain traced function
+	aghi	%r15,-TRACED_FUNC_FRAME_SIZE
 	stg	%r1,__SF_BACKCHAIN(%r15)
+	stg	%r0,(__SF_GPRS+8*8)(%r15)
+	stg	%r15,(__SF_GPRS+9*8)(%r15)
+	# allocate pt_regs and stack frame for ftrace_trace_function
+	aghi	%r15,-STACK_FRAME_SIZE
 	stg	%r1,(STACK_PTREGS_GPRS+15*8)(%r15)
+	aghi	%r1,-TRACED_FUNC_FRAME_SIZE
+	stg	%r1,__SF_BACKCHAIN(%r15)
 	stg	%r0,(STACK_PTREGS_PSW+8)(%r15)
 	stmg	%r2,%r14,(STACK_PTREGS_GPRS+2*8)(%r15)
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 77d93c534284..b095b1c78987 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1383,7 +1383,8 @@ static void aux_output_end(struct perf_output_handle *handle)
 	te = aux_sdb_trailer(aux, aux->alert_mark);
 	te->flags &= ~SDB_TE_ALERT_REQ_MASK;
 
-	debug_sprintf_event(sfdbg, 6, "%s: collect %#lx SDBs\n", __func__, i);
+	debug_sprintf_event(sfdbg, 6, "%s: SDBs %ld range %ld head %ld\n",
+			    __func__, i, range_scan, aux->head);
 }
 
 /*
@@ -1416,13 +1417,17 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	 * SDBs between aux->head and aux->empty_mark are already ready
 	 * for new data. range_scan is num of SDBs not within them.
 	 */
+	debug_sprintf_event(sfdbg, 6,
+			    "%s: range %ld head %ld alert %ld empty %ld\n",
+			    __func__, range, aux->head, aux->alert_mark,
+			    aux->empty_mark);
 	if (range > AUX_SDB_NUM_EMPTY(aux)) {
 		range_scan = range - AUX_SDB_NUM_EMPTY(aux);
 		idx = aux->empty_mark + 1;
 		for (i = 0; i < range_scan; i++, idx++) {
 			te = aux_sdb_trailer(aux, idx);
-			te->flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
-			te->flags = te->flags & ~SDB_TE_ALERT_REQ_MASK;
+			te->flags &= ~(SDB_TE_BUFFER_FULL_MASK |
+				       SDB_TE_ALERT_REQ_MASK);
 			te->overflow = 0;
 		}
 		/* Save the position of empty SDBs */
@@ -1441,15 +1446,11 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	cpuhw->lsctl.tear = base + offset * sizeof(unsigned long);
 	cpuhw->lsctl.dear = aux->sdb_index[head];
 
-	debug_sprintf_event(sfdbg, 6, "%s: "
-			    "head->alert_mark->empty_mark (num_alert, range)"
-			    "[%#lx -> %#lx -> %#lx] (%#lx, %#lx) "
-			    "tear index %#lx, tear %#lx dear %#lx\n", __func__,
+	debug_sprintf_event(sfdbg, 6, "%s: head %ld alert %ld empty %ld "
+			    "index %ld tear %#lx dear %#lx\n", __func__,
 			    aux->head, aux->alert_mark, aux->empty_mark,
-			    AUX_SDB_NUM_ALERT(aux), range,
 			    head / CPUM_SF_SDB_PER_TABLE,
-			    cpuhw->lsctl.tear,
-			    cpuhw->lsctl.dear);
+			    cpuhw->lsctl.tear, cpuhw->lsctl.dear);
 
 	return 0;
 }
@@ -1469,8 +1470,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 	te = aux_sdb_trailer(aux, alert_index);
 	do {
 		orig_flags = te->flags;
-		orig_overflow = te->overflow;
-		*overflow = orig_overflow;
+		*overflow = orig_overflow = te->overflow;
 		if (orig_flags & SDB_TE_BUFFER_FULL_MASK) {
 			/*
 			 * SDB is already set by hardware.
@@ -1512,9 +1512,12 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 			     unsigned long long *overflow)
 {
 	unsigned long long orig_overflow, orig_flags, new_flags;
-	unsigned long i, range_scan, idx;
+	unsigned long i, range_scan, idx, idx_old;
 	struct hws_trailer_entry *te;
 
+	debug_sprintf_event(sfdbg, 6, "%s: range %ld head %ld alert %ld "
+			    "empty %ld\n", __func__, range, aux->head,
+			    aux->alert_mark, aux->empty_mark);
 	if (range <= AUX_SDB_NUM_EMPTY(aux))
 		/*
 		 * No need to scan. All SDBs in range are marked as empty.
@@ -1537,7 +1540,7 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 	 * indicator fall into this range, set it.
 	 */
 	range_scan = range - AUX_SDB_NUM_EMPTY(aux);
-	idx = aux->empty_mark + 1;
+	idx_old = idx = aux->empty_mark + 1;
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
 		do {
@@ -1557,6 +1560,9 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 	/* Update empty_mark to new position */
 	aux->empty_mark = aux->head + range - 1;
 
+	debug_sprintf_event(sfdbg, 6, "%s: range_scan %ld idx %ld..%ld "
+			    "empty %ld\n", __func__, range_scan, idx_old,
+			    idx - 1, aux->empty_mark);
 	return true;
 }
 
@@ -1570,7 +1576,6 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	unsigned long range = 0, size;
 	unsigned long long overflow = 0;
 	struct perf_output_handle *handle = &cpuhw->handle;
-	unsigned long num_sdb;
 
 	aux = perf_get_aux(handle);
 	if (WARN_ON_ONCE(!aux))
@@ -1578,8 +1583,9 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 
 	/* Inform user space new data arrived */
 	size = AUX_SDB_NUM_ALERT(aux) << PAGE_SHIFT;
+	debug_sprintf_event(sfdbg, 6, "%s: #alert %ld\n", __func__,
+			    size >> PAGE_SHIFT);
 	perf_aux_output_end(handle, size);
-	num_sdb = aux->sfb.num_sdb;
 
 	while (!done) {
 		/* Get an output handle */
@@ -1587,7 +1593,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 		if (handle->size == 0) {
 			pr_err("The AUX buffer with %lu pages for the "
 			       "diagnostic-sampling mode is full\n",
-				num_sdb);
+				aux->sfb.num_sdb);
 			debug_sprintf_event(sfdbg, 1,
 					    "%s: AUX buffer used up\n",
 					    __func__);
@@ -1612,14 +1618,14 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 			size = range << PAGE_SHIFT;
 			perf_aux_output_end(&cpuhw->handle, size);
 			pr_err("Sample data caused the AUX buffer with %lu "
-			       "pages to overflow\n", num_sdb);
-			debug_sprintf_event(sfdbg, 1, "%s: head %#lx range %#lx "
-					    "overflow %#llx\n", __func__,
+			       "pages to overflow\n", aux->sfb.num_sdb);
+			debug_sprintf_event(sfdbg, 1, "%s: head %ld range %ld "
+					    "overflow %lld\n", __func__,
 					    aux->head, range, overflow);
 		} else {
 			size = AUX_SDB_NUM_ALERT(aux) << PAGE_SHIFT;
 			perf_aux_output_end(&cpuhw->handle, size);
-			debug_sprintf_event(sfdbg, 6, "%s: head %#lx alert %#lx "
+			debug_sprintf_event(sfdbg, 6, "%s: head %ld alert %ld "
 					    "already full, try another\n",
 					    __func__,
 					    aux->head, aux->alert_mark);
@@ -1627,11 +1633,9 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	}
 
 	if (done)
-		debug_sprintf_event(sfdbg, 6, "%s: aux_reset_buffer "
-				    "[%#lx -> %#lx -> %#lx] (%#lx, %#lx)\n",
-				    __func__, aux->head, aux->alert_mark,
-				    aux->empty_mark, AUX_SDB_NUM_ALERT(aux),
-				    range);
+		debug_sprintf_event(sfdbg, 6, "%s: head %ld alert %ld "
+				    "empty %ld\n", __func__, aux->head,
+				    aux->alert_mark, aux->empty_mark);
 }
 
 /*
@@ -1654,8 +1658,7 @@ static void aux_buffer_free(void *data)
 	kfree(aux->sdb_index);
 	kfree(aux);
 
-	debug_sprintf_event(sfdbg, 4, "%s: free "
-			    "%lu SDBTs\n", __func__, num_sdbt);
+	debug_sprintf_event(sfdbg, 4, "%s: SDBTs %lu\n", __func__, num_sdbt);
 }
 
 static void aux_sdb_init(unsigned long sdb)
@@ -1707,13 +1710,13 @@ static void *aux_buffer_setup(struct perf_event *event, void **pages,
 	}
 
 	/* Allocate aux_buffer struct for the event */
-	aux = kmalloc(sizeof(struct aux_buffer), GFP_KERNEL);
+	aux = kzalloc(sizeof(struct aux_buffer), GFP_KERNEL);
 	if (!aux)
 		goto no_aux;
 	sfb = &aux->sfb;
 
 	/* Allocate sdbt_index for fast reference */
-	n_sdbt = (nr_pages + CPUM_SF_SDB_PER_TABLE - 1) / CPUM_SF_SDB_PER_TABLE;
+	n_sdbt = DIV_ROUND_UP(nr_pages, CPUM_SF_SDB_PER_TABLE);
 	aux->sdbt_index = kmalloc_array(n_sdbt, sizeof(void *), GFP_KERNEL);
 	if (!aux->sdbt_index)
 		goto no_sdbt_index;
@@ -1763,8 +1766,8 @@ static void *aux_buffer_setup(struct perf_event *event, void **pages,
 	 */
 	aux->empty_mark = sfb->num_sdb - 1;
 
-	debug_sprintf_event(sfdbg, 4, "%s: setup %lu SDBTs and %lu SDBs\n",
-			    __func__, sfb->num_sdbt, sfb->num_sdb);
+	debug_sprintf_event(sfdbg, 4, "%s: SDBTs %lu SDBs %lu\n", __func__,
+			    sfb->num_sdbt, sfb->num_sdb);
 
 	return aux;
 
diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
index 59dee9d3bebf..eee3a482195a 100644
--- a/arch/s390/kernel/pgm_check.S
+++ b/arch/s390/kernel/pgm_check.S
@@ -81,7 +81,7 @@ PGM_CHECK_DEFAULT			/* 3c */
 PGM_CHECK_DEFAULT			/* 3d */
 PGM_CHECK_DEFAULT			/* 3e */
 PGM_CHECK_DEFAULT			/* 3f */
-PGM_CHECK_DEFAULT			/* 40 */
+PGM_CHECK(monitor_event_exception)	/* 40 */
 PGM_CHECK_DEFAULT			/* 41 */
 PGM_CHECK_DEFAULT			/* 42 */
 PGM_CHECK_DEFAULT			/* 43 */
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 164c0282b41a..dc75588d7894 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -53,11 +53,6 @@ void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str)
                 if (fixup)
 			regs->psw.addr = extable_fixup(fixup);
 		else {
-			enum bug_trap_type btt;
-
-			btt = report_bug(regs->psw.addr, regs);
-			if (btt == BUG_TRAP_TYPE_WARN)
-				return;
 			die(regs, str);
 		}
         }
@@ -245,6 +240,27 @@ void space_switch_exception(struct pt_regs *regs)
 	do_trap(regs, SIGILL, ILL_PRVOPC, "space switch event");
 }
 
+void monitor_event_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	if (user_mode(regs))
+		return;
+
+	switch (report_bug(regs->psw.addr - (regs->int_code >> 16), regs)) {
+	case BUG_TRAP_TYPE_NONE:
+		fixup = s390_search_extables(regs->psw.addr);
+		if (fixup)
+			regs->psw.addr = extable_fixup(fixup);
+		break;
+	case BUG_TRAP_TYPE_WARN:
+		break;
+	case BUG_TRAP_TYPE_BUG:
+		die(regs, "monitor event");
+		break;
+	}
+}
+
 void kernel_stack_overflow(struct pt_regs *regs)
 {
 	bust_spinlocks(1);
@@ -255,8 +271,23 @@ void kernel_stack_overflow(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kernel_stack_overflow);
 
+static void test_monitor_call(void)
+{
+	int val = 1;
+
+	asm volatile(
+		"	mc	0,0\n"
+		"0:	xgr	%0,%0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (val));
+	if (!val)
+		panic("Monitor call doesn't work!\n");
+}
+
 void __init trap_init(void)
 {
 	sort_extable(__start_dma_ex_table, __stop_dma_ex_table);
 	local_mcck_enable();
+	test_monitor_call();
 }
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 8e872951c07b..bc61ea18e88d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -939,5 +939,5 @@ subsys_initcall_sync(pci_base_init);
 void zpci_rescan(void)
 {
 	if (zpci_is_enabled())
-		clp_rescan_pci_devices_simple();
+		clp_rescan_pci_devices_simple(NULL);
 }
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 4c613e569fe0..0d3d8f170ea4 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -240,12 +240,14 @@ int clp_add_pci_device(u32 fid, u32 fh, int configured)
 }
 
 /*
- * Enable/Disable a given PCI function defined by its function handle.
+ * Enable/Disable a given PCI function and update its function handle if
+ * necessary
  */
-static int clp_set_pci_fn(u32 *fh, u8 nr_dma_as, u8 command)
+static int clp_set_pci_fn(struct zpci_dev *zdev, u8 nr_dma_as, u8 command)
 {
 	struct clp_req_rsp_set_pci *rrb;
 	int rc, retries = 100;
+	u32 fid = zdev->fid;
 
 	rrb = clp_alloc_block(GFP_KERNEL);
 	if (!rrb)
@@ -256,7 +258,7 @@ static int clp_set_pci_fn(u32 *fh, u8 nr_dma_as, u8 command)
 		rrb->request.hdr.len = sizeof(rrb->request);
 		rrb->request.hdr.cmd = CLP_SET_PCI_FN;
 		rrb->response.hdr.len = sizeof(rrb->response);
-		rrb->request.fh = *fh;
+		rrb->request.fh = zdev->fh;
 		rrb->request.oc = command;
 		rrb->request.ndas = nr_dma_as;
 
@@ -269,12 +271,17 @@ static int clp_set_pci_fn(u32 *fh, u8 nr_dma_as, u8 command)
 		}
 	} while (rrb->response.hdr.rsp == CLP_RC_SETPCIFN_BUSY);
 
-	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
-		*fh = rrb->response.fh;
-	else {
+	if (rc || rrb->response.hdr.rsp != CLP_RC_OK) {
 		zpci_err("Set PCI FN:\n");
 		zpci_err_clp(rrb->response.hdr.rsp, rc);
-		rc = -EIO;
+	}
+
+	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK) {
+		zdev->fh = rrb->response.fh;
+	} else if (!rc && rrb->response.hdr.rsp == CLP_RC_SETPCIFN_ALRDY &&
+			rrb->response.fh == 0) {
+		/* Function is already in desired state - update handle */
+		rc = clp_rescan_pci_devices_simple(&fid);
 	}
 	clp_free_block(rrb);
 	return rc;
@@ -282,18 +289,17 @@ static int clp_set_pci_fn(u32 *fh, u8 nr_dma_as, u8 command)
 
 int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
 {
-	u32 fh = zdev->fh;
 	int rc;
 
-	rc = clp_set_pci_fn(&fh, nr_dma_as, CLP_SET_ENABLE_PCI_FN);
-	zpci_dbg(3, "ena fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
+	rc = clp_set_pci_fn(zdev, nr_dma_as, CLP_SET_ENABLE_PCI_FN);
+	zpci_dbg(3, "ena fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
 	if (rc)
 		goto out;
 
-	zdev->fh = fh;
 	if (zpci_use_mio(zdev)) {
-		rc = clp_set_pci_fn(&fh, nr_dma_as, CLP_SET_ENABLE_MIO);
-		zpci_dbg(3, "ena mio fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
+		rc = clp_set_pci_fn(zdev, nr_dma_as, CLP_SET_ENABLE_MIO);
+		zpci_dbg(3, "ena mio fid:%x, fh:%x, rc:%d\n",
+				zdev->fid, zdev->fh, rc);
 		if (rc)
 			clp_disable_fh(zdev);
 	}
@@ -309,11 +315,8 @@ int clp_disable_fh(struct zpci_dev *zdev)
 	if (!zdev_enabled(zdev))
 		return 0;
 
-	rc = clp_set_pci_fn(&fh, 0, CLP_SET_DISABLE_PCI_FN);
+	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
 	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
-	if (!rc)
-		zdev->fh = fh;
-
 	return rc;
 }
 
@@ -370,10 +373,14 @@ static void __clp_add(struct clp_fh_list_entry *entry, void *data)
 static void __clp_update(struct clp_fh_list_entry *entry, void *data)
 {
 	struct zpci_dev *zdev;
+	u32 *fid = data;
 
 	if (!entry->vendor_id)
 		return;
 
+	if (fid && *fid != entry->fid)
+		return;
+
 	zdev = get_zdev_by_fid(entry->fid);
 	if (!zdev)
 		return;
@@ -413,7 +420,10 @@ int clp_rescan_pci_devices(void)
 	return rc;
 }
 
-int clp_rescan_pci_devices_simple(void)
+/* Rescan PCI functions and refresh function handles. If fid is non-NULL only
+ * refresh the handle of the function matching @fid
+ */
+int clp_rescan_pci_devices_simple(u32 *fid)
 {
 	struct clp_req_rsp_list_pci *rrb;
 	int rc;
@@ -422,7 +432,7 @@ int clp_rescan_pci_devices_simple(void)
 	if (!rrb)
 		return -ENOMEM;
 
-	rc = clp_list_pci(rrb, NULL, __clp_update);
+	rc = clp_list_pci(rrb, fid, __clp_update);
 
 	clp_free_block(rrb);
 	return rc;
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index a433ba01a317..215f17437a4f 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -13,6 +13,8 @@
 #include <linux/stat.h>
 #include <linux/pci.h>
 
+#include "../../../drivers/pci/pci.h"
+
 #include <asm/sclp.h>
 
 #define zpci_attr(name, fmt, member)					\
@@ -49,31 +51,50 @@ static DEVICE_ATTR_RO(mio_enabled);
 static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
+	struct kernfs_node *kn;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct zpci_dev *zdev = to_zpci(pdev);
-	int ret;
-
-	if (!device_remove_file_self(dev, attr))
-		return count;
-
+	int ret = 0;
+
+	/* Can't use device_remove_self() here as that would lead us to lock
+	 * the pci_rescan_remove_lock while holding the device' kernfs lock.
+	 * This would create a possible deadlock with disable_slot() which is
+	 * not directly protected by the device' kernfs lock but takes it
+	 * during the device removal which happens under
+	 * pci_rescan_remove_lock.
+	 *
+	 * This is analogous to sdev_store_delete() in
+	 * drivers/scsi/scsi_sysfs.c
+	 */
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	WARN_ON_ONCE(!kn);
+	/* device_remove_file() serializes concurrent calls ignoring all but
+	 * the first
+	 */
+	device_remove_file(dev, attr);
+
+	/* A concurrent call to recover_store() may slip between
+	 * sysfs_break_active_protection() and the sysfs file removal.
+	 * Once it unblocks from pci_lock_rescan_remove() the original pdev
+	 * will already be removed.
+	 */
 	pci_lock_rescan_remove();
-	pci_stop_and_remove_bus_device(pdev);
-	ret = zpci_disable_device(zdev);
-	if (ret)
-		goto error;
-
-	ret = zpci_enable_device(zdev);
-	if (ret)
-		goto error;
-
-	pci_rescan_bus(zdev->bus);
+	if (pci_dev_is_added(pdev)) {
+		pci_stop_and_remove_bus_device(pdev);
+		ret = zpci_disable_device(zdev);
+		if (ret)
+			goto out;
+
+		ret = zpci_enable_device(zdev);
+		if (ret)
+			goto out;
+		pci_rescan_bus(zdev->bus);
+	}
+out:
 	pci_unlock_rescan_remove();
-
-	return count;
-
-error:
-	pci_unlock_rescan_remove();
-	return ret;
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
+	return ret ? ret : count;
 }
 static DEVICE_ATTR_WO(recover);
 
