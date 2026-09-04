Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552C40D57B;
	Fri,  4 Sep 2026 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517128; cv=none; b=m/oyFiWDD65YuvXpuhn4DOpxs8RI1tiWpGW0MpYSIfB2Yon2lg/18yJ9T4ylxhibHaVEu8hJq4/cPe+VKUuM031j/njbsHv4+JxYL4RmqnNWX6XgScM7pYyYzEj20pU0hoAJ7eK9xhagLLsotKQ1iVcS5ObxggRuL67XLyOim80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517128; c=relaxed/simple;
	bh=kZ9RrjvUgKoMwJXhQRx50y1OEec/LgS3dkcDc4jM6Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJkZOXPd1GUyUcxGDJYx8ci9MbhKrzI9Y2+JWuhZfAmsHO9YMo9hjHOt4xCO0ZlRJh2YD5XyR8ih2eqmUDUv9hwGDV0vFbSZXFF707BQdyE5BROW1H8ZEIdNQ/ZChfXHGpIsCieam04Si6CfWZCLx8okCsMcl2YvnjMhmVHE84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imjhi5C6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imjhi5C6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514F01F00A3E;
	Fri,  4 Sep 2026 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517124;
	bh=iXyelc+FdB9VSTl/i2yP74IHaPK+mw0KNF3ivrE2O1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Imjhi5C68+WVUyyI+e1KEjw0G++/SB33J+83mEDMgMVkrAtmG+x1TjrjHXpU1eoE1
	 ouw10g3YpiRRS0THJqW0w6IePFegK++eRPPO+UUM6K7prWNqE4Z9xusxFjfetXwf0d
	 YYLHkLwXw7yKnYJNOH2LT/YJeWk2CwoLf302Dg+zBUYL5jzASGRs2PaqVscwF5W0N5
	 pYe4qwllVGtoJknkD3s167sMHZ04ANVITl3OCFS5jL5r+OkM1WaOfevwP/PkHAr4ix
	 B0WI1hNO5/KhhBKJsk0Ho+3FgEKQHD/79SIW3QZi0jxMy8hs9q5hAUh33FO8nqsiDs
	 mlvJ47fztZCtQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
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
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 1/4] dma: swiotlb: Centralize default pool policy selection
Date: Fri,  4 Sep 2026 15:48:07 +0530
Message-ID: <20260904101810.1193505-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
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

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm/mm/init.c                   |   6 +-
 arch/arm64/mm/init.c                 |   5 +-
 arch/loongarch/kernel/setup.c        |   2 +-
 arch/mips/cavium-octeon/dma-octeon.c |   2 +-
 arch/mips/loongson64/dma.c           |   2 +-
 arch/mips/sibyte/common/dma.c        |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 arch/powerpc/mm/mem.c                |  15 ++-
 arch/powerpc/platforms/pseries/svm.c |  10 --
 arch/powerpc/sysdev/fsl_pci.c        |   1 +
 arch/riscv/mm/init.c                 |   6 +-
 arch/s390/mm/init.c                  |   2 +-
 arch/x86/include/asm/iommu.h         |   2 +
 arch/x86/kernel/amd_gart_64.c        |   1 +
 arch/x86/kernel/pci-dma.c            |  19 ++--
 include/linux/swiotlb.h              |  12 ++-
 kernel/dma/swiotlb.c                 | 134 +++++++++++++++++++--------
 17 files changed, 156 insertions(+), 69 deletions(-)

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
index fbf215ecc7d0..7d51fb5f5a71 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -351,7 +351,10 @@ void __init arch_mm_preinit(void)
 		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
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
index f8994caefc70..fc1bec090db1 100644
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
 
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 3be2451e7bc8..22c8190fe34d 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -14,8 +14,10 @@ extern bool amd_iommu_snp_en;
 
 #ifdef CONFIG_SWIOTLB
 extern bool x86_swiotlb_enable;
+extern unsigned int x86_swiotlb_flags;
 #else
 #define x86_swiotlb_enable false
+#define x86_swiotlb_flags 0
 #endif
 
 /* 10 seconds */
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b5f1f031d45b..d0fbc0271e43 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -814,6 +814,7 @@ int __init gart_iommu_init(void)
 	dma_ops = &gart_dma_ops;
 	x86_platform.iommu_shutdown = gart_iommu_shutdown;
 	x86_swiotlb_enable = false;
