Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5893BBFA9;
	Thu, 13 Aug 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616765; cv=none; b=VHl/5bOWBoVyNUevhfXky0UwfaKCQuIJsPg0o0p6K1lOM0j/kcaMqdrWuttieFowU4vj6K0ud6OnaN8QrQw4/pbnFUj+xfljQVPOSsS5SQMGSZASgA8bC2eQSRvAlsVcdT0SpAhiY1Y1y79Whn0tIhK72mK8CRxoV81ZbUbcfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616765; c=relaxed/simple;
	bh=w1rZoQgKcVqAHDxDAHE8BXphwtwq2nTt3wv3JpATXoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4oDONm/13wnMByNS8N2OKLMOA3/E16xVhLyYZWgRykMZ1T7jIiU4GT9rkJBM2QjfElaw9Rp8MPHNiQvP57uT/nBGyPs0FQ6nb47lxo49Ig6y5wgo9pKYRmyn45Jn7fEfy6K8vXwl/LZLe2aUtvyL2oY2tPqH+oa6jTsL/CDuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjhLqTpm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjhLqTpm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699F91F000E9;
	Thu, 13 Aug 2026 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616762;
	bh=5PHCW/v+JKvQwWv1NsSjsLXYqOrxgLeGNzW79kSPybs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VjhLqTpmNuACKc18t0b3/0fPvVuC2WT7W8CwhFzRpLuw2RYUAWspOWsTL/3tU9A8m
	 K3dJxQJG5Xoce+jD9MeNMjg/bjmQfnMci+IwDHfaD7czycm723XOEihrbOaTp+G4Mh
	 X/aVFs7j7/FCx5FyXGU/cBY1zDI9odFKn2RfiSqxkR6wbxEVsGfQMVDliG2BUwC8fs
	 vpqvTNHcQSZLnYL4d+oIx8fDqa+CfcjUaM/MsYotAO3++KZNBeGmnOUQEHDvVp2mb/
	 SheJh4I1cQTHEsVu2ON+AE8ZrEAdcTZGzzk8Mo7fmREXAL2RaktvDcamGxmwgf8iff
	 tUUlpTFec5SbA==
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
Subject: [RFC PATCH v2 2/2] dma: swiotlb: Initialize and size shared default pools for memory encryption
Date: Thu, 13 Aug 2026 15:55:21 +0530
Message-ID: <20260813102521.1367737-3-aneesh.kumar@kernel.org>
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

Systems with memory encryption require shared or unencrypted buffers for
device DMA. Confidential guests may route all DMA through SWIOTLB, making
the default pool too small for I/O-intensive workloads. Host memory
encryption also requires a shared default pool when bouncing is needed,
but does not require the guest sizing policy.

Move the existing x86 sizing policy into the SWIOTLB core. Detect memory
encryption before allocating the default pool so that it is initialized
and marked shared even without DMA addressing limitations. Increase the
pool size to 6% of guest memory, clamped between the default size and
1 GiB, only for confidential guests.

The core can determine the confidential-computing requirement directly,
so remove SWIOTLB_INIT_CC_SHARED and its architecture uses. Keep the
pseries secure-guest setup before swiotlb_init() so that the pool is
allocated with SWIOTLB_ANY and is not released later.

A restricted DMA pool already supplies shared bounce buffers for its
devices. Record its presence during reserved-memory initialization and
avoid initializing or marking the default pool as shared solely because
memory encryption is enabled.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c      |  6 +---
 arch/powerpc/mm/mem.c     |  2 +-
 arch/s390/mm/init.c       |  2 +-
 arch/x86/mm/mem_encrypt.c | 28 ---------------
 include/linux/swiotlb.h   |  2 --
 kernel/dma/swiotlb.c      | 72 +++++++++++++++++++++++++++++----------
 6 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9f5b366d2086..c3188ca878f3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -338,12 +338,8 @@ void __init arch_setup_zero_pages(void)
 void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
-	/* pKVM uses restricted-dma-pool */
-	bool cc_guest = is_realm_world();
 
-	if (cc_guest)
-		flags |= SWIOTLB_INIT_CC_SHARED;
-	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
+	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
 	swiotlb_init(flags);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f93a89e18498..b77946db3f17 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -297,7 +297,7 @@ void __init arch_mm_preinit(void)
 		 * devices always need to use the SWIOTLB buffer for DMA
 		 * even if dma_capable() says otherwise.
 		 */
