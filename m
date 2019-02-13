Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/11] init: consolidate the GENERIC_CALIBRATE_DELAY symbol
Date: Wed, 13 Feb 2019 18:40:01 +0100
Message-Id: <20190213174005.28785-8-hch@lst.de>
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

Add one definition to init/Kconfig and let the architectures select it
if supported.  The only complication is xtensa, where it is a user
visible option - we introduce a xtensa-specific symbol instead to work
around this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig      | 5 +----
 arch/arc/Kconfig        | 4 +---
 arch/arm/Kconfig        | 5 +----
 arch/arm64/Kconfig      | 4 +---
 arch/c6x/Kconfig        | 4 +---
 arch/csky/Kconfig       | 4 +---
 arch/ia64/Kconfig       | 5 +----
 arch/m68k/Kconfig       | 5 +----
 arch/microblaze/Kconfig | 4 +---
 arch/mips/Kconfig       | 5 +----
 arch/nds32/Kconfig      | 4 +---
 arch/nios2/Kconfig      | 4 +---
 arch/parisc/Kconfig     | 5 +----
 arch/riscv/Kconfig      | 4 +---
 arch/sh/Kconfig         | 3 ---
 arch/sparc/Kconfig      | 5 +----
 arch/um/Kconfig         | 5 +----
 arch/unicore32/Kconfig  | 4 +---
 arch/x86/Kconfig        | 4 +---
 arch/xtensa/Kconfig     | 3 ++-
 init/Kconfig            | 3 +++
 21 files changed, 23 insertions(+), 66 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 474202d89b25..65b5514e5a7f 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -25,6 +25,7 @@ config ALPHA
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select AUDIT_ARCH
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_SMP_IDLE_THREAD
@@ -58,10 +59,6 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config ZONE_DMA
 	bool
 	default y
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index b1d6f297e448..e965383c05d7 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -17,6 +17,7 @@ config ARC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_FIND_FIRST_BIT
@@ -73,9 +74,6 @@ config MMU
 config NO_IOPORT_MAP
 	def_bool y
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d6e7713a71ae..96780ab64a2e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
@@ -184,10 +185,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f3d3e48aff26..c39dac831f08 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -85,6 +85,7 @@ config ARM64
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
@@ -247,9 +248,6 @@ config GENERIC_HWEIGHT
 config GENERIC_CSUM
         def_bool y
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config ZONE_DMA32
 	def_bool y
 
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index f11465554ecf..d5f382830f49 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -10,6 +10,7 @@ config C6X
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
 	select GENERIC_ATOMIC64
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
@@ -26,9 +27,6 @@ config MMU
 config FPU
 	def_bool n
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3c3de7ac95bf..4085ba807e0c 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -11,6 +11,7 @@ config CSKY
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
 	select DW_APB_TIMER_OF
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
@@ -82,9 +83,6 @@ config CPU_NO_USER_BKPT
 	  instruction exception.
 	  In kernel we parse the *regs->pc to determine whether to send SIGTRAP or not.
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8c14b669d194..fc44c046953e 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -34,6 +34,7 @@ config IA64
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
 	select VIRT_TO_BUS
 	select ARCH_DISCARD_MEMBLOCK
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_IRQ_SHOW
@@ -87,10 +88,6 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 	depends on HUGETLB_PAGE
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ace0b2cd5fe..ed03da5430d9 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -14,6 +14,7 @@ config M68K
 	select HAVE_UID16
 	select VIRT_TO_BUS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_STRNCPY_FROM_USER if MMU
@@ -41,10 +42,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config GENERIC_CSUM
 	bool
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 1989ba1d1798..65a44727a7a2 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -13,6 +13,7 @@ config MICROBLAZE
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
 	select GENERIC_ATOMIC64
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IDLE_POLL_SETUP
@@ -72,9 +73,6 @@ config ARCH_HAS_ILOG2_U64
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 88792685687c..530eaf950744 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -19,6 +19,7 @@ config MIPS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
@@ -1044,10 +1045,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index ca62d4f97acb..38135bf98a6f 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -12,6 +12,7 @@ config NDS32
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_ATOMIC64
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
@@ -48,9 +49,6 @@ config NDS32
 	help
 	  Andes(nds32) Linux support.
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config GENERIC_CSUM
         def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3b50689007f5..10320e023594 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -6,6 +6,7 @@ config NIOS2
 	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_PROBE
@@ -31,9 +32,6 @@ config GENERIC_CSUM
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config NO_IOPORT_MAP
 	def_bool y
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 845067133dc2..fcbc67b6b830 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -27,6 +27,7 @@ config PARISC
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
@@ -93,10 +94,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config TIME_LOW_RES
 	bool
 	depends on SMP
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a6d914631d47..732614eb3683 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
@@ -73,9 +74,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	bool
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 932f9329cc5f..01d09a4637d9 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -103,9 +103,6 @@ config GENERIC_CSUM
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-
 config GENERIC_LOCKBREAK
 	def_bool y
 	depends on SMP && PREEMPT
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e7ded2147230..58270c021b01 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -35,6 +35,7 @@ config SPARC
 	select HAVE_EBPF_JIT if SPARC64
 	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
@@ -190,10 +191,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 49c289cb95e8..431a11c9ac51 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -13,6 +13,7 @@ config UML
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
@@ -36,10 +37,6 @@ config ISA
 config SBUS
 	bool
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config HZ
 	int
 	default 100
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 7dd2b9f690b1..52b4d48e351a 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -8,6 +8,7 @@ config UNICORE32
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
 	select GENERIC_ATOMIC64
+	select GENERIC_CALIBRATE_DELAY
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PCI
@@ -43,9 +44,6 @@ config ARCH_HAS_ILOG2_U64
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aa72acc7f537..1bd4f19b6b28 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,7 @@ config X86
 	select DCACHE_WORD_ACCESS
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
+	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
@@ -267,9 +268,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
 
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
 config ARCH_HAS_CPU_RELAX
 	def_bool y
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index b264a4dff465..d02c25184ca0 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -416,8 +416,9 @@ config XTENSA_CPU_CLOCK
 	depends on !XTENSA_CALIBRATE_CCOUNT
 	default 16
 
-config GENERIC_CALIBRATE_DELAY
+config XTENSA_GENERIC_CALIBRATE_DELAY
 	bool "Auto calibration of the BogoMIPS value"
+	select GENERIC_CALIBRATE_DELAY
 	help
 	  The BogoMIPS value can easily be derived from the CPU frequency.
 
diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..b7d5ccd4f44c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -36,6 +36,9 @@ config IRQ_WORK
 config BUILDTIME_EXTABLE_SORT
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+
 config THREAD_INFO_IN_TASK
 	bool
 	help
-- 
2.20.1
