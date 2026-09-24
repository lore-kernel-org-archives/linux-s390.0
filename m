Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E530475335;
	Thu, 24 Sep 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253660; cv=none; b=gBqKfu0u+9aO/j+Mv3McOmeBHq7WyVUHjUSVLo5Tr7+CiXPakBQwBUnFY0Oggm2I6N+SSXvEBe9nA+PcdqGoFrw4xMih6LxJGmJSI2ISOWVG/OsHJCUd1uccj4FCG9gS7vPsyMkjKGKEQweEsQU5sy7tGff2p26sXel6bi+8LL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253660; c=relaxed/simple;
	bh=/jqVamknE/hwPpDPAMvs5lJns+5IkegjNU9d50yOpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1QViBiyTHqbeQ74VrvJEEdQ5VJpUUwJg3W4sMA4kR1LLYDDpDaRGUt9/bSC++FhbzvjzfSnNihBZjOZQ3dajSsHMYOtleMsW+2jXp3gYZ2nlLAUuL3bjvmzoMqbTgzWaF/ln69G2zTezA0zC/QcKf8o1Irppn31mX/fiJFX3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hKW3MwOL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hKW3MwOL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2zc1Az1WPMbLgYZBuF3TRrXNWHds2+oNXVqycmmDQYg=;
	t=1790253656; x=1791463256; b=hKW3MwOLbsDa6l9kCHQbXXPtj9MXDgy8U7XCewXUO1IApnC
	SjuWnARiteuB0rEH2W8mgWqNiH9Klzf7q14Yr9upB4XxILtTmYZOJpNeIBtyT0IWrTyYUd4CAW7Xc
	Xc672Q9B0O/hzpphapoTQNyJyP2M4vs9uyUbOUyFivS77+423Y0qKiJJaDTsMRx4LfVITClTESFmN
	Oa+yJtnwIHhhdVqI7wTy7hcoECMp6ygCKyJzOfZP479PahFb1UagCA6QhK+8YATaBBhylxE9qyopp
	3VldOMmfj4RwM1fgPz1iPktFSNVqRhkYXHxhwrW1ifYX3fygAPRHtKyEwKPt2dLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikt-000000092x8-3gP2;
	Thu, 24 Sep 2026 14:40:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] um: ORC unwinder support
Date: Thu, 24 Sep 2026 14:35:53 +0200
Message-ID: <20260924144039.52fff8ac4e16.Ie3f2b9610f0bc9cf45ca82c17f3b9e0f90354ea4@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124039.1621965-6-johannes@sipsolutions.net>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add support for the ORC unwinder on 64-bit UML. Since that's just
normal x86_64 code, the objtool etc. is the same and the unwinder
itself is mostly copied from x86, except
 - register accesses, obviously;
 - no need for (entry) assembly support
 - interrupts are host signals, so we can unwind across them
   by detecting the signal restorer and using the ucontext

Note that due to the indirect calls with -mcmodel=large objtool
gets confused in some places resulting in some warnings, but I
couldn't find a way to suppress that and it seemed harmless.

Assisted-by: LLM
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig.debug            |  15 +
 arch/um/include/asm/common.lds.S |   2 +
 arch/um/include/asm/stacktrace.h |  87 ++++++
 arch/um/include/asm/unwind.h     |  70 ++++-
 arch/um/include/shared/os.h      |   1 +
 arch/um/kernel/Makefile          |   3 +
 arch/um/kernel/dyn.lds.S         |   1 +
 arch/um/kernel/skas/Makefile     |   2 +
 arch/um/kernel/stacktrace.c      |  21 ++
 arch/um/kernel/um_arch.c         |   3 +
 arch/um/kernel/uml.lds.S         |   1 +
 arch/um/kernel/unwind_orc.c      | 478 +++++++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c        |   6 +
 arch/x86/um/user-offsets.c       |   4 +
 scripts/Makefile                 |   4 +
 tools/scripts/Makefile.arch      |   5 +
 16 files changed, 700 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/kernel/unwind_orc.c

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index 1dfb2959c73b..1228738fc228 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -36,3 +36,18 @@ config EARLY_PRINTK
 
 	  This is useful for kernel debugging when your machine crashes very
 	  early before the console code is initialized.
