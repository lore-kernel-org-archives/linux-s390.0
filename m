From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 03:56:21 +0000
Subject: [patch 3/3] S390-HWBKPT v5: Modify ptrace to use Hardware
Message-Id: <20100527034421.GD6404@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Modify the ptrace code to use the hardware breakpoint interfaces for
user-space

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 arch/s390/include/asm/ptrace.h |    3 -
 arch/s390/kernel/process.c     |    3 +
 arch/s390/kernel/ptrace.c      |  218 ++++++++++++++++++++++++++++------------
 3 files changed, 155 insertions(+), 69 deletions(-)


diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index fef9b33..b65f48c 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -406,7 +406,8 @@ typedef struct
 	 */
 	unsigned  single_step       : 1;
 	unsigned  instruction_fetch : 1;
-	unsigned                    : 30;
+	unsigned  storage_alteration: 1;
+	unsigned                    : 29;
 	/*
 	 * These addresses are copied into cr10 & cr11 if single
 	 * stepping is switched off
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 1039fde..7f630a6 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
+#include <linux/hw_breakpoint.h>
 #include <asm/compat.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -153,6 +154,7 @@ void exit_thread(void)
 
 void flush_thread(void)
 {
+	flush_ptrace_hw_breakpoint(current);
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -215,6 +217,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	p->thread.mm_segment = get_fs();
 	/* Don't copy debug registers */
 	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
+	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
 	/* Initialize per thread user and system timer values */
 	ti = task_thread_info(p);
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 9f654da..7393d34 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -36,6 +36,8 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/seccomp.h>
+#include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
 #include <trace/syscall.h>
 #include <asm/compat.h>
 #include <asm/segment.h>
@@ -45,6 +47,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/hw_breakpoint.h>
 #include "entry.h"
 
 #ifdef CONFIG_COMPAT
@@ -54,70 +57,97 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+#define PER_INST_FETCH	0x40000000
+#define PER_STG_ALT	0x20000000
+
 enum s390_regset {
 	REGSET_GENERAL,
 	REGSET_FP,
 	REGSET_GENERAL_EXTENDED,
 };
 
