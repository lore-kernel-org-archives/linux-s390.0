Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 09:26:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.5-rc2
Message-ID: <20160129092641.161a3f96@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:


An optimization for irq-restore, the SSM instruction is quite a bit slower
than an if-statement and a STOSM. 

The copy_file_range system all is added.

Cleanup for PCI and CIO.

And a couple of bug fixes.


Shortlog:

Christian Borntraeger (1):
      s390/irqflags: optimize irq restore

Dominik Dingel (1):
      s390/mm: use TASK_MAX_SIZE where applicable

Heiko Carstens (5):
      s390/numa: allocate memory with correct alignment
      s390: remove superfluous memblock_alloc() return value checks
      s390: wire up copy_file_range syscall
      s390: remove all usages of PSW_ADDR_AMODE
      s390: remove all usages of PSW_ADDR_INSN

Ingo Tuchscherer (1):
      s390/zcrypt: Fix cryptographic device id in kernel messages

Michael Holzheu (1):
      s390/numa: move numa_init_late() from device to arch_initcall

Sebastian Ott (10):
      s390/pci: adjust IOMAP_MAX_ENTRIES
      s390/pci: provide ZPCI_ADDR macro
      s390/pci: improve ZPCI_* macros
      s390/pci: resize iomap
      s390/pci: fix bar check
      s390/pci: set error state for unusable functions
      s390/pci: remove iomap sanity checks
      s390/cio: fix measurement characteristics memleak
      s390/cio: ensure consistent measurement state
      s390/cio: update measurement characteristics

 arch/s390/include/asm/irqflags.h       |  9 +++--
 arch/s390/include/asm/pci_io.h         | 14 +++++---
 arch/s390/include/asm/processor.h      |  4 +--
 arch/s390/include/asm/ptrace.h         |  6 ++--
 arch/s390/include/uapi/asm/unistd.h    |  3 +-
 arch/s390/kernel/compat_wrapper.c      |  1 +
 arch/s390/kernel/crash_dump.c          |  2 --
 arch/s390/kernel/debug.c               |  2 +-
 arch/s390/kernel/dumpstack.c           |  9 +++--
 arch/s390/kernel/early.c               |  8 ++---
 arch/s390/kernel/ftrace.c              |  2 +-
 arch/s390/kernel/ipl.c                 |  4 +--
 arch/s390/kernel/kprobes.c             | 16 ++++-----
 arch/s390/kernel/perf_event.c          | 12 +++----
 arch/s390/kernel/process.c             | 12 +++----
 arch/s390/kernel/ptrace.c              |  6 ++--
 arch/s390/kernel/setup.c               | 16 ++++-----
 arch/s390/kernel/signal.c              | 13 ++++----
 arch/s390/kernel/smp.c                 |  2 --
 arch/s390/kernel/stacktrace.c          | 11 +++---
 arch/s390/kernel/syscalls.S            |  1 +
 arch/s390/kernel/traps.c               | 11 +++---
 arch/s390/kvm/guestdbg.c               |  4 +--
 arch/s390/mm/fault.c                   |  6 ++--
 arch/s390/mm/init.c                    |  2 +-
 arch/s390/mm/mmap.c                    | 12 +++----
 arch/s390/mm/pgtable.c                 |  2 +-
 arch/s390/numa/numa.c                  |  6 ++--
 arch/s390/oprofile/backtrace.c         |  9 +++--
 arch/s390/pci/pci.c                    | 61 +++++++++++++++++-----------------
 arch/s390/pci/pci_event.c              |  5 +++
 drivers/s390/cio/chp.c                 | 21 +++++-------
 drivers/s390/cio/chp.h                 |  2 +-
 drivers/s390/cio/chsc.c                | 43 +++++++++++++-----------
 drivers/s390/crypto/zcrypt_error.h     | 15 +++++----
 drivers/s390/crypto/zcrypt_msgtype50.c |  9 ++---
 drivers/s390/crypto/zcrypt_msgtype6.c  | 20 +++++------
 37 files changed, 192 insertions(+), 189 deletions(-)

diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
index 16aa0c7..595a275 100644
--- a/arch/s390/include/asm/irqflags.h
+++ b/arch/s390/include/asm/irqflags.h
@@ -8,6 +8,8 @@
 
 #include <linux/types.h>
 
+#define ARCH_IRQ_ENABLED	(3UL << (BITS_PER_LONG - 8))
+
 /* store then OR system mask. */
 #define __arch_local_irq_stosm(__or)					\
 ({									\
@@ -54,14 +56,17 @@ static inline notrace void arch_local_irq_enable(void)
 	__arch_local_irq_stosm(0x03);
 }
 
+/* This only restores external and I/O interrupt state */
 static inline notrace void arch_local_irq_restore(unsigned long flags)
 {
-	__arch_local_irq_ssm(flags);
+	/* only disabled->disabled and disabled->enabled is valid */
+	if (flags & ARCH_IRQ_ENABLED)
+		arch_local_irq_enable();
 }
 
 static inline notrace bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return !(flags & (3UL << (BITS_PER_LONG - 8)));
+	return !(flags & ARCH_IRQ_ENABLED);
 }
 
 static inline notrace bool arch_irqs_disabled(void)
diff --git a/arch/s390/include/asm/pci_io.h b/arch/s390/include/asm/pci_io.h
index 1a9a98d..69aa18b 100644
--- a/arch/s390/include/asm/pci_io.h
+++ b/arch/s390/include/asm/pci_io.h
@@ -8,10 +8,13 @@
 #include <asm/pci_insn.h>
 
 /* I/O Map */