+	x86_swiotlb_flags = 0;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 75cf8f6ae8cd..3c82ebb5b6e0 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -39,13 +39,15 @@ int iommu_detected __read_mostly = 0;
 
 #ifdef CONFIG_SWIOTLB
 bool x86_swiotlb_enable;
-static unsigned int x86_swiotlb_flags;
+unsigned int x86_swiotlb_flags;
 
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
@@ -66,7 +68,6 @@ static void __init pci_swiotlb_detect(void)
 static inline void __init pci_swiotlb_detect(void)
 {
 }
-#define x86_swiotlb_flags 0
 #endif /* CONFIG_SWIOTLB */
 
 #ifdef CONFIG_SWIOTLB_XEN
@@ -81,8 +82,10 @@ static void __init pci_xen_swiotlb_init(void)
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
@@ -103,7 +106,7 @@ void __init pci_iommu_alloc(void)
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
-	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
+	swiotlb_init(x86_swiotlb_flags);
 }
 
 static __init int iommu_setup(char *p)
@@ -149,8 +152,10 @@ static __init int iommu_setup(char *p)
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
index 2a421241b980..d69370c08094 100644
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
 
 unsigned long swiotlb_size_or_default(void);
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
index ded7016a46a7..aa19e81ae544 100644
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
@@ -117,26 +124,33 @@ struct io_tlb_area {
 	spinlock_t lock;
 };
 
-/*
- * Round up number of slabs to the next power of 2. The last area is going
- * be smaller than the rest if default_nslabs is not power of two.
- * The number of slot in an area should be a multiple of IO_TLB_SEGSIZE,
- * otherwise a segment may span two or more areas. It conflicts with free
- * contiguous slots tracking: free slots are treated contiguous no matter
- * whether they cross an area boundary.
- *
- * Return true if default_nslabs is rounded up.
- */
-static bool round_up_default_nslabs(void)
+/* Return a segment-aligned size that can be split evenly between areas. */
+static unsigned long swiotlb_aligned_nslabs(unsigned long size)
 {
+	unsigned long nslabs;
+
+	nslabs = ALIGN(DIV_ROUND_UP(size, IO_TLB_SIZE), IO_TLB_SEGSIZE);
 	if (!default_nareas)
-		return false;
+		return nslabs;
+
+	if (nslabs < IO_TLB_SEGSIZE * default_nareas)
+		nslabs = IO_TLB_SEGSIZE * default_nareas;
+	else if (!is_power_of_2(nslabs))
+		nslabs = roundup_pow_of_two(nslabs);
 
-	if (default_nslabs < IO_TLB_SEGSIZE * default_nareas)
-		default_nslabs = IO_TLB_SEGSIZE * default_nareas;
-	else if (is_power_of_2(default_nslabs))
+	return nslabs;
+}
+
+/* Return true if default_nslabs is rounded up for the configured areas. */
+static bool round_up_default_nslabs(void)
+{
+	unsigned long nslabs;
+
+	nslabs = swiotlb_aligned_nslabs(default_nslabs << IO_TLB_SHIFT);
+	if (nslabs == default_nslabs)
 		return false;
-	default_nslabs = roundup_pow_of_two(default_nslabs);
+
+	default_nslabs = nslabs;
 	return true;
 }
 
@@ -300,10 +314,8 @@ void __init swiotlb_adjust_size(unsigned long size)
 	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
 		return;
 
-	size = ALIGN(size, IO_TLB_SIZE);
-	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
-	if (round_up_default_nslabs())
-		size = default_nslabs << IO_TLB_SHIFT;
+	default_nslabs = swiotlb_aligned_nslabs(size);
+	size = default_nslabs << IO_TLB_SHIFT;
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }
 
@@ -356,24 +368,15 @@ static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
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
@@ -464,22 +467,71 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
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
+		break;
+	case SWIOTLB_POOL_CC_GUEST:
+		break;
+	case SWIOTLB_POOL_NONE:
+		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
+		break;
+	case SWIOTLB_POOL_DEFAULT:
+		break;
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
@@ -493,6 +545,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
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
 
@@ -533,9 +591,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
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

