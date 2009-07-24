Return-Path: <linux-kernel-owner+w=401wt.eu-S1752701AbZGXKwo@vger.kernel.org>
Date: Fri, 24 Jul 2009 12:52:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for v2.6.31-rc4
Message-ID: <20090724125202.75a9ecc5@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Felix Beck (1):
      [S390] zcrypt: fix scheduling of hrtimer ap_poll_timer

Heiko Carstens (3):
      [S390] hibernation: fix lowcore handling
      [S390] hibernation: fix register corruption on machine checks
      [S390] vdso: fix per cpu area allocation

Martin Schwidefsky (1):
      [S390] vdso: clock_gettime of CLOCK_THREAD_CPUTIME_ID with noexec=on

 arch/s390/kernel/early.c                |    4 +-
 arch/s390/kernel/smp.c                  |    7 +++--
 arch/s390/kernel/vdso64/clock_gettime.S |   11 +++++++-
 arch/s390/power/swsusp.c                |   36 ++++++++++++++++++++----------
 arch/s390/power/swsusp_asm64.S          |   35 +++++++----------------------
 drivers/s390/crypto/ap_bus.c            |    9 ++++++-
 6 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index f9b1440..8d15314 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -210,7 +210,7 @@ static noinline __init void detect_machine_type(void)
 		machine_flags |= MACHINE_FLAG_VM;
 }
 
-static void early_pgm_check_handler(void)
+static __init void early_pgm_check_handler(void)
 {
 	unsigned long addr;
 	const struct exception_table_entry *fixup;
@@ -222,7 +222,7 @@ static void early_pgm_check_handler(void)
 	S390_lowcore.program_old_psw.addr = fixup->fixup | PSW_ADDR_AMODE;
 }
 
