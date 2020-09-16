Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 16 Sep 2020 15:12:05 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: x86/irq] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
In-Reply-To: <20200826112333.992429909@linutronix.de>
References: <20200826112333.992429909@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912544.15536.15310601835998993591.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     077ee78e392869e46ae6bdc6ba2a3c4249d0b5e1
Gitweb:        https://git.kernel.org/tip/077ee78e392869e46ae6bdc6ba2a3c4249d0b5e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:37 +02:00

PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable

The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
requires them or not. Architectures which are fully utilizing hierarchical
irq domains should never call into that code.

It's not only architectures which depend on that by implementing one or
more of the weak functions, there is also a bunch of drivers which relies
on the weak functions which invoke msi_controller::setup_irq[s] and
msi_controller::teardown_irq.

Make the architectures and drivers which rely on them select them in Kconfig
and if not selected replace them by stub functions which emit a warning and
fail the PCI/MSI interrupt allocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112333.992429909@linutronix.de
---
 arch/ia64/Kconfig              |  1 +
 arch/mips/Kconfig              |  1 +
 arch/powerpc/Kconfig           |  1 +
 arch/s390/Kconfig              |  1 +
 arch/sparc/Kconfig             |  1 +
 arch/x86/Kconfig               |  1 +
 drivers/pci/Kconfig            |  3 +++
 drivers/pci/controller/Kconfig |  3 +++
 drivers/pci/msi.c              |  3 ++-
 include/linux/msi.h            | 31 ++++++++++++++++++++++++++-----
 10 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 5b4ec80..7ff5b3b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -56,6 +56,7 @@ config IA64
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select NUMA if !FLATMEM
+	select PCI_MSI_ARCH_FALLBACKS
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c95fa3a..3690582 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -86,6 +86,7 @@ config MIPS
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
+	select PCI_MSI_ARCH_FALLBACKS
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65bed1f..9e66ca1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,6 +246,7 @@ config PPC
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select PCI_SYSCALL			if PCI
 	select PPC_DAWR				if PPC64
 	select RTC_LIB
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b29fcc6..63dd5a0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -185,6 +185,7 @@ config S390
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index efeff2c..21a3239 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC
 	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select PCI_SYSCALL if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac6..196e068 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,6 +225,7 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2..438a792 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -56,6 +56,9 @@ config PCI_MSI_IRQ_DOMAIN
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
+config PCI_MSI_ARCH_FALLBACKS
+	bool
+
 config PCI_QUIRKS
 	default y
 	bool "Enable PCI quirk workarounds" if EXPERT
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f18c372..4a7afbe 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -41,6 +41,7 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
@@ -67,6 +68,7 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
@@ -95,6 +97,7 @@ config PCI_HOST_GENERIC
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on OF || COMPILE_TEST
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a2f00d1..d52d118 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -58,8 +58,8 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
 #endif
 
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 /* Arch hooks */
-
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_controller *chip = dev->bus->msi;
@@ -132,6 +132,7 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 {
 	return default_teardown_msi_irqs(dev);
 }
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
 static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0180534..6b584cc 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
 /*
- * The arch hooks to setup up msi irqs. Those functions are
- * implemented as weak symbols so that they /can/ be overriden by
- * architecture specific code if needed.
+ * The arch hooks to setup up msi irqs. Default functions are implemented
+ * as weak symbols so that they /can/ be overriden by architecture specific
+ * code if needed. These hooks must be enabled by the architecture or by
+ * drivers which depend on them via msi_controller based MSI handling.
+ *
+ * If CONFIG_PCI_MSI_ARCH_FALLBACKS is not selected they are replaced by
+ * stubs with warnings.
  */
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
-void arch_restore_msi_irqs(struct pci_dev *dev);
-
 void default_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
+/*
+ * The restore hooks are still available as they are useful even
+ * for fully irq domain based setups. Courtesy to XEN/X86.
+ */
+void arch_restore_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
 struct msi_controller {
