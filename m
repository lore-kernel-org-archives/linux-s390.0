Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 1/3] x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
Date: Sat, 13 Jul 2019 01:45:52 -0300
In-Reply-To: <20190713044554.28719-1-bauerman@linux.ibm.com>
References: <20190713044554.28719-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190713044554.28719-2-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

powerpc is also going to use this feature, so put it in a generic location.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/Kconfig      | 3 +++
 arch/s390/Kconfig | 3 ---
 arch/x86/Kconfig  | 4 +---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c47b328eada0..4ef3499d4480 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -927,6 +927,9 @@ config LOCK_EVENT_COUNTS
 	  the chance of application behavior change because of timing
 	  differences. The counts are reported via debugfs.
 
+config ARCH_HAS_MEM_ENCRYPT
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5d8570ed6cab..f820e631bf89 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config ARCH_HAS_MEM_ENCRYPT
-        def_bool y
-
 config MMU
 	def_bool y
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c9f331bb538b..5d3295f2df94 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -68,6 +68,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
@@ -1520,9 +1521,6 @@ config X86_CPA_STATISTICS
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
-config ARCH_HAS_MEM_ENCRYPT
-	def_bool y
-
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
