Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 26 Apr 2020 09:39:21 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.7-rc3
Message-ID: <your-ad-here.call-01587886761-ext-5453@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.7-rc3.

Thank you,
Vasily

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-3

for you to fetch changes up to 673deb0beba5d39c2e0bc6536e00b03b6ef59cc0:

  s390/protvirt: fix compilation issue (2020-04-25 10:17:24 +0200)

----------------------------------------------------------------
s390 fixes for 5.7-rc3

- Add few notrace annotations to avoid potential crashes when switching
  ftrace tracers.

- Avoid setting affinity for floating irqs in pci code.

- Fix build issue found by kbuild test robot.

----------------------------------------------------------------
Claudio Imbrenda (1):
      s390/protvirt: fix compilation issue

Niklas Schnelle (1):
      s390/pci: do not set affinity for floating irqs

Philipp Rudo (1):
      s390/ftrace: fix potential crashes when switching tracers

 arch/s390/boot/uv.c      | 2 --
 arch/s390/kernel/diag.c  | 2 +-
 arch/s390/kernel/smp.c   | 4 ++--
 arch/s390/kernel/trace.c | 2 +-
 arch/s390/kernel/uv.c    | 3 ++-
 arch/s390/pci/pci_irq.c  | 5 +++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 8fde561f1d07..f887a479cdc7 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -7,9 +7,7 @@
 #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
 int __bootdata_preserved(prot_virt_guest);
 #endif
-#if IS_ENABLED(CONFIG_KVM)
 struct uv_info __bootdata_preserved(uv_info);
-#endif
 
 void uv_query_info(void)
 {
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index 61f2b0412345..ccba63aaeb47 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -133,7 +133,7 @@ void diag_stat_inc(enum diag_stat_enum nr)
 }
 EXPORT_SYMBOL(diag_stat_inc);
 
-void diag_stat_inc_norecursion(enum diag_stat_enum nr)
+void notrace diag_stat_inc_norecursion(enum diag_stat_enum nr)
 {
 	this_cpu_inc(diag_stat.counter[nr]);
 	trace_s390_diagnose_norecursion(diag_map[nr].code);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 7eaabbab2213..10dbb12eb14d 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -403,7 +403,7 @@ int smp_find_processor_id(u16 address)
 	return -1;
 }
 
-bool arch_vcpu_is_preempted(int cpu)
+bool notrace arch_vcpu_is_preempted(int cpu)
 {
 	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
 		return false;
@@ -413,7 +413,7 @@ bool arch_vcpu_is_preempted(int cpu)
 }
 EXPORT_SYMBOL(arch_vcpu_is_preempted);
 
-void smp_yield_cpu(int cpu)
+void notrace smp_yield_cpu(int cpu)
 {
 	if (!MACHINE_HAS_DIAG9C)
 		return;
diff --git a/arch/s390/kernel/trace.c b/arch/s390/kernel/trace.c
index 490b52e85014..11a669f3cc93 100644
--- a/arch/s390/kernel/trace.c
+++ b/arch/s390/kernel/trace.c
@@ -14,7 +14,7 @@ EXPORT_TRACEPOINT_SYMBOL(s390_diagnose);
 
 static DEFINE_PER_CPU(unsigned int, diagnose_trace_depth);
 
-void trace_s390_diagnose_norecursion(int diag_nr)
+void notrace trace_s390_diagnose_norecursion(int diag_nr)
 {
 	unsigned long flags;
 	unsigned int *depth;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index c86d654351d1..4c0677fc8904 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -23,10 +23,11 @@
 int __bootdata_preserved(prot_virt_guest);
 #endif
 
+struct uv_info __bootdata_preserved(uv_info);
+
 #if IS_ENABLED(CONFIG_KVM)
 int prot_virt_host;
 EXPORT_SYMBOL(prot_virt_host);
-struct uv_info __bootdata_preserved(uv_info);
 EXPORT_SYMBOL(uv_info);
 
 static int __init prot_virt_setup(char *val)
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index fbe97ab2e228..743f257cf2cb 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -115,7 +115,6 @@ static struct irq_chip zpci_irq_chip = {
 	.name = "PCI-MSI",
 	.irq_unmask = pci_msi_unmask_irq,
 	.irq_mask = pci_msi_mask_irq,
-	.irq_set_affinity = zpci_set_irq_affinity,
 };
 
 static void zpci_handle_cpu_local_irq(bool rescan)
@@ -276,7 +275,9 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		rc = -EIO;
 		if (hwirq - bit >= msi_vecs)
 			break;
-		irq = __irq_alloc_descs(-1, 0, 1, 0, THIS_MODULE, msi->affinity);
+		irq = __irq_alloc_descs(-1, 0, 1, 0, THIS_MODULE,
+				(irq_delivery == DIRECTED) ?
+				msi->affinity : NULL);
 		if (irq < 0)
 			return -ENOMEM;
 		rc = irq_set_msi_desc(irq, msi);
