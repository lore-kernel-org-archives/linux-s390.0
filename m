Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069053;
	b=lwyIlB0J9BfUFDpk9LGYllab8k15/cUqDWMs8paiH1T7ZMDVbgYh032Yo93I1m4n1EUA
	 /EYhfNZU41sJBUEhRmCW9YzaUQVOgoZ6cRxJhbnhbHe8BSXqHoITWY+KjVEhI8bslLQyG
	 w7QTusdUxAFtou/u1ATHzf46t0Gx/jJHsspeuEO+XMczld2nAndgYELR8QMfPktMaLd7W
	 lOLndPU4hazcy9z4Y2KskmTi0MQFyyLI8UHNmA2M2ilzyUJfe0CMxSqnUy3WTzFxnh7m8
	 rKgI6FQV8gM1oy1TWnABWAjd1GHGYj2WzN10lj3zfwl0JtPWSdVHNfTCSKfKMLE8Vsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069053;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=f/MOHsSisa2L7BXtNJryTv0nLjyVbG8gOduAFuv2I2s=;
	b=R9UWioZxqW0Fve6+8FX3CXeIvK+jPcVKBimmoPmuraKMO5zrjyx6N0L8BSYwKZi4n97/
	 vw5uRycTXepK0QDw+8I3G2q8+WtPGaUKltnQa0bB4wmXzP7OWfCYHhccP7TcuIgM02ZMC
	 qKo6fr80np+EwItpcnx6Hiic5aYR45Wx9175VOxiOSJT1Y66cpxDonMx78Db00VLSkrOI
	 9PAk6rMSSyVVlH7POlQuzVz4uk2bipZtttRzPQ+v3wOy+CX7h1LgooMgMWQtaa9Ijf1Nu
	 ZWR1sYp6IZUEZV/95DTuA+HRZZSRhz9Kvok/CfPX8Fa0/x8T4he7kme1s1z8UVqJ/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9dEp54X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C65606A320;
	Thu, 19 Nov 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9dEp54X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B21F000C4;
	Thu, 19 Nov 2026 06:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069053;
	bh=f/MOHsSisa2L7BXtNJryTv0nLjyVbG8gOduAFuv2I2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k9dEp54XOJagevXf++wBigo2DaB6rNCzUaDXIQks9+X6B+NNJUB/lV0qo1ul8FOJV
	 t7xZkQNiEBUYS18SPEyCdR7/agkpKb5ipbp01/B1CSVqJEbqikamOlgmXVLKpsEgVR
	 CjXQFuYb8jEH3ySdNYVQVHhkHLmvVoxBGH6e3r/AkfuBY0JYCs8esj14DqzE/opXAv
	 sbMOY2YHvc+wp2ABTD2U3UjSXZQCznT2HH3PtDbGkY0CcsOHtoBPaUpkrdEM5tFE1F
	 44YKj3G6yjUPnEA2ha+skDJ3B1Ed314W8WZz8zUyfvS2e+Ty0iWM0gf/uruaDLUtWS
	 g2hLIJS235SGA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 19 Nov 2026 08:16:58 +0200
Subject: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
 Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, 
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev
X-Mailer: b4 0.16.1-dev

The options that let an architecture opt in to kexec and crash dump
features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
defined in each architecture's Kconfig as def_bool, and most of them are
copied over several architectures.

Declare these options once in kernel/Kconfig.kexec next to the options
that depend on them, similarly to how mm/Kconfig does it, and make the
architectures select them instead.

Selection conditions are preserved, so there is no functional change.

