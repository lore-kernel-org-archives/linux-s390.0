Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgIRX1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Sep 2020 19:27:35 -0400
Date: Sat, 19 Sep 2020 01:27:25 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9-rc6
Message-ID: <your-ad-here.call-01600471645-ext-5592@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc6.

Thank you,
Vasily

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-6

for you to fetch changes up to cd4d3d5f21ddbfae3f686ac0ff405f21f7847ad3:

  s390: add 3f program exception handler (2020-09-14 10:08:07 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc6

- Fix order in trace_hardirqs_off_caller() to make locking state
  consistent even if the IRQ tracer calls into lockdep again.
  Touches common code. Acked-by Peter Zijlstra.

- Correctly handle secure storage violation exception to avoid kernel
  panic triggered by user space misbehaviour.

- Switch the idle->seqcount over to using raw_write_*() to avoid
  "suspicious RCU usage".

- Fix memory leaks on hard unplug in pci code.

- Use kvmalloc instead of kmalloc for larger allocations in zcrypt.

- Add few missing __init annotations to static functions to avoid section
  mismatch complains when functions are not inlined.

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: fix kmalloc 256k failure

Ilya Leoshkevich (1):
      s390/init: add missing __init annotations

Janosch Frank (1):
      s390: add 3f program exception handler

Niklas Schnelle (1):
      s390/pci: fix leak of DMA tables on hard unplug

Peter Zijlstra (1):
      s390/idle: fix suspicious RCU usage

Sven Schnelle (1):
      lockdep: fix order in trace_hardirqs_off_caller()

 arch/s390/kernel/entry.h             |  1 +
 arch/s390/kernel/idle.c              |  5 ++---
 arch/s390/kernel/pgm_check.S         |  2 +-
 arch/s390/kernel/setup.c             |  6 +++---
 arch/s390/mm/fault.c                 | 20 ++++++++++++++++++++
 arch/s390/pci/pci.c                  |  4 ++++
 arch/s390/pci/pci_event.c            |  2 ++
 drivers/s390/crypto/zcrypt_ccamisc.c |  8 ++++----
 kernel/trace/trace_preemptirq.c      |  4 ++--
 9 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index faca269d5f27..a44ddc2f2dec 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -26,6 +26,7 @@ void do_protection_exception(struct pt_regs *regs);
 void do_dat_exception(struct pt_regs *regs);
 void do_secure_storage_access(struct pt_regs *regs);
 void do_non_secure_storage_access(struct pt_regs *regs);
+void do_secure_storage_violation(struct pt_regs *regs);
 
 void addressing_exception(struct pt_regs *regs);
 void data_exception(struct pt_regs *regs);
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index c73f50649e7e..f7f1e64e0d98 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -39,14 +39,13 @@ void enabled_wait(void)
 	local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	/* XXX seqcount has tracepoints that require RCU */
-	write_seqcount_begin(&idle->seqcount);
+	raw_write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
 	idle->idle_time += idle_time;
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
-	write_seqcount_end(&idle->seqcount);
+	raw_write_seqcount_end(&idle->seqcount);
 }
 NOKPROBE_SYMBOL(enabled_wait);
 
diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
index 2c27907a5ffc..9a92638360ee 100644
--- a/arch/s390/kernel/pgm_check.S
+++ b/arch/s390/kernel/pgm_check.S
@@ -80,7 +80,7 @@ PGM_CHECK(do_dat_exception)		/* 3b */
 PGM_CHECK_DEFAULT			/* 3c */
 PGM_CHECK(do_secure_storage_access)	/* 3d */
 PGM_CHECK(do_non_secure_storage_access)	/* 3e */
