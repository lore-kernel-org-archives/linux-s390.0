Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/11] tracing: consolidate the TRACE_IRQFLAGS_SUPPORT symbol
Date: Wed, 13 Feb 2019 18:39:59 +0100
Message-Id: <20190213174005.28785-6-hch@lst.de>
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

Add one definition to kernel/trace/Kconfig and let the architectures
select if it supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig              | 4 +---
 arch/arm/Kconfig              | 5 +----
 arch/arm64/Kconfig            | 4 +---
 arch/csky/Kconfig             | 4 +---
 arch/hexagon/Kconfig          | 4 +---
 arch/microblaze/Kconfig       | 1 +
 arch/microblaze/Kconfig.debug | 2 --
 arch/mips/Kconfig             | 1 +
 arch/mips/Kconfig.debug       | 4 ----
 arch/nds32/Kconfig            | 4 +---
 arch/nios2/Kconfig            | 4 +---
 arch/nios2/Kconfig.debug      | 3 ---
 arch/openrisc/Kconfig         | 4 +---
 arch/parisc/Kconfig           | 1 +
 arch/parisc/Kconfig.debug     | 2 --
 arch/powerpc/Kconfig          | 5 +----
 arch/riscv/Kconfig            | 4 +---
 arch/s390/Kconfig             | 1 +
 arch/s390/Kconfig.debug       | 3 ---
 arch/sh/Kconfig               | 1 +
 arch/sh/Kconfig.debug         | 3 ---
 arch/sparc/Kconfig            | 1 +
 arch/sparc/Kconfig.debug      | 4 ----
 arch/um/Kconfig               | 5 +----
 arch/x86/Kconfig              | 1 +
 arch/x86/Kconfig.debug        | 3 ---
 arch/xtensa/Kconfig           | 4 +---
 kernel/trace/Kconfig          | 3 +++
 28 files changed, 22 insertions(+), 63 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e8e3776fc5fa..065fbd55dcc4 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -49,13 +49,11 @@ config ARC
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 	select STACKTRACE_SUPPORT
 	select STACKTRACE
+	select TRACE_IRQFLAGS_SUPPORT
 
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 68a891f3ffa0..1995e1b24506 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -111,6 +111,7 @@ config ARM
 	select RWSEM_XCHGADD_ALGORITHM
 	select STACKTRACE_SUPPORT
 	select SYS_SUPPORTS_APM_EMULATION
+	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
@@ -170,10 +171,6 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default !CPU_V7M
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a6a0bb868369..ecbe481ce064 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -176,6 +176,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select TRACE_IRQFLAGS_SUPPORT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -234,9 +235,6 @@ config ILLEGAL_POINTER_VALUE
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 90279a11fcf7..3c3de7ac95bf 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -46,6 +46,7 @@ config CSKY
 	select PERF_USE_VMALLOC if CPU_CK610
 	select RTC_LIB
 	select TIMER_OF
+	select TRACE_IRQFLAGS_SUPPORT
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
 
@@ -99,9 +100,6 @@ config STACKTRACE_SUPPORT
 config TIME_LOW_RES
 	def_bool y
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config CPU_TLB_SIZE
 	int
 	default "128"	if (CPU_CK610 || CPU_CK807 || CPU_CK810)
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 615693b62ea0..b6c3111ec5f9 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -33,6 +33,7 @@ config HEXAGON
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select RWSEM_XCHGADD_ALGORITHM
+	select TRACE_IRQFLAGS_SUPPORT
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
@@ -54,9 +55,6 @@ config EARLY_PRINTK
 config MMU
 	def_bool y
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index ecccf8651caa..238f8b410331 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -38,6 +38,7 @@ config MICROBLAZE
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
diff --git a/arch/microblaze/Kconfig.debug b/arch/microblaze/Kconfig.debug
index dc2e3c45e8a2..617df4f48a5d 100644
--- a/arch/microblaze/Kconfig.debug
+++ b/arch/microblaze/Kconfig.debug
@@ -1,5 +1,3 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/kconfig-language.txt.
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0645e7b96493..d1c89635a459 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -82,6 +82,7 @@ config MIPS
 	select RTC_LIB
 	select STACKTRACE_SUPPORT
 	select SYSCTL_EXCEPTION_TRACE
+	select TRACE_IRQFLAGS_SUPPORT
 	select VIRT_TO_BUS
 
 menu "Machine selection"
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 0c86b2a2adfc..7727b30a42df 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default y
-
 config EARLY_PRINTK
 	bool "Early printk" if EXPERT
 	depends on SYS_HAS_EARLY_PRINTK
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 65a506fe25a9..ca62d4f97acb 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -40,6 +40,7 @@ config NDS32
 	select RTC_LIB
 	select STACKTRACE_SUPPORT
 	select THREAD_INFO_IN_TASK
