Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfGLFlm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 01:41:42 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 1/3] x86/Kconfig: Move ARCH_HAS_MEM_ENCRYPT to arch/Kconfig
Date: Fri, 12 Jul 2019 02:36:29 -0300
Message-Id: <20190712053631.9814-2-bauerman@linux.ibm.com>
In-Reply-To: <20190712053631.9814-1-bauerman@linux.ibm.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

powerpc and s390 are going to use this feature as well, so put it in a
generic location.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/Kconfig     | 3 +++
 arch/x86/Kconfig | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 12e02a8f9de7..7f4d28da8fe3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -67,6 +67,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
@@ -1500,9 +1501,6 @@ config X86_CPA_STATISTICS
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
-config ARCH_HAS_MEM_ENCRYPT
-	def_bool y
-
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