-PGM_CHECK_DEFAULT			/* 3f */
+PGM_CHECK(do_secure_storage_violation)	/* 3f */
 PGM_CHECK(monitor_event_exception)	/* 40 */
 PGM_CHECK_DEFAULT			/* 41 */
 PGM_CHECK_DEFAULT			/* 42 */
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index e600f6953d7c..c2c1b4e723ea 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -619,7 +619,7 @@ static struct notifier_block kdump_mem_nb = {
 /*
  * Make sure that the area behind memory_end is protected
  */
-static void reserve_memory_end(void)
+static void __init reserve_memory_end(void)
 {
 	if (memory_end_set)
 		memblock_reserve(memory_end, ULONG_MAX);
@@ -628,7 +628,7 @@ static void reserve_memory_end(void)
 /*
  * Make sure that oldmem, where the dump is stored, is protected
  */
-static void reserve_oldmem(void)
+static void __init reserve_oldmem(void)
 {
 #ifdef CONFIG_CRASH_DUMP
 	if (OLDMEM_BASE)
@@ -640,7 +640,7 @@ static void reserve_oldmem(void)
 /*
  * Make sure that oldmem, where the dump is stored, is protected
  */
-static void remove_oldmem(void)
+static void __init remove_oldmem(void)
 {
 #ifdef CONFIG_CRASH_DUMP
 	if (OLDMEM_BASE)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4c8c063bce5b..996884dcc9fd 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -859,6 +859,21 @@ void do_non_secure_storage_access(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_non_secure_storage_access);
 
+void do_secure_storage_violation(struct pt_regs *regs)
+{
+	/*
+	 * Either KVM messed up the secure guest mapping or the same
+	 * page is mapped into multiple secure guests.
+	 *
+	 * This exception is only triggered when a guest 2 is running
+	 * and can therefore never occur in kernel context.
+	 */
+	printk_ratelimited(KERN_WARNING
+			   "Secure storage violation in task: %s, pid %d\n",
+			   current->comm, current->pid);
+	send_sig(SIGSEGV, current, 0);
+}
+
 #else
 void do_secure_storage_access(struct pt_regs *regs)
 {
@@ -869,4 +884,9 @@ void do_non_secure_storage_access(struct pt_regs *regs)
 {
 	default_trap_handler(regs);
 }
+
+void do_secure_storage_violation(struct pt_regs *regs)
+{
+	default_trap_handler(regs);
+}
 #endif
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 4b62d6b55024..1804230dd8d8 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -668,6 +668,10 @@ EXPORT_SYMBOL_GPL(zpci_enable_device);
 int zpci_disable_device(struct zpci_dev *zdev)
 {
 	zpci_dma_exit_device(zdev);
+	/*
+	 * The zPCI function may already be disabled by the platform, this is
+	 * detected in clp_disable_fh() which becomes a no-op.
+	 */
 	return clp_disable_fh(zdev);
 }
 EXPORT_SYMBOL_GPL(zpci_disable_device);
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 9a3a291cad43..d9ae7456dd4c 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -143,6 +143,8 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zpci_remove_device(zdev);
 		}
 
+		zdev->fh = ccdf->fh;
+		zpci_disable_device(zdev);
 		zdev->state = ZPCI_FN_STATE_STANDBY;
 		if (!clp_get_state(ccdf->fid, &state) &&
 		    state == ZPCI_FN_STATE_RESERVED) {
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 3f5b61351cde..c793dcabd551 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1692,9 +1692,9 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	*nr_apqns = 0;
 
 	/* fetch status of all crypto cards */
-	device_status = kmalloc_array(MAX_ZDEV_ENTRIES_EXT,
-				      sizeof(struct zcrypt_device_status_ext),
-				      GFP_KERNEL);
+	device_status = kvmalloc_array(MAX_ZDEV_ENTRIES_EXT,
+				       sizeof(struct zcrypt_device_status_ext),
+				       GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
 	zcrypt_device_status_mask_ext(device_status);
@@ -1762,7 +1762,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		verify = 0;
 	}
 
-	kfree(device_status);
+	kvfree(device_status);
 	return rc;
 }
 EXPORT_SYMBOL(cca_findcard2);
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f10073e62603..f4938040c228 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -102,14 +102,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
 		if (!in_nmi())
 			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
 	}
-
-	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