+
+config UNWINDER_ORC
+	bool "ORC unwinder"
+	depends on X86_64
+	select OBJTOOL
+	select BUILDTIME_TABLE_SORT
+	help
+	  This option enables the ORC (Oops Rewind Capability) unwinder for
+	  kernel stack traces, instead of scanning the stack for anything
+	  that looks like a kernel text address.  It uses unwind tables that
+	  objtool generates at compile time, so traces are exact and don't
+	  depend on frame pointers.  This increases the kernel image size by
+	  roughly 1-4 MB, depending on the configuration.
+
+	  If you're unsure, say N.
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index fd481ac371de..f7c05291fc12 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -20,6 +20,8 @@
 
   BUG_TABLE
 
+  ORC_UNWIND_TABLE
+
   .uml.setup.init : {
 	__uml_setup_start = .;
 	*(.uml.setup.init)
diff --git a/arch/um/include/asm/stacktrace.h b/arch/um/include/asm/stacktrace.h
index 436b55952c3a..2a5e86eac3bf 100644
--- a/arch/um/include/asm/stacktrace.h
+++ b/arch/um/include/asm/stacktrace.h
@@ -4,6 +4,7 @@
 
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
+#include <linux/sched/task_stack.h>
 
 struct stack_frame {
 	struct stack_frame *next_frame;
@@ -40,4 +41,90 @@ static inline unsigned long
 
 void dump_trace(struct task_struct *tsk, const struct stacktrace_ops *ops, void *data);
 
+#ifdef CONFIG_UNWINDER_ORC
+
+#include <linux/smp-internal.h>
+
+/* host signal handlers run on the per-CPU cpu_irqstacks (sigaltstack) */
+enum stack_type {
+	STACK_TYPE_UNKNOWN,
+	STACK_TYPE_TASK,
+	STACK_TYPE_IRQ,
+};
+
+struct stack_info {
+	enum stack_type type;
+	unsigned long *begin, *end, *next_sp;
+};
+
+static inline bool on_stack(struct stack_info *info, void *addr, size_t len)
+{
+	void *begin = info->begin;
+	void *end = info->end;
+
+	return info->type != STACK_TYPE_UNKNOWN &&
+	       addr >= begin && addr < end &&
+	       addr + len > begin && addr + len <= end;
+}
+
+static inline bool in_task_stack(unsigned long *stack, struct task_struct *task,
+				 struct stack_info *info)
+{
+	unsigned long *begin = task_stack_page(task);
+	unsigned long *end = task_stack_page(task) + THREAD_SIZE;
+
+	if (stack < begin || stack >= end)
+		return false;
+
+	info->type = STACK_TYPE_TASK;
+	info->begin = begin;
+	info->end = end;
+	info->next_sp = NULL;
+
+	return true;
+}
+
+static inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
+{
+	void *begin = cpu_irqstacks;
+	void *end = cpu_irqstacks + NR_CPUS;
+
+	if ((void *)stack < begin || (void *)stack >= end)
+		return false;
+
+	begin = PTR_ALIGN_DOWN(stack, THREAD_SIZE);
+	info->type = STACK_TYPE_IRQ;
+	info->begin = begin;
+	info->end = begin + THREAD_SIZE;
+	info->next_sp = NULL;
+
+	return true;
+}
+
+static inline int get_stack_info(unsigned long *stack, struct task_struct *task,
+				 struct stack_info *info, unsigned long *visit_mask)
+{
+	task = task ? : current;
+
+	if (!stack)
+		goto unknown;
+
+	if (!in_task_stack(stack, task, info) &&
+	    (task != current || !in_irq_stack(stack, info)))
+		goto unknown;
+
+	if (visit_mask) {
+		if (*visit_mask & (1UL << info->type))
+			goto unknown;
+		*visit_mask |= 1UL << info->type;
+	}
+
+	return 0;
+
+unknown:
+	info->type = STACK_TYPE_UNKNOWN;
+	return -EINVAL;
+}
+#endif /* CONFIG_UNWINDER_ORC */
+
 #endif /* _ASM_UML_STACKTRACE_H */
diff --git a/arch/um/include/asm/unwind.h b/arch/um/include/asm/unwind.h
index 7ffa5437b761..848013ba2f23 100644
--- a/arch/um/include/asm/unwind.h
+++ b/arch/um/include/asm/unwind.h
@@ -1,8 +1,72 @@
 #ifndef _ASM_UML_UNWIND_H
 #define _ASM_UML_UNWIND_H
 
-static inline void
-unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
-		   void *orc, size_t orc_size) {}
+#ifdef CONFIG_UNWINDER_ORC
+
+#include <linux/sched.h>
+#include <linux/ftrace.h>
+#include <asm/ptrace.h>
+#include <asm/stacktrace.h>
+
+struct unwind_state {
+	struct stack_info stack_info;
+	unsigned long stack_mask;
+	struct task_struct *task;
+	int graph_idx;
+	bool error;
+	bool signal;
+	unsigned long sp, bp, ip;
+	struct pt_regs *regs;
+};
+
+void __unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs, unsigned long *first_frame);
+bool unwind_next_frame(struct unwind_state *state);
+unsigned long unwind_get_return_address(struct unwind_state *state);
+
+static inline bool unwind_done(struct unwind_state *state)
+{
+	return state->stack_info.type == STACK_TYPE_UNKNOWN;
+}
+
+static inline bool unwind_error(struct unwind_state *state)
+{
+	return state->error;
+}
+
+static inline
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		  struct pt_regs *regs, unsigned long *first_frame)
+{
+	first_frame = first_frame ? : get_stack_pointer(task, regs);
+
+	__unwind_start(state, task, regs, first_frame);
+}
+
+void unwind_init(void);
+
+/* No HAVE_RETHOOK on UML, so only ftrace_graph needs to be undone. */
+static inline
+unsigned long unwind_recover_ret_addr(struct unwind_state *state,
+				      unsigned long addr, unsigned long *addr_p)
+{
+	return ftrace_graph_ret_addr(state->task, &state->graph_idx,
+				     addr, addr_p);
+}
+
+static inline bool task_on_another_cpu(struct task_struct *task)
+{
+#ifdef CONFIG_SMP
+	return task != current && task->on_cpu;
+#else
+	return false;
+#endif
+}
+
+#else /* !CONFIG_UNWINDER_ORC */
+
+static inline void unwind_init(void) {}
+
+#endif /* CONFIG_UNWINDER_ORC */
 
 #endif /* _ASM_UML_UNWIND_H */
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b26e94292fc1..e2ed2be96e4e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -239,6 +239,7 @@ extern int set_umid(char *name);
 extern char *get_umid(void);
 
 /* signal.c */
