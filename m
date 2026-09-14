Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F43ACA43;
	Mon, 14 Sep 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369418; cv=none; b=uP5zj5pmOpCi0UAZc/VAxCNVOtkB3foxkZBl6/njTJRi+YVb+i6WAwipLUWy72HI6hzuAww9U043iY5GBkrxg7Wu8hV9fSY3LFVaXCsb+xXPT3RIsmkxZ6q02Rb0w057UTf2+C8qCi1ThKlhsEiHfGY6RhAqduWgNhUEuOEB/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369418; c=relaxed/simple;
	bh=+SASFzDMBNGBSsPiJbYQAj6oJSNY3PejaCNk2W0IpY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC78iQox1hHiHTDl+mHpKiCwoUoafg3nB/4OjrZbYnfvsI+lfs0dqG9rRU5o3esfy/SEyKkjvHsOFD1Fk+nONUedupHGDFSw1uykic1XD/yRIlp+tD4Bz5zCKbCcachoCVGXgiNSzrVRwpRvkib7X+hHVNGfQhl9Spz/nKZ0uXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE1P8nt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE1P8nt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489181F000FF;
	Mon, 14 Sep 2026 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369416;
	bh=WEcbhQazoSj1y/YavhLCyevXiP51++W+4wFyMfPfLH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JE1P8nt2+GATNQTa6sTYnl9jTgx15El0FdbS10klL/OAbcC8zGQdc3X2a12aswWUQ
	 ugSnP+fGMPaGDy3B6IGUKT7DPxiW5tFG84lqLNP2447KfWNNm5vAZVc0+vfLU/1joS
	 rLlBbE1Od/kwZi0Zsm8Mz/fdEWcVXoW1Gf2Q2fb7LiECmYDcqPI/pGkJZzte7hyYAq
	 tZj1Xx65LGLQ22zHRcP0bBcIKlA1xCYv/c+mccHOq140cRCtt5VOD/PjpM0xEXmOhE
	 rQcF6J7GxnekCBSZLyX1nhfSJmRyRKpxd8uGz1HHqfFlnfFDXKgzuH0ynjBavxFC9h
	 BY/QWR4Q43auw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
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
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 5/5] dma: swiotlb: Remove SWIOTLB_ANY
Date: Mon, 14 Sep 2026 12:31:34 +0530
Message-ID: <20260914070135.313337-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914070135.313337-1-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swiotlb pools are currently allocated below the architecture's low
address limit by default. SWIOTLB_ANY overrides this and permits
allocation anywhere in directly mapped memory.

SWIOTLB_INIT_ADDRESSING_LIMIT now explicitly identifies callers which
need a pool that is reachable by devices with limited DMA addressing.
Use it as the placement constraint and remove SWIOTLB_ANY.

This changes the default behavior for callers which do not set either
flag. Previously, omitting SWIOTLB_ANY placed the default pool below the
architecture's low address limit and also constrained dynamically
allocated pools to the same range. After this change, omitting
SWIOTLB_INIT_ADDRESSING_LIMIT permits both static and dynamic pools to
use any directly mapped memory.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/core-api/swiotlb.rst |  8 ++++----
 arch/powerpc/mm/mem.c              |  6 ++++--
 arch/s390/mm/init.c                |  2 +-
 arch/x86/kernel/pci-dma.c          |  2 +-
 include/linux/swiotlb.h            |  7 +++----
 kernel/dma/swiotlb.c               | 17 ++++++-----------
 6 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index 71b4e4c27eb5..06d9f88fdf7b 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -148,10 +148,10 @@ may also be adjusted
 due to other conditions, such as running in a CoCo VM, as described above. If
 CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated later in
 the life of the system. Each pool must be a contiguous range of physical
-memory. The default pool is allocated below the 4 GiB physical address line so
-it works for devices that can only address 32-bits of physical memory (unless
-architecture-specific code provides the SWIOTLB_ANY flag). In a CoCo VM, the
-pool memory must be decrypted before swiotlb is used.
+memory. The default pool is allocated below the architecture's low address
+limit when it is needed for devices with limited DMA addressing. Otherwise,
+it may be allocated anywhere in directly mapped memory. In a CoCo VM, the pool
+memory must be decrypted before swiotlb is used.
 
 Each pool is divided into "slots" of size IO_TLB_SIZE, which is 2 KiB with
 current definitions. IO_TLB_SEGSIZE contiguous slots (128 slots) constitute
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 006ed41097e9..1bdea6c03848 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -295,9 +295,11 @@ void __init arch_mm_preinit(void)
 		/*
 		 * Since the guest memory is inaccessible to the host,
 		 * devices always need to use the SWIOTLB buffer for DMA
-		 * even if dma_capable() says otherwise.
+		 * even if dma_capable() says otherwise. The hypervisor has
+		 * no addressing limitation, so the buffer may be allocated
+		 * anywhere.
 		 */
-		ppc_swiotlb_flags |= SWIOTLB_ANY;
+		ppc_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
 	}
 
 	/*
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 78f507e24ceb..ce10292447f1 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_ANY);
+	swiotlb_init(SWIOTLB_VERBOSE);
 	swiotlb_update_mem_attributes();
 }
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index cd6dd151d634..a8070cae8253 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -89,7 +89,7 @@ static void __init pci_xen_swiotlb_init(void)
 	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
 	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
 			       SWIOTLB_INIT_FORCE_DISABLE);
-	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
+	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP;
 	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
 	if (IS_ENABLED(CONFIG_PCI))
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ef7a776ee508..77542f107b3f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,13 +15,12 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 /* Initialize a default-sized pool for devices with limited DMA addressing. */
-#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
 /* Initialize a default-sized pool that requires architecture remapping. */
-#define SWIOTLB_INIT_REMAP		(1 << 3)
+#define SWIOTLB_INIT_REMAP		(1 << 2)
 /* Do not initialize a pool unless SWIOTLB is explicitly required. */
-#define SWIOTLB_INIT_FORCE_DISABLE	(1 << 4)
+#define SWIOTLB_INIT_FORCE_DISABLE	(1 << 3)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6695da682f96..f8a77926b8b0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -448,15 +448,10 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	void *tlb;
 
-	/*
-	 * By default allocate the bounce buffer memory from low memory, but
-	 * allow to pick a location everywhere for hypervisors with guest
-	 * memory encryption.
-	 */
-	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
-	else
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
 
 	if (!tlb) {
 		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
@@ -604,10 +599,10 @@ void __init swiotlb_init_remap(unsigned int flags,
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
-	if (flags & SWIOTLB_ANY)
-		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
-	else
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
+	else
+		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
 #endif
 
 	/* if we have host or guest memory encryption */
-- 
2.43.0

