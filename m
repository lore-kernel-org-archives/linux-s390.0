Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE684A23;
	Tue, 17 Dec 2024 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407306; cv=none; b=Dz5tH+PWkH+owqGeRwlQUf9Lf5lpHdp7WGggHPZyXdC0Od6BY/LUjoyHjtzu3wMX+/eVnq1fCTSDArW6PMjB0FwjinjnAtidkjO7a5Hi61Ley2dORbxkd70szuRnEvFOVjJf5mI9lfva+pDLtojC/C0OveOJWo9L+1Hinlg/aPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407306; c=relaxed/simple;
	bh=bSnEOXFRCTRCa26H4csv+FcvXBCngb0EEW7isqrqg9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Due9QwCVxRJ8VnBZWYwGiTm1mfdrD8ChVvr3G/WlMFXlDyxBNrkf7B0mAo3twCKEuCqa8YD5HXUX1ZMWAIWj4GmnrPr97NAAwyn5eFT2BXWERkABD1IuJJ9YpAveiHLRdG2As2+2/bqGbJoCnEpMldDJgY7jgd5msQGYW7FIXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CDA1063;
	Mon, 16 Dec 2024 19:48:48 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C23E3F720;
	Mon, 16 Dec 2024 19:48:13 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: steven.price@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] mm/ptdump: Drop GENERIC_PTDUMP
Date: Tue, 17 Dec 2024 09:18:07 +0530
Message-Id: <20241217034807.2541349-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENERIC_PTDUMP does not guard any code but instead just used for platform's
subscription into core ptdump defined under PTDUMP_CORE, which is selected.
Instead use PTDUMP_CORE for platform subscription and drop GENERIC_PTDUMP.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.13-rc3 and has been tested on arm64, although it
also clears build tests on impacted platforms.

 Documentation/arch/arm64/ptdump.rst       | 1 -
 arch/arm64/Kconfig                        | 2 +-
 arch/arm64/kvm/Kconfig                    | 3 +--
 arch/powerpc/Kconfig                      | 2 +-
 arch/powerpc/configs/mpc885_ads_defconfig | 1 -
 arch/riscv/Kconfig                        | 2 +-
 arch/s390/Kconfig                         | 2 +-
 arch/x86/Kconfig                          | 2 +-
 arch/x86/Kconfig.debug                    | 2 +-
 kernel/configs/debug.config               | 1 -
 mm/Kconfig.debug                          | 8 ++------
 11 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
index 5dcfc5d7cddf..61ca040a885b 100644
--- a/Documentation/arch/arm64/ptdump.rst
+++ b/Documentation/arch/arm64/ptdump.rst
@@ -22,7 +22,6 @@ offlining of memory being accessed by the ptdump code.
 In order to dump the kernel page tables, enable the following
 configurations and mount debugfs::
 
- CONFIG_GENERIC_PTDUMP=y
  CONFIG_PTDUMP_CORE=y
  CONFIG_PTDUMP_DEBUGFS=y
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5..b5479c8b454c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,7 +154,7 @@ config ARM64
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
-	select GENERIC_PTDUMP
+	select PTDUMP_CORE
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index ead632ad01b4..fe17d7f5b061 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -71,8 +71,7 @@ config PTDUMP_STAGE2_DEBUGFS
 	depends on KVM
 	depends on DEBUG_KERNEL
 	depends on DEBUG_FS
-	depends on GENERIC_PTDUMP
-	select PTDUMP_CORE
+	depends on PTDUMP_CORE
 	default n
 	help
 	  Say Y here if you want to show the stage-2 kernel pagetables
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a0ce777f9706..c716f8df10de 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -203,7 +203,7 @@ config PPC
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
-	select GENERIC_PTDUMP
+	select PTDUMP_CORE
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 77306be62e9e..ea6f836407d2 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -78,4 +78,3 @@ CONFIG_DEBUG_VM_PGTABLE=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BDI_SWITCH=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_GENERIC_PTDUMP=y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4a7ca0388c0..05f969729e72 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -111,7 +111,7 @@ config RISCV
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
-	select GENERIC_PTDUMP if MMU
+	select PTDUMP_CORE if MMU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0077969170e8..0e19fe547d84 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -155,7 +155,7 @@ config S390
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_PTDUMP
+	select PTDUMP_CORE
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c4..d84cb2ac93ac 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,7 +173,7 @@ config X86
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ		if SMP
-	select GENERIC_PTDUMP
+	select PTDUMP_CORE
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 74777a97e394..198d7f090b98 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -59,7 +59,7 @@ config EARLY_PRINTK_USB_XDBC
 config EFI_PGT_DUMP
 	bool "Dump the EFI pagetable"
 	depends on EFI
-	select PTDUMP_CORE
+	depends on PTDUMP_CORE
 	help
 	  Enable this if you want to dump the EFI page table before
 	  enabling virtual mode. This can be used to debug miscellaneous
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 20552f163930..8aafd050b754 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -73,7 +73,6 @@ CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_VM_RB=y
 CONFIG_DEBUG_VM_VMACACHE=y
-CONFIG_GENERIC_PTDUMP=y
 CONFIG_KASAN=y
 CONFIG_KASAN_GENERIC=y
 CONFIG_KASAN_INLINE=y
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 41a58536531d..b206e5a11f96 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -187,7 +187,7 @@ config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
 	depends on ARCH_HAS_DEBUG_WX
 	depends on MMU
-	select PTDUMP_CORE
+	depends on PTDUMP_CORE
 	help
 	  Generate a warning if any W+X mappings are found at boot.
 
@@ -212,9 +212,6 @@ config DEBUG_WX
 
 	  If in doubt, say "Y".
 
-config GENERIC_PTDUMP
-	bool
-
 config PTDUMP_CORE
 	bool
 
@@ -222,8 +219,7 @@ config PTDUMP_DEBUGFS
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
 	depends on DEBUG_FS
-	depends on GENERIC_PTDUMP
-	select PTDUMP_CORE
+	depends on PTDUMP_CORE
 	help
 	  Say Y here if you want to show the kernel pagetable layout in a
 	  debugfs file. This information is only useful for kernel developers
-- 
2.30.2