+extern unsigned long os_sigreturn_ip;
 extern void timer_set_signal_handler(void);
 extern void set_sigstack(void *sig_stack, int size);
 extern void set_handler(int sig);
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index be60bc451b3f..1dcea482a03a 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -25,8 +25,11 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-$(CONFIG_UNWINDER_ORC) += unwind_orc.o
 obj-$(CONFIG_SMP) += smp.o
 
+KCOV_INSTRUMENT_unwind_orc.o := n
+
 USER_OBJS := config.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 042e8d7fba0a..8cb28e997c22 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -1,5 +1,6 @@
 #include <asm/vmlinux.lds.h>
 #include <asm/page.h>
+#include <asm/orc_lookup.h>
 
 OUTPUT_FORMAT(ELF_FORMAT)
 OUTPUT_ARCH(ELF_ARCH)
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 3384be42691f..467e64c1a820 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -46,5 +46,7 @@ CFLAGS_stub_exe.o += $(call cc-option, -ftrivial-auto-var-init=uninitialized)
 
 UNPROFILE_OBJS := stub.o stub_exe.o
 KCOV_INSTRUMENT := n
+# not really linked as code and shouldn't have ORC data created
+OBJECT_FILES_NON_STANDARD_stub.o := y
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/stacktrace.c b/arch/um/kernel/stacktrace.c
index fd3b61b3d4d2..d4489b4c191b 100644
--- a/arch/um/kernel/stacktrace.c
+++ b/arch/um/kernel/stacktrace.c
@@ -12,7 +12,27 @@
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <asm/stacktrace.h>
+#include <asm/unwind.h>
 
