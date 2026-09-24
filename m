Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58468349CFF;
	Thu, 24 Sep 2026 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230169; cv=none; b=EPgIYHZxzZiCxV+JccEiuKoNUOvxU82r29E6GIbpJtQ4n9wllPV82ZXqNn8c4zq3C16dEOWriNFFan3vRvMLqRoYY7KcKYoDDlonDf0KQ0GIkhDzoYwSKdqgduvpHPjEO+NUdZJQ3E7/NqhRZUpnmkWwufZDR4PHxtyHWJufJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230169; c=relaxed/simple;
	bh=dihbcKvFW699pQaPyqYSLLAFCYqBWIOZ5GkuBbOAeOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4GyTO5KqQR//kJnUZEMnRc/7aMz/0ye3VnA5Nxb0dHt+urd+OIRrsA1+1fr+lVRB+m6oUwuvhv3rTjfPkUpNld4sB4K16Ueg5Ta4SSefRlMO8tTOVlG+kUkaBZaOcsFLC2/j4E45DpkyTEuyx6lj4Zq4HB3ya8jXRrnM5+yknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItBK3aGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItBK3aGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E11F0089E;
	Thu, 24 Sep 2026 06:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230167;
	bh=fa42Z7sJn7eHCCjR0HSX1YHro4gkTrs6qZrrDCPffPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ItBK3aGbHrt4wxvNLXSR46LDg1miA4vs/XlcsDuC253bPnZwWk2jQ7yy8TnL9VaOS
	 oeNxIJrgppPEKVgxMYt3UOZm6t+SvqgmSRLFDyL5BOjo+vEX7Z+HgZCjg+dw2n/4F+
	 SGosF02od0BiOT+e38RoEe5rNPcRtz+MmIZ4xeJ5gBvptDWlET9BSDWIh9jARHFCfw
	 WUN+s3njBjg/xw82BPVgi4XyKoTEu3pQ0RPOkDNore7vMawLL6P3Ig+6aLjIvchgTL
	 KXh/WYWnRU5aEvPuJQjdr0jlAlEpj+vEV0D2iJDrdAWLQq4QPMnasu+2lN1uV8v7ej
	 Kyy7s9L9xeKxg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 4/8] dma: swiotlb: Centralize default pool policy selection
Date: Thu, 24 Sep 2026 11:37:52 +0530
Message-ID: <20260924060756.1325156-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addressing_limited argument to swiotlb_init() describes only one
reason for allocating a default SWIOTLB pool. A pool may also be needed
for memory encryption, unaligned kmalloc bouncing, or swiotlb=force.

Replace the boolean argument with the SWIOTLB_INIT_ADDRESSING_LIMIT flag
and have architectures report their DMA addressing constraints through
the initialization flags.

Introduce SWIOTLB pool policies and select the policy in the core before
allocating the default pool. This separates the decision to allocate a
pool from the policy used to size it, allowing subsequent changes to
centralize minimal and confidential-guest sizing.

Set the shared-pool state before memory attributes are updated. Also move
the pseries secure-guest setup before swiotlb_init() so its initialization
flags are available when the policy is selected.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm/mm/init.c                   |  6 +-
 arch/arm64/mm/init.c                 |  5 +-
 arch/loongarch/kernel/setup.c        |  2 +-
 arch/mips/cavium-octeon/dma-octeon.c |  2 +-
 arch/mips/loongson64/dma.c           |  2 +-
 arch/mips/sibyte/common/dma.c        |  2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |  4 +-
 arch/powerpc/mm/mem.c                | 15 ++++-
 arch/powerpc/platforms/pseries/svm.c | 10 ----
 arch/powerpc/sysdev/fsl_pci.c        |  1 +
 arch/riscv/mm/init.c                 |  6 +-
 arch/s390/mm/init.c                  |  2 +-
 arch/x86/kernel/pci-dma.c            | 16 +++--
 include/linux/swiotlb.h              | 12 ++--
 kernel/dma/swiotlb.c                 | 90 ++++++++++++++++++++++------
 15 files changed, 128 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc1bf04686d..aca97a4e5dcd 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -223,7 +223,11 @@ static inline void poison_init_mem(void *s, size_t count)
 void __init arch_mm_preinit(void)
 {
 #ifdef CONFIG_ARM_LPAE
-	swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
+	unsigned int flags = SWIOTLB_VERBOSE;
+
+	if (max_pfn > arm_dma_pfn_limit)
+		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+	swiotlb_init(flags);
 #endif
 
 #ifdef CONFIG_SA1111
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0842098a279b..f55ebe57b8e1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -351,7 +351,10 @@ void __init arch_mm_preinit(void)
 		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
 	}
 
