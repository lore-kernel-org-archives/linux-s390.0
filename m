Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389281AbfGRD33 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 23:29:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I3S3ca017751
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2019 23:29:27 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tteqmv4vh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2019 23:29:27 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 18 Jul 2019 04:29:27 +0100
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 1/6] x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
Date: Thu, 18 Jul 2019 00:28:53 -0300
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190718032858.28744-2-bauerman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

powerpc is also going to use this feature, so put it in a generic location.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig      | 3 +++
 arch/s390/Kconfig | 4 +---
 arch/x86/Kconfig  | 4 +---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e8d19c3cb91f..8fc285180848 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -935,6 +935,9 @@ config LOCK_EVENT_COUNTS
 	  the chance of application behavior change because of timing
 	  differences. The counts are reported via debugfs.
 
+config ARCH_HAS_MEM_ENCRYPT
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a4ad2733eedf..f43319c44454 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config ARCH_HAS_MEM_ENCRYPT
-        def_bool y
-
 config MMU
 	def_bool y
 
@@ -68,6 +65,7 @@ config S390
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
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
