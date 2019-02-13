Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/11] lib: consolidate the GENERIC_HWEIGHT symbol
Date: Wed, 13 Feb 2019 18:40:04 +0100
Message-Id: <20190213174005.28785-11-hch@lst.de>
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

Introduce a new ARCH_HAS_HWEIGHT symbol for alpha and ia64, and just
default to the generic version otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig      | 5 +----
 arch/arc/Kconfig        | 3 ---
 arch/arm/Kconfig        | 4 ----
 arch/arm64/Kconfig      | 3 ---
 arch/c6x/Kconfig        | 3 ---
 arch/csky/Kconfig       | 3 ---
 arch/h8300/Kconfig      | 3 ---
 arch/hexagon/Kconfig    | 3 ---
 arch/ia64/Kconfig       | 1 +
 arch/m68k/Kconfig       | 4 ----
 arch/microblaze/Kconfig | 3 ---
 arch/mips/Kconfig       | 4 ----
 arch/nds32/Kconfig      | 3 ---
 arch/nios2/Kconfig      | 3 ---
 arch/openrisc/Kconfig   | 3 ---
 arch/parisc/Kconfig     | 4 ----
 arch/powerpc/Kconfig    | 4 ----
 arch/riscv/Kconfig      | 3 ---
 arch/s390/Kconfig       | 3 ---
 arch/sh/Kconfig         | 3 ---
 arch/sparc/Kconfig      | 4 ----
 arch/unicore32/Kconfig  | 3 ---
 arch/x86/Kconfig        | 3 ---
 arch/x86/um/Kconfig     | 3 ---
 arch/xtensa/Kconfig     | 3 ---
 lib/Kconfig             | 7 +++++++
 26 files changed, 9 insertions(+), 79 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 65b5514e5a7f..a549c53563e8 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -2,6 +2,7 @@
 config ALPHA
 	bool
 	default y
+	select ARCH_HAS_HWEIGHT if ALPHA_EV67
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_NO_PREEMPT
@@ -446,10 +447,6 @@ config ALPHA_IRONGATE
 	depends on ALPHA_NAUTILUS
 	default y
 
-config GENERIC_HWEIGHT
-	bool
-	default y if !ALPHA_EV67
-
 config ALPHA_AVANTI
 	bool
 	depends on ALPHA_XL || ALPHA_AVANTI_CH
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 6476404b98b8..8bf4c0f7cc1d 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -72,9 +72,6 @@ config MMU
 config NO_IOPORT_MAP
 	def_bool y
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
 	depends on ARC_MMU_V4
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c230fb1e09ba..b47825767e3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -182,10 +182,6 @@ config ARCH_HAS_BANDGAP
 config FIX_EARLYCON_MEM
 	def_bool y if MMU
 
-config GENERIC_HWEIGHT
-	bool
-	default y
-
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7cc3334aba29..98c3776ccf6b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -237,9 +237,6 @@ config ILLEGAL_POINTER_VALUE
 	hex
 	default 0xdead000000000000
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ZONE_DMA32
 	def_bool y
 
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 19b145ef7d92..c439d2f46af0 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -28,9 +28,6 @@ config MMU
 config FPU
 	def_bool n
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config C6X_BIG_KERNEL
 	bool "Build a big kernel"
 	help
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index c0a49cbd3df0..14a9905e99a4 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -84,9 +84,6 @@ config CPU_NO_USER_BKPT
 	  instruction exception.
 	  In kernel we parse the *regs->pc to determine whether to send SIGTRAP or not.
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config MMU
 	def_bool y
 
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 4f5a1efab822..77ce104bb42e 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -27,9 +27,6 @@ config H8300
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config NO_IOPORT_MAP
 	def_bool y
 
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 7a01f4c5a4f6..fb2996063d5a 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -61,9 +61,6 @@ config MMU
 config GENERIC_IRQ_PROBE
 	def_bool y
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 menu "Machine selection"
 
 choice
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index fc44c046953e..c9eb106b1f4c 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -8,6 +8,7 @@ menu "Processor type and features"
 
 config IA64
 	bool
+	select ARCH_HAS_HWEIGHT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI if (!IA64_HP_SIM)
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 1bf6abaea604..91b150b6572c 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -38,10 +38,6 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	bool
 
