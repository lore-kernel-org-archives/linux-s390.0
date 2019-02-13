Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/11] lib: consolidate the GENERIC_BUG symbol
Date: Wed, 13 Feb 2019 18:40:02 +0100
Message-Id: <20190213174005.28785-9-hch@lst.de>
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

And just let the architectures that want it select the symbol.
Same for GENERIC_BUG_RELATIVE_POINTERS.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig     |  5 +----
 arch/arm64/Kconfig   | 10 ++--------
 arch/c6x/Kconfig     |  5 +----
 arch/hexagon/Kconfig |  5 +----
 arch/parisc/Kconfig  |  6 +-----
 arch/powerpc/Kconfig |  6 +-----
 arch/riscv/Kconfig   | 10 ++--------
 arch/s390/Kconfig    |  8 ++------
 arch/sh/Kconfig      |  5 +----
 arch/x86/Kconfig     | 10 ++--------
 lib/Kconfig          |  6 ++++++
 11 files changed, 20 insertions(+), 56 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96780ab64a2e..c230fb1e09ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
+	select GENERIC_BUG if BUG
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
@@ -256,10 +257,6 @@ config PHYS_OFFSET
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
 config PGTABLE_LEVELS
 	int
 	default 3 if ARM_LPAE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c39dac831f08..913b2ca7ec22 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -85,6 +85,8 @@ config ARM64
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
+	select GENERIC_BUG if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -234,14 +236,6 @@ config ILLEGAL_POINTER_VALUE
 	hex
 	default 0xdead000000000000
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	def_bool y
-	depends on GENERIC_BUG
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index d5f382830f49..19b145ef7d92 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -10,6 +10,7 @@ config C6X
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
 	select GENERIC_ATOMIC64
+	select GENERIC_BUG if BUG
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
@@ -30,10 +31,6 @@ config FPU
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
 config C6X_BIG_KERNEL
 	bool "Build a big kernel"
 	help
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 425217c98a77..5eb4f48506b6 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -14,6 +14,7 @@ config HEXAGON
 	# select GPIOLIB
 	# select HAVE_CLK
 	# select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_BUG if BUG
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
@@ -65,10 +66,6 @@ config GENERIC_IRQ_PROBE
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
 menu "Machine selection"
 
 choice
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fcbc67b6b830..42282b8e086d 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -27,6 +27,7 @@ config PARISC
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_BUG if BUG
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
@@ -85,11 +86,6 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
-config GENERIC_BUG
-	bool
-	default y
-	depends on BUG
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b9f3639555f..1684017fa496 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,6 +142,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
+	select GENERIC_BUG			if BUG
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
@@ -283,11 +284,6 @@ config AUDIT_ARCH
 	bool
 	default y
 
-config GENERIC_BUG
-	bool
-	default y
-	depends on BUG
-
 config SYS_SUPPORTS_APM_EMULATION
 	default y if PMAC_APM_EMU
 	bool
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 732614eb3683..c410ed896567 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,8 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select GENERIC_BUG if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS if 64BIT
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
@@ -66,14 +68,6 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-	select GENERIC_BUG_RELATIVE_POINTERS if 64BIT
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	bool
-
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 15ccdd04814e..2a5c12be633e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -17,12 +17,6 @@ config ARCH_HAS_ILOG2_U64
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_BUG
-	def_bool y if BUG
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	def_bool y
-
 config GENERIC_LOCKBREAK
 	def_bool y if SMP && PREEMPT
 
@@ -103,6 +97,8 @@ config S390
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS2
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
+	select GENERIC_BUG if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES if !SMP
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 01d09a4637d9..92d16cab61f3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -35,6 +35,7 @@ config SUPERH
 	select LOCKDEP_SUPPORT
 	select RTC_LIB
 	select GENERIC_ATOMIC64
+	select GENERIC_BUG if BUG && SUPERH32
 	select GENERIC_IRQ_SHOW
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
@@ -92,10 +93,6 @@ config ARCH_DEFCONFIG
 	default "arch/sh/configs/shx3_defconfig" if SUPERH32
 	default "arch/sh/configs/cayman_defconfig" if SUPERH64
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG && SUPERH32
-
 config GENERIC_CSUM
 	def_bool y
 	depends on SUPERH64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1bd4f19b6b28..f4cb31174e1b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,8 @@ config X86
 	select DCACHE_WORD_ACCESS
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
+	select GENERIC_BUG			if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS	if X86_64
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
@@ -253,14 +255,6 @@ config GENERIC_ISA_DMA
 	def_bool y
 	depends on ISA_DMA_API
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-	select GENERIC_BUG_RELATIVE_POINTERS if X86_64
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	bool
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..a827d214d866 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -615,6 +615,12 @@ config STRING_SELFTEST
 
 endmenu
 
+config GENERIC_BUG
+	bool
+
+config GENERIC_BUG_RELATIVE_POINTERS
+	bool
+
 config GENERIC_LIB_ASHLDI3
 	bool
 
-- 
2.20.1
