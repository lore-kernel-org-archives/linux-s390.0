Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
Date: Wed, 13 Feb 2019 18:39:57 +0100
Message-Id: <20190213174005.28785-4-hch@lst.de>
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

Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
the spinlock version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig      | 8 +-------
 arch/arc/Kconfig        | 3 ---
 arch/arm/Kconfig        | 5 +----
 arch/arm64/Kconfig      | 4 +---
 arch/c6x/Kconfig        | 3 ---
 arch/csky/Kconfig       | 3 ---
 arch/h8300/Kconfig      | 3 ---
 arch/hexagon/Kconfig    | 7 +------
 arch/ia64/Kconfig       | 5 +----
 arch/m68k/Kconfig       | 7 -------
 arch/microblaze/Kconfig | 6 ------
 arch/mips/Kconfig       | 7 -------
 arch/nds32/Kconfig      | 3 ---
 arch/nios2/Kconfig      | 3 ---
 arch/openrisc/Kconfig   | 6 ------
 arch/parisc/Kconfig     | 6 ------
 arch/powerpc/Kconfig    | 8 +-------
 arch/riscv/Kconfig      | 3 ---
 arch/s390/Kconfig       | 7 +------
 arch/sh/Kconfig         | 6 ------
 arch/sparc/Kconfig      | 9 +--------
 arch/unicore32/Kconfig  | 6 ------
 arch/x86/Kconfig        | 4 +---
 arch/x86/um/Kconfig     | 7 +------
 arch/xtensa/Kconfig     | 4 +---
 kernel/Kconfig.locks    | 7 +++++++
 26 files changed, 18 insertions(+), 122 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 584a6e114853..474202d89b25 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -35,6 +35,7 @@ config ALPHA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
+	select RWSEM_XCHGADD_ALGORITHM
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
@@ -49,13 +50,6 @@ config MMU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config ARCH_HAS_ILOG2_U32
 	bool
 	default n
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..c0dd229af534 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -63,9 +63,6 @@ config SCHED_OMIT_FRAME_POINTER
 config GENERIC_CSUM
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool n
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..1ed4c0560b50 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -108,6 +108,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select REFCOUNT_FULL
 	select RTC_LIB
+	select RWSEM_XCHGADD_ALGORITHM
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
@@ -176,10 +177,6 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default !CPU_V7M
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..2f8da4e18a1e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -170,6 +170,7 @@ config ARM64
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
+	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
@@ -238,9 +239,6 @@ config LOCKDEP_SUPPORT
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 456e154674d1..f11465554ecf 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -26,9 +26,6 @@ config MMU
 config FPU
 	def_bool n
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c845f5..90279a11fcf7 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -93,9 +93,6 @@ config GENERIC_HWEIGHT
 config MMU
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config STACKTRACE_SUPPORT
 	def_bool y
 
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 6472a0685470..ba33326e7c54 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -26,9 +26,6 @@ config H8300
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index fb2fbfcfc532..49f364ea18d4 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -31,6 +31,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select RWSEM_XCHGADD_ALGORITHM
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
@@ -64,12 +65,6 @@ config GENERIC_CSUM
 config GENERIC_IRQ_PROBE
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool n
-
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8d7396bd1790..99a629f05de4 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -53,6 +53,7 @@ config IA64
 	select HAVE_ARCH_AUDITSYSCALL
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
+	select RWSEM_XCHGADD_ALGORITHM
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
@@ -83,10 +84,6 @@ config STACKTRACE_SUPPORT
 config GENERIC_LOCKBREAK
 	def_bool n
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
 	depends on HUGETLB_PAGE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index e173ea2ff395..6ace0b2cd5fe 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -31,13 +31,6 @@ config M68K
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 58aff2653d86..d459c70d9a66 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -57,15 +57,9 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config ZONE_DMA
 	def_bool y
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a84c24d894aa..6ad1882a8db9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1037,13 +1037,6 @@ source "arch/mips/paravirt/Kconfig"
 
 endmenu
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index dda1906bba11..6a3c53d05dcd 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -59,9 +59,6 @@ config GENERIC_LOCKBREAK
         def_bool y
 	depends on PREEMPT
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 532343eebf89..715e6c09b4a5 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -39,9 +39,6 @@ config NO_IOPORT_MAP
 config FPU
 	def_bool n
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool n
 
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 09ab59e942ae..9f51da5e4f57 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -42,12 +42,6 @@ config CPU_BIG_ENDIAN
 config MMU
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool n
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 7ca2c3ebad64..8efbeeafb68e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -74,12 +74,6 @@ config GENERIC_LOCKBREAK
 	default y
 	depends on SMP && PREEMPT
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	bool
 	default n
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..2c3ccffbb2ec 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -103,13 +103,6 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_LOCKBREAK
 	bool
 	default y
@@ -239,6 +232,7 @@ config PPC
 	select PCI_DOMAINS			if PCI
 	select PCI_SYSCALL			if PCI
 	select RTC_LIB
+	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS			if !PPC64
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b60f4e3e36f4..fa251310c48c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -69,9 +69,6 @@ config STACKTRACE_SUPPORT
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b09eb3f..7f547d4d835f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -14,12 +14,6 @@ config LOCKDEP_SUPPORT
 config STACKTRACE_SUPPORT
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
@@ -181,6 +175,7 @@ config S390
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
+	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a9c36f95744a..4f8c7472079b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -89,12 +89,6 @@ config ARCH_DEFCONFIG
 	default "arch/sh/configs/shx3_defconfig" if SUPERH32
 	default "arch/sh/configs/cayman_defconfig" if SUPERH64
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG && SUPERH32
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d5dd652fb8cc..60c90e59eb3c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -90,6 +90,7 @@ config SPARC64
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
+	select RWSEM_XCHGADD_ALGORITHM
 
 config ARCH_DEFCONFIG
 	string
@@ -190,14 +191,6 @@ config NR_CPUS
 
 source "kernel/Kconfig.hz"
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y if SPARC32
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y if SPARC64
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c3a41bfe161b..e080087f0762 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -38,12 +38,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..3c98f3f78631 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -202,6 +202,7 @@ config X86
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
+	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
 	select SRCU
 	select SYSCTL_EXCEPTION_TRACE
@@ -269,9 +270,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index f518b4744ff8..f5a8cded3ca4 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -26,18 +26,13 @@ config X86_32
 config X86_64
 	def_bool 64BIT
 	select MODULES_USE_ELF_RELA
+	select RWSEM_XCHGADD_ALGORITHM
 
 config ARCH_DEFCONFIG
 	string
 	default "arch/um/configs/i386_defconfig" if X86_32
 	default "arch/um/configs/x86_64_defconfig" if X86_64
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool 64BIT
-
-config RWSEM_GENERIC_SPINLOCK
-	def_bool !RWSEM_XCHGADD_ALGORITHM
-
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables" if !64BIT
 	default 64BIT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index ce91682770cb..ddd3b02191a6 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -34,6 +34,7 @@ config XTENSA
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
+	select RWSEM_XCHGADD_ALGORITHM
 	select VIRT_TO_BUS
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
@@ -43,9 +44,6 @@ config XTENSA
 	  with reasonable minimum requirements.  The Xtensa Linux project has
 	  a home page at <http://www.linux-xtensa.org/>.
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 84d882f3e299..66ab9fd97c08 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -248,3 +248,10 @@ config ARCH_USE_QUEUED_RWLOCKS
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
 	depends on SMP
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+
+config RWSEM_GENERIC_SPINLOCK
+	default y if !RWSEM_XCHGADD_ALGORITHM
+	bool
-- 
2.20.1