-static void
-FixPerRegisters(struct task_struct *task)
+static inline unsigned long get_per_addr(per_struct *per_info)
 {
-	struct pt_regs *regs;
-	per_struct *per_info;
-	per_cr_words cr_words;
+	if (per_info->single_step)
+		return 0;
 
-	regs = task_pt_regs(task);
-	per_info = (per_struct *) &task->thread.per_info;
-	per_info->control_regs.bits.em_instruction_fetch =
-		per_info->single_step | per_info->instruction_fetch;
-	
+	return per_info->starting_addr;
+}
+
+static unsigned long get_per_len(per_struct *per_info)
+{
 	if (per_info->single_step) {
-		per_info->control_regs.bits.starting_addr = 0;
 #ifdef CONFIG_COMPAT
 		if (is_compat_task())
-			per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
+			return 0x7fffffffUL;
 		else
 #endif
-			per_info->control_regs.bits.ending_addr = PSW_ADDR_INSN;
-	} else {
-		per_info->control_regs.bits.starting_addr =
-			per_info->starting_addr;
-		per_info->control_regs.bits.ending_addr =
-			per_info->ending_addr;
+			return PSW_ADDR_INSN;
+	} else
+		return per_info->ending_addr - per_info->starting_addr + 1;
+}
+
+static void ptrace_remove_breakpoint(struct task_struct *task)
+{
+	struct perf_event *bp;
+	struct thread_struct *t = &task->thread;
+
+	bp = t->ptrace_bps[0];
+	if (bp) {
+		unregister_hw_breakpoint(bp);
+		t->ptrace_bps[0] = NULL;
 	}
-	/*
-	 * if any of the control reg tracing bits are on 
-	 * we switch on per in the psw
-	 */
-	if (per_info->control_regs.words.cr[0] & PER_EM_MASK)
-		regs->psw.mask |= PSW_MASK_PER;
-	else
-		regs->psw.mask &= ~PSW_MASK_PER;
-
-	if (per_info->control_regs.bits.em_storage_alteration)
-		per_info->control_regs.bits.storage_alt_space_ctl = 1;
-	else
-		per_info->control_regs.bits.storage_alt_space_ctl = 0;
-
-	if (task == current) {
-		__ctl_store(cr_words, 9, 11);
-		if (memcmp(&cr_words, &per_info->control_regs.words,
-			   sizeof(cr_words)) != 0)
-			__ctl_load(per_info->control_regs.words, 9, 11);
+}
+
+static void ptrace_triggered(struct perf_event *bp, int nmi,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs)
+{
+}
+
+static void ptrace_set_breakpoint(struct task_struct *task, int disabled)
+{
+	per_struct *per_info;
+	struct perf_event *bp;
+	struct thread_struct *t = &task->thread;
+	struct perf_event_attr attr;
+
+	ptrace_breakpoint_init(&attr);
+	per_info = (per_struct *) &task->thread.per_info;
+
+	if (per_info->single_step | per_info->instruction_fetch)
+		attr.bp_type = HW_BREAKPOINT_X;
+	else if (per_info->storage_alteration)
+		attr.bp_type = HW_BREAKPOINT_W;
+	else {
+		ptrace_remove_breakpoint(task);
+		return;
+	}
+
+	attr.disabled = disabled;
+	attr.bp_addr = get_per_addr(per_info);
+	attr.bp_len = get_per_len(per_info);
+
+	if (!t->ptrace_bps[0]) {
+		bp = register_user_hw_breakpoint(&attr, ptrace_triggered, task);
+		if (!IS_ERR(bp))
+			t->ptrace_bps[0] = bp;
+	} else {
+		bp = t->ptrace_bps[0];
+		modify_user_hw_breakpoint(bp, &attr);
 	}
 }
 
 void user_enable_single_step(struct task_struct *task)
 {
 	task->thread.per_info.single_step = 1;
-	FixPerRegisters(task);
+	ptrace_set_breakpoint(task, 0);
 }
 
 void user_disable_single_step(struct task_struct *task)
 {
 	task->thread.per_info.single_step = 0;
-	FixPerRegisters(task);
+	ptrace_set_breakpoint(task, 0);
 }
 
 /*
@@ -132,6 +162,40 @@ ptrace_disable(struct task_struct *child)
 	user_disable_single_step(child);
 }
 
+static inline addr_t get_psw_mask(struct perf_event *bp)
+{
+	return bp->hw.info.type == HW_BREAKPOINT_X ? PER_INST_FETCH :
+			(bp->hw.info.type == HW_BREAKPOINT_W ? PER_STG_ALT : 0);
+}
+
+static addr_t ptrace_get_per_info(struct task_struct *child, addr_t offset)
+{
+	per_struct *dummy = NULL;
+	addr_t tmp;
+	struct thread_struct *thread = &(child->thread);
+
+	if (offset < (addr_t) (&dummy->control_regs + 1)) {
+		struct perf_event *bp = thread->ptrace_bps[0];
+
+		if (!bp)
+			return 0;
+		else if (offset == 0)
+			tmp = get_psw_mask(bp);
+		else if (offset ==
+			(addr_t) (&dummy->control_regs.bits.starting_addr))
+			tmp = bp->hw.info.address;
+		else
+			tmp = bp->hw.info.address + bp->hw.info.len - 1;
+	} else if (offset < (addr_t) &dummy->starting_addr) {
+		tmp = *(addr_t *)((addr_t) &child->thread.per_info + offset);
+		/* reset the storage alteration bit */
+		tmp &= ~PER_STG_ALT;
+	} else
+		tmp = *(addr_t *)((addr_t) &child->thread.per_info + offset);
+
+	return tmp;
+}
+
 #ifndef CONFIG_64BIT
 # define __ADDR_MASK 3
 #else
@@ -202,11 +266,8 @@ static unsigned long __peek_user(struct task_struct *child, addr_t addr)
 				<< (BITS_PER_LONG - 32);
 
 	} else if (addr < (addr_t) (&dummy->regs.per_info + 1)) {
-		/*
-		 * per_info is found in the thread structure
-		 */
 		offset = addr - (addr_t) &dummy->regs.per_info;
-		tmp = *(addr_t *)((addr_t) &child->thread.per_info + offset);
+		tmp = ptrace_get_per_info(child, offset);
 
 	} else
 		tmp = 0;
