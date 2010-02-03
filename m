From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 03 Feb 2010 06:51:03 +0000
Subject: [patch 1/3] S390-HWBKPT v4:S390 architecture specific Hardware
Message-Id: <20100203063903.GB17281@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Introduce s390 specific implementation for the perf-events based hardware
breakpoint interfaces defined in kernel/hw_breakpoint.c. Enable the
HAVE_HW_BREAKPOINT flag and the Makefile.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 arch/s390/Kconfig                       |    1 
 arch/s390/include/asm/Kbuild            |    1 
 arch/s390/include/asm/hw_breakpoint.h   |   60 +++++
 arch/s390/include/asm/processor.h       |    6 +
 arch/s390/kernel/Makefile               |    2 
 arch/s390/kernel/hw_breakpoint.c        |  347 +++++++++++++++++++++++++++++++
 samples/hw_breakpoint/data_breakpoint.c |    4 
 7 files changed, 420 insertions(+), 1 deletions(-)
 create mode 100644 arch/s390/include/asm/hw_breakpoint.h
 create mode 100644 arch/s390/kernel/hw_breakpoint.c


diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c802352..1f3bfc5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -123,6 +123,7 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_BH
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
+	select HAVE_HW_BREAKPOINT
 
 config SCHED_OMIT_FRAME_POINTER
 	bool
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 63a2341..a80fcdb 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,6 +8,7 @@ header-y += ucontext.h
 header-y += vtoc.h
 header-y += zcrypt.h
 header-y += chsc.h
+header-y += hw_breakpoint.h
 
 unifdef-y += cmb.h
 unifdef-y += debug.h
diff --git a/arch/s390/include/asm/hw_breakpoint.h b/arch/s390/include/asm/hw_breakpoint.h
new file mode 100644
index 0000000..2620318
--- /dev/null
+++ b/arch/s390/include/asm/hw_breakpoint.h
@@ -0,0 +1,60 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2009 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+#ifndef	_S390_HW_BREAKPOINT_H
+#define	_S390_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+
+#include <linux/kdebug.h>
+#include <linux/percpu.h>
+#include <linux/list.h>
+#include <asm/processor.h>
+
+struct arch_hw_breakpoint {
+	char		*name; /* Contains name of the symbol to set bkpt */
+	unsigned long	address;
+	unsigned long	len;
+	u8		type;
+};
+
+/* Available HW breakpoint type encodings */
+
+/* trigger on instruction execute */
+#define S390_BREAKPOINT_EXECUTE	0x01
+/* trigger on memory write */
+#define S390_BREAKPOINT_WRITE	0x02
+
+struct perf_event;
+struct pmu;
+
+extern int arch_validate_hwbkpt_settings(struct perf_event *bp,
+						struct task_struct *tsk);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				     unsigned long val, void *data);
+
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
+
+extern struct pmu perf_ops_bp;
+#endif	/* __KERNEL__ */
+#endif	/* _S390_HW_BREAKPOINT_H */
+
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index b427154..d7750c4 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -25,6 +25,8 @@
  * instruction pointer ("program counter").
  */
 #define current_text_addr() ({ void *pc; asm("basr %0,0" : "=a" (pc)); pc; })