Acked-by: Baoquan He <baoquan.he@linux.dev>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm/Kconfig       | 12 +++---------
 arch/arm64/Kconfig     | 36 +++++++++---------------------------
 arch/loongarch/Kconfig | 20 +++++---------------
 arch/m68k/Kconfig      |  4 +---
 arch/mips/Kconfig      | 12 +++---------
 arch/parisc/Kconfig    |  8 ++------
 arch/powerpc/Kconfig   | 30 +++++++-----------------------
 arch/riscv/Kconfig     | 28 +++++++---------------------
 arch/s390/Kconfig      | 28 ++++++----------------------
 arch/sh/Kconfig        | 16 ++++------------
 arch/x86/Kconfig       | 48 ++++++++++++------------------------------------
 kernel/Kconfig.kexec   | 42 ++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 101 insertions(+), 183 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0cc289a7184ab..afb6cc0995e57 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,6 +4,7 @@ config ARM
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
+	select ARCH_DEFAULT_CRASH_DUMP
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CACHE_LINE_SIZE if OF
 	select ARCH_HAS_CC_CAN_LINK
@@ -41,7 +42,9 @@ config ARM
 	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI
+	select ARCH_SUPPORTS_CRASH_DUMP
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
+	select ARCH_SUPPORTS_KEXEC if (!SMP || PM_SLEEP_SMP) && MMU
 	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
@@ -1584,9 +1587,6 @@ config XIP_DEFLATED_DATA
 	  copied, saving some precious ROM space. A possible drawback is a
 	  slightly longer boot delay.
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool (!SMP || PM_SLEEP_SMP) && MMU
-
 config ATAGS_PROC
 	bool "Export atags in procfs"
 	depends on ATAGS && KEXEC
@@ -1595,12 +1595,6 @@ config ATAGS_PROC
 	  Should the atags used to boot the kernel be exported in an "atags"
 	  file in procfs. Useful with kexec.
 
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool y
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
 	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9b08b2457a555..c47a2e8d781b3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,8 @@ config ARM64
 	select ARCH_HAS_CHECK_WX
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_DEFAULT_CRASH_DUMP
+	select ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
@@ -30,6 +32,7 @@ config ARM64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION if CRASH_RESERVE
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
@@ -77,11 +80,17 @@ config ARM64
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_CRASH_DUMP
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
+	select ARCH_SUPPORTS_KEXEC if PM_SLEEP_SMP
+	select ARCH_SUPPORTS_KEXEC_FILE
+	select ARCH_SUPPORTS_KEXEC_HANDOVER
+	select ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
+	select ARCH_SUPPORTS_KEXEC_SIG
 	select ARCH_SUPPORTS_RMM
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SCHED_SMT
@@ -1769,38 +1778,11 @@ config PARAVIRT_TIME_ACCOUNTING
 
 	  If in doubt, say N here.
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool PM_SLEEP_SMP
-
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool y
-
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 
-config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
-	def_bool y
-
-config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_HANDOVER
-	def_bool y
-
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool y
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
-config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-	def_bool CRASH_RESERVE
-
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b5ed4881d3c01..f7738e7b829de 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_DEFAULT_CRASH_DUMP if 64BIT
 	select ARCH_NEEDS_DEFER_KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
@@ -20,6 +21,7 @@ config LOONGARCH
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
+	select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION if CRASH_RESERVE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KERNEL_FPU_SUPPORT if 64BIT && CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
@@ -63,8 +65,11 @@ config LOONGARCH
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_CRASH_DUMP if 64BIT
 	select ARCH_SUPPORTS_HUGETLBFS if 64BIT
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
+	select ARCH_SUPPORTS_KEXEC
+	select ARCH_SUPPORTS_KEXEC_FILE if 64BIT
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
@@ -677,12 +682,6 @@ config CPU_HAS_PREFETCH
 	bool
 	default y
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool 64BIT
-
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool 64BIT
 	depends on KEXEC_FILE
@@ -690,20 +689,11 @@ config ARCH_SELECTS_KEXEC_FILE
 	select RELOCATABLE
 	select HAVE_IMA_KEXEC if IMA
 
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool 64BIT
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool 64BIT
-
 config ARCH_SELECTS_CRASH_DUMP
 	def_bool 64BIT
 	depends on CRASH_DUMP
 	select RELOCATABLE
 
