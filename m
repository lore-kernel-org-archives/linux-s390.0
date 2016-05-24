From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 07/23] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Tue, 24 May 2016 03:04:36 +0300
Message-ID: <1464048292-30136-8-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: kilobyte@angband.pl, pinskia@gmail.com, szabolcs.nagy@arm.com, Nathan_Lynch@mentor.com, heiko.carstens@de.ibm.com, agraf@suse.de, geert@linux-m68k.org, Prasun.Kapoor@caviumnetworks.com, klimov.linux@gmail.com, broonie@kernel.org, ynorov@caviumnetworks.com, schwidefsky@de.ibm.com, bamvor.zhangjian@huawei.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

All new 32-bit architectures should have 64-bit off_t type, but existing
architectures has 32-bit ones.

To handle it, new config option is added to arch/Kconfig that defaults
ARCH_32BIT_OFF_T to be disabled for non-64 bit architectures. All existing
32-bit architectures enable it explicitly here.

New option affects force_o_largefile() behaviour. Namely, if off_t is
64-bits long, we have no reason to reject user to open big files.

Note that even if architectures has only 64-bit off_t in the kernel
(arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
a libc may use 32-bit off_t, and therefore want to limit the file size
to 4GB unless specified differently in the open flags.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/Kconfig            | 4 ++++
 arch/arc/Kconfig        | 1 +
 arch/arm/Kconfig        | 1 +
 arch/blackfin/Kconfig   | 1 +
 arch/cris/Kconfig       | 1 +
 arch/frv/Kconfig        | 1 +
 arch/h8300/Kconfig      | 1 +
 arch/hexagon/Kconfig    | 1 +
 arch/m32r/Kconfig       | 1 +
 arch/m68k/Kconfig       | 1 +
 arch/metag/Kconfig      | 1 +
 arch/microblaze/Kconfig | 1 +
 arch/mips/Kconfig       | 1 +
 arch/mn10300/Kconfig    | 1 +
 arch/nios2/Kconfig      | 1 +
 arch/openrisc/Kconfig   | 1 +
 arch/parisc/Kconfig     | 1 +
 arch/powerpc/Kconfig    | 1 +
 arch/score/Kconfig      | 1 +
 arch/sh/Kconfig         | 1 +
 arch/sparc/Kconfig      | 1 +
 arch/tile/Kconfig       | 1 +
 arch/unicore32/Kconfig  | 1 +
 arch/x86/Kconfig        | 1 +
 arch/x86/um/Kconfig     | 1 +
 arch/xtensa/Kconfig     | 1 +
 include/linux/fcntl.h   | 2 +-
 27 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 92fcbd4..a2b7cf3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -230,6 +230,10 @@ config ARCH_THREAD_INFO_ALLOCATOR
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
 
+config ARCH_32BIT_OFF_T
+	bool
+	depends on !64BIT
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index a876743..13f66cc 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,6 +9,7 @@
 config ARC
 	def_bool y
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
+	select ARCH_32BIT_OFF_T
 	select BUILDTIME_EXTABLE_SORT
 	select COMMON_CLK
 	select CLONE_BACKWARDS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2..efe3ca2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index a63c122..ef4368e 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -12,6 +12,7 @@ config RWSEM_XCHGADD_ALGORITHM
 
 config BLACKFIN
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index e086f9e..5bc9203 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -50,6 +50,7 @@ config LOCKDEP_SUPPORT
 config CRIS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index eefd9a4..2f14904 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -1,6 +1,7 @@
 config FRV
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_PERF_EVENTS
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 986ea84..8c221f1 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,5 +1,6 @@
 config H8300
         def_bool y
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 57298e7..df84602 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -3,6 +3,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index c82b292..7866bca 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -1,6 +1,7 @@
 config M32R
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select INIT_ALL_POSSIBLE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 498b567..e9897e4 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -1,6 +1,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index a0fa88d..5b7620a 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -1,5 +1,6 @@
 config METAG
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select EMBEDDED
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3d793b5..bdb0f83 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2018c2b..079a6d2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1,6 +1,7 @@
 config MIPS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 06ddb55..bc1aae5 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -1,5 +1,6 @@
 config MN10300
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_OPROFILE
 	select HAVE_UID16
 	select GENERIC_IRQ_SHOW
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4375554..a38fc38 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,5 +1,6 @@
 config NIOS2
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CLKSRC_OF
 	select GENERIC_ATOMIC64
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e118c02..0271714 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -5,6 +5,7 @@
 
 config OPENRISC
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 88cfaa8..affad75 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -1,5 +1,6 @@
 config PARISC
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c0..2c7a795 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -85,6 +85,7 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 366e1b5..bc7bc7a 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -2,6 +2,7 @@ menu "Machine selection"
 
 config SCORE
        def_bool y
+       select ARCH_32BIT_OFF_T
        select GENERIC_IRQ_SHOW
        select GENERIC_IOMAP
        select GENERIC_ATOMIC64
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ed20fc..2438390 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -52,6 +52,7 @@ config SUPERH
 
 config SUPERH32
 	def_bool ARCH = "sh"
+	select ARCH_32BIT_OFF_T
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 57ffaf2..c88b82d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -45,6 +45,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 8171930..f9d61e7 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -3,6 +3,7 @@
 
 config TILE
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select HAVE_PERF_EVENTS
 	select USE_PMC if PERF_EVENTS
 	select HAVE_DMA_API_DEBUG
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index e5602ee..b995104 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -1,6 +1,7 @@
 config UNICORE32
 	def_bool y
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_32BIT_OFF_T
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_MEMBLOCK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2dc18605..3628b14 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -20,6 +20,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
+	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index ed56a1c..8436bcd 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -21,6 +21,7 @@ config 64BIT
 config X86_32
 	def_bool !64BIT
 	select HAVE_AOUT
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index e832d3e..b68de31 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 76ce329..46960a1 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -5,7 +5,7 @@
 
 
 #ifndef force_o_largefile
-#define force_o_largefile() (BITS_PER_LONG != 32)
+#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
 
 #if BITS_PER_LONG == 32
-- 
2.5.0