-#define ZPCI_IOMAP_MAX_ENTRIES		0x7fff
-#define ZPCI_IOMAP_ADDR_BASE		0x8000000000000000ULL
-#define ZPCI_IOMAP_ADDR_IDX_MASK	0x7fff000000000000ULL
-#define ZPCI_IOMAP_ADDR_OFF_MASK	0x0000ffffffffffffULL
+#define ZPCI_IOMAP_SHIFT		48
+#define ZPCI_IOMAP_ADDR_BASE		0x8000000000000000UL
+#define ZPCI_IOMAP_ADDR_OFF_MASK	((1UL << ZPCI_IOMAP_SHIFT) - 1)
+#define ZPCI_IOMAP_MAX_ENTRIES							\
+	((ULONG_MAX - ZPCI_IOMAP_ADDR_BASE + 1) / (1UL << ZPCI_IOMAP_SHIFT))
+#define ZPCI_IOMAP_ADDR_IDX_MASK						\
+	(~ZPCI_IOMAP_ADDR_OFF_MASK - ZPCI_IOMAP_ADDR_BASE)
 
 struct zpci_iomap_entry {
 	u32 fh;
@@ -21,8 +24,9 @@ struct zpci_iomap_entry {
 
 extern struct zpci_iomap_entry *zpci_iomap_start;
 
+#define ZPCI_ADDR(idx) (ZPCI_IOMAP_ADDR_BASE | ((u64) idx << ZPCI_IOMAP_SHIFT))
 #define ZPCI_IDX(addr)								\
-	(((__force u64) addr & ZPCI_IOMAP_ADDR_IDX_MASK) >> 48)
+	(((__force u64) addr & ZPCI_IOMAP_ADDR_IDX_MASK) >> ZPCI_IOMAP_SHIFT)
 #define ZPCI_OFFSET(addr)							\
 	((__force u64) addr & ZPCI_IOMAP_ADDR_OFF_MASK)
 
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index f16debf..1c4fe12 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -166,14 +166,14 @@ extern __vector128 init_task_fpu_regs[__NUM_VXRS];
  */
 #define start_thread(regs, new_psw, new_stackp) do {			\
 	regs->psw.mask	= PSW_USER_BITS | PSW_MASK_EA | PSW_MASK_BA;	\
-	regs->psw.addr	= new_psw | PSW_ADDR_AMODE;			\
+	regs->psw.addr	= new_psw;					\
 	regs->gprs[15]	= new_stackp;					\
 	execve_tail();							\
 } while (0)
 
 #define start_thread31(regs, new_psw, new_stackp) do {			\
 	regs->psw.mask	= PSW_USER_BITS | PSW_MASK_BA;			\
-	regs->psw.addr	= new_psw | PSW_ADDR_AMODE;			\
+	regs->psw.addr	= new_psw;					\
 	regs->gprs[15]	= new_stackp;					\
 	crst_table_downgrade(current->mm, 1UL << 31);			\
 	execve_tail();							\
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index f00cd35..99bc456 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -149,7 +149,7 @@ static inline int test_pt_regs_flag(struct pt_regs *regs, int flag)
 #define arch_has_block_step()	(1)
 
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
-#define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
+#define instruction_pointer(regs) ((regs)->psw.addr)
 #define user_stack_pointer(regs)((regs)->gprs[15])
 #define profile_pc(regs) instruction_pointer(regs)
 
@@ -161,7 +161,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
 {
-	regs->psw.addr = val | PSW_ADDR_AMODE;
+	regs->psw.addr = val;
 }
 
 int regs_query_register_offset(const char *name);
@@ -171,7 +171,7 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n);
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
-	return regs->gprs[15] & PSW_ADDR_INSN;
+	return regs->gprs[15];
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index 34ec202..ab3aa68 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -310,7 +310,8 @@
 #define __NR_recvmsg		372
 #define __NR_shutdown		373
 #define __NR_mlock2		374
-#define NR_syscalls 375
+#define __NR_copy_file_range	375
+#define NR_syscalls 376
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index fac4eed..ae2cda5 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -177,3 +177,4 @@ COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
 COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
 COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
 COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
+COMPAT_SYSCALL_WRAP6(copy_file_range, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index a92b39f..3986c9f 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -59,8 +59,6 @@ struct save_area * __init save_area_alloc(bool is_boot_cpu)
 	struct save_area *sa;
 
 	sa = (void *) memblock_alloc(sizeof(*sa), 8);
-	if (!sa)
-		return NULL;
 	if (is_boot_cpu)
 		list_add(&sa->list, &dump_save_areas);
 	else
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 6fca0e4..c890a55 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1470,7 +1470,7 @@ debug_dflt_header_fn(debug_info_t * id, struct debug_view *view,
 		except_str = "*";
 	else
 		except_str = "-";
-	caller = ((unsigned long) entry->caller) & PSW_ADDR_INSN;
+	caller = (unsigned long) entry->caller;
 	rc += sprintf(out_buf, "%02i %011lld:%06lu %1u %1s %02i %p  ",
 		      area, (long long)time_spec.tv_sec,
 		      time_spec.tv_nsec / 1000, level, except_str,
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index dc8e204..02bd02f 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -34,22 +34,21 @@ __show_trace(unsigned long sp, unsigned long low, unsigned long high)
 	unsigned long addr;
 
 	while (1) {
-		sp = sp & PSW_ADDR_INSN;
 		if (sp < low || sp > high - sizeof(*sf))
 			return sp;
 		sf = (struct stack_frame *) sp;
-		addr = sf->gprs[8] & PSW_ADDR_INSN;
+		addr = sf->gprs[8];
 		printk("([<%016lx>] %pSR)\n", addr, (void *)addr);
 		/* Follow the backchain. */
 		while (1) {
 			low = sp;
-			sp = sf->back_chain & PSW_ADDR_INSN;
+			sp = sf->back_chain;
 			if (!sp)
 				break;
 			if (sp <= low || sp > high - sizeof(*sf))
 				return sp;
 			sf = (struct stack_frame *) sp;
-			addr = sf->gprs[8] & PSW_ADDR_INSN;
+			addr = sf->gprs[8];
 			printk(" [<%016lx>] %pSR\n", addr, (void *)addr);
 		}
 		/* Zero backchain detected, check for interrupt frame. */
@@ -57,7 +56,7 @@ __show_trace(unsigned long sp, unsigned long low, unsigned long high)
 		if (sp <= low || sp > high - sizeof(*regs))
 			return sp;
 		regs = (struct pt_regs *) sp;
-		addr = regs->psw.addr & PSW_ADDR_INSN;
+		addr = regs->psw.addr;
 		printk(" [<%016lx>] %pSR\n", addr, (void *)addr);
 		low = sp;
 		sp = regs->gprs[15];
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 20a5caf..c55576b 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -252,14 +252,14 @@ static void early_pgm_check_handler(void)
 	unsigned long addr;
 
 	addr = S390_lowcore.program_old_psw.addr;
-	fixup = search_exception_tables(addr & PSW_ADDR_INSN);
+	fixup = search_exception_tables(addr);
 	if (!fixup)
 		disabled_wait(0);
 	/* Disable low address protection before storing into lowcore. */
 	__ctl_store(cr0, 0, 0);
 	cr0_new = cr0 & ~(1UL << 28);
 	__ctl_load(cr0_new, 0, 0);
-	S390_lowcore.program_old_psw.addr = extable_fixup(fixup)|PSW_ADDR_AMODE;
+	S390_lowcore.program_old_psw.addr = extable_fixup(fixup);
 	__ctl_load(cr0, 0, 0);
 }
 
@@ -268,9 +268,9 @@ static noinline __init void setup_lowcore_early(void)
 	psw_t psw;
 
 	psw.mask = PSW_MASK_BASE | PSW_DEFAULT_KEY | PSW_MASK_EA | PSW_MASK_BA;
-	psw.addr = PSW_ADDR_AMODE | (unsigned long) s390_base_ext_handler;
+	psw.addr = (unsigned long) s390_base_ext_handler;
 	S390_lowcore.external_new_psw = psw;
-	psw.addr = PSW_ADDR_AMODE | (unsigned long) s390_base_pgm_handler;
+	psw.addr = (unsigned long) s390_base_pgm_handler;
 	S390_lowcore.program_new_psw = psw;
 	s390_base_pgm_handler_fn = early_pgm_check_handler;
 }
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index e0eaf11..0f7bfeb 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -203,7 +203,7 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 		goto out;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
-	ip = (ip & PSW_ADDR_INSN) - MCOUNT_INSN_SIZE;
+	ip -= MCOUNT_INSN_SIZE;
 	trace.func = ip;
 	trace.depth = current->curr_ret_stack + 1;
 	/* Only trace if the calling function expects to. */
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 0a5a6b6..f20abdb 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2057,12 +2057,12 @@ void s390_reset_system(void)
 	/* Set new machine check handler */
 	S390_lowcore.mcck_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT;
 	S390_lowcore.mcck_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) s390_base_mcck_handler;
+		(unsigned long) s390_base_mcck_handler;
 
 	/* Set new program check handler */
 	S390_lowcore.program_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT;
 	S390_lowcore.program_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) s390_base_pgm_handler;
