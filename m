Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
Date: Wed, 13 Feb 2019 18:40:00 +0100
Message-Id: <20190213174005.28785-7-hch@lst.de>
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add one definition to lib/Kconfig.debug and let the architectures
select if it supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig        | 4 +---
 arch/arm/Kconfig        | 5 +----
 arch/arm64/Kconfig      | 4 +---
 arch/hexagon/Kconfig    | 4 +---
 arch/microblaze/Kconfig | 4 +---
 arch/mips/Kconfig       | 5 +----
 arch/openrisc/Kconfig   | 4 +---
 arch/powerpc/Kconfig    | 5 +----
 arch/s390/Kconfig       | 4 +---
 arch/sh/Kconfig         | 4 +---
 arch/sparc/Kconfig      | 5 +----
 arch/um/Kconfig         | 5 +----
 arch/unicore32/Kconfig  | 4 +---
 arch/x86/Kconfig        | 4 +---
 arch/xtensa/Kconfig     | 4 +---
 lib/Kconfig.debug       | 3 +++
 16 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 065fbd55dcc4..b1d6f297e448 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -42,6 +42,7 @@ config ARC
 	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
+	select LOCKDEP_SUPPORT
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
@@ -54,9 +55,6 @@ config ARC
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1995e1b24506..d6e7713a71ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -98,6 +98,7 @@ config ARM
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
+	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
 	select OF_EARLY_FLATTREE if OF
@@ -167,10 +168,6 @@ config NO_IOPORT_MAP
 config SBUS
 	bool
 
-config LOCKDEP_SUPPORT
-	bool
-	default y
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ecbe481ce064..f3d3e48aff26 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -157,6 +157,7 @@ config ARM64
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA
 	select MULTI_IRQ_HANDLER
 	select NEED_DMA_MAP_STATE
@@ -232,9 +233,6 @@ config ILLEGAL_POINTER_VALUE
 	hex
 	default 0xdead000000000000
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index b6c3111ec5f9..425217c98a77 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -21,6 +21,7 @@ config HEXAGON
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
+	select LOCKDEP_SUPPORT
 	select ARCH_DISCARD_MEMBLOCK
 	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
@@ -46,9 +47,6 @@ config HEXAGON_PHYS_OFFSET
 config FRAME_POINTER
 	def_bool y
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config EARLY_PRINTK
 	def_bool y
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 238f8b410331..1989ba1d1798 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -31,6 +31,7 @@ config MICROBLAZE
 	select HAVE_OPROFILE
 	select HAVE_PCI
 	select IRQ_DOMAIN
+	select LOCKDEP_SUPPORT
 	select XILINX_INTC
 	select MODULES_USE_ELF_RELA
 	select OF
@@ -77,9 +78,6 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_CSUM
 	def_bool y
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 source "arch/microblaze/Kconfig.platform"
 
 menu "Processor type and features"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d1c89635a459..88792685687c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -76,6 +76,7 @@ config MIPS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
+	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select MODULES_USE_ELF_REL if MODULES
 	select PERF_USE_VMALLOC
@@ -3051,10 +3052,6 @@ endchoice
 
 endmenu
 
-config LOCKDEP_SUPPORT
-	bool
-	default y
-
 config HAVE_LATENCYTOP_SUPPORT
 	bool
 	default y
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 514787c0c469..6cb7632fa5b0 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -28,6 +28,7 @@ config OPENRISC
 	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
+	select LOCKDEP_SUPPORT
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select ARCH_USE_QUEUED_SPINLOCKS
@@ -55,9 +56,6 @@ config NO_IOPORT_MAP
 config GENERIC_CSUM
         def_bool y
 
-config LOCKDEP_SUPPORT
-	def_bool  y
-
 menu "Processor type and features"
 
 choice
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1156021fd4a8..8b9f3639555f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -91,10 +91,6 @@ config PPC_WATCHDOG
 	  seleted via the generic lockup detector menu which is why we
 	  have no standalone config option for it here.
 
-config LOCKDEP_SUPPORT
-	bool
-	default y
-
 config GENERIC_LOCKBREAK
 	bool
 	default y
@@ -213,6 +209,7 @@ config PPC
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 662acc163019..15ccdd04814e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -8,9 +8,6 @@ config ZONE_DMA
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
@@ -165,6 +162,7 @@ config S390
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
+	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_SG_DMA_LENGTH	if PCI
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 840c33df6f0e..932f9329cc5f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -32,6 +32,7 @@ config SUPERH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select MAY_HAVE_SPARSE_IRQ
 	select IRQ_FORCED_THREADING
+	select LOCKDEP_SUPPORT
 	select RTC_LIB
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
@@ -128,9 +129,6 @@ config SYS_SUPPORTS_SMP
 config SYS_SUPPORTS_NUMA
 	bool
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 4f8c3f9dd2c6..e7ded2147230 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -85,6 +85,7 @@ config SPARC64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select HAVE_NMI
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select LOCKDEP_SUPPORT
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select GENERIC_TIME_VSYSCALL
@@ -109,10 +110,6 @@ config ARCH_ATU
 	bool
 	default y if SPARC64
 
-config LOCKDEP_SUPPORT
-	bool
-	default y if SPARC64
-
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y if SPARC64
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f1b7bf7cc66e..49c289cb95e8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -17,6 +17,7 @@ config UML
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
+	select LOCKDEP_SUPPORT
 	select STACKTRACE
 	select STACKTRACE_SUPPORT
 	select TRACE_IRQFLAGS_SUPPORT
@@ -35,10 +36,6 @@ config ISA
 config SBUS
 	bool
 
-config LOCKDEP_SUPPORT
-	bool
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index d7dccc247301..7dd2b9f690b1 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -11,6 +11,7 @@ config UNICORE32
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PCI
+	select LOCKDEP_SUPPORT
 	select VIRT_TO_BUS
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select GENERIC_FIND_FIRST_BIT
@@ -33,9 +34,6 @@ config GENERIC_CSUM
 config NO_IOPORT_MAP
 	bool
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a53d7a4ffd09..aa72acc7f537 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -196,6 +196,7 @@ config X86
 	select HAVE_USER_RETURN_NOTIFIER
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
+	select LOCKDEP_SUPPORT
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
@@ -227,9 +228,6 @@ config ARCH_DEFCONFIG
 	default "arch/x86/configs/i386_defconfig" if X86_32
 	default "arch/x86/configs/x86_64_defconfig" if X86_64
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config MMU
 	def_bool y
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2c4bb92df487..b264a4dff465 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -32,6 +32,7 @@ config XTENSA
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
+	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select RWSEM_XCHGADD_ALGORITHM
@@ -62,9 +63,6 @@ config HZ
 	int
 	default 100
 
-config LOCKDEP_SUPPORT
-	def_bool y
-
 config MMU
 	def_bool n
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..9331914f9598 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1054,6 +1054,9 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config LOCKDEP_SUPPORT
+	bool
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.20.1
