Return-Path: <linux-arch-owner@vger.kernel.org>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] atomic64: No need for CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
Date: Thu, 8 Sep 2016 09:28:18 -0700
Message-ID: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160908162818.t3OqEvKozGR2d779TZ3_JADpo_O2fObfN6ySlFFfT6Y@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@mellanox.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Matthew Wilcox <willy@linux.intel.com>, Alexander Potapenko <glider@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ming Lin <ming.l@ssi.samsung.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This came to light when implementing native 64-bit atomics for ARCv2.

The atomic64 self-test code uses CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
to check whether atomic64_dec_if_positive() is available.
It seems it was needed when not every arch defined it.
However as of current code the Kconfig option seems needless

- for CONFIG_GENERIC_ATOMIC64 it is auto-enabled in lib/Kconfig and a
  generic definition of API is present lib/atomic64.c
- arches with native 64-bit atomics select it in arch/*/Kconfig and
  define the API in their headers

So I see no point in keeping the Kconfig option

Compile tested for 2 representatives:
 - blackfin (CONFIG_GENERIC_ATOMIC64)
 - x86 (!CONFIG_GENERIC_ATOMIC64)

Also logistics wise it seemed simpler to just do this in 1 patch vs.
splitting per arch - but I can break it up if maintainer feel that
is better to avoid conflicts.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthew Wilcox <willy@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ming Lin <ming.l@ssi.samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/alpha/Kconfig   | 1 -
 arch/arm/Kconfig     | 1 -
 arch/arm64/Kconfig   | 1 -
 arch/mips/Kconfig    | 1 -
 arch/parisc/Kconfig  | 1 -
 arch/powerpc/Kconfig | 1 -
 arch/s390/Kconfig    | 1 -
 arch/sparc/Kconfig   | 1 -
 arch/tile/Kconfig    | 1 -
 arch/x86/Kconfig     | 1 -
 lib/Kconfig          | 3 ---
 lib/atomic64_test.c  | 4 ----
 12 files changed, 17 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7f312d80b43b..0e49d39ea74a 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -15,7 +15,6 @@ config ALPHA
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select AUDIT_ARCH
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48bb7ec..2a50957c7bfb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,7 +1,6 @@
 config ARM
 	bool
 	default y
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f586f1..3df2ca7efbcc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -6,7 +6,6 @@ config ARM64
 	select ACPI_MCFG if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 26388562e300..5bbea197c220 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -30,7 +30,6 @@ config MIPS
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select RTC_LIB if !MACH_LOONGSON64
 	select GENERIC_ATOMIC64 if !64BIT
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DMA_API_DEBUG
 	select GENERIC_IRQ_PROBE
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index cd8778103165..9e40b52c0721 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -15,7 +15,6 @@ config PARISC
 	select BUILDTIME_EXTABLE_SORT
 	select HAVE_PERF_EVENTS
 	select GENERIC_ATOMIC64 if !64BIT
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select BROKEN_RODATA
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab2ce08..18d1b42cf545 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -113,7 +113,6 @@ config PPC
 	select HAVE_DEBUG_KMEMLEAK
 	select ARCH_HAS_SG_CHAIN
 	select GENERIC_ATOMIC64 if PPC32
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e751fe25d6ab..af52b07efde2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -67,7 +67,6 @@ config DEBUG_RODATA
 
 config S390
 	def_bool y
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 59b09600dd32..bfedbe0cb7b2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -22,7 +22,6 @@ config SPARC
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_EXIT_THREAD
 	select SYSCTL_EXCEPTION_TRACE
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select RTC_CLASS
 	select RTC_DRV_M48T59
 	select RTC_SYSTOHC
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 4820a02838ac..12eda5440c93 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -3,7 +3,6 @@
 
 config TILE
 	def_bool y
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c580d8c33562..0cf609998550 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -23,7 +23,6 @@ config X86
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/lib/Kconfig b/lib/Kconfig
index d79909dc01ec..0e74df3c5441 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -457,9 +457,6 @@ config NLATTR
 config GENERIC_ATOMIC64
        bool
 
-config ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
-	def_bool y if GENERIC_ATOMIC64
-
 config LRU_CACHE
 	tristate
 
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index dbb369145dda..46042901130f 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -213,7 +213,6 @@ static __init void test_atomic64(void)
 	r += one;
 	BUG_ON(v.counter != r);
 
-#ifdef CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	INIT(onestwos);
 	BUG_ON(atomic64_dec_if_positive(&v) != (onestwos - 1));
 	r -= one;
@@ -226,9 +225,6 @@ static __init void test_atomic64(void)
 	INIT(-one);
 	BUG_ON(atomic64_dec_if_positive(&v) != (-one - one));
 	BUG_ON(v.counter != r);
-#else
-#warning Please implement atomic64_dec_if_positive for your architecture and select the above Kconfig symbol
-#endif
 
 	INIT(onestwos);
 	BUG_ON(!atomic64_inc_not_zero(&v));
-- 
2.7.4