-	swiotlb_init(true, flags);
+	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
+		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+
+	swiotlb_init(flags);
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 6fa4a22a58fd..02f52f6b2747 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -404,7 +404,7 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	memblock_set_bottom_up(true);
 
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 9fbba6a8fa4c..ca7c37bc070f 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -235,5 +235,5 @@ void __init plat_swiotlb_setup(void)
 #endif
 
 	swiotlb_adjust_size(swiotlbsize);
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 }
diff --git a/arch/mips/loongson64/dma.c b/arch/mips/loongson64/dma.c
index 52801442ea86..5b8056e6c5a8 100644
--- a/arch/mips/loongson64/dma.c
+++ b/arch/mips/loongson64/dma.c
@@ -25,5 +25,5 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 void __init plat_swiotlb_setup(void)
 {
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 }
diff --git a/arch/mips/sibyte/common/dma.c b/arch/mips/sibyte/common/dma.c
index c5c2c782aff6..3835fee21489 100644
--- a/arch/mips/sibyte/common/dma.c
+++ b/arch/mips/sibyte/common/dma.c
@@ -10,5 +10,5 @@
 
 void __init plat_swiotlb_setup(void)
 {
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 }
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index ba256c37bcc0..97fffa46f05a 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -14,8 +14,10 @@ unsigned int ppc_swiotlb_flags;
 
 void __init swiotlb_detect_4g(void)
 {
-	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
+	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
 		ppc_swiotlb_enable = 1;
+		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+	}
 }
 
 static int __init check_swiotlb_enabled(void)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b617b69452cd..006ed41097e9 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -287,6 +287,19 @@ void __init arch_mm_preinit(void)
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
 
 #ifdef CONFIG_SWIOTLB
+	if (is_secure_guest()) {
+
+		/* Don't release the SWIOTLB buffer. */
+		ppc_swiotlb_enable = 1;
+
+		/*
+		 * Since the guest memory is inaccessible to the host,
+		 * devices always need to use the SWIOTLB buffer for DMA
+		 * even if dma_capable() says otherwise.
+		 */
+		ppc_swiotlb_flags |= SWIOTLB_ANY;
+	}
+
 	/*
 	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
 	 * 4G. We force memblock to bottom-up mode to ensure that the
@@ -295,7 +308,7 @@ void __init arch_mm_preinit(void)
 	 * back to to-down.
 	 */
 	memblock_set_bottom_up(true);
-	swiotlb_init(ppc_swiotlb_enable, ppc_swiotlb_flags);
+	swiotlb_init(ppc_swiotlb_flags);
 #endif
 
 	kasan_late_init();
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 7a403dbd35ee..4a0be631dc6d 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -21,16 +21,6 @@ static int __init init_svm(void)
 	if (!is_secure_guest())
 		return 0;
 
-	/* Don't release the SWIOTLB buffer. */
-	ppc_swiotlb_enable = 1;
-
-	/*
-	 * Since the guest memory is inaccessible to the host, devices always
-	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
-	 * otherwise.
-	 */
-	ppc_swiotlb_flags |= SWIOTLB_ANY;
-
 	/* Share the SWIOTLB buffer with the host. */
 	swiotlb_update_mem_attributes();
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 600f83cea1cd..49264e25108b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -444,6 +444,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	if (hose->dma_window_size < mem) {
 #ifdef CONFIG_SWIOTLB
 		ppc_swiotlb_enable = 1;
+		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 #else
 		pr_err("%pOF: ERROR: Memory size exceeds PCI ATMU ability to "
 			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5fa392021717..2562cf45a8f2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -190,7 +190,11 @@ void __init arch_mm_preinit(void)
 		swiotlb_flags |= SWIOTLB_ANY;
 	}
 
-	swiotlb_init(swiotlb, swiotlb_flags);
+	if ((max_pfn > PFN_DOWN(dma32_phys_limit)) &&
+	     (memblock_start_of_DRAM() < dma32_phys_limit))
+		swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+
+	swiotlb_init(swiotlb_flags);
 
 	print_vm_layout();
 }
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index be7e009e7b59..78f507e24ceb 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(true, SWIOTLB_VERBOSE | SWIOTLB_ANY);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_ANY);
 	swiotlb_update_mem_attributes();
 }
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 75cf8f6ae8cd..0cff255827ba 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -44,8 +44,10 @@ static unsigned int x86_swiotlb_flags;
 static void __init pci_swiotlb_detect(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
+	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_enable = true;
+		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+	}
 
 	/*
 	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
@@ -81,8 +83,10 @@ static void __init pci_xen_swiotlb_init(void)
 	if (!xen_swiotlb_enabled())
 		return;
 	x86_swiotlb_enable = true;
-	x86_swiotlb_flags |= SWIOTLB_ANY;
-	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
+	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
+	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
+	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
+	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
 	if (IS_ENABLED(CONFIG_PCI))
 		pci_request_acs();
@@ -103,7 +107,7 @@ void __init pci_iommu_alloc(void)
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
-	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
+	swiotlb_init(x86_swiotlb_flags);
 }
 
 static __init int iommu_setup(char *p)
@@ -149,8 +153,10 @@ static __init int iommu_setup(char *p)
 			return 1;
 		}
 #ifdef CONFIG_SWIOTLB
-		if (!strncmp(p, "soft", 4))
+		if (!strncmp(p, "soft", 4)) {
 			x86_swiotlb_enable = true;
+			x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+		}
 #endif
 		if (!strncmp(p, "pt", 2))
 			iommu_set_default_passthrough(true);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5f24edf47b68..6386536a5ec6 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -16,6 +16,10 @@ struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
+/* Initialize a default-sized pool for devices with limited DMA addressing. */
+#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+/* Initialize a default-sized pool that requires architecture remapping. */
+#define SWIOTLB_INIT_REMAP		(1 << 3)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -39,8 +43,8 @@ struct scatterlist;
 #endif
 
 unsigned long swiotlb_default_pool_size(void);
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-	int (*remap)(void *tlb, unsigned long nslabs));
+void __init swiotlb_init_remap(unsigned int flags,
+			       int (*remap)(void *tlb, unsigned long nslabs));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	int (*remap)(void *tlb, unsigned long nslabs));
 extern void __init swiotlb_update_mem_attributes(void);
