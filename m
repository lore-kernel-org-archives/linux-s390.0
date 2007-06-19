Return-Path: <linux-kernel-owner+w=401wt.eu-S1758300AbXFSIsz@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 19 Jun 2007 10:50:11 +0200
Message-Id: <1182243012.2542.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/appldata/appldata_base.c |    5 ++---
 arch/s390/kernel/entry.S           |    8 +++++++-
 arch/s390/kernel/entry64.S         |    8 +++++++-
 arch/s390/kernel/setup.c           |    1 +
 arch/s390/kernel/traps.c           |    9 ++++++---
 drivers/s390/char/zcore.c          |    3 +++
 include/asm-s390/processor.h       |    5 +++++
 include/asm-s390/ptrace.h          |    9 +--------
 8 files changed, 32 insertions(+), 16 deletions(-)

Heiko Carstens (4):
      [S390] Fix yet another two section mismatches.
      [S390] Print list of modules on die().
      [S390] Move psw_set_key.
      [S390] Add oops_enter()/oops_exit() calls to die().

Michael Holzheu (2):
      [S390] Missing blank when appending cio_ignore kernel parameter
      [S390] Fix zfcpdump header

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 81a2b92..6ffbab7 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -535,8 +535,7 @@ void appldata_unregister_ops(struct appldata_ops *ops)
 
 /******************************* init / exit *********************************/
 
-static void
-appldata_online_cpu(int cpu)
+static void __cpuinit appldata_online_cpu(int cpu)
 {
 	init_virt_timer(&per_cpu(appldata_timer, cpu));
 	per_cpu(appldata_timer, cpu).function = appldata_timer_function;
@@ -580,7 +579,7 @@ appldata_cpu_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block appldata_nb = {
+static struct notifier_block __cpuinitdata appldata_nb = {
 	.notifier_call = appldata_cpu_notify,
 };
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index c8a2212..6234c69 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -769,10 +769,13 @@ mcck_return:
 
 	RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
-#ifdef CONFIG_SMP
 /*
  * Restart interruption handler, kick starter for additional CPUs
  */
+#ifdef CONFIG_SMP
+#ifndef CONFIG_HOTPLUG_CPU
+	.section .init.text,"ax"
+#endif
 	.globl restart_int_handler
 restart_int_handler:
 	l	%r15,__LC_SAVE_AREA+60	# load ksp
@@ -785,6 +788,9 @@ restart_int_handler:
 	br	%r14			# branch to start_secondary
 restart_addr:
 	.long	start_secondary
+#ifndef CONFIG_HOTPLUG_CPU
+	.previous
+#endif
 #else
 /*
  * If we do not run with SMP enabled, let the new CPU crash ...
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 93745fd..685f11f 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -745,10 +745,13 @@ mcck_return:
 #endif
 	lpswe	__LC_RETURN_MCCK_PSW	# back to caller
 
-#ifdef CONFIG_SMP
 /*
  * Restart interruption handler, kick starter for additional CPUs
  */
+#ifdef CONFIG_SMP
+#ifndef CONFIG_HOTPLUG_CPU
+	.section .init.text,"ax"
+#endif
 	.globl restart_int_handler
 restart_int_handler:
 	lg	%r15,__LC_SAVE_AREA+120 # load ksp
@@ -759,6 +762,9 @@ restart_int_handler:
 	lmg	%r6,%r15,__SF_GPRS(%r15) # load registers from clone
 	stosm	__SF_EMPTY(%r15),0x04	# now we can turn dat on
 	jg	start_secondary
+#ifndef CONFIG_HOTPLUG_CPU
+	.previous
+#endif
 #else
 /*
  * If we do not run with SMP enabled, let the new CPU crash ...
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 51d6309..7e1bfb9 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -300,6 +300,7 @@ static void __init setup_zfcpdump(unsigned int console_devno)
 	else
 		sprintf(str, "cio_ignore=all,!0.0.%04x",
 			ipl_info.data.fcp.dev_id.devno);
+	strcat(COMMAND_LINE, " ");
 	strcat(COMMAND_LINE, str);
 	console_loglevel = 2;
 }
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index cbfe730..ee9186f 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -253,19 +253,22 @@ void die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
 
+	oops_enter();
 	debug_stop_all();
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
-        show_regs(regs);
+	print_modules();
+	show_regs(regs);
 	bust_spinlocks(0);
-        spin_unlock_irq(&die_lock);
+	spin_unlock_irq(&die_lock);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception: panic_on_oops");
-        do_exit(SIGSEGV);
+	oops_exit();
+	do_exit(SIGSEGV);
 }
 
 static void inline
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 66eb068..4e711a9 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -267,7 +267,9 @@ struct zcore_header {
 	u64 tod;
 	cpuid_t cpu_id;
 	u32 arch_id;
+	u32 volnr;
 	u32 build_arch;
+	u64 rmem_size;
 	char pad2[4016];
 } __attribute__((packed,__aligned__(16)));
 
@@ -559,6 +561,7 @@ static void __init zcore_header_init(int arch, struct zcore_header *hdr)
 	else
 		hdr->arch_id = DUMP_ARCH_S390;
 	hdr->mem_size = sys_info.mem_size;
+	hdr->rmem_size = sys_info.mem_size;
 	hdr->mem_end = sys_info.mem_size;
 	hdr->num_pages = sys_info.mem_size / PAGE_SIZE;
 	hdr->tod = get_clock();
diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index e0fcea8..5cb480a 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -216,6 +216,11 @@ static inline void cpu_relax(void)
 	barrier();
 }
 
+static inline void psw_set_key(unsigned int key)
+{
+	asm volatile("spka 0(%0)" : : "d" (key));
+}
+
 /*
  * Set PSW to specified value.
  */
diff --git a/include/asm-s390/ptrace.h b/include/asm-s390/ptrace.h
index fa6ca87..332ee73 100644
--- a/include/asm-s390/ptrace.h
+++ b/include/asm-s390/ptrace.h
@@ -470,14 +470,7 @@ struct user_regs_struct
 #define regs_return_value(regs)((regs)->gprs[2])
 #define profile_pc(regs) instruction_pointer(regs)
 extern void show_regs(struct pt_regs * regs);
-#endif
-
-static inline void
-psw_set_key(unsigned int key)
-{
-	asm volatile("spka 0(%0)" : : "d" (key));
-}
-
+#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
 #endif /* _S390_PTRACE_H */