+		(unsigned long) s390_base_pgm_handler;
 
 	/*
 	 * Clear subchannel ID and number to signal new kernel that no CCW or
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 389db56..250f597 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -226,7 +226,7 @@ static void enable_singlestep(struct kprobe_ctlblk *kcb,
 	__ctl_load(per_kprobe, 9, 11);
 	regs->psw.mask |= PSW_MASK_PER;
 	regs->psw.mask &= ~(PSW_MASK_IO | PSW_MASK_EXT);
-	regs->psw.addr = ip | PSW_ADDR_AMODE;
+	regs->psw.addr = ip;
 }
 NOKPROBE_SYMBOL(enable_singlestep);
 
@@ -238,7 +238,7 @@ static void disable_singlestep(struct kprobe_ctlblk *kcb,
 	__ctl_load(kcb->kprobe_saved_ctl, 9, 11);
 	regs->psw.mask &= ~PSW_MASK_PER;
 	regs->psw.mask |= kcb->kprobe_saved_imask;
-	regs->psw.addr = ip | PSW_ADDR_AMODE;
+	regs->psw.addr = ip;
 }
 NOKPROBE_SYMBOL(disable_singlestep);
 
@@ -310,7 +310,7 @@ static int kprobe_handler(struct pt_regs *regs)
 	 */
 	preempt_disable();
 	kcb = get_kprobe_ctlblk();
-	p = get_kprobe((void *)((regs->psw.addr & PSW_ADDR_INSN) - 2));
+	p = get_kprobe((void *)(regs->psw.addr - 2));
 
 	if (p) {
 		if (kprobe_running()) {
@@ -460,7 +460,7 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 			break;
 	}
 
-	regs->psw.addr = orig_ret_address | PSW_ADDR_AMODE;
+	regs->psw.addr = orig_ret_address;
 
 	pop_kprobe(get_kprobe_ctlblk());
 	kretprobe_hash_unlock(current, &flags);
@@ -490,7 +490,7 @@ NOKPROBE_SYMBOL(trampoline_probe_handler);
 static void resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long ip = regs->psw.addr & PSW_ADDR_INSN;
+	unsigned long ip = regs->psw.addr;
 	int fixup = probe_get_fixup_type(p->ainsn.insn);
 
 	/* Check if the kprobes location is an enabled ftrace caller */
@@ -605,9 +605,9 @@ static int kprobe_trap_handler(struct pt_regs *regs, int trapnr)
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
-		entry = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
+		entry = search_exception_tables(regs->psw.addr);
 		if (entry) {
-			regs->psw.addr = extable_fixup(entry) | PSW_ADDR_AMODE;
+			regs->psw.addr = extable_fixup(entry);
 			return 1;
 		}
 
@@ -683,7 +683,7 @@ int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
 
 	/* setup return addr to the jprobe handler routine */
-	regs->psw.addr = (unsigned long) jp->entry | PSW_ADDR_AMODE;
+	regs->psw.addr = (unsigned long) jp->entry;
 	regs->psw.mask &= ~(PSW_MASK_IO | PSW_MASK_EXT);
 
 	/* r15 is the stack pointer */
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 61595c1..cfcba2d 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -74,7 +74,7 @@ static unsigned long guest_is_user_mode(struct pt_regs *regs)
 
 static unsigned long instruction_pointer_guest(struct pt_regs *regs)
 {
-	return sie_block(regs)->gpsw.addr & PSW_ADDR_INSN;
+	return sie_block(regs)->gpsw.addr;
 }
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
@@ -231,29 +231,27 @@ static unsigned long __store_trace(struct perf_callchain_entry *entry,
 	struct pt_regs *regs;
 
 	while (1) {
-		sp = sp & PSW_ADDR_INSN;
 		if (sp < low || sp > high - sizeof(*sf))
 			return sp;
 		sf = (struct stack_frame *) sp;
-		perf_callchain_store(entry, sf->gprs[8] & PSW_ADDR_INSN);
+		perf_callchain_store(entry, sf->gprs[8]);
 		/* Follow the backchain. */
 		while (1) {
 			low = sp;
-			sp = sf->back_chain & PSW_ADDR_INSN;
+			sp = sf->back_chain;
 			if (!sp)
 				break;
 			if (sp <= low || sp > high - sizeof(*sf))
 				return sp;
 			sf = (struct stack_frame *) sp;
-			perf_callchain_store(entry,
-					     sf->gprs[8] & PSW_ADDR_INSN);
+			perf_callchain_store(entry, sf->gprs[8]);
 		}
 		/* Zero backchain detected, check for interrupt frame. */
 		sp = (unsigned long) (sf + 1);
 		if (sp <= low || sp > high - sizeof(*regs))
 			return sp;
 		regs = (struct pt_regs *) sp;
-		perf_callchain_store(entry, sf->gprs[8] & PSW_ADDR_INSN);
+		perf_callchain_store(entry, sf->gprs[8]);
 		low = sp;
 		sp = regs->gprs[15];
 	}
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 114ee8b..2bba7df 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -56,10 +56,10 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 		return 0;
 	low = task_stack_page(tsk);
 	high = (struct stack_frame *) task_pt_regs(tsk);
-	sf = (struct stack_frame *) (tsk->thread.ksp & PSW_ADDR_INSN);
+	sf = (struct stack_frame *) tsk->thread.ksp;
 	if (sf <= low || sf > high)
 		return 0;
-	sf = (struct stack_frame *) (sf->back_chain & PSW_ADDR_INSN);
+	sf = (struct stack_frame *) sf->back_chain;
 	if (sf <= low || sf > high)
 		return 0;
 	return sf->gprs[8];
@@ -154,7 +154,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
 				PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
-		frame->childregs.psw.addr = PSW_ADDR_AMODE |
+		frame->childregs.psw.addr =
 				(unsigned long) kernel_thread_starter;
 		frame->childregs.gprs[9] = new_stackp; /* function */
 		frame->childregs.gprs[10] = arg;
@@ -220,14 +220,14 @@ unsigned long get_wchan(struct task_struct *p)
 		return 0;
 	low = task_stack_page(p);
 	high = (struct stack_frame *) task_pt_regs(p);
-	sf = (struct stack_frame *) (p->thread.ksp & PSW_ADDR_INSN);
+	sf = (struct stack_frame *) p->thread.ksp;
 	if (sf <= low || sf > high)
 		return 0;
 	for (count = 0; count < 16; count++) {
-		sf = (struct stack_frame *) (sf->back_chain & PSW_ADDR_INSN);
+		sf = (struct stack_frame *) sf->back_chain;
 		if (sf <= low || sf > high)
 			return 0;
-		return_address = sf->gprs[8] & PSW_ADDR_INSN;
+		return_address = sf->gprs[8];
 		if (!in_sched_functions(return_address))
 			return return_address;
 	}
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 01c37b3..49b1c13 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -84,7 +84,7 @@ void update_cr_regs(struct task_struct *task)
 		if (test_tsk_thread_flag(task, TIF_UPROBE_SINGLESTEP))
 			new.control |= PER_EVENT_IFETCH;
 		new.start = 0;
-		new.end = PSW_ADDR_INSN;
+		new.end = -1UL;
 	}
 
 	/* Take care of the PER enablement bit in the PSW. */
@@ -148,7 +148,7 @@ static inline unsigned long __peek_user_per(struct task_struct *child,
 	else if (addr == (addr_t) &dummy->cr11)
 		/* End address of the active per set. */
 		return test_thread_flag(TIF_SINGLE_STEP) ?
-			PSW_ADDR_INSN : child->thread.per_user.end;
+			-1UL : child->thread.per_user.end;
 	else if (addr == (addr_t) &dummy->bits)
 		/* Single-step bit. */
 		return test_thread_flag(TIF_SINGLE_STEP) ?
@@ -495,8 +495,6 @@ long arch_ptrace(struct task_struct *child, long request,
 		}
 		return 0;
 	default:
-		/* Removing high order bit from addr (only for 31 bit). */
-		addr &= PSW_ADDR_INSN;
 		return ptrace_request(child, request, addr, data);
 	}
 }
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c6878fb..9220db5 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -301,25 +301,21 @@ static void __init setup_lowcore(void)
 	BUILD_BUG_ON(sizeof(struct lowcore) != LC_PAGES * 4096);
 	lc = __alloc_bootmem_low(LC_PAGES * PAGE_SIZE, LC_PAGES * PAGE_SIZE, 0);
 	lc->restart_psw.mask = PSW_KERNEL_BITS;