-		ppc_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED | SWIOTLB_ANY;
+		ppc_swiotlb_flags |= SWIOTLB_ANY;
 	}
 
 	/*
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 801f8ac95250..ce10292447f1 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_CC_SHARED);
+	swiotlb_init(SWIOTLB_VERBOSE);
 	swiotlb_update_mem_attributes();
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 7f17c05a0209..912f22ca838f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -14,7 +14,6 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
 
-#include <asm/iommu.h>
 #include <asm/sev.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
@@ -102,9 +101,6 @@ void __init mem_encrypt_init(void)
 
 void __init mem_encrypt_setup_arch(void)
 {
-	phys_addr_t total_mem = memblock_phys_mem_size();
-	unsigned long size;
-
 	/*
 	 * Do RMP table fixups after the e820 tables have been setup by
 	 * e820__memory_setup().
@@ -112,33 +108,9 @@ void __init mem_encrypt_setup_arch(void)
 	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		snp_fixup_e820_tables();
 
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
-
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
-	/*
-	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
-	 * Kernel uses SWIOTLB to make this happen without changing device
-	 * drivers. However, depending on the workload being run, the
-	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
-	 * run out of buffers for DMA, resulting in I/O errors and/or
-	 * performance degradation especially with high I/O workloads.
-	 *
-	 * Adjust the default size of SWIOTLB using a percentage of guest
-	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
-	 * memory is allocated from low memory, ensure that the adjusted size
-	 * is within the limits of low available memory.
-	 *
-	 * The percentage of guest memory used here for SWIOTLB buffers
-	 * is more of an approximation of the static adjustment which
-	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
-	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
-	swiotlb_adjust_size(size);
-
 	/* Set restricted memory access for virtio. */
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 }
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f0548fb81785..9afb7c9a447a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -18,8 +18,6 @@ struct scatterlist;
 #define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 /* Initialize a default-sized pool for devices with limited DMA addressing. */
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
-/* Initialize a shared default pool for confidential-computing systems. */
-#define SWIOTLB_INIT_CC_SHARED		(1 << 3)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dd1bf6c61446..67b57831b4bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -80,6 +80,7 @@ struct io_tlb_slot {
 
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
+static bool restricted_dma_pool_present __initdata;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 
@@ -274,24 +275,15 @@ static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
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
@@ -382,12 +374,54 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
+static void __init swiotlb_adjust_cc_attributes(void)
+{
+	unsigned long size;
+	phys_addr_t total_mem = memblock_phys_mem_size();
+
+	/* Do not resize for host memory encryption. */
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * For SEV and TDX and CCA, all DMA has to occur via
+	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
+	 * happen without changing device drivers. However, depending on
+	 * the workload being run, the default 64MB of SWIOTLB may not be
+	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
+	 * I/O errors and/or performance degradation especially with high
+	 * I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB using a percentage of guest
+	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
+	 * memory is allocated from low memory, ensure that the adjusted
+	 * size is within the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers is
+	 * more of an approximation of the static adjustment which 64MB for
+	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = total_mem * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	swiotlb_adjust_size(size);
+
+	if (!IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC))
+		pr_info("Consider enabling CONFIG_SWIOTLB_DYNAMIC for memory-encrypted systems\n");
+}
+
 static bool __init swiotlb_kmalloc_needs_bounce(void)
 {
 	return IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 	       (dma_get_cache_alignment() > 1);
 }
 
+static bool __init swiotlb_default_pool_needs_cc_shared(void)
+{
+	/* A restricted DMA pool provides the shared buffers instead. */
+	return cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
+	       !restricted_dma_pool_present;
+}
+
 static bool __init swiotlb_should_init(unsigned int flags)
 {
 	if (swiotlb_force_disable)
@@ -402,11 +436,12 @@ static bool __init swiotlb_should_init(unsigned int flags)
 	if (swiotlb_force_bounce)
 		return true;
 
-	if (flags & SWIOTLB_INIT_CC_SHARED)
+	if (swiotlb_default_pool_needs_cc_shared())
 		return true;
 
 	return false;
 }
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -423,9 +458,6 @@ void __init swiotlb_init_remap(unsigned int flags,
 	if (!swiotlb_should_init(flags))
 		return;
 
-	if (flags & SWIOTLB_INIT_CC_SHARED)
-		io_tlb_default_mem.cc_shared = true;
-
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
@@ -437,9 +469,11 @@ void __init swiotlb_init_remap(unsigned int flags,
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
 #endif
 
-	if (!(flags & (SWIOTLB_INIT_ADDRESSING_LIMIT |
-		       SWIOTLB_INIT_CC_SHARED)) &&
-	    swiotlb_kmalloc_needs_bounce()) {
+	if (swiotlb_default_pool_needs_cc_shared()) {
+		io_tlb_default_mem.cc_shared = true;
+		swiotlb_adjust_cc_attributes();
+	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
+		   swiotlb_kmalloc_needs_bounce()) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
@@ -2086,6 +2120,8 @@ static int __init rmem_swiotlb_setup(unsigned long node,
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
+	restricted_dma_pool_present = true;
+
 	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
 	return 0;
-- 
2.43.0