-config GENERIC_HWEIGHT
-	bool
-	default y
-
 config TIME_LOW_RES
 	bool
 	default y
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d8907d6f969c..0185ac1f0268 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -71,9 +71,6 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	def_bool n
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 source "arch/microblaze/Kconfig.platform"
 
 menu "Processor type and features"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bd0c9be7e7cf..04e041cac595 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1042,10 +1042,6 @@ source "arch/mips/paravirt/Kconfig"
 
 endmenu
 
-config GENERIC_HWEIGHT
-	bool
-	default y
-
 config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 7b3a36705aa8..979661f0ab51 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -50,9 +50,6 @@ config NDS32
 	help
 	  Andes(nds32) Linux support.
 
-config GENERIC_HWEIGHT
-        def_bool y
-
 config GENERIC_LOCKBREAK
         def_bool y
 	depends on PREEMPT
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 11ef63217ebe..a0485f5f0db0 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -27,9 +27,6 @@ config NIOS2
 	select CPU_NO_EFFICIENT_FFS
 	select ARCH_DISCARD_MEMBLOCK
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config NO_IOPORT_MAP
 	def_bool y
 
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 15d7df402c19..dc026973e6f6 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -46,9 +46,6 @@ config CPU_BIG_ENDIAN
 config MMU
 	def_bool y
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config NO_IOPORT_MAP
 	def_bool y
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 42282b8e086d..7d5ded83c180 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -86,10 +86,6 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
-config GENERIC_HWEIGHT
-	bool
-	default y
-
 config TIME_LOW_RES
 	bool
 	depends on SMP
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a0e9207893c8..8dd4d2b24fdb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -96,10 +96,6 @@ config GENERIC_LOCKBREAK
 	default y
 	depends on SMP && PREEMPT
 
-config GENERIC_HWEIGHT
-	bool
-	default y
-
 config ARCH_HAS_DMA_SET_COHERENT_MASK
         bool
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2b173a48bdbc..0acdd7aaaaea 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -69,9 +69,6 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config PGTABLE_LEVELS
 	int
 	default 3 if 64BIT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2a5c12be633e..9a25e19364f5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -14,9 +14,6 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	def_bool n
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config GENERIC_LOCKBREAK
 	def_bool y if SMP && PREEMPT
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 3d0bd7fbe11a..af6a40af1702 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -94,9 +94,6 @@ config ARCH_DEFCONFIG
 	default "arch/sh/configs/shx3_defconfig" if SUPERH32
 	default "arch/sh/configs/cayman_defconfig" if SUPERH64
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config GENERIC_LOCKBREAK
 	def_bool y
 	depends on SMP && PREEMPT
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 58270c021b01..78135ac357ed 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -187,10 +187,6 @@ config NR_CPUS
 
 source "kernel/Kconfig.hz"
 
-config GENERIC_HWEIGHT
-	bool
-	default y
-
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 9de1d983a99a..e69a8c3232e1 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -38,9 +38,6 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	bool
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f4cb31174e1b..7a9347c7448e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -255,9 +255,6 @@ config GENERIC_ISA_DMA
 	def_bool y
 	depends on ISA_DMA_API
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index f5a8cded3ca4..1628a54af003 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -49,6 +49,3 @@ config ARCH_HAS_SC_SIGNALS
 
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	def_bool !64BIT
-
-config GENERIC_HWEIGHT
-	def_bool y
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d02c25184ca0..ff57afdeda04 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -47,9 +47,6 @@ config XTENSA
 	  with reasonable minimum requirements.  The Xtensa Linux project has
 	  a home page at <http://www.linux-xtensa.org/>.
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
diff --git a/lib/Kconfig b/lib/Kconfig
index bd2e7e74c321..91019f26d0a8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -35,6 +35,13 @@ config RATIONAL
 config GENERIC_CSUM
 	bool
 
+config ARCH_HAS_HWEIGHT
+	bool
+
+config GENERIC_HWEIGHT
+	default y if !ARCH_HAS_HWEIGHT
+	bool
+
 config GENERIC_STRNCPY_FROM_USER
 	bool
 
-- 
2.20.1