+	select TRACE_IRQFLAGS_SUPPORT
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
@@ -60,9 +61,6 @@ config GENERIC_LOCKBREAK
         def_bool y
 	depends on PREEMPT
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config FIX_EARLYCON_MEM
 	def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 715e6c09b4a5..3b50689007f5 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -20,6 +20,7 @@ config NIOS2
 	select OF_EARLY_FLATTREE
 	select SOC_BUS
 	select SPARSE_IRQ
+	select TRACE_IRQFLAGS_SUPPORT
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
 	select ARCH_DISCARD_MEMBLOCK
@@ -39,9 +40,6 @@ config NO_IOPORT_MAP
 config FPU
 	def_bool n
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool n
-
 menu "Kernel features"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
index f1da8a7b17ff..a8bc06e96ef5 100644
--- a/arch/nios2/Kconfig.debug
+++ b/arch/nios2/Kconfig.debug
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config EARLY_PRINTK
 	bool "Activate early kernel debugging"
 	default y
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index addbe1d0dee6..514787c0c469 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -36,6 +36,7 @@ config OPENRISC
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -49,9 +50,6 @@ config GENERIC_HWEIGHT
 config NO_IOPORT_MAP
 	def_bool y
 
-config TRACE_IRQFLAGS_SUPPORT
-        def_bool y
-
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 9288ff6af559..845067133dc2 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -54,6 +54,7 @@ config PARISC
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/parisc/Kconfig.debug b/arch/parisc/Kconfig.debug
index 1478ded0e247..d1558d84eeae 100644
--- a/arch/parisc/Kconfig.debug
+++ b/arch/parisc/Kconfig.debug
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 45d0d69237b1..1156021fd4a8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -91,10 +91,6 @@ config PPC_WATCHDOG
 	  seleted via the generic lockup detector menu which is why we
 	  have no standalone config option for it here.
 
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default y
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
@@ -232,6 +228,7 @@ config PPC
 	select SPARSE_IRQ
 	select STACKTRACE_SUPPORT
 	select SYSCTL_EXCEPTION_TRACE
+	select TRACE_IRQFLAGS_SUPPORT
 	select VIRT_TO_BUS			if !PPC64
 	#
 	# Please keep this list sorted alphabetically.
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f0e87594fc9b..a6d914631d47 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -48,6 +48,7 @@ config RISCV
 	select PCI_MSI if PCI
 	select RISCV_TIMER
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
 
@@ -64,9 +65,6 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index fde5d60aab7e..662acc163019 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -177,6 +177,7 @@ config S390
 	select STACKTRACE_SUPPORT
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_SCALED_CPUTIME
diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
index 190527560b2c..1cae0977b3eb 100644
--- a/arch/s390/Kconfig.debug
+++ b/arch/s390/Kconfig.debug
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config S390_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e77d3befa52a..840c33df6f0e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,6 +50,7 @@ config SUPERH
 	select OLD_SIGACTION
 	select PCI_DOMAINS if PCI
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 010b6c33bbba..4eabecb62329 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config SH_STANDARD_BIOS
 	bool "Use LinuxSH standard BIOS"
 	depends on SUPERH32
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 85c4447fce00..4f8c3f9dd2c6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -46,6 +46,7 @@ config SPARC
 	select LOCKDEP_SMALL if LOCKDEP
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
+	select TRACE_IRQFLAGS_SUPPORT
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 50a918d496c8..6b2bec1888b3 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default y
-
 config DEBUG_DCFLUSH
 	bool "D-cache flush debugging"
 	depends on SPARC64 && DEBUG_KERNEL
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index a88ad4c0c3b4..f1b7bf7cc66e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -19,6 +19,7 @@ config UML
 	select HAVE_GCC_PLUGINS
 	select STACKTRACE
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 
 config MMU
@@ -34,10 +35,6 @@ config ISA
 config SBUS
 	bool
 
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default y
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c5f92cfd5d85..a53d7a4ffd09 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -210,6 +210,7 @@ config X86
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
+	select TRACE_IRQFLAGS_SUPPORT
 	select X86_FEATURE_NAMES		if PROC_FS
 
 config INSTRUCTION_DECODER
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0723dff17e6c..bca2566ef208 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config EARLY_PRINTK_USB
 	bool
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 51cdd270a44d..2c4bb92df487 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -36,6 +36,7 @@ config XTENSA
 	select PERF_USE_VMALLOC
 	select RWSEM_XCHGADD_ALGORITHM
 	select STACKTRACE_SUPPORT
+	select TRACE_IRQFLAGS_SUPPORT
 	select VIRT_TO_BUS
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
@@ -64,9 +65,6 @@ config HZ
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config MMU
 	def_bool n
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 80291d016e21..a349e02e587b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -9,6 +9,9 @@ config STACKTRACE_SUPPORT
 config USER_STACKTRACE_SUPPORT
 	bool
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+
 config NOP_TRACER
 	bool
 
-- 
2.20.1
