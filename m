Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6036196E;
	Thu, 13 Aug 2026 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616754; cv=none; b=itxUmDChwZ3dMxn2QYTd+Kh5bLJVfLABHyANsyoE67P6FuN54l8ajLHKvcw/anjiSSUQR0Xp/k84vmDDE0rJaHliC5H0d1b02nSw3mAggnH4e4JzVWlVre06g3xzlIzxHNQWw+p91hguRyXwpdXdnd/rEHWE8GBgyAN3eW8JNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616754; c=relaxed/simple;
	bh=OuK9pk/zzN0vhb8IOFVugCvZ/3CC7EImWr8tYDDJrDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phbYz1Q93bnWttATNicQZZB2cPV0jUdL7KoqaBjFRJ9Cj5ZfNc65TgPEAW1Art2ECq0pZg53VZ/SmZpUnCUAKe0iWS4cwGmJ638JB3i4oPQAq6zV5oQlKFB/p1i8z8msbXKna0vfId19IFnWS98A2EEuSxB5J4l0w4M/nVR3Gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIVWEmZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIVWEmZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197721F00A3A;
	Thu, 13 Aug 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616752;
	bh=XabZ2hWfS6jdH7PFxaix/OtkUgZ46txEKjxMvcXWLco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIVWEmZx9jrdikgyqVtBDit8iXafTBpBIomAYLvCLrD3WHKZ/ew6xzRhiincMsyUD
	 TS1tIEuEvR1Ngfv/SUJObJ4FqY8L/f8qG9iG/GW8FnB5qhC7uZMKHTMWTYw3A1A2i3
	 Yd+aPZavImK2W86PN3UEK1uOcZXlrsv6TXFFtGbFVrdmDwnc7Am0d1JZyoJulK0Psx
	 TzgS5SeZTkMwgab/rgGK5ZDPZfMd2filMN7bnXX+KxHEjB8BLyDIa4/vvJfg2Xvpsi
	 MTWcgJr0oXLJFw6ysiHS9Puyi0DJ7BbHMiGjA0yoLiCTEqNII08un6PFO5iczy8wCg
	 hLJhA7OSWVdJw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v2 1/2] dma: swiotlb: Centralize default pool initialization and sizing
Date: Thu, 13 Aug 2026 15:55:20 +0530
Message-ID: <20260813102521.1367737-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addressing_limited argument to swiotlb_init() no longer describes
all the reasons why a default swiotlb pool may be needed. Confidential
computing systems need a shared pool even without addressing limitations,
while some systems need a smaller pool for bouncing unaligned kmalloc
buffers.

Replace the argument with SWIOTLB_INIT_ADDRESSING_LIMIT and
SWIOTLB_INIT_CC_SHARED reason flags, and add swiotlb_should_init() to
determine whether initialization is required for limited DMA addressing,
confidential-computing shared DMA, unaligned kmalloc bouncing, or
swiotlb=force.

Have architectures report addressing-limit and confidential-computing
requirements before swiotlb_init(). Mark CC pools shared before their
memory attributes are updated, and keep both addressing-limited and
CC-shared pools at their normal size instead of applying the reduced
kmalloc-only sizing policy.

Move the reduced kmalloc-bounce sizing policy from arm64 and RISC-V into
the SWIOTLB core. This keeps architecture code responsible for reporting
why a pool is needed while centralizing initialization and sizing
decisions.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm/mm/init.c                   |  6 +++-
 arch/arm64/mm/init.c                 | 18 ++++------
 arch/loongarch/kernel/setup.c        |  2 +-
 arch/mips/cavium-octeon/dma-octeon.c |  2 +-
 arch/mips/loongson64/dma.c           |  2 +-
 arch/mips/sibyte/common/dma.c        |  2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |  4 ++-
 arch/powerpc/mm/mem.c                | 15 +++++++-
 arch/powerpc/platforms/pseries/svm.c | 10 ------
 arch/powerpc/sysdev/fsl_pci.c        |  1 +
 arch/riscv/mm/init.c                 | 18 +++-------
 arch/s390/mm/init.c                  |  2 +-
 arch/x86/include/asm/iommu.h         |  2 ++
 arch/x86/kernel/amd_gart_64.c        |  1 +
 arch/x86/kernel/pci-dma.c            | 17 +++++----
 arch/x86/mm/mem_encrypt.c            |  4 +++
 include/linux/swiotlb.h              | 12 ++++---
 kernel/dma/swiotlb.c                 | 52 ++++++++++++++++++++++++----
 18 files changed, 109 insertions(+), 61 deletions(-)

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
index e308a7cabd12..9f5b366d2086 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -338,19 +338,15 @@ void __init arch_setup_zero_pages(void)
 void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
