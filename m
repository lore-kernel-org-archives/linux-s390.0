From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 03:55:01 +0000
Subject: [patch 2/3] S390-HWBKPT v5: Enabling s390 kernel for kernel PER
Message-Id: <20100527034301.GC6404@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Enable kernel PER tracing in the kernel entry point.
A new flag kernel_per_tracing has been added to lowcore for each CPU,
which is checked at every kernel entry point and set the PER bit in
current PSW.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 arch/s390/include/asm/lowcore.h  |   10 ++++++++--
 arch/s390/kernel/asm-offsets.c   |    2 ++
 arch/s390/kernel/entry.S         |   12 ++++++++++++
 arch/s390/kernel/entry64.S       |   12 ++++++++++++
 arch/s390/kernel/hw_breakpoint.c |   28 +++++++++++++++++++++-------
 5 files changed, 55 insertions(+), 9 deletions(-)


diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 05527c0..a9d3c5f 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -135,7 +135,10 @@ struct _lowcore {
 	__u64	clock_comparator;		/* 0x02d0 */
 	__u32	machine_flags;			/* 0x02d8 */
 	__u32	ftrace_func;			/* 0x02dc */
-	__u8	pad_0x02e0[0x0300-0x02e0];	/* 0x02e0 */
+
+	/* Kernel PER tracing mask */
+	__u32	kernel_per_tracing_mask;	/* 0x02e0 */
+	__u8	pad_0x02e4[0x0300-0x02e4];	/* 0x02e4 */
 
 	/* Interrupt response block */
 	__u8	irb[64];			/* 0x0300 */
@@ -265,7 +268,10 @@ struct _lowcore {
 	__u64	vdso_per_cpu_data;		/* 0x0350 */
 	__u64	machine_flags;			/* 0x0358 */
 	__u64	ftrace_func;			/* 0x0360 */
-	__u8	pad_0x0368[0x0380-0x0368];	/* 0x0368 */
+
+	/* Kernel PER tracing mask */
+	__u64	kernel_per_tracing_mask;	/* 0x0368 */
+	__u8	pad_0x0370[0x0380-0x0370];	/* 0x0370 */
 
 	/* Interrupt response block. */
 	__u8	irb[64];			/* 0x0380 */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index a094089..abb33ec 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -130,6 +130,8 @@ int main(void)
 	DEFINE(__LC_INT_CLOCK, offsetof(struct _lowcore, int_clock));
 	DEFINE(__LC_MACHINE_FLAGS, offsetof(struct _lowcore, machine_flags));
 	DEFINE(__LC_FTRACE_FUNC, offsetof(struct _lowcore, ftrace_func));
+	DEFINE(__LC_KERNEL_PER_TRACING_MASK,
+			offsetof(struct _lowcore, kernel_per_tracing_mask));
 	DEFINE(__LC_IRB, offsetof(struct _lowcore, irb));
 	DEFINE(__LC_CPU_TIMER_SAVE_AREA, offsetof(struct _lowcore, cpu_timer_save_area));
 	DEFINE(__LC_CLOCK_COMP_SAVE_AREA, offsetof(struct _lowcore, clock_comp_save_area));
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 6af7045..2f93424 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -266,6 +266,10 @@ sysc_do_restart:
 	sth	%r7,SP_SVCNR(%r15)
 	sll	%r7,2		  # svc number *4
 	l	%r8,BASED(.Lsysc_table)
+	tm	__LC_KERNEL_PER_TRACING_MASK,0x40  # kernel per tracing is on?
+	jz	sysc_noper
+	stosm	__SF_EMPTY(%r15),0x40	# enable per event recording
+sysc_noper:
 	tm	__TI_flags+2(%r9),_TIF_SYSCALL
 	l	%r8,0(%r7,%r8)	  # get system call addr.
 	bnz	BASED(sysc_tracesys)
@@ -604,6 +608,10 @@ io_int_handler:
 io_no_vtime:
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	TRACE_IRQS_OFF
+	tm	__LC_KERNEL_PER_TRACING_MASK,0x40  # kernel per tracing is on?
+	jz	io_noper
+	stosm	__SF_EMPTY(%r15),0x40	# enable per event recording
+io_noper:
 	l	%r1,BASED(.Ldo_IRQ)	# load address of do_IRQ
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	basr	%r14,%r1		# branch to standard irq handler
@@ -750,6 +758,10 @@ ext_int_handler:
 ext_no_vtime:
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	TRACE_IRQS_OFF
+	tm	__LC_KERNEL_PER_TRACING_MASK,0x40  # kernel per tracing is on?
+	jz	ext_noper
+	stosm	__SF_EMPTY(%r15),0x40	# enable per event recording
+ext_noper:
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	lh	%r3,__LC_EXT_INT_CODE	# get interruption code
 	l	%r1,BASED(.Ldo_extint)
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 52106d5..adfb985 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -260,6 +260,10 @@ sysc_do_restart:
 	larl	%r10,sys_call_table_emu  # use 31 bit emulation system calls
 sysc_noemu:
 #endif
+	tm	__LC_KERNEL_PER_TRACING_MASK,0x40  # kernel per tracing is on?
+	jz	sysc_noper
+	stosm	__SF_EMPTY(%r15),0x40	# enable per event recording
+sysc_noper:
 	tm	__TI_flags+6(%r9),_TIF_SYSCALL
 	lgf	%r8,0(%r7,%r10) # load address of system call routine
 	jnz	sysc_tracesys
@@ -579,6 +583,10 @@ io_no_vtime:
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	TRACE_IRQS_OFF
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
+	tm	__LC_KERNEL_PER_TRACING_MASK,0x40  # kernel per tracing is on?
+	jz	io_noper
+	stosm	__SF_EMPTY(%r15),0x40	# enable per event recording
+io_noper:
 	brasl	%r14,do_IRQ		# call standard irq handler
 io_return:
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
@@ -744,6 +752,10 @@ ext_no_vtime:
 	TRACE_IRQS_OFF
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	llgh	%r3,__LC_EXT_INT_CODE	# get interruption code
+	tm	__LC_KERNEL_PER_TRACING_MASK,0x40  # kernel per tracing is on?
+	jz	ext_noper
+	stosm	__SF_EMPTY(%r15),0x40	# enable per event recording
+ext_noper:
 	brasl	%r14,do_extint
 	j	io_return
 
diff --git a/arch/s390/kernel/hw_breakpoint.c b/arch/s390/kernel/hw_breakpoint.c
index 1cce08e..19c5bb5 100644
--- a/arch/s390/kernel/hw_breakpoint.c
+++ b/arch/s390/kernel/hw_breakpoint.c
@@ -82,6 +82,19 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	per_regs[0].starting_addr = info->address;
 	per_regs[0].ending_addr = info->address + info->len - 1;
 
+	if (!bp->attr.exclude_kernel
+		&& per_regs[0].em_storage_alteration) {
+		/* For kernel wide breakpoints the Storage-Alteration-Space
+		 * Control bit as well as the Storage-Alternation-Event bit
+		 * in the ASCE needs to be set. Otherwise we might end up
+		 * tracing copy_to_user events as well.
+		 */
+		per_regs[0].storage_alt_space_ctl = 1;
+		__ctl_set_bit(1, 7);
+		__ctl_set_bit(7, 7);
+		__ctl_set_bit(13, 7);
+	}
+
 	/* Load the control register 9, 10 and 11 with per info */
 	__ctl_load(per_regs, 9, 11);
 	__get_cpu_var(cpu_per_regs[0]) = per_regs[0];
@@ -93,13 +106,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		 */
 		if (!bp->attr.exclude_kernel) {
 			/* Enable wide breakpoint in the kernel */
-			/* FIXME:
-			 * It's not good idea to use existing flag in lowcore
-			 * for turning on/off PER tracing in kernel. instead
-			 * define a new flag and handle PER tracing checks in
-			 * entry*.S
-			 */
-
+			S390_lowcore.kernel_per_tracing_mask |= PSW_MASK_PER;
 
 			/* set PER bit int psw_kernel_bits to avoid loosing it
 			 * accidently if someone modifies PSW bit directly.
@@ -148,7 +155,14 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 
 	if (!bp->attr.exclude_kernel) {
 		/* clear wide breakpoint in the kernel */
+		S390_lowcore.kernel_per_tracing_mask &= ~PSW_MASK_PER;
 		psw_kernel_bits &= ~PSW_MASK_PER;
+		per_regs[0] = __get_cpu_var(cpu_per_regs[0]);
+		if (per_regs[0].em_storage_alteration) {
+			__ctl_clear_bit(1, 7);
+			__ctl_clear_bit(7, 7);
+			__ctl_clear_bit(13, 7);
+		}
 	}
 	if (tsk) {
 		/* clear breakpoint bound to a task context */