-config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-	def_bool CRASH_RESERVE
-
 config RELOCATABLE
 	bool "Relocatable kernel"
 	depends on 64BIT
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index eb84c3af92c02..0142c37c23229 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -12,6 +12,7 @@ config M68K
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select ARCH_SUPPORTS_KEXEC if (M68KCLASSIC || SUN3) && MMU
 	select ARCH_USE_MEMTEST if MMU_MOTOROLA
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
@@ -100,9 +101,6 @@ config MMU_SUN3
 	def_bool MMU && SUN3
 	select HAVE_PAGE_SIZE_8KB
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool (M68KCLASSIC || SUN3) && MMU
-
 config BOOTINFO_PROC
 	bool "Export bootinfo in procfs"
 	depends on KEXEC && (M68KCLASSIC || SUN3)
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dac3ec5120a34..e275d9d13f6a2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_DEFAULT_CRASH_DUMP
 	select ARCH_HAS_CC_CAN_LINK
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT
@@ -25,7 +26,9 @@ config MIPS
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_SUPPORTS_CRASH_DUMP
 	select ARCH_SUPPORTS_HUGETLBFS if CPU_SUPPORTS_HUGEPAGES
+	select ARCH_SUPPORTS_KEXEC
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_LD_ORPHAN_WARN
@@ -2871,15 +2874,6 @@ config HZ
 config SCHED_HRTICK
 	def_bool HIGH_RES_TIMERS
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool y
-
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool y
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded"
 	default "0xffffffff84000000"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 77f67028ad89c..aec3078e365b4 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -20,6 +20,8 @@ config PARISC
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SPLIT_ARG64 if !64BIT
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
+	select ARCH_SUPPORTS_KEXEC
+	select ARCH_SUPPORTS_KEXEC_FILE
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_STACKWALK
 	select ARCH_HAS_CACHE_LINE_SIZE
@@ -373,12 +375,6 @@ config NR_CPUS
 
 endmenu
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool y
-
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3b6cd6556069..179b8674e8d87 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -122,6 +122,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_DEFAULT_CRASH_DUMP		if !PPC_BOOK3S_32
 	select ARCH_NEEDS_DEFER_KASAN		if PPC_RADIX_MMU
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
@@ -136,6 +137,7 @@ config PPC
 	select ARCH_HAS_DMA_OPS			if PPC64
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION	if CRASH_RESERVE
 	select ARCH_HAS_GIGANTIC_PAGE		if ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC64 && PPC_FPU
@@ -169,8 +171,13 @@ config PPC
 	select ARCH_SPLIT_ARG64			if PPC32
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_CRASH_DUMP		if PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
+	select ARCH_SUPPORTS_CRASH_HOTPLUG	if PPC64
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
 	select ARCH_SUPPORTS_HUGE_PFNMAP	if PPC_BOOK3S_64 && TRANSPARENT_HUGEPAGE
+	select ARCH_SUPPORTS_KEXEC		if PPC_BOOK3S || PPC_E500 || (44x && !SMP)
+	select ARCH_SUPPORTS_KEXEC_FILE		if PPC64
+	select ARCH_SUPPORTS_KEXEC_PURGATORY
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if !HUGETLB_PAGE
 	select ARCH_SUPPORTS_SCHED_MC		if SMP
 	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
@@ -627,15 +634,6 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
 	default "y" if PPC_POWERNV
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
-
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool PPC64
-
-config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool y
-
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
@@ -701,25 +699,11 @@ config RELOCATABLE_TEST
 	  loaded at, which tends to be non-zero and therefore test the
 	  relocation code.
 
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
-
-config ARCH_DEFAULT_CRASH_DUMP
-	bool
-	default y if !PPC_BOOK3S_32
-
 config ARCH_SELECTS_CRASH_DUMP
 	def_bool y
 	depends on CRASH_DUMP
 	select RELOCATABLE if PPC64 || 44x || PPC_85xx
 