+/* Total number of available HW breakpoint registers */
+#define HBP_NUM	1
 
 static inline void get_cpu_id(struct cpuid *ptr)
 {
@@ -71,6 +73,8 @@ typedef struct {
         __u32 ar4;
 } mm_segment_t;
 
+struct perf_event;
+
 /*
  * Thread structure
  */
@@ -86,6 +90,8 @@ struct thread_struct {
 	unsigned long ieee_instruction_pointer; 
         /* pfault_wait is used to block the process on a pfault event */
 	unsigned long pfault_wait;
+	/* Save middle states of ptrace breakpoints */
+	struct perf_event *ptrace_bps[HBP_NUM];
 };
 
 typedef struct thread_struct thread_struct;
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 683f638..62e72b2 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -23,7 +23,7 @@ CFLAGS_sysinfo.o += -Iinclude/math-emu -Iarch/s390/math-emu -w
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o setup.o \
 	    processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o mem_detect.o \
-	    vdso.o vtime.o sysinfo.o nmi.o sclp.o
+	    vdso.o vtime.o sysinfo.o nmi.o sclp.o hw_breakpoint.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
diff --git a/arch/s390/kernel/hw_breakpoint.c b/arch/s390/kernel/hw_breakpoint.c
new file mode 100644
index 0000000..a537a48
--- /dev/null
+++ b/arch/s390/kernel/hw_breakpoint.c
@@ -0,0 +1,347 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2009 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's PER control registers.
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/irqflags.h>
+#include <linux/notifier.h>
+#include <linux/kallsyms.h>
+#include <linux/kprobes.h>
+#include <linux/percpu.h>
+#include <linux/kdebug.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/hw_breakpoint.h>
+#include <asm/processor.h>
+#include <asm/sections.h>
+#include <asm/uaccess.h>
+
+/* Per cpu PER control register values */
+DEFINE_PER_CPU(per_cr_bits, cpu_per_regs[1]);
+
+/*
+ * Stores the breakpoints currently in use on each breakpoint address
+ * register for each cpus
+ */
+static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
+
+/*
+ * Install a perf counter breakpoint.
+ *
+ * S390 provides only one hardware breakpoint register. Use it for this
+ * breakpoint if free.
+ *
+ * Atomic: we hold the counter->ctx->lock and we only handle variables,
+ * lowcore area and control registers local to this cpu.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event **slot;
+	struct task_struct *tsk = bp->ctx->task;
+	per_cr_bits per_regs[1];
+
+	memset(per_regs, 0, sizeof(per_cr_bits));
+
+	slot = &__get_cpu_var(bp_per_reg[0]);
+	if (!*slot) {
+		*slot = bp;
+	} else {
+		WARN_ONCE(1 , "Can't find any breakpoint slot");
+		return -EBUSY;
+	}
+
+	if (info->type == S390_BREAKPOINT_WRITE)
+		per_regs[0].em_storage_alteration = 1;
+	if (info->type == S390_BREAKPOINT_EXECUTE)
+		per_regs[0].em_instruction_fetch = 1;
+	per_regs[0].starting_addr = info->address;
+	per_regs[0].ending_addr = info->address + info->len - 1;
+
+	/* Load the control register 9, 10 and 11 with per info */
+	__ctl_load(per_regs, 9, 11);
+	__get_cpu_var(cpu_per_regs[0]) = per_regs[0];
+
+	if (((per_cr_words *)per_regs)->cr[0] & PER_EM_MASK) {
+		if (!tsk) {
+			/* wide breakpoint in the kernel */
+			/* FIXME:
+			 * It's not good idea to use existing flag in lowcore
+			 * for turning on/off PER tracing in kernel. instead
+			 * define a new flag and handle PER tracing checks in
+			 * entry*.S
+			 */
+
+
+			/* set PER bit int psw_kernel_bits to avoid loosing it
+			 * accidently if someone modifies PSW bit directly.
+			 */
+			psw_kernel_bits |= PSW_MASK_PER;
+
+		} else {
+			/* user-space hardware breakpoint */
+			struct pt_regs *regs = task_pt_regs(tsk);
+
+			regs->psw.mask |= PSW_MASK_PER;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Uninstall the breakpoint contained in the given counter.
+ *
+ * Atomic: we hold the counter->ctx->lock and we only handle variables,
+ * lowcore area and control registers local to this cpu.
+ */
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct perf_event **slot;
+	per_cr_bits per_regs[1];
+	struct task_struct *tsk = bp->ctx->task;
+
+	slot = &__get_cpu_var(bp_per_reg[0]);
+	if (*slot == bp) {
+		*slot = NULL;
+	} else {
+		/* This should never happen but still having a
+		 * warning message in case if something really bad
+		 * happens.
+		 */
+		WARN_ONCE(1, "Can't find any breakpoint slot");
+		return;
+	}
+	memset(per_regs, 0, sizeof(per_cr_bits));
+	__ctl_load(per_regs, 9, 11);
+
+	if (!tsk) {
+		/* wide breakpoint in the kernel */
+		psw_kernel_bits &= ~PSW_MASK_PER;
+	} else {
+		/* user-space hardware breakpoint */
+		struct pt_regs *regs = task_pt_regs(tsk);
+
+		regs->psw.mask &= ~PSW_MASK_PER;
+	}
+	return;
+}
+
+static inline int is_kernel(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
+		return 1;
+	return in_gate_area_no_task(addr);
+}
+
+/*
+ * Check for virtual address in kernel space.
+ */
+static int arch_check_va_in_kernelspace(unsigned long va, unsigned long hbp_len)
+{
+	if (is_kernel(va))
+		return is_kernel(va + hbp_len - 1);
+
+	if (is_module_address(va))
+		return is_module_address(va + hbp_len - 1);
+
+	return 0;
+}
+
+/*
+ * Store a breakpoint's encoded address, length, and type.
+ */
+static int arch_store_info(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	/*
+	 * For kernel-addresses, either the address or symbol name can be
+	 * specified.
+	 */
+	if (info->name)
+		info->address = kallsyms_lookup_name(info->name);
+
+	if (info->len == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Populate arch specific bp info. s390 arch supports EXECUTE and WRITE
+ * access types.
+ */
+static int arch_build_bp_info(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	info->address = bp->attr.bp_addr;
+	info->len = bp->attr.bp_len;
+
+	switch (bp->attr.bp_type) {
+	case HW_BREAKPOINT_W:
+		info->type = S390_BREAKPOINT_WRITE;
+		break;
+	case HW_BREAKPOINT_X:
+		info->type = S390_BREAKPOINT_EXECUTE;
+		if (info->len == 0)
+			info->len = 1;
+		break;
+	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp,
+					struct task_struct *tsk)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	int ret;
+
+	ret = arch_build_bp_info(bp);
+	if (ret)
+		return ret;
+
+	ret = arch_store_info(bp);
+
+	if (ret)
+		return ret;
+
+	/* Check that the virtual address is in the proper range */
+	if (tsk) {
+		/* user space. */
+		if (!access_ok(VERIFY_WRITE,
+				(void __user *)info->address, info->len - 1))
+			return -EFAULT;
+	} else {
+		if (!arch_check_va_in_kernelspace(info->address, info->len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * Release the user breakpoints used by ptrace
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	struct thread_struct *t = &tsk->thread;
+
+	unregister_hw_breakpoint(t->ptrace_bps[0]);
+	t->ptrace_bps[0] = NULL;
+}
+
+/*
+ * Handle debug exception notifications.
+ */
+static int __kprobes hw_breakpoint_handler(struct die_args *args)
+{
+	struct perf_event *bp;
+	per_cr_bits saved_cregs[1];
+	per_cr_bits per_regs[1];
+	per_lowcore_bits *per_code;
+	int cpu, rc = NOTIFY_STOP;
+	struct pt_regs *regs = args->regs;
+
+	/* Do an early return if this is not a storage-alteration/instruction
+	 * fetch event.
+	 *
+	 * We may be racing with interrupts by the time we reach here. Check
+	 * if old psw was a kernel/user space. If user space then PER code
+	 * is copied to thread_struct, otherwise it is in lowcore.
+	 */
+	if (regs->psw.mask & PSW_MASK_PSTATE)
+		per_code = &current->thread.per_info.lowcore.bits;
+	else
+		per_code = (per_lowcore_bits *)&S390_lowcore.per_perc_atmid;
+
+	if ((!per_code->perc_storage_alteration &&
+			!per_code->perc_instruction_fetch) ||
+		(per_code->perc_storage_alteration &&
+			per_code->perc_store_real_address))
+		return NOTIFY_DONE;
+
+	/* Disable breakpoints during exception handling */
+	__ctl_store(saved_cregs, 9, 11);
+	memset(per_regs, 0, sizeof(per_cr_bits));
+	__ctl_load(per_regs, 9, 11);
+
+	cpu = get_cpu();
+
+	/*
+	 * The counter may be concurrently released but that can only
+	 * occur from a call_rcu() path. We can then safely fetch
+	 * the breakpoint, use its callback, touch its counter
+	 * while we are in an rcu_read_lock() path.
+	 */
+
+	rcu_read_lock();
+	bp = per_cpu(bp_per_reg[0], cpu);
+	/*
+	 * bp can be NULL due to lazy debug register switching
+	 * or due to concurrent perf counter removing.
+	 */
+	if (bp)
+		rc = NOTIFY_DONE;
+
+	perf_bp_event(bp, args->regs);
+	rcu_read_unlock();
+
+	/* Enable breakpoints */
+	__ctl_load(saved_cregs, 9, 11);
+	put_cpu();
+
+	return rc;
+}
+
+/*
+ * Handle debug exception notifications.
+ */
+int __kprobes hw_breakpoint_exceptions_notify(
+		struct notifier_block *unused, unsigned long val, void *data)
+{
+	if (val != DIE_SSTEP)
+		return NOTIFY_DONE;
+
+	return hw_breakpoint_handler(data);
+}
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+	/* TODO */
+}
+
+void hw_breakpoint_pmu_unthrottle(struct perf_event *bp)
+{
+	/* TODO */
+}
diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index c69cbe9..465ee4a 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -58,7 +58,11 @@ static int __init hw_break_module_init(void)
 	hw_breakpoint_init(&attr);
 	attr.bp_addr = kallsyms_lookup_name(ksym_name);
 	attr.bp_len = HW_BREAKPOINT_LEN_4;
+#ifdef CONFIG_S390
+	attr.bp_type = HW_BREAKPOINT_W;
+#else
 	attr.bp_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
+#endif
 
 	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler);
 	if (IS_ERR(sample_hbp)) {