-	lc->restart_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
+	lc->restart_psw.addr = (unsigned long) restart_int_handler;
 	lc->external_new_psw.mask = PSW_KERNEL_BITS |
 		PSW_MASK_DAT | PSW_MASK_MCHECK;
-	lc->external_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) ext_int_handler;
+	lc->external_new_psw.addr = (unsigned long) ext_int_handler;
 	lc->svc_new_psw.mask = PSW_KERNEL_BITS |
 		PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
-	lc->svc_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) system_call;
+	lc->svc_new_psw.addr = (unsigned long) system_call;
 	lc->program_new_psw.mask = PSW_KERNEL_BITS |
 		PSW_MASK_DAT | PSW_MASK_MCHECK;
-	lc->program_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) pgm_check_handler;
+	lc->program_new_psw.addr = (unsigned long) pgm_check_handler;
 	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
-	lc->mcck_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) mcck_int_handler;
+	lc->mcck_new_psw.addr = (unsigned long) mcck_int_handler;
 	lc->io_new_psw.mask = PSW_KERNEL_BITS |
 		PSW_MASK_DAT | PSW_MASK_MCHECK;
-	lc->io_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) io_int_handler;
+	lc->io_new_psw.addr = (unsigned long) io_int_handler;
 	lc->clock_comparator = -1ULL;
 	lc->kernel_stack = ((unsigned long) &init_thread_union)
 		+ THREAD_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs);
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 028cc46..d82562c 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -331,13 +331,13 @@ static int setup_frame(int sig, struct k_sigaction *ka,
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-		restorer = (unsigned long) ka->sa.sa_restorer | PSW_ADDR_AMODE;
+		restorer = (unsigned long) ka->sa.sa_restorer;
 	} else {
 		/* Signal frame without vector registers are short ! */
 		__u16 __user *svc = (void __user *) frame + frame_size - 2;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn, svc))
 			return -EFAULT;
-		restorer = (unsigned long) svc | PSW_ADDR_AMODE;
+		restorer = (unsigned long) svc;
 	}
 
 	/* Set up registers for signal handler */
@@ -347,7 +347,7 @@ static int setup_frame(int sig, struct k_sigaction *ka,
 	regs->psw.mask = PSW_MASK_EA | PSW_MASK_BA |
 		(PSW_USER_BITS & PSW_MASK_ASC) |
 		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
+	regs->psw.addr = (unsigned long) ka->sa.sa_handler;
 
 	regs->gprs[2] = sig;
 	regs->gprs[3] = (unsigned long) &frame->sc;
@@ -394,13 +394,12 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
-		restorer = (unsigned long)
-			ksig->ka.sa.sa_restorer | PSW_ADDR_AMODE;
+		restorer = (unsigned long) ksig->ka.sa.sa_restorer;
 	} else {
 		__u16 __user *svc = &frame->svc_insn;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn, svc))
 			return -EFAULT;
-		restorer = (unsigned long) svc | PSW_ADDR_AMODE;
+		restorer = (unsigned long) svc;
 	}
 
 	/* Create siginfo on the signal stack */
@@ -426,7 +425,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	regs->psw.mask = PSW_MASK_EA | PSW_MASK_BA |
 		(PSW_USER_BITS & PSW_MASK_ASC) |
 		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (unsigned long) ksig->ka.sa.sa_handler | PSW_ADDR_AMODE;
+	regs->psw.addr = (unsigned long) ksig->ka.sa.sa_handler;
 
 	regs->gprs[2] = ksig->sig;
 	regs->gprs[3] = (unsigned long) &frame->info;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index a13468b..3c65a8e 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -623,8 +623,6 @@ void __init smp_save_dump_cpus(void)
 		return;
 	/* Allocate a page as dumping area for the store status sigps */
 	page = memblock_alloc_base(PAGE_SIZE, PAGE_SIZE, 1UL << 31);