-void setup_lowcore_early(void)
+static noinline __init void setup_lowcore_early(void)
 {
 	psw_t psw;
 
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 2270730..be2cae0 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -687,13 +687,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
 		lowcore->extended_save_area_addr = (u32) save_area;
-#else
-	if (vdso_alloc_per_cpu(smp_processor_id(), lowcore))
-		BUG();
 #endif
 	set_prefix((u32)(unsigned long) lowcore);
 	local_mcck_enable();
 	local_irq_enable();
+#ifdef CONFIG_64BIT
+	if (vdso_alloc_per_cpu(smp_processor_id(), &S390_lowcore))
+		BUG();
+#endif
 	for_each_possible_cpu(cpu)
 		if (cpu != smp_processor_id())
 			smp_create_idle(cpu);
diff --git a/arch/s390/kernel/vdso64/clock_gettime.S b/arch/s390/kernel/vdso64/clock_gettime.S
index 79dbfee..49106c6 100644
--- a/arch/s390/kernel/vdso64/clock_gettime.S
+++ b/arch/s390/kernel/vdso64/clock_gettime.S
@@ -88,10 +88,17 @@ __kernel_clock_gettime:
 	llilh	%r4,0x0100
 	sar	%a4,%r4
 	lghi	%r4,0
+	epsw	%r5,0
 	sacf	512				/* Magic ectg instruction */
 	.insn	ssf,0xc80100000000,__VDSO_ECTG_BASE(4),__VDSO_ECTG_USER(4),4
-	sacf	0
-	sar	%a4,%r2
+	tml	%r5,0x4000
+	jo	11f
+	tml	%r5,0x8000
+	jno	10f
+	sacf	256
+	j	11f
+10:	sacf	0
+11:	sar	%a4,%r2
 	algr	%r1,%r0				/* r1 = cputime as TOD value */
 	mghi	%r1,1000			/* convert to nanoseconds */
 	srlg	%r1,%r1,12			/* r1 = cputime in nanosec */
diff --git a/arch/s390/power/swsusp.c b/arch/s390/power/swsusp.c
index e6a4fe9..bd1f5c6 100644
--- a/arch/s390/power/swsusp.c
+++ b/arch/s390/power/swsusp.c
@@ -7,24 +7,36 @@
  *
  */
 
+#include <asm/system.h>
 
-/*
- * save CPU registers before creating a hibernation image and before
- * restoring the memory state from it
- */
 void save_processor_state(void)
 {
-	/* implentation contained in the
-	 * swsusp_arch_suspend function
+	/* swsusp_arch_suspend() actually saves all cpu register contents.
+	 * Machine checks must be disabled since swsusp_arch_suspend() stores
+	 * register contents to their lowcore save areas. That's the same
+	 * place where register contents on machine checks would be saved.
+	 * To avoid register corruption disable machine checks.
+	 * We must also disable machine checks in the new psw mask for
+	 * program checks, since swsusp_arch_suspend() may generate program
+	 * checks. Disabling machine checks for all other new psw masks is
+	 * just paranoia.
 	 */
+	local_mcck_disable();
+	/* Disable lowcore protection */
+	__ctl_clear_bit(0,28);
+	S390_lowcore.external_new_psw.mask &= ~PSW_MASK_MCHECK;
+	S390_lowcore.svc_new_psw.mask &= ~PSW_MASK_MCHECK;
+	S390_lowcore.io_new_psw.mask &= ~PSW_MASK_MCHECK;
+	S390_lowcore.program_new_psw.mask &= ~PSW_MASK_MCHECK;
 }
 
-/*
- * restore the contents of CPU registers
- */
 void restore_processor_state(void)
 {
-	/* implentation contained in the
-	 * swsusp_arch_resume function
-	 */
+	S390_lowcore.external_new_psw.mask |= PSW_MASK_MCHECK;
+	S390_lowcore.svc_new_psw.mask |= PSW_MASK_MCHECK;
+	S390_lowcore.io_new_psw.mask |= PSW_MASK_MCHECK;
+	S390_lowcore.program_new_psw.mask |= PSW_MASK_MCHECK;
+	/* Enable lowcore protection */
+	__ctl_set_bit(0,28);
+	local_mcck_enable();
 }
diff --git a/arch/s390/power/swsusp_asm64.S b/arch/s390/power/swsusp_asm64.S
index 76d688d..b26df5c 100644
--- a/arch/s390/power/swsusp_asm64.S
+++ b/arch/s390/power/swsusp_asm64.S
@@ -32,19 +32,14 @@ swsusp_arch_suspend:
 	/* Deactivate DAT */
 	stnsm	__SF_EMPTY(%r15),0xfb
 
-	/* Switch off lowcore protection */
-	stctg	%c0,%c0,__SF_EMPTY(%r15)
-	ni	__SF_EMPTY+4(%r15),0xef
-	lctlg	%c0,%c0,__SF_EMPTY(%r15)
-
 	/* Store prefix register on stack */
 	stpx	__SF_EMPTY(%r15)
 
-	/* Setup base register for lowcore (absolute 0) */
-	llgf	%r1,__SF_EMPTY(%r15)
+	/* Save prefix register contents for lowcore */
+	llgf	%r4,__SF_EMPTY(%r15)
 
 	/* Get pointer to save area */
-	aghi	%r1,0x1000
+	lghi	%r1,0x1000
 
 	/* Store registers */
 	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
@@ -79,17 +74,15 @@ swsusp_arch_suspend:
 	xc	__SF_EMPTY(4,%r15),__SF_EMPTY(%r15)
 	spx	__SF_EMPTY(%r15)
 
-	/* Setup lowcore */
-	brasl	%r14,setup_lowcore_early
+	lghi	%r2,0
+	lghi	%r3,2*PAGE_SIZE
+	lghi	%r5,2*PAGE_SIZE
+1:	mvcle	%r2,%r4,0
+	jo	1b
 
 	/* Save image */
 	brasl	%r14,swsusp_save
 
-	/* Switch on lowcore protection */
-	stctg	%c0,%c0,__SF_EMPTY(%r15)
-	oi	__SF_EMPTY+4(%r15),0x10
-	lctlg	%c0,%c0,__SF_EMPTY(%r15)
-
 	/* Restore prefix register and return */
 	lghi	%r1,0x1000
 	spx	0x318(%r1)
@@ -117,11 +110,6 @@ swsusp_arch_resume:
 	/* Deactivate DAT */
 	stnsm	__SF_EMPTY(%r15),0xfb
 
-	/* Switch off lowcore protection */
-	stctg	%c0,%c0,__SF_EMPTY(%r15)
-	ni	__SF_EMPTY+4(%r15),0xef
-	lctlg	%c0,%c0,__SF_EMPTY(%r15)
-
 	/* Set prefix page to zero */
 	xc	__SF_EMPTY(4,%r15),__SF_EMPTY(%r15)
 	spx	__SF_EMPTY(%r15)
@@ -175,7 +163,7 @@ swsusp_arch_resume:
 	/* Load old stack */
 	lg	%r15,0x2f8(%r13)
 
-	/* Pointer to save arae */
+	/* Pointer to save area */
 	lghi	%r13,0x1000
 
 #ifdef CONFIG_SMP
@@ -187,11 +175,6 @@ swsusp_arch_resume:
 	/* Restore prefix register */
 	spx	0x318(%r13)
 
-	/* Switch on lowcore protection */
-	stctg	%c0,%c0,__SF_EMPTY(%r15)
-	oi	__SF_EMPTY+4(%r15),0x10
-	lctlg	%c0,%c0,__SF_EMPTY(%r15)
-
 	/* Activate DAT */
 	stosm	__SF_EMPTY(%r15),0x04
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 727a809..ed3dcde 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1145,12 +1145,17 @@ ap_config_timeout(unsigned long ptr)
  */
 static inline void ap_schedule_poll_timer(void)
 {
+	ktime_t hr_time;
 	if (ap_using_interrupts() || ap_suspend_flag)
 		return;
 	if (hrtimer_is_queued(&ap_poll_timer))
 		return;
-	hrtimer_start(&ap_poll_timer, ktime_set(0, poll_timeout),
-		      HRTIMER_MODE_ABS);
+	if (ktime_to_ns(hrtimer_expires_remaining(&ap_poll_timer)) <= 0) {
+		hr_time = ktime_set(0, poll_timeout);
+		hrtimer_forward_now(&ap_poll_timer, hr_time);
+		hrtimer_restart(&ap_poll_timer);
+	}
+	return;
 }
 
 /**