@@ -183,7 +187,7 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 	return mem && mem->force_bounce;
 }
 
-void swiotlb_init(bool addressing_limited, unsigned int flags);
+void swiotlb_init(unsigned int flags);
 void __init swiotlb_exit(void);
 void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -193,7 +197,7 @@ void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
 #else
-static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
+static inline void swiotlb_init(unsigned int flags)
 {
 }
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 61efa3244daa..8ae315b2d0e7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -81,6 +81,13 @@ struct io_tlb_slot {
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
+enum swiotlb_pool_policy {
+	SWIOTLB_POOL_NONE,
+	SWIOTLB_POOL_MINIMAL,
+	SWIOTLB_POOL_DEFAULT,
+	SWIOTLB_POOL_CC_GUEST,
+};
+
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 
 static void swiotlb_dyn_alloc(struct work_struct *work);
@@ -354,24 +361,15 @@ static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
 void __init swiotlb_update_mem_attributes(void)
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
-	unsigned long bytes;
-
-	/*
-	 * if platform support memory encryption, swiotlb buffers are
-	 * shared by default.
-	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		io_tlb_default_mem.cc_shared = true;
-	else
-		io_tlb_default_mem.cc_shared = false;
 
 	if (!mem->nslabs || mem->late_alloc)
 		return;
-	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 
 	if (io_tlb_default_mem.cc_shared) {
 		int ret;
+		unsigned long bytes;
 
+		bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 		ret = set_memory_decrypted((unsigned long)mem->vaddr,
 					   bytes >> PAGE_SHIFT);
 		if (ret) {
@@ -462,22 +460,72 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
+static bool __init swiotlb_kmalloc_needs_bounce(void)
+{
+	return IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	       (dma_get_cache_alignment() > 1);
+}
+
+static void __init
+swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
+{
+	switch (policy) {
+	case SWIOTLB_POOL_MINIMAL:
+		return;
+	case SWIOTLB_POOL_CC_GUEST:
+		return;
+	case SWIOTLB_POOL_NONE:
+		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
+		return;
+	case SWIOTLB_POOL_DEFAULT:
+	default:
+		return;
+	}
+}
+
+static enum swiotlb_pool_policy __init
+swiotlb_select_pool_policy(unsigned int flags)
+{
+	if (swiotlb_force_disable)
+		return SWIOTLB_POOL_NONE;
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return SWIOTLB_POOL_CC_GUEST;
+
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return SWIOTLB_POOL_DEFAULT;
+
+	if (flags & SWIOTLB_INIT_REMAP)
+		return SWIOTLB_POOL_DEFAULT;
+
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
+		return SWIOTLB_POOL_DEFAULT;
+
+	if (swiotlb_force_bounce)
+		return SWIOTLB_POOL_DEFAULT;
+
+	if (swiotlb_kmalloc_needs_bounce())
+		return SWIOTLB_POOL_MINIMAL;
+
+	return SWIOTLB_POOL_NONE;
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
  */
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+void __init swiotlb_init_remap(unsigned int flags,
+			       int (*remap)(void *tlb, unsigned long nslabs))
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
+	enum swiotlb_pool_policy policy;
 	unsigned long nslabs;
 	unsigned int nareas;
 	size_t alloc_size;
 	void *tlb;
 
-	if (!addressing_limit && !swiotlb_force_bounce)
-		return;
-	if (swiotlb_force_disable)
+	policy = swiotlb_select_pool_policy(flags);
+	if (policy == SWIOTLB_POOL_NONE)
 		return;
 
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
@@ -491,6 +539,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
 #endif
 
+	/* if we have host or guest memory encryption */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		io_tlb_default_mem.cc_shared = true;
+
+	swiotlb_adjust_pool_size(policy);
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -531,9 +585,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_print_info();
 }
 
-void __init swiotlb_init(bool addressing_limit, unsigned int flags)
+void __init swiotlb_init(unsigned int flags)
 {
-	swiotlb_init_remap(addressing_limit, flags, NULL);
+	swiotlb_init_remap(flags, NULL);
 }
 
 /*
-- 
2.43.0