+#ifdef CONFIG_UNWINDER_ORC
+void dump_trace(struct task_struct *tsk,
+		const struct stacktrace_ops *ops,
+		void *data)
+{
+	struct pt_regs *segv_regs = tsk == current ? tsk->thread.segv_regs : NULL;
+	struct unwind_state state;
+	unsigned long addr;
+
+	for (unwind_start(&state, tsk, segv_regs, NULL);
+	     !unwind_done(&state); unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		/* e.g. a signal interrupted libc, keep going with the fallback */
+		if (!addr)
+			continue;
+		ops->address(data, addr, !unwind_error(&state));
+	}
+}
+#else
 void dump_trace(struct task_struct *tsk,
 		const struct stacktrace_ops *ops,
 		void *data)
@@ -40,6 +60,7 @@ void dump_trace(struct task_struct *tsk,
 		sp++;
 	}
 }
+#endif
 
 static void save_addr(void *data, unsigned long address, int reliable)
 {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e4ee693961e4..2f9ae739d182 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -26,6 +26,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/text-patching.h>
+#include <asm/unwind.h>
 #include <as-layout.h>
 #include <arch.h>
 #include <init.h>
@@ -422,6 +423,8 @@ void __init setup_arch(char **cmdline_p)
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
 		memzero_explicit(rng_seed, sizeof(rng_seed));
 	}
+
+	unwind_init();
 }
 
 void __init arch_cpu_finalize_init(void)
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index ac53e0fa9efe..a73bb3782aa7 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vmlinux.lds.h>
 #include <asm/page.h>
+#include <asm/orc_lookup.h>
 
 OUTPUT_FORMAT(ELF_FORMAT)
 OUTPUT_ARCH(ELF_ARCH)