+	/* pKVM uses restricted-dma-pool */
+	bool cc_guest = is_realm_world();
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
-		/*
-		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
-		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
-	}
+	if (cc_guest)
+		flags |= SWIOTLB_INIT_CC_SHARED;
+	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
+		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
-	swiotlb_init(true, flags);
+	swiotlb_init(flags);
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index eaebb52bd36e..5952eec7d570 100644
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
index 4c1afab91996..f93a89e18498 100644
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
+		ppc_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED | SWIOTLB_ANY;
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
index 5b1b3c88b4d1..2d7c5aaeea19 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -162,25 +162,15 @@ static void print_vm_layout(void) { }
 
 void __init arch_mm_preinit(void)
 {
-	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
+	unsigned int flags = SWIOTLB_VERBOSE;
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
-	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
-	    dma_cache_alignment != 1) {
-		/*
-		 * If no bouncing needed for ZONE_DMA, allocate 1MB swiotlb
-		 * buffer per 1GB of RAM for kmalloc() bouncing on
-		 * non-coherent platforms.
-		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
-		swiotlb = true;
-	}
+	if (max_pfn > PFN_DOWN(dma32_phys_limit))
+		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
-	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
+	swiotlb_init(flags);
 
 	print_vm_layout();
 }
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8d1de5a2e554..801f8ac95250 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_CC_SHARED);
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
index 75cf8f6ae8cd..a02a0b098591 100644
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
@@ -81,8 +82,8 @@ static void __init pci_xen_swiotlb_init(void)
 	if (!xen_swiotlb_enabled())
 		return;
 	x86_swiotlb_enable = true;
-	x86_swiotlb_flags |= SWIOTLB_ANY;
-	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
+	x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT | SWIOTLB_ANY;
+	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
 	if (IS_ENABLED(CONFIG_PCI))
 		pci_request_acs();
@@ -103,7 +104,7 @@ void __init pci_iommu_alloc(void)
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
-	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
+	swiotlb_init(x86_swiotlb_flags);
 }
 
 static __init int iommu_setup(char *p)
@@ -149,8 +150,10 @@ static __init int iommu_setup(char *p)
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
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 95bae74fdab2..7f17c05a0209 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
 
+#include <asm/iommu.h>
 #include <asm/sev.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
@@ -111,6 +112,9 @@ void __init mem_encrypt_setup_arch(void)
 	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		snp_fixup_e820_tables();
 
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 277b9aa2edaa..f0548fb81785 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -16,6 +16,10 @@ struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
+/* Initialize a default-sized pool for devices with limited DMA addressing. */
+#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+/* Initialize a shared default pool for confidential-computing systems. */
+#define SWIOTLB_INIT_CC_SHARED		(1 << 3)
 
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
index 897aba538c5b..dd1bf6c61446 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -382,12 +382,37 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
+static bool __init swiotlb_kmalloc_needs_bounce(void)
+{
+	return IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	       (dma_get_cache_alignment() > 1);
+}
+
+static bool __init swiotlb_should_init(unsigned int flags)
+{
+	if (swiotlb_force_disable)
+		return false;
+
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
+		return true;
+
+	if (swiotlb_kmalloc_needs_bounce())
+		return true;
+
+	if (swiotlb_force_bounce)
+		return true;
+
+	if (flags & SWIOTLB_INIT_CC_SHARED)
+		return true;
+
+	return false;
+}
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
 	unsigned long nslabs;
@@ -395,11 +420,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	size_t alloc_size;
 	void *tlb;
 
-	if (!addressing_limit && !swiotlb_force_bounce)
-		return;
-	if (swiotlb_force_disable)
+	if (!swiotlb_should_init(flags))
 		return;
 
+	if (flags & SWIOTLB_INIT_CC_SHARED)
+		io_tlb_default_mem.cc_shared = true;
+
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
@@ -411,6 +437,18 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
 #endif
 
+	if (!(flags & (SWIOTLB_INIT_ADDRESSING_LIMIT |
+		       SWIOTLB_INIT_CC_SHARED)) &&
+	    swiotlb_kmalloc_needs_bounce()) {
+		/*
+		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
+		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
+		 */
+		unsigned long size =
+			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
+
+		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+	}
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -451,9 +489,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
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