-	if (!page)
-		panic("could not allocate memory for save area\n");
 	/* Set multi-threading state to the previous system. */
 	pcpu_set_smt(sclp.mtid_prev);
 	boot_cpu_addr = stap();
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 1785cd8..5acba3c 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -21,12 +21,11 @@ static unsigned long save_context_stack(struct stack_trace *trace,
 	unsigned long addr;
 
 	while(1) {
-		sp &= PSW_ADDR_INSN;
 		if (sp < low || sp > high)
 			return sp;
 		sf = (struct stack_frame *)sp;
 		while(1) {
-			addr = sf->gprs[8] & PSW_ADDR_INSN;
+			addr = sf->gprs[8];
 			if (!trace->skip)
 				trace->entries[trace->nr_entries++] = addr;
 			else
@@ -34,7 +33,7 @@ static unsigned long save_context_stack(struct stack_trace *trace,
 			if (trace->nr_entries >= trace->max_entries)
 				return sp;
 			low = sp;
-			sp = sf->back_chain & PSW_ADDR_INSN;
+			sp = sf->back_chain;
 			if (!sp)
 				break;
 			if (sp <= low || sp > high - sizeof(*sf))
@@ -46,7 +45,7 @@ static unsigned long save_context_stack(struct stack_trace *trace,
 		if (sp <= low || sp > high - sizeof(*regs))
 			return sp;
 		regs = (struct pt_regs *)sp;
-		addr = regs->psw.addr & PSW_ADDR_INSN;
+		addr = regs->psw.addr;
 		if (savesched || !in_sched_functions(addr)) {
 			if (!trace->skip)
 				trace->entries[trace->nr_entries++] = addr;
@@ -65,7 +64,7 @@ void save_stack_trace(struct stack_trace *trace)
 	register unsigned long sp asm ("15");
 	unsigned long orig_sp, new_sp;
 
-	orig_sp = sp & PSW_ADDR_INSN;
+	orig_sp = sp;
 	new_sp = save_context_stack(trace, orig_sp,
 				    S390_lowcore.panic_stack - PAGE_SIZE,
 				    S390_lowcore.panic_stack, 1);
@@ -86,7 +85,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	unsigned long sp, low, high;
 
-	sp = tsk->thread.ksp & PSW_ADDR_INSN;
+	sp = tsk->thread.ksp;
 	low = (unsigned long) task_stack_page(tsk);
 	high = (unsigned long) task_pt_regs(tsk);
 	save_context_stack(trace, sp, low, high, 0);
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 5378c3e..293d8b9 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -383,3 +383,4 @@ SYSCALL(sys_recvfrom,compat_sys_recvfrom)
 SYSCALL(sys_recvmsg,compat_sys_recvmsg)
 SYSCALL(sys_shutdown,sys_shutdown)
 SYSCALL(sys_mlock2,compat_sys_mlock2)
+SYSCALL(sys_copy_file_range,compat_sys_copy_file_range) /* 375 */
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index d69d648..017eb03d 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -32,8 +32,7 @@ static inline void __user *get_trap_ip(struct pt_regs *regs)
 		address = *(unsigned long *)(current->thread.trap_tdb + 24);
 	else
 		address = regs->psw.addr;
-	return (void __user *)
-		((address - (regs->int_code >> 16)) & PSW_ADDR_INSN);
+	return (void __user *) (address - (regs->int_code >> 16));
 }
 
 static inline void report_user_fault(struct pt_regs *regs, int signr)
@@ -46,7 +45,7 @@ static inline void report_user_fault(struct pt_regs *regs, int signr)
 		return;
 	printk("User process fault: interruption code %04x ilc:%d ",
 	       regs->int_code & 0xffff, regs->int_code >> 17);
-	print_vma_addr("in ", regs->psw.addr & PSW_ADDR_INSN);
+	print_vma_addr("in ", regs->psw.addr);
 	printk("\n");
 	show_regs(regs);
 }
@@ -69,13 +68,13 @@ void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str)
 		report_user_fault(regs, si_signo);
         } else {
                 const struct exception_table_entry *fixup;
-                fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
+		fixup = search_exception_tables(regs->psw.addr);
                 if (fixup)
-			regs->psw.addr = extable_fixup(fixup) | PSW_ADDR_AMODE;
+			regs->psw.addr = extable_fixup(fixup);
 		else {
 			enum bug_trap_type btt;
 
-			btt = report_bug(regs->psw.addr & PSW_ADDR_INSN, regs);
+			btt = report_bug(regs->psw.addr, regs);
 			if (btt == BUG_TRAP_TYPE_WARN)
 				return;
 			die(regs, str);
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 47518a3..d697312 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -116,7 +116,7 @@ static void enable_all_hw_wp(struct kvm_vcpu *vcpu)
 	if (*cr9 & PER_EVENT_STORE && *cr9 & PER_CONTROL_ALTERATION) {
 		*cr9 &= ~PER_CONTROL_ALTERATION;
 		*cr10 = 0;
-		*cr11 = PSW_ADDR_INSN;
+		*cr11 = -1UL;
 	} else {
 		*cr9 &= ~PER_CONTROL_ALTERATION;
 		*cr9 |= PER_EVENT_STORE;
@@ -159,7 +159,7 @@ void kvm_s390_patch_guest_per_regs(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->gcr[0] &= ~0x800ul;
 		vcpu->arch.sie_block->gcr[9] |= PER_EVENT_IFETCH;
 		vcpu->arch.sie_block->gcr[10] = 0;
-		vcpu->arch.sie_block->gcr[11] = PSW_ADDR_INSN;
+		vcpu->arch.sie_block->gcr[11] = -1UL;
 	}
 
 	if (guestdbg_hw_bp_enabled(vcpu)) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 1b903f6..791a414 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -228,7 +228,7 @@ static inline void report_user_fault(struct pt_regs *regs, long signr)
 		return;
 	printk(KERN_ALERT "User process fault: interruption code %04x ilc:%d ",
 	       regs->int_code & 0xffff, regs->int_code >> 17);
-	print_vma_addr(KERN_CONT "in ", regs->psw.addr & PSW_ADDR_INSN);
+	print_vma_addr(KERN_CONT "in ", regs->psw.addr);
 	printk(KERN_CONT "\n");
 	printk(KERN_ALERT "failing address: %016lx TEID: %016lx\n",
 	       regs->int_parm_long & __FAIL_ADDR_MASK, regs->int_parm_long);
@@ -256,9 +256,9 @@ static noinline void do_no_context(struct pt_regs *regs)
 	const struct exception_table_entry *fixup;
 
 	/* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
+	fixup = search_exception_tables(regs->psw.addr);
 	if (fixup) {
-		regs->psw.addr = extable_fixup(fixup) | PSW_ADDR_AMODE;
+		regs->psw.addr = extable_fixup(fixup);
 		return;
 	}
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index c722400..73e2903 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -98,7 +98,7 @@ void __init paging_init(void)
 	__ctl_load(S390_lowcore.kernel_asce, 1, 1);
 	__ctl_load(S390_lowcore.kernel_asce, 7, 7);
 	__ctl_load(S390_lowcore.kernel_asce, 13, 13);
-	arch_local_irq_restore(4UL << (BITS_PER_LONG - 8));
+	__arch_local_irq_stosm(0x04);
 
 	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index ea01477..45c4daa 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -169,12 +169,12 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 
 int s390_mmap_check(unsigned long addr, unsigned long len, unsigned long flags)
 {
-	if (is_compat_task() || (TASK_SIZE >= (1UL << 53)))
+	if (is_compat_task() || TASK_SIZE >= TASK_MAX_SIZE)
 		return 0;
 	if (!(flags & MAP_FIXED))
 		addr = 0;
 	if ((addr + len) >= TASK_SIZE)
-		return crst_table_upgrade(current->mm, 1UL << 53);
+		return crst_table_upgrade(current->mm, TASK_MAX_SIZE);
 	return 0;
 }
 
@@ -189,9 +189,9 @@ s390_get_unmapped_area(struct file *filp, unsigned long addr,
 	area = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
 	if (!(area & ~PAGE_MASK))
 		return area;
-	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < (1UL << 53)) {
+	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < TASK_MAX_SIZE) {
 		/* Upgrade the page table to 4 levels and retry. */
-		rc = crst_table_upgrade(mm, 1UL << 53);
+		rc = crst_table_upgrade(mm, TASK_MAX_SIZE);
 		if (rc)
 			return (unsigned long) rc;
 		area = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
@@ -211,9 +211,9 @@ s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
 	area = arch_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
 	if (!(area & ~PAGE_MASK))
 		return area;
-	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < (1UL << 53)) {
+	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < TASK_MAX_SIZE) {
 		/* Upgrade the page table to 4 levels and retry. */
-		rc = crst_table_upgrade(mm, 1UL << 53);
+		rc = crst_table_upgrade(mm, TASK_MAX_SIZE);
 		if (rc)
 			return (unsigned long) rc;
 		area = arch_get_unmapped_area_topdown(filp, addr, len,
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index a809fa8..5109827 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -55,7 +55,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long limit)
 	unsigned long entry;
 	int flush;
 
-	BUG_ON(limit > (1UL << 53));
+	BUG_ON(limit > TASK_MAX_SIZE);
 	flush = 0;
 repeat:
 	table = crst_table_alloc(mm);
diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 43f32ce..2794845 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -57,9 +57,7 @@ static __init pg_data_t *alloc_node_data(void)
 {
 	pg_data_t *res;
 
-	res = (pg_data_t *) memblock_alloc(sizeof(pg_data_t), 1);
-	if (!res)
-		panic("Could not allocate memory for node data!\n");
+	res = (pg_data_t *) memblock_alloc(sizeof(pg_data_t), 8);
 	memset(res, 0, sizeof(pg_data_t));
 	return res;
 }
@@ -162,7 +160,7 @@ static int __init numa_init_late(void)
 		register_one_node(nid);
 	return 0;
 }
-device_initcall(numa_init_late);
+arch_initcall(numa_init_late);
 
 static int __init parse_debug(char *parm)
 {
diff --git a/arch/s390/oprofile/backtrace.c b/arch/s390/oprofile/backtrace.c
index 8a6811b..fe0bfe3 100644
--- a/arch/s390/oprofile/backtrace.c
+++ b/arch/s390/oprofile/backtrace.c
@@ -16,24 +16,23 @@ __show_trace(unsigned int *depth, unsigned long sp,
 	struct pt_regs *regs;
 
 	while (*depth) {
-		sp = sp & PSW_ADDR_INSN;
 		if (sp < low || sp > high - sizeof(*sf))
 			return sp;
 		sf = (struct stack_frame *) sp;
 		(*depth)--;
-		oprofile_add_trace(sf->gprs[8] & PSW_ADDR_INSN);
+		oprofile_add_trace(sf->gprs[8]);
 
 		/* Follow the backchain.  */
 		while (*depth) {
 			low = sp;
-			sp = sf->back_chain & PSW_ADDR_INSN;
+			sp = sf->back_chain;
 			if (!sp)
 				break;
 			if (sp <= low || sp > high - sizeof(*sf))
 				return sp;
 			sf = (struct stack_frame *) sp;
 			(*depth)--;
-			oprofile_add_trace(sf->gprs[8] & PSW_ADDR_INSN);
+			oprofile_add_trace(sf->gprs[8]);
 
 		}
 
@@ -46,7 +45,7 @@ __show_trace(unsigned int *depth, unsigned long sp,
 			return sp;
 		regs = (struct pt_regs *) sp;
 		(*depth)--;
-		oprofile_add_trace(sf->gprs[8] & PSW_ADDR_INSN);
+		oprofile_add_trace(sf->gprs[8]);
 		low = sp;
 		sp = regs->gprs[15];
 	}
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 11d4f27..8f19c8f 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -68,9 +68,12 @@ static struct airq_struct zpci_airq = {
 	.isc = PCI_ISC,
 };
 
-/* I/O Map */
+#define ZPCI_IOMAP_ENTRIES						\
+	min(((unsigned long) CONFIG_PCI_NR_FUNCTIONS * PCI_BAR_COUNT),	\
+	    ZPCI_IOMAP_MAX_ENTRIES)
+
 static DEFINE_SPINLOCK(zpci_iomap_lock);
-static DECLARE_BITMAP(zpci_iomap, ZPCI_IOMAP_MAX_ENTRIES);
+static unsigned long *zpci_iomap_bitmap;
 struct zpci_iomap_entry *zpci_iomap_start;
 EXPORT_SYMBOL_GPL(zpci_iomap_start);
 
@@ -265,27 +268,20 @@ void __iomem *pci_iomap_range(struct pci_dev *pdev,
 			      unsigned long max)
 {
 	struct zpci_dev *zdev =	to_zpci(pdev);
-	u64 addr;
 	int idx;
 
-	if ((bar & 7) != bar)
+	if (!pci_resource_len(pdev, bar))
 		return NULL;
 
 	idx = zdev->bars[bar].map_idx;
 	spin_lock(&zpci_iomap_lock);
-	if (zpci_iomap_start[idx].count++) {
-		BUG_ON(zpci_iomap_start[idx].fh != zdev->fh ||
-		       zpci_iomap_start[idx].bar != bar);
-	} else {
-		zpci_iomap_start[idx].fh = zdev->fh;
-		zpci_iomap_start[idx].bar = bar;
-	}
 	/* Detect overrun */
-	BUG_ON(!zpci_iomap_start[idx].count);
+	WARN_ON(!++zpci_iomap_start[idx].count);
+	zpci_iomap_start[idx].fh = zdev->fh;
+	zpci_iomap_start[idx].bar = bar;
 	spin_unlock(&zpci_iomap_lock);
 
-	addr = ZPCI_IOMAP_ADDR_BASE | ((u64) idx << 48);
-	return (void __iomem *) addr + offset;
+	return (void __iomem *) ZPCI_ADDR(idx) + offset;
 }
 EXPORT_SYMBOL(pci_iomap_range);
 
@@ -297,12 +293,11 @@ EXPORT_SYMBOL(pci_iomap);
 
 void pci_iounmap(struct pci_dev *pdev, void __iomem *addr)
 {
-	unsigned int idx;
+	unsigned int idx = ZPCI_IDX(addr);
 
-	idx = (((__force u64) addr) & ~ZPCI_IOMAP_ADDR_BASE) >> 48;
 	spin_lock(&zpci_iomap_lock);
 	/* Detect underrun */
-	BUG_ON(!zpci_iomap_start[idx].count);
+	WARN_ON(!zpci_iomap_start[idx].count);
 	if (!--zpci_iomap_start[idx].count) {
 		zpci_iomap_start[idx].fh = 0;
 		zpci_iomap_start[idx].bar = 0;
@@ -544,15 +539,15 @@ static void zpci_irq_exit(void)
 
 static int zpci_alloc_iomap(struct zpci_dev *zdev)
 {
-	int entry;
+	unsigned long entry;
 
 	spin_lock(&zpci_iomap_lock);
-	entry = find_first_zero_bit(zpci_iomap, ZPCI_IOMAP_MAX_ENTRIES);
-	if (entry == ZPCI_IOMAP_MAX_ENTRIES) {
+	entry = find_first_zero_bit(zpci_iomap_bitmap, ZPCI_IOMAP_ENTRIES);
+	if (entry == ZPCI_IOMAP_ENTRIES) {
 		spin_unlock(&zpci_iomap_lock);
 		return -ENOSPC;
 	}
-	set_bit(entry, zpci_iomap);
+	set_bit(entry, zpci_iomap_bitmap);
 	spin_unlock(&zpci_iomap_lock);
 	return entry;
 }
@@ -561,7 +556,7 @@ static void zpci_free_iomap(struct zpci_dev *zdev, int entry)
 {
 	spin_lock(&zpci_iomap_lock);
 	memset(&zpci_iomap_start[entry], 0, sizeof(struct zpci_iomap_entry));
-	clear_bit(entry, zpci_iomap);
+	clear_bit(entry, zpci_iomap_bitmap);
 	spin_unlock(&zpci_iomap_lock);
 }
 
@@ -611,8 +606,7 @@ static int zpci_setup_bus_resources(struct zpci_dev *zdev,
 		if (zdev->bars[i].val & 4)
 			flags |= IORESOURCE_MEM_64;
 
-		addr = ZPCI_IOMAP_ADDR_BASE + ((u64) entry << 48);
-
+		addr = ZPCI_ADDR(entry);
 		size = 1UL << zdev->bars[i].size;
 
 		res = __alloc_res(zdev, addr, size, flags);
@@ -873,23 +867,30 @@ static int zpci_mem_init(void)
 	zdev_fmb_cache = kmem_cache_create("PCI_FMB_cache", sizeof(struct zpci_fmb),
 				16, 0, NULL);
 	if (!zdev_fmb_cache)
-		goto error_zdev;
+		goto error_fmb;
 
-	/* TODO: use realloc */
-	zpci_iomap_start = kzalloc(ZPCI_IOMAP_MAX_ENTRIES * sizeof(*zpci_iomap_start),
-				   GFP_KERNEL);
+	zpci_iomap_start = kcalloc(ZPCI_IOMAP_ENTRIES,
+				   sizeof(*zpci_iomap_start), GFP_KERNEL);
 	if (!zpci_iomap_start)
 		goto error_iomap;
-	return 0;
 
+	zpci_iomap_bitmap = kcalloc(BITS_TO_LONGS(ZPCI_IOMAP_ENTRIES),
+				    sizeof(*zpci_iomap_bitmap), GFP_KERNEL);
+	if (!zpci_iomap_bitmap)
+		goto error_iomap_bitmap;
+
+	return 0;
+error_iomap_bitmap:
+	kfree(zpci_iomap_start);
 error_iomap:
 	kmem_cache_destroy(zdev_fmb_cache);
-error_zdev:
+error_fmb:
 	return -ENOMEM;
 }
 
 static void zpci_mem_exit(void)
 {
+	kfree(zpci_iomap_bitmap);
 	kfree(zpci_iomap_start);
 	kmem_cache_destroy(zdev_fmb_cache);
 }
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 369a3e0..b0e0475 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -53,6 +53,11 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 
 	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
 	       pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
+
+	if (!pdev)
+		return;
+
+	pdev->error_state = pci_channel_io_perm_failure;
 }
 
 void zpci_event_error(void *data)
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index c692dfe..50597f9 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -139,11 +139,11 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
 
 	device = container_of(kobj, struct device, kobj);
 	chp = to_channelpath(device);
-	if (!chp->cmg_chars)
+	if (chp->cmg == -1)
 		return 0;
 
-	return memory_read_from_buffer(buf, count, &off,
-				chp->cmg_chars, sizeof(struct cmg_chars));
+	return memory_read_from_buffer(buf, count, &off, &chp->cmg_chars,
+				       sizeof(chp->cmg_chars));
 }
 
 static struct bin_attribute chp_measurement_chars_attr = {
@@ -416,7 +416,8 @@ static void chp_release(struct device *dev)
  * chp_update_desc - update channel-path description
  * @chp - channel-path
  *
- * Update the channel-path description of the specified channel-path.
+ * Update the channel-path description of the specified channel-path
+ * including channel measurement related information.
  * Return zero on success, non-zero otherwise.
  */
 int chp_update_desc(struct channel_path *chp)
@@ -428,8 +429,10 @@ int chp_update_desc(struct channel_path *chp)
 		return rc;
 
 	rc = chsc_determine_fmt1_channel_path_desc(chp->chpid, &chp->desc_fmt1);
+	if (rc)
+		return rc;
 
-	return rc;
+	return chsc_get_channel_measurement_chars(chp);
 }
 
 /**
@@ -466,14 +469,6 @@ int chp_new(struct chp_id chpid)
 		ret = -ENODEV;
 		goto out_free;
 	}
-	/* Get channel-measurement characteristics. */
-	if (css_chsc_characteristics.scmc && css_chsc_characteristics.secm) {
-		ret = chsc_get_channel_measurement_chars(chp);
-		if (ret)
-			goto out_free;
-	} else {
-		chp->cmg = -1;
-	}
 	dev_set_name(&chp->dev, "chp%x.%02x", chpid.cssid, chpid.id);
 
 	/* make it known to the system */
diff --git a/drivers/s390/cio/chp.h b/drivers/s390/cio/chp.h
index 4efd5b8..af02322 100644
--- a/drivers/s390/cio/chp.h
+++ b/drivers/s390/cio/chp.h
@@ -48,7 +48,7 @@ struct channel_path {
 	/* Channel-measurement related stuff: */
 	int cmg;
 	int shared;
-	void *cmg_chars;
+	struct cmg_chars cmg_chars;
 };
 
 /* Return channel_path struct for given chpid. */
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index a831d18..c424c0c 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 
 #include <asm/cio.h>
@@ -224,8 +225,9 @@ out_unreg:
 
 void chsc_chp_offline(struct chp_id chpid)
 {
-	char dbf_txt[15];
+	struct channel_path *chp = chpid_to_chp(chpid);
 	struct chp_link link;
+	char dbf_txt[15];
 
 	sprintf(dbf_txt, "chpr%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
@@ -236,6 +238,11 @@ void chsc_chp_offline(struct chp_id chpid)
 	link.chpid = chpid;
 	/* Wait until previous actions have settled. */
 	css_wait_for_slow_path();
+
+	mutex_lock(&chp->lock);
+	chp_update_desc(chp);
+	mutex_unlock(&chp->lock);
+
 	for_each_subchannel_staged(s390_subchannel_remove_chpid, NULL, &link);
 }
 
@@ -690,8 +697,9 @@ static void chsc_process_crw(struct crw *crw0, struct crw *crw1, int overflow)
 
 void chsc_chp_online(struct chp_id chpid)
 {
-	char dbf_txt[15];
+	struct channel_path *chp = chpid_to_chp(chpid);
 	struct chp_link link;
+	char dbf_txt[15];
 
 	sprintf(dbf_txt, "cadd%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
@@ -701,6 +709,11 @@ void chsc_chp_online(struct chp_id chpid)
 		link.chpid = chpid;
 		/* Wait until previous actions have settled. */
 		css_wait_for_slow_path();
+
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+
 		for_each_subchannel_staged(__s390_process_res_acc, NULL,
 					   &link);
 		css_schedule_reprobe();
@@ -967,22 +980,19 @@ static void
 chsc_initialize_cmg_chars(struct channel_path *chp, u8 cmcv,
 			  struct cmg_chars *chars)
 {
-	struct cmg_chars *cmg_chars;
 	int i, mask;
 
-	cmg_chars = chp->cmg_chars;
 	for (i = 0; i < NR_MEASUREMENT_CHARS; i++) {
 		mask = 0x80 >> (i + 3);
 		if (cmcv & mask)
-			cmg_chars->values[i] = chars->values[i];
+			chp->cmg_chars.values[i] = chars->values[i];
 		else
-			cmg_chars->values[i] = 0;
+			chp->cmg_chars.values[i] = 0;
 	}
 }
 
 int chsc_get_channel_measurement_chars(struct channel_path *chp)
 {
-	struct cmg_chars *cmg_chars;
 	int ccode, ret;
 
 	struct {
@@ -1006,10 +1016,11 @@ int chsc_get_channel_measurement_chars(struct channel_path *chp)
 		u32 data[NR_MEASUREMENT_CHARS];
 	} __attribute__ ((packed)) *scmc_area;
 
-	chp->cmg_chars = NULL;
-	cmg_chars = kmalloc(sizeof(*cmg_chars), GFP_KERNEL);
-	if (!cmg_chars)
-		return -ENOMEM;
+	chp->shared = -1;
+	chp->cmg = -1;
+
+	if (!css_chsc_characteristics.scmc || !css_chsc_characteristics.secm)
+		return 0;
 
 	spin_lock_irq(&chsc_page_lock);
 	memset(chsc_page, 0, PAGE_SIZE);
@@ -1031,25 +1042,19 @@ int chsc_get_channel_measurement_chars(struct channel_path *chp)
 			      scmc_area->response.code);
 		goto out;
 	}
-	if (scmc_area->not_valid) {
-		chp->cmg = -1;
-		chp->shared = -1;
+	if (scmc_area->not_valid)
 		goto out;
-	}
+
 	chp->cmg = scmc_area->cmg;
 	chp->shared = scmc_area->shared;
 	if (chp->cmg != 2 && chp->cmg != 3) {
 		/* No cmg-dependent data. */
 		goto out;
 	}
-	chp->cmg_chars = cmg_chars;
 	chsc_initialize_cmg_chars(chp, scmc_area->cmcv,
 				  (struct cmg_chars *) &scmc_area->data);
 out:
 	spin_unlock_irq(&chsc_page_lock);
-	if (!chp->cmg_chars)
-		kfree(cmg_chars);
-
 	return ret;
 }
 
diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 7b23f43..de1b6c1 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -112,9 +112,10 @@ static inline int convert_error(struct zcrypt_device *zdev,
 		atomic_set(&zcrypt_rescan_req, 1);
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%drc%d",
-			zdev->ap_dev->qid, zdev->online, ehdr->reply_code);
+			AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online,
+			ehdr->reply_code);
 		return -EAGAIN;
 	case REP82_ERROR_TRANSPORT_FAIL:
 	case REP82_ERROR_MACHINE_FAILURE:
@@ -123,16 +124,18 @@ static inline int convert_error(struct zcrypt_device *zdev,
 		atomic_set(&zcrypt_rescan_req, 1);
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%drc%d",
-			zdev->ap_dev->qid, zdev->online, ehdr->reply_code);
+			AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online,
+			ehdr->reply_code);
 		return -EAGAIN;
 	default:
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%drc%d",
-			zdev->ap_dev->qid, zdev->online, ehdr->reply_code);
+			AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online,
+			ehdr->reply_code);
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
 }
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index 74edf29..eedfaa2 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -336,9 +336,10 @@ static int convert_type80(struct zcrypt_device *zdev,
 		/* The result is too short, the CEX2A card may not do that.. */
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%drc%d",
-			       zdev->ap_dev->qid, zdev->online, t80h->code);
+			       AP_QID_DEVICE(zdev->ap_dev->qid),
+			       zdev->online, t80h->code);
 
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
@@ -368,9 +369,9 @@ static int convert_response(struct zcrypt_device *zdev,
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%dfail",
-			       zdev->ap_dev->qid, zdev->online);
+			       AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online);
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
 }
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 9a2dd47..2195971 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -572,9 +572,9 @@ static int convert_type86_ica(struct zcrypt_device *zdev,
 			return -EINVAL;
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%drc%d",
-			       zdev->ap_dev->qid, zdev->online,
+			       AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online,
 			       msg->hdr.reply_code);
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
@@ -715,9 +715,9 @@ static int convert_response_ica(struct zcrypt_device *zdev,
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%dfail",
-			       zdev->ap_dev->qid, zdev->online);
+			       AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online);
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
 }
@@ -747,9 +747,9 @@ static int convert_response_xcrb(struct zcrypt_device *zdev,
 		xcRB->status = 0x0008044DL; /* HDD_InvalidParm */
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%dfail",
-			       zdev->ap_dev->qid, zdev->online);
+			       AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online);
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
 }
@@ -773,9 +773,9 @@ static int convert_response_ep11_xcrb(struct zcrypt_device *zdev,
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%dfail",
-			       zdev->ap_dev->qid, zdev->online);
+			       AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online);
 		return -EAGAIN; /* repeat the request on a different device. */
 	}
 }
@@ -800,9 +800,9 @@ static int convert_response_rng(struct zcrypt_device *zdev,
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zdev->online = 0;
 		pr_err("Cryptographic device %x failed and was set offline\n",
-		       zdev->ap_dev->qid);
+		       AP_QID_DEVICE(zdev->ap_dev->qid));
 		ZCRYPT_DBF_DEV(DBF_ERR, zdev, "dev%04xo%dfail",
-			       zdev->ap_dev->qid, zdev->online);
+			       AP_QID_DEVICE(zdev->ap_dev->qid), zdev->online);
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
 }