diff --git a/arch/um/kernel/unwind_orc.c b/arch/um/kernel/unwind_orc.c
new file mode 100644
index 000000000000..e1883ed4e07f
--- /dev/null
+++ b/arch/um/kernel/unwind_orc.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/objtool.h>
+#include <linux/module.h>
+#include <linux/orc.h>
+#include <linux/bpf.h>
+#include <asm/ptrace.h>
+#include <asm/stacktrace.h>
+#include <asm/unwind.h>
+#include <asm/orc_types.h>
+#include <asm/orc_lookup.h>
+#include <asm/orc_header.h>
+#include <generated/user_constants.h>
+#include <os.h>
+
+ORC_HEADER;
+
+#define orc_warn(fmt, ...) \
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+
+#define orc_warn_current(args...)					\
+({									\
+	static bool dumped_before;					\
+	if (state->task == current && !state->error) {			\
+		orc_warn(args);						\
+		if (unwind_debug && !dumped_before) {			\
+			dumped_before = true;				\
+			unwind_dump(state);				\
+		}							\
+	}								\
+})
+
+extern int __start_orc_unwind_ip[];
+extern int __stop_orc_unwind_ip[];
+extern struct orc_entry __start_orc_unwind[];
+extern struct orc_entry __stop_orc_unwind[];
+
+static bool orc_init __ro_after_init;
+static bool unwind_debug __ro_after_init;
+static unsigned int lookup_num_blocks __ro_after_init;
+
+static int __init unwind_debug_cmdline(char *str)
+{
+	unwind_debug = true;
+
+	return 0;
+}
+early_param("unwind_debug", unwind_debug_cmdline);
+
+static void unwind_dump(struct unwind_state *state)
+{
+	static bool dumped_before;
+	unsigned long word, *sp;
+	struct stack_info stack_info = {0};
+	unsigned long visit_mask = 0;
+
+	if (dumped_before)
+		return;
+
+	dumped_before = true;
+
+	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
+			state->stack_info.type, state->stack_info.next_sp,
+			state->stack_mask, state->graph_idx);
+
+	for (sp = __builtin_frame_address(0); sp;
+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
+			break;
+
+		for (; sp < stack_info.end; sp++) {
+			word = READ_ONCE_NOCHECK(*sp);
+
+			printk_deferred("%0*lx: %0*lx (%pB)\n", BITS_PER_LONG / 4,
+					(unsigned long)sp, BITS_PER_LONG / 4,
+					word, (void *)word);
+		}
+	}
+}
+
+/* Fake frame pointer entry -- used as a fallback for generated code */
+static struct orc_entry orc_fp_entry = {
+	.type		= ORC_TYPE_CALL,
+	.sp_reg		= ORC_REG_BP,
+	.sp_offset	= 16,
+	.bp_reg		= ORC_REG_PREV_SP,
+	.bp_offset	= -16,
+};
+
+static struct orc_entry *orc_bpf_find(unsigned long ip)
+{
+#ifdef CONFIG_BPF_JIT
+	if (bpf_has_frame_pointer(ip))
+		return &orc_fp_entry;
+#endif
+
+	return NULL;
+}
+
+/*
+ * If we crash with IP==0, the last successfully executed instruction
+ * was probably an indirect function call with a NULL function pointer,
+ * and we don't have unwind information for NULL.
+ * This hardcoded ORC entry for IP==0 allows us to unwind from a NULL function
+ * pointer into its parent and then continue normally from there.
+ */
+static struct orc_entry null_orc_entry = {
+	.sp_offset = sizeof(long),
+	.sp_reg = ORC_REG_SP,
+	.bp_reg = ORC_REG_UNDEFINED,
+	.type = ORC_TYPE_CALL
+};
+
+static struct orc_entry *orc_find(unsigned long ip)
+{
+	struct orc_entry *orc;
+
+	if (ip == 0)
+		return &null_orc_entry;
+
+	/* For non-init vmlinux addresses, use the fast lookup table: */
+	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
+		unsigned int idx, start, stop;
+
+		idx = (ip - LOOKUP_START_IP) / LOOKUP_BLOCK_SIZE;
+
+		if (unlikely((idx >= lookup_num_blocks - 1))) {
+			orc_warn("bad lookup idx: idx=%u num=%u ip=%pB\n",
+				 idx, lookup_num_blocks, (void *)ip);
+			return NULL;
+		}
+
+		start = orc_lookup[idx];
+		stop = orc_lookup[idx + 1] + 1;
+
+		if (unlikely((__start_orc_unwind + start >= __stop_orc_unwind) ||
+			     (__start_orc_unwind + stop > __stop_orc_unwind))) {
+			orc_warn("bad lookup value: idx=%u num=%u start=%u stop=%u ip=%pB\n",
+				 idx, lookup_num_blocks, start, stop, (void *)ip);
+			return NULL;
+		}
+
+		return __orc_find(__start_orc_unwind_ip + start,
+				  __start_orc_unwind + start, stop - start, ip);
+	}
+
+	/* vmlinux .init slow lookup: */
+	if (is_kernel_inittext(ip))
+		return __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
+				  __stop_orc_unwind_ip - __start_orc_unwind_ip, ip);
+
+	/* Module lookup: */
+	orc = orc_module_find(ip);
+	if (orc)
+		return orc;
+
+	/* BPF lookup: */
+	return orc_bpf_find(ip);
+}
+
+void __init unwind_init(void)
+{
+	size_t orc_ip_size = (void *)__stop_orc_unwind_ip - (void *)__start_orc_unwind_ip;
+	size_t orc_size = (void *)__stop_orc_unwind - (void *)__start_orc_unwind;
+	size_t num_entries = orc_ip_size / sizeof(int);
+	struct orc_entry *orc;
+	int i;
+
+	if (!num_entries || orc_ip_size % sizeof(int) != 0 ||
+	    orc_size % sizeof(struct orc_entry) != 0 ||
+	    num_entries != orc_size / sizeof(struct orc_entry)) {
+		orc_warn("Bad or missing .orc_unwind table.  Disabling unwinder.\n");
+		return;
+	}
+
+	/*
+	 * Note, the orc_unwind and orc_unwind_ip tables were already
+	 * sorted at build time via the 'sorttable' tool.
+	 * It's ready for binary search straight away, no need to sort it.
+	 */
+
+	/* Initialize the fast lookup table: */
+	lookup_num_blocks = orc_lookup_end - orc_lookup;
+	for (i = 0; i < lookup_num_blocks - 1; i++) {
+		orc = __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
+				 num_entries,
+				 LOOKUP_START_IP + (LOOKUP_BLOCK_SIZE * i));
+		if (!orc) {
+			orc_warn("Corrupt .orc_unwind table.  Disabling unwinder.\n");
+			return;
+		}
+
+		orc_lookup[i] = orc - __start_orc_unwind;
+	}
+
+	/* Initialize the ending block: */
+	orc = __orc_find(__start_orc_unwind_ip, __start_orc_unwind, num_entries,
+			 LOOKUP_STOP_IP);
+	if (!orc) {
+		orc_warn("Corrupt .orc_unwind table.  Disabling unwinder.\n");
+		return;
+	}
+	orc_lookup[lookup_num_blocks - 1] = orc - __start_orc_unwind;
+
+	orc_init = true;
+}
+
+unsigned long unwind_get_return_address(struct unwind_state *state)
+{
+	if (unwind_done(state))
+		return 0;
+
+	return __kernel_text_address(state->ip) ? state->ip : 0;
+}
+EXPORT_SYMBOL_GPL(unwind_get_return_address);
+
+static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
+			    size_t len)
+{
+	struct stack_info *info = &state->stack_info;
+	void *addr = (void *)_addr;
+
+	if (on_stack(info, addr, len))
+		return true;
+
+	return !get_stack_info(addr, state->task, info, &state->stack_mask) &&
+		on_stack(info, addr, len);
+}
+
+static bool deref_stack_reg(struct unwind_state *state, unsigned long addr,
+			    unsigned long *val)
+{
+	if (!stack_access_ok(state, addr, sizeof(long)))
+		return false;
+
+	*val = READ_ONCE_NOCHECK(*(unsigned long *)addr);
+	return true;
+}
+
+bool unwind_next_frame(struct unwind_state *state)
+{
+	unsigned long ip_p, sp, orig_ip = state->ip, prev_sp = state->sp;
+	enum stack_type prev_type = state->stack_info.type;
+	struct orc_entry *orc;
+	bool indirect = false;
+
+	if (unwind_done(state))
+		return false;
+
+	/* Don't let modules unload while we're reading their ORC data. */
+	guard(rcu)();
+
+	/* End-of-stack check for user tasks: */
+	if (state->regs && user_mode(state->regs))
+		goto the_end;
+
+	/*
+	 * Find the orc_entry associated with the text address.
+	 *
+	 * For a call frame (as opposed to a signal frame), state->ip points to
+	 * the instruction after the call.  That instruction's stack layout
+	 * could be different from the call instruction's layout, for example
+	 * if the call was to a noreturn function.  So get the ORC data for the
+	 * call instruction itself.
+	 */
+	orc = orc_find(state->signal ? state->ip : state->ip - 1);
+	if (!orc) {
+		/*
+		 * As a fallback, try to assume this code uses a frame pointer.
+		 * This is just a guess, so the rest of the unwind is no longer
+		 * considered reliable.
+		 */
+		orc = &orc_fp_entry;
+		state->error = true;
+	} else {
+		if (orc->type == ORC_TYPE_UNDEFINED)
+			goto err;
+
+		if (orc->type == ORC_TYPE_END_OF_STACK)
+			goto the_end;
+	}
+
+	state->signal = orc->signal;
+
+	/* Find the previous frame's stack: */
+	switch (orc->sp_reg) {
+	case ORC_REG_SP:
+		sp = state->sp + orc->sp_offset;
+		break;
+
+	case ORC_REG_BP:
+		sp = state->bp + orc->sp_offset;
+		break;
+
+	case ORC_REG_SP_INDIRECT:
+		sp = state->sp;
+		indirect = true;
+		break;
+
+	case ORC_REG_BP_INDIRECT:
+		sp = state->bp + orc->sp_offset;
+		indirect = true;
+		break;
+
+	default:
+		/* thee rest are only used in x86 asm code, not in UML */
+		orc_warn("unsupported SP base reg %d at %pB\n",
+			 orc->sp_reg, (void *)state->ip);
+		goto err;
+	}
+
+	if (indirect) {
+		if (!deref_stack_reg(state, sp, &sp))
+			goto err;
+
+		if (orc->sp_reg == ORC_REG_SP_INDIRECT)
+			sp += orc->sp_offset;
+	}
+
+	/* Find IP and SP: */
+	switch (orc->type) {
+	case ORC_TYPE_CALL:
+		ip_p = sp - sizeof(long);
+
+		if (!deref_stack_reg(state, ip_p, &state->ip))
+			goto err;
+
+		state->ip = unwind_recover_ret_addr(state, state->ip,
+						    (unsigned long *)ip_p);
+		state->sp = sp;
+		state->regs = NULL;
+		break;
+
+	default:
+		/* also only in x86 asm code */
+		orc_warn("unsupported .orc_unwind entry type %d at %pB\n",
+			 orc->type, (void *)orig_ip);
+		goto err;
+	}
+
+	/* Find BP: */
+	switch (orc->bp_reg) {
+	case ORC_REG_UNDEFINED:
+		if (state->regs)
+			state->bp = PT_REGS_BP(state->regs);
+		break;
+
+	case ORC_REG_PREV_SP:
+		if (!deref_stack_reg(state, sp + orc->bp_offset, &state->bp))
+			goto err;
+		break;
+
+	case ORC_REG_BP:
+		if (!deref_stack_reg(state, state->bp + orc->bp_offset, &state->bp))
+			goto err;
+		break;
+
+	default:
+		orc_warn("unknown BP base reg %d for ip %pB\n",
+			 orc->bp_reg, (void *)orig_ip);
+		goto err;
+	}
+
+	/*
+	 * If we find sigreturn then we're unwinding across a single, which
+	 * means the ucontext of the interrupted code is on the stack too.
+	 */
+	if (os_sigreturn_ip && state->ip == os_sigreturn_ip) {
+		unsigned long uc = state->sp;
+
+		if (!deref_stack_reg(state, uc + HOST_UC_IP, &state->ip) ||
+		    !deref_stack_reg(state, uc + HOST_UC_SP, &state->sp) ||
+		    !deref_stack_reg(state, uc + HOST_UC_BP, &state->bp))
+			goto err;
+		state->signal = true;
+	}
+
+	/* Prevent a recursive loop due to bad ORC data: */
+	if (state->stack_info.type == prev_type &&
+	    on_stack(&state->stack_info, (void *)state->sp, sizeof(long)) &&
+	    state->sp <= prev_sp) {
+		orc_warn_current("stack going in the wrong direction? at %pB\n",
+				 (void *)orig_ip);
+		goto err;
+	}
+
+	return true;
+
+err:
+	state->error = true;
+
+the_end:
+	state->stack_info.type = STACK_TYPE_UNKNOWN;
+	return false;
+}
+EXPORT_SYMBOL_GPL(unwind_next_frame);
+
+void __unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs, unsigned long *first_frame)
+{
+	memset(state, 0, sizeof(*state));
+	state->task = task;
+
+	if (!orc_init)
+		goto err;
+
+	/*
+	 * Refuse to unwind the stack of a task while it's executing on another
+	 * CPU.  This check is racy, but that's ok: the unwinder has other
+	 * checks to prevent it from going off the rails.
+	 */
+	if (task_on_another_cpu(task))
+		goto err;
+
+	if (regs) {
+		if (user_mode(regs))
+			goto the_end;
+
+		state->ip = PT_REGS_IP(regs);
+		state->sp = PT_REGS_SP(regs);
+		state->bp = PT_REGS_BP(regs);
+		state->regs = regs;
+		state->signal = true;
+	} else if (task == current) {
+		/* all three must come from the same instruction */
+		asm volatile("lea (%%rip), %0\n\t"
+			     "mov %%rsp, %1\n\t"
+			     "mov %%rbp, %2\n\t"
+			     : "=r" (state->ip), "=r" (state->sp),
+			       "=r" (state->bp));
+	} else {
+		/* registers saved by switch_threads() when it was switched out */
+		state->ip = KSTK_EIP(task);
+		state->sp = KSTK_ESP(task);
+		state->bp = KSTK_EBP(task);
+	}
+
+	if (get_stack_info((unsigned long *)state->sp, state->task,
+			   &state->stack_info, &state->stack_mask)) {
+		/*
+		 * We weren't on a valid stack.  It's possible that
+		 * we overflowed a valid stack into a guard page.
+		 * See if the next page up is valid so that we can
+		 * generate some kind of backtrace if this happens.
+		 */
+		void *next_page = (void *)PAGE_ALIGN((unsigned long)state->sp);
+
+		state->error = true;
+		if (get_stack_info(next_page, state->task, &state->stack_info,
+				   &state->stack_mask))
+			return;
+	}
+
+	/*
+	 * The caller can provide the address of the first frame directly
+	 * (first_frame) or indirectly (regs->sp) to indicate which stack frame
+	 * to start unwinding at.  Skip ahead until we reach it.
+	 */
+
+	/* When starting from regs, skip the regs frame: */
+	if (regs) {
+		unwind_next_frame(state);
+		return;
+	}
+
+	/* Otherwise, skip ahead to the user-specified starting frame: */
+	while (!unwind_done(state) &&
+	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
+			state->sp <= (unsigned long)first_frame))
+		unwind_next_frame(state);
+
+	return;
+
+err:
+	state->error = true;
+the_end:
+	state->stack_info.type = STACK_TYPE_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(__unwind_start);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 6c993bc8c78e..687b8a3a8ba9 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -212,6 +212,8 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 	errno = save_errno;
 }
 