@@ -237,6 +298,47 @@ peek_user(struct task_struct *child, addr_t addr, addr_t data)
 }
 
 /*
+ * Use hardware breakpoint interface for PER info.
+ */
+static void ptrace_set_per_info(struct task_struct *child, addr_t offset,
+								addr_t data)
+{
+	per_struct *dummy = NULL;
+	int disabled = 0;
+
+	/*
+	 * gdb tries to set the PER storage alteration bit in
+	 * perf_info->control_regs. With hardware breakpoint interface
+	 * in place, we do not want anything to be set in
+	 * perf_info->control_regs. Instead we will store this info
+	 * in per_info->storage_alteration. Hence make sure that any
+	 * further writes from gdb does not wipe out
+	 * per_info->storage_alteration info.
+	 */
+
+	if (offset == (addr_t) &dummy->control_regs) {
+		if (data & PER_STG_ALT)
+			child->thread.per_info.storage_alteration = 1;
+		else
+			child->thread.per_info.storage_alteration = 0;
+	} else if (offset == (addr_t) (&dummy->control_regs + 1)) {
+		if (child->thread.per_info.storage_alteration) {
+			*(addr_t *)((addr_t) &child->thread.per_info + offset)
+									= data;
+			child->thread.per_info.storage_alteration = 1;
+		} else
+			*(addr_t *)((addr_t) &child->thread.per_info + offset)
+									= data;
+	} else if (offset > (addr_t) (&dummy->control_regs + 1))
+		*(addr_t *)((addr_t) &child->thread.per_info + offset) = data;
+
+	if (offset == (addr_t) &dummy->starting_addr)
+		disabled = 1;
+
+	ptrace_set_breakpoint(child, disabled);
+}
+
+/*
  * Write a word to the user area of a process at location addr. This
  * operation does have an additional problem compared to peek_user.
  * Stores to the program status word and on the floating point
@@ -313,11 +415,9 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		 * per_info is found in the thread structure 
 		 */
 		offset = addr - (addr_t) &dummy->regs.per_info;
-		*(addr_t *)((addr_t) &child->thread.per_info + offset) = data;
-
+		ptrace_set_per_info(child, offset, data);
 	}
 
-	FixPerRegisters(child);
 	return 0;
 }
 
@@ -409,7 +509,6 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 static u32 __peek_user_compat(struct task_struct *child, addr_t addr)
 {
 	struct user32 *dummy32 = NULL;
-	per_struct32 *dummy_per32 = NULL;
 	addr_t offset;
 	__u32 tmp;
 
@@ -463,15 +562,8 @@ static u32 __peek_user_compat(struct task_struct *child, addr_t addr)
 		 */
 		offset = addr - (addr_t) &dummy32->regs.per_info;
 		/* This is magic. See per_struct and per_struct32. */
-		if ((offset >= (addr_t) &dummy_per32->control_regs &&
-		     offset < (addr_t) (&dummy_per32->control_regs + 1)) ||
-		    (offset >= (addr_t) &dummy_per32->starting_addr &&
-		     offset <= (addr_t) &dummy_per32->ending_addr) ||
-		    offset == (addr_t) &dummy_per32->lowcore.words.address)
-			offset = offset*2 + 4;
-		else
-			offset = offset*2;
-		tmp = *(__u32 *)((addr_t) &child->thread.per_info + offset);
+		offset = offset*2;
+		tmp = (__u32) ptrace_get_per_info(child, offset);
 
 	} else
 		tmp = 0;
@@ -498,7 +590,6 @@ static int __poke_user_compat(struct task_struct *child,
 			      addr_t addr, addr_t data)
 {
 	struct user32 *dummy32 = NULL;
-	per_struct32 *dummy_per32 = NULL;
 	__u32 tmp = (__u32) data;
 	addr_t offset;
 
@@ -566,19 +657,10 @@ static int __poke_user_compat(struct task_struct *child,
 		 * because the second half (bytes 4-7) is needed and
 		 * not the first half.
 		 */
-		if ((offset >= (addr_t) &dummy_per32->control_regs &&
-		     offset < (addr_t) (&dummy_per32->control_regs + 1)) ||
-		    (offset >= (addr_t) &dummy_per32->starting_addr &&
-		     offset <= (addr_t) &dummy_per32->ending_addr) ||
-		    offset == (addr_t) &dummy_per32->lowcore.words.address)
-			offset = offset*2 + 4;
-		else
-			offset = offset*2;
-		*(__u32 *)((addr_t) &child->thread.per_info + offset) = tmp;
-
+		offset = offset*2;
+		ptrace_set_per_info(child, offset, data);
 	}
 
-	FixPerRegisters(child);
 	return 0;
 }
 