-config ARCH_SUPPORTS_CRASH_HOTPLUG
-	def_bool y
-	depends on PPC64
-
-config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-	def_bool CRASH_RESERVE
-
 config FA_DUMP
 	bool "Firmware-assisted dump"
 	depends on CRASH_DUMP && PPC64 && (PPC_RTAS || PPC_POWERNV)
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e7891a2a89da6..3fc73c99d06f1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -18,6 +18,7 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_RIMT if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ARCH_DEFAULT_CRASH_DUMP
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP
@@ -35,6 +36,7 @@ config RISCV
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION	if CRASH_RESERVE
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_KCOV
@@ -65,9 +67,14 @@ config RISCV
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI
+	select ARCH_SUPPORTS_CRASH_DUMP
+	select ARCH_SUPPORTS_CRASH_HOTPLUG
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
+	select ARCH_SUPPORTS_KEXEC
+	select ARCH_SUPPORTS_KEXEC_FILE		if 64BIT
+	select ARCH_SUPPORTS_KEXEC_PURGATORY	if 64BIT
 	select ARCH_SUPPORTS_LTO_CLANG if CMODEL_MEDANY
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
@@ -1105,38 +1112,17 @@ config RISCV_BOOT_SPINWAIT
 
 	  If unsure what to do here, say N.
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool y
-
 config ARCH_SELECTS_KEXEC
 	def_bool y
 	depends on KEXEC
 	select HOTPLUG_CPU if SMP
 
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool 64BIT
-
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 	select KEXEC_ELF
 
-config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool ARCH_SUPPORTS_KEXEC_FILE
-
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool y
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
-config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-	def_bool CRASH_RESERVE
-
-config ARCH_SUPPORTS_CRASH_HOTPLUG
-	def_bool y
-
 config COMPAT
 	bool "Kernel support for 32-bit U-mode"
 	default 64BIT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7138d923d86f8..3a4ad71b8364d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -83,6 +83,7 @@ config S390
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	select ARCH_DEFAULT_CRASH_DUMP
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_PMD_SOFTLEAVES if TRANSPARENT_HUGEPAGE
@@ -150,9 +151,14 @@ config S390
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI
+	select ARCH_SUPPORTS_CRASH_DUMP
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
+	select ARCH_SUPPORTS_KEXEC
+	select ARCH_SUPPORTS_KEXEC_FILE
+	select ARCH_SUPPORTS_KEXEC_PURGATORY
+	select ARCH_SUPPORTS_KEXEC_SIG
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
@@ -312,28 +318,6 @@ config ARCH_USERFLAGS
 	string
 	default "-m64"
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool y
-
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool y
-	help
-	  Refer to <file:Documentation/arch/s390/zfcpdump.rst> for more details on this.
-	  This option also enables s390 zfcpdump.
-	  See also <file:Documentation/arch/s390/zfcpdump.rst>
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
 menu "Processor type and features"
 
 config HAVE_MARCH_Z10_FEATURES
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5512f446eed16..a12397bfa53be 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,6 +2,7 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_DEFAULT_CRASH_DUMP
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
@@ -15,6 +16,9 @@ config SUPERH
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_NEED_CMPXCHG_1_EMU
+	select ARCH_SUPPORTS_CRASH_DUMP if BROKEN_ON_SMP
+	select ARCH_SUPPORTS_KEXEC if MMU
+	select ARCH_SUPPORTS_KEXEC_JUMP
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
@@ -534,18 +538,6 @@ menu "Kernel features"
 
 source "kernel/Kconfig.hz"
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool MMU
-
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool BROKEN_ON_SMP
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_JUMP
-	def_bool y
-
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default MEMORY_START
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179b..1a2c84604a073 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -66,6 +66,7 @@ config X86
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	select ARCH_DEFAULT_CRASH_DUMP
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
@@ -88,6 +89,7 @@ config X86
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION	if CRASH_RESERVE
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
@@ -129,6 +131,16 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_CFI		if X86_64
 	select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG
+	select ARCH_SUPPORTS_CRASH_DUMP		if X86_64 || (X86_32 && HIGHMEM)
+	select ARCH_SUPPORTS_CRASH_HOTPLUG
+	select ARCH_SUPPORTS_KEXEC
+	select ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
+	select ARCH_SUPPORTS_KEXEC_FILE		if X86_64
+	select ARCH_SUPPORTS_KEXEC_HANDOVER	if X86_64
+	select ARCH_SUPPORTS_KEXEC_JUMP
+	select ARCH_SUPPORTS_KEXEC_PURGATORY
+	select ARCH_SUPPORTS_KEXEC_SIG
+	select ARCH_SUPPORTS_KEXEC_SIG_FORCE
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
@@ -1948,47 +1960,11 @@ config EFI_RUNTIME_MAP
 
 source "kernel/Kconfig.hz"
 
-config ARCH_SUPPORTS_KEXEC
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool X86_64
-
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 
-config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_SIG_FORCE
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_JUMP
-	def_bool y
-
-config ARCH_SUPPORTS_KEXEC_HANDOVER
-	def_bool X86_64
-
-config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool X86_64 || (X86_32 && HIGHMEM)
-
-config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
-
-config ARCH_SUPPORTS_CRASH_HOTPLUG
-	def_bool y
-
-config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-	def_bool CRASH_RESERVE
-
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index a97ed9605602f..af03cc773145b 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -2,6 +2,9 @@
 
 menu "Kexec and crash features"
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	bool
+
 config CRASH_RESERVE
 	bool
 
@@ -17,6 +20,9 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config ARCH_SUPPORTS_KEXEC
+	bool
+
 config KEXEC
 	bool "Enable kexec system call"
 	depends on ARCH_SUPPORTS_KEXEC
@@ -35,6 +41,15 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config ARCH_SUPPORTS_KEXEC_FILE
+	bool
+
+config ARCH_SUPPORTS_KEXEC_PURGATORY
+	bool
+
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	bool
+
 config KEXEC_FILE
 	bool "Enable kexec file based system call"
 	depends on ARCH_SUPPORTS_KEXEC_FILE
@@ -46,6 +61,9 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by kexec system call.
 
+config ARCH_SUPPORTS_KEXEC_SIG
+	bool
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on ARCH_SUPPORTS_KEXEC_SIG
@@ -60,6 +78,9 @@ config KEXEC_SIG
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
+config ARCH_SUPPORTS_KEXEC_SIG_FORCE
+	bool
+
 config KEXEC_SIG_FORCE
 	bool "Require a valid signature in kexec_file_load() syscall"
 	depends on ARCH_SUPPORTS_KEXEC_SIG_FORCE
@@ -68,6 +89,12 @@ config KEXEC_SIG_FORCE
 	  This option makes kernel signature verification mandatory for
 	  the kexec_file_load() syscall.
 
+config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
+	bool
+
+config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
+	bool
+
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support (ARM)"
 	default ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
@@ -77,6 +104,9 @@ config KEXEC_IMAGE_VERIFY_SIG
 	help
 	  Enable Image signature verification support.
 
+config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
+	bool
+
 config KEXEC_BZIMAGE_VERIFY_SIG
 	bool "Enable bzImage signature verification support"
 	depends on ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
@@ -86,6 +116,9 @@ config KEXEC_BZIMAGE_VERIFY_SIG
 	help
 	  Enable bzImage signature verification support.
 
+config ARCH_SUPPORTS_KEXEC_JUMP
+	bool
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on ARCH_SUPPORTS_KEXEC_JUMP
@@ -94,6 +127,12 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config ARCH_SUPPORTS_CRASH_DUMP
+	bool
+
+config ARCH_DEFAULT_CRASH_DUMP
+	bool
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
@@ -144,6 +183,9 @@ config CRASH_DUMP_KUNIT_TEST
 
 	  If unsure, say N.
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	bool
+
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
 	default y

-- 
2.53.0