+unsigned long os_sigreturn_ip;
+
 void set_handler(int sig)
 {
 	struct sigaction action;
@@ -239,6 +241,10 @@ void set_handler(int sig)
 	if (sigaction(sig, &action, NULL) < 0)
 		panic("sigaction failed - errno = %d\n", errno);
 
+	/* libc installs its own restorer, find it for the unwinder */
+	if (!os_sigreturn_ip && !sigaction(sig, NULL, &action))
+		os_sigreturn_ip = (unsigned long)action.sa_restorer;
+
 	sigemptyset(&sig_mask);
 	sigaddset(&sig_mask, sig);
 	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index d6e1cd9956bf..003bcf6eeea3 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -66,6 +66,10 @@ void foo(void)
 
 	DEFINE_LONGS(HOST_IP, RIP);
 	DEFINE_LONGS(HOST_SP, RSP);
+
+	DEFINE(HOST_UC_IP, offsetof(ucontext_t, uc_mcontext.gregs[REG_RIP]));
+	DEFINE(HOST_UC_SP, offsetof(ucontext_t, uc_mcontext.gregs[REG_RSP]));
+	DEFINE(HOST_UC_BP, offsetof(ucontext_t, uc_mcontext.gregs[REG_RBP]));
 #endif
 
 	DEFINE(UM_FRAME_SIZE, sizeof(struct user_regs_struct));
diff --git a/scripts/Makefile b/scripts/Makefile
index 3434a82a119f..8fbbc77c3860 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -45,6 +45,10 @@ endif
 ifeq ($(ARCH),loongarch)
 SRCARCH := loongarch
 endif
+# UML runs host code, and only supports x86 as the host arch
+ifeq ($(ARCH),um)
+SRCARCH := x86
+endif
 HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/$(SRCARCH)/include
 HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 endif
diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index ed5f008d400e..d13c22be53a8 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -38,6 +38,11 @@ ifeq ($(ARCH),loongarch64)
        SRCARCH := loongarch
 endif
 
+# UML runs host code, and only supports x86 as the host arch
+ifeq ($(ARCH),um)
+       SRCARCH := x86
+endif
+
 # Probe for __LP64__ only when the compiler is installed: this runs at
 # parse time for every target, including ones that never compile, e.g.
 # install-build-deps, and would otherwise spew "gcc: not found" when the
-- 
2.55.0

