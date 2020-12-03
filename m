Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728137AbgLCTeK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 14:34:10 -0500
Date: Thu, 3 Dec 2020 20:30:52 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.10-rc7
Message-ID: <20201203193052.GD9994@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull two late fixes for s390. One commit is fixing lockdep irq state
tracing which broke with -rc6. The other one fixes logical vs physical CPU
address mixup in our PCI code.

Thanks,
Heiko

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-6

for you to fetch changes up to b1cae1f84a0f609a34ebcaa087fbecef32f69882:

  s390: fix irq state tracing (2020-12-02 18:17:50 +0100)

----------------------------------------------------------------
- fix lockdep irq state tracing

- fix logical vs physical CPU address confusion in PCI code

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/pci: fix CPU address in MSI for directed IRQ

Heiko Carstens (1):
      s390: fix irq state tracing

 arch/s390/kernel/entry.S | 15 ---------------
 arch/s390/lib/delay.c    |  5 ++---
 arch/s390/pci/pci_irq.c  | 14 +++++++++++---
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 26bb0603c5a1..92beb1444644 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -763,12 +763,7 @@ ENTRY(io_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
 	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 .Lio_loop:
 	lgr	%r2,%r11		# pass pointer to pt_regs
@@ -791,12 +786,7 @@ ENTRY(io_int_handler)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lio_work
 .Lio_restore:
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tm	__PT_PSW(%r11),3
-	jno	0f
 	TRACE_IRQS_ON
-0:
-#endif
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
@@ -976,12 +966,7 @@ ENTRY(ext_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
 	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,EXT_INTERRUPT
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index daca7bad66de..8c0c68e7770e 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(__delay);
 
 static void __udelay_disabled(unsigned long long usecs)
 {
-	unsigned long cr0, cr0_new, psw_mask, flags;
+	unsigned long cr0, cr0_new, psw_mask;
 	struct s390_idle_data idle;
 	u64 end;
 
@@ -45,9 +45,8 @@ static void __udelay_disabled(unsigned long long usecs)
 	psw_mask = __extract_psw() | PSW_MASK_EXT | PSW_MASK_WAIT;
 	set_clock_comparator(end);
 	set_cpu_flag(CIF_IGNORE_IRQ);
-	local_irq_save(flags);
 	psw_idle(&idle, psw_mask);
-	local_irq_restore(flags);
+	trace_hardirqs_off();
 	clear_cpu_flag(CIF_IGNORE_IRQ);
 	set_clock_comparator(S390_lowcore.clock_comparator);
 	__ctl_load(cr0, 0, 0);
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 743f257cf2cb..75217fb63d7b 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
 {
 	struct msi_desc *entry = irq_get_msi_desc(data->irq);
 	struct msi_msg msg = entry->msg;
+	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
 
 	msg.address_lo &= 0xff0000ff;
-	msg.address_lo |= (cpumask_first(dest) << 8);
+	msg.address_lo |= (cpu_addr << 8);
 	pci_write_msi_msg(data->irq, &msg);
 
 	return IRQ_SET_MASK_OK;
@@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned long bit;
 	struct msi_desc *msi;
 	struct msi_msg msg;
+	int cpu_addr;
 	int rc, irq;
 
 	zdev->aisb = -1UL;
@@ -287,9 +289,15 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 					 handle_percpu_irq);
 		msg.data = hwirq - bit;
 		if (irq_delivery == DIRECTED) {
+			if (msi->affinity)
+				cpu = cpumask_first(&msi->affinity->mask);
+			else
+				cpu = 0;
+			cpu_addr = smp_cpu_get_cpu_address(cpu);
+
 			msg.address_lo = zdev->msi_addr & 0xff0000ff;
-			msg.address_lo |= msi->affinity ?
-				(cpumask_first(&msi->affinity->mask) << 8) : 0;
+			msg.address_lo |= (cpu_addr << 8);
+
 			for_each_possible_cpu(cpu) {
 				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
 			}
