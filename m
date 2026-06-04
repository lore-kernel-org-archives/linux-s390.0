Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28653CEBB0;
	Thu,  4 Jun 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562480; cv=none; b=uOyG1D3YXLgsQv5koYtH1B2o5R6pp0pzY56in0seNtCOxvv/X/vJLvACWgBOpMVW7YvIRB+5lJGJqIU6hg+B7oE6+Kh+nhkGe9jG+KPhczE/juTkl827kdjqvQu1TIH4Ej35xZaxwvy+a8UDPRjxaMQMDeDHMTjKCjlFGASQQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562480; c=relaxed/simple;
	bh=6HETLAt32CBbeEc4GAU5rHrvV27bMsoj5a4NMg17Sp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olf1ICkX4ursQ/IBi5R994wVQF8VbQ/k+CkiAjFOKUUV4BGpanrxG1zVpHDtS80RoK6F/jd4ZAFgslx1a5yIBT/o1YuF4qmo3i8O2Ja1Bn/aVoXhdAp5lBaM/k5nbZBIhZGTTiQvEbA+Ncw9bf9sqzzlKzuwtVJnqlk8voQ3DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6VahbK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6VahbK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE051F00898;
	Thu,  4 Jun 2026 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562469;
	bh=URo6DlnMpbtavFM7tRdTFhpFHPXTlgZ6/DhDkraf8VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6VahbK6+J+Q76eYsnHHEyhjg9QaXu227M3xPkrMB2CAsrvGEmAgG6CStw1jVAA3/
	 i3I8j1afhgTuDT1+F7KukkLLV+gTaruspi2DS3o3T6EepbrAqEcXJLZaLzHaQfSaRU
	 RfMl56/LZRFkDm3ann0u/1J4q6r3GffD7SSciLVgb22nzDicFgqlh0B5tTGDbVH5GU
	 M67B4Y69Ybzn3ge+8RRJQX0lz1jjCArmG1KPWHvv5tW3efSxVawYfxS6NJ6a+m4s9y
	 70pDL+Q3FIKaLYXjuZy+GmHTDkvFgVx7S0cnEk6AnALdT+8sq1fQurJZLTL1+KWkko
	 83EdzX3vr0S4Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
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
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
	x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v6 06/20] dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
Date: Thu,  4 Jun 2026 14:09:45 +0530
Message-ID: <20260604083959.1265923-7-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach swiotlb to distinguish between encrypted and decrypted bounce
buffer pools, and make allocation and mapping paths select a pool whose
state matches the requested DMA attributes.

Add a unencrypted flag to io_tlb_mem, initialize it for the default and
restricted pools, and propagate DMA_ATTR_CC_SHARED into swiotlb pool
allocation. Reject swiotlb alloc/map requests when the selected pool does
not match the required encrypted/decrypted state.

Also return DMA addresses with the matching phys_to_dma_{encrypted,
unencrypted} helper so the DMA address encoding stays consistent with the
chosen pool.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/dma-direct.h |  10 +++
 include/linux/swiotlb.h    |   8 +-
 kernel/dma/direct.c        |  13 +++-
 kernel/dma/swiotlb.c       | 154 ++++++++++++++++++++++++++++---------
 4 files changed, 142 insertions(+), 43 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index c249912456f9..94fad4e7c11e 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -77,6 +77,10 @@ static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
 #ifndef phys_to_dma_unencrypted
 #define phys_to_dma_unencrypted		phys_to_dma
 #endif
+
+#ifndef phys_to_dma_encrypted
+#define phys_to_dma_encrypted		phys_to_dma
+#endif
 #else
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
@@ -90,6 +94,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
 {
 	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
 }
+
+static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
+		phys_addr_t paddr)
+{
+	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
+}
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 29187cec90d8..4dcbf3931be1 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -81,6 +81,7 @@ struct io_tlb_pool {
 	struct list_head node;
 	struct rcu_head rcu;
 	bool transient;
+	bool unencrypted;
 #endif
 };
 
@@ -111,6 +112,7 @@ struct io_tlb_mem {
 	struct dentry *debugfs;
 	bool force_bounce;
 	bool for_alloc;
+	bool unencrypted;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	bool can_grow;
 	u64 phys_limit;
@@ -282,7 +284,8 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
 extern void swiotlb_print_info(void);
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-struct page *swiotlb_alloc(struct device *dev, size_t size);
+struct page *swiotlb_alloc(struct device *dev, size_t size,
+		unsigned long attrs);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
 void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, struct io_tlb_pool *pool);
@@ -292,7 +295,8 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 	return dev->dma_io_tlb_mem->for_alloc;
 }
 #else
-static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
+static inline struct page *swiotlb_alloc(struct device *dev, size_t size,
+		unsigned long attrs)
 {
 	return NULL;
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 681f16a984ab..0b4a26c6b6fd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -96,9 +96,10 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 	return ret;
 }
 
-static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
+static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
+		unsigned long attrs)
 {
-	struct page *page = swiotlb_alloc(dev, size);
+	struct page *page = swiotlb_alloc(dev, size, attrs);
 
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		swiotlb_free(dev, page, size);
@@ -258,8 +259,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 						  gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
-		page = dma_direct_alloc_swiotlb(dev, size);
+		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (page) {
+			/*
+			 * swiotlb allocations comes from pool already marked
+			 * decrypted
+			 */
 			mark_mem_decrypt = false;
 			goto setup_page;
 		}
@@ -407,7 +412,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 						  gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
-		page = dma_direct_alloc_swiotlb(dev, size);
+		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 78ce05857c00..2bf3981db35d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -259,10 +259,21 @@ void __init swiotlb_update_mem_attributes(void)
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long bytes;
 
+	/*
+	 * if platform support memory encryption, swiotlb buffers are
+	 * decrypted by default.
+	 */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		io_tlb_default_mem.unencrypted = true;
+	else
+		io_tlb_default_mem.unencrypted = false;
+
 	if (!mem->nslabs || mem->late_alloc)
 		return;
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
-	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
+
+	if (io_tlb_default_mem.unencrypted)
+		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
 }
 
 static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
@@ -505,8 +516,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->slots)
 		goto error_slots;
 
-	set_memory_decrypted((unsigned long)vstart,
-			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+	if (io_tlb_default_mem.unencrypted)
+		set_memory_decrypted((unsigned long)vstart,
+				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+
 	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
 				 nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
@@ -539,7 +552,9 @@ void __init swiotlb_exit(void)
 	tbl_size = PAGE_ALIGN(mem->end - mem->start);
 	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
 
-	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+	if (io_tlb_default_mem.unencrypted)
+		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+
 	if (mem->late_alloc) {
 		area_order = get_order(array_size(sizeof(*mem->areas),
 			mem->nareas));
@@ -563,6 +578,7 @@ void __init swiotlb_exit(void)
  * @gfp:	GFP flags for the allocation.
  * @bytes:	Size of the buffer.
  * @phys_limit:	Maximum allowed physical address of the buffer.
+ * @unencrypted: true to allocate unencrypted memory, false for encrypted memory
  *
  * Allocate pages from the buddy allocator. If successful, make the allocated
  * pages decrypted that they can be used for DMA.
@@ -570,7 +586,8 @@ void __init swiotlb_exit(void)
  * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
  * if the allocated physical address was above @phys_limit.
  */
-static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
+		u64 phys_limit, bool unencrypted)
 {
 	unsigned int order = get_order(bytes);
 	struct page *page;
@@ -588,13 +605,13 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 	}
 
 	vaddr = phys_to_virt(paddr);
-	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (unencrypted && set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		goto error;
 	return page;
 
 error:
 	/* Intentional leak if pages cannot be encrypted again. */
-	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (unencrypted && !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		__free_pages(page, order);
 	return NULL;
 }
@@ -604,30 +621,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
  * @dev:	Device for which a memory pool is allocated.
  * @bytes:	Size of the buffer.
  * @phys_limit:	Maximum allowed physical address of the buffer.
+ * @attrs:	DMA attributes for the allocation.
  * @gfp:	GFP flags for the allocation.
  *
  * Return: Allocated pages, or %NULL on allocation failure.
  */
 static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
-		u64 phys_limit, gfp_t gfp)
+		u64 phys_limit, unsigned long attrs, gfp_t gfp)
 {
 	struct page *page;
-	unsigned long attrs = 0;
 
 	/*
 	 * Allocate from the atomic pools if memory is encrypted and
 	 * the allocation is atomic, because decrypting may block.
 	 */
-	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
+	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
 		void *vaddr;
 
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
-		/* swiotlb considered decrypted by default */
-		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-			attrs = DMA_ATTR_CC_SHARED;
-
 		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
 					   attrs, dma_coherent_ok);
 	}
@@ -638,7 +651,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
 
-	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
+	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit,
+					     !!(attrs & DMA_ATTR_CC_SHARED)))) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
@@ -657,15 +671,18 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
  * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
  * @vaddr:	Virtual address of the buffer.
  * @bytes:	Size of the buffer.
+ * @unencrypted: true if @vaddr was allocated decrypted and must be
+ *	re-encrypted before being freed
  */
-static void swiotlb_free_tlb(void *vaddr, size_t bytes)
+static void swiotlb_free_tlb(void *vaddr, size_t bytes, bool unencrypted)
 {
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(NULL, vaddr, bytes))
 		return;
 
 	/* Intentional leak if pages cannot be encrypted again. */
-	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (!unencrypted ||
+	    !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		__free_pages(virt_to_page(vaddr), get_order(bytes));
 }
 
@@ -676,6 +693,7 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
  * @nslabs:	Desired (maximum) number of slabs.
  * @nareas:	Number of areas.
  * @phys_limit:	Maximum DMA buffer physical address.
+ * @attrs:	DMA attributes for the allocation.
  * @gfp:	GFP flags for the allocations.
  *
  * Allocate and initialize a new IO TLB memory pool. The actual number of
@@ -686,7 +704,8 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
  */
 static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 		unsigned long minslabs, unsigned long nslabs,
-		unsigned int nareas, u64 phys_limit, gfp_t gfp)
+		unsigned int nareas, u64 phys_limit,
+		unsigned long attrs, gfp_t gfp)
 {
 	struct io_tlb_pool *pool;
 	unsigned int slot_order;
@@ -704,9 +723,10 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	if (!pool)
 		goto error;
 	pool->areas = (void *)pool + sizeof(*pool);
+	pool->unencrypted = !!(attrs & DMA_ATTR_CC_SHARED);
 
 	tlb_size = nslabs << IO_TLB_SHIFT;
-	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
+	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp))) {
 		if (nslabs <= minslabs)
 			goto error_tlb;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
@@ -724,7 +744,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	return pool;
 
 error_slots:
-	swiotlb_free_tlb(page_address(tlb), tlb_size);
+	swiotlb_free_tlb(page_address(tlb), tlb_size,
+			 !!(attrs & DMA_ATTR_CC_SHARED));
 error_tlb:
 	kfree(pool);
 error:
@@ -742,7 +763,9 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
 	struct io_tlb_pool *pool;
 
 	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
-				  default_nareas, mem->phys_limit, GFP_KERNEL);
+				  default_nareas, mem->phys_limit,
+				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
+				  GFP_KERNEL);
 	if (!pool) {
 		pr_warn_ratelimited("Failed to allocate new pool");
 		return;
@@ -762,7 +785,7 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
 	size_t tlb_size = pool->end - pool->start;
 
 	free_pages((unsigned long)pool->slots, get_order(slots_size));
-	swiotlb_free_tlb(pool->vaddr, tlb_size);
+	swiotlb_free_tlb(pool->vaddr, tlb_size, pool->unencrypted);
 	kfree(pool);
 }
 
@@ -1037,13 +1060,11 @@ static void dec_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
  * Return: Index of the first allocated slot, or -1 on error.
  */
 static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool,
-		int area_index, phys_addr_t orig_addr, size_t alloc_size,
-		unsigned int alloc_align_mask)
+		int area_index, phys_addr_t orig_addr, dma_addr_t tbl_dma_addr,
+		size_t alloc_size, unsigned int alloc_align_mask)
 {
 	struct io_tlb_area *area = pool->areas + area_index;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
-	dma_addr_t tbl_dma_addr =
-		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
 	unsigned int nslots = nr_slots(alloc_size), stride;
@@ -1056,6 +1077,8 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	tbl_dma_addr &= boundary_mask;
+
 	/*
 	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
 	 * page-aligned in the absence of any other alignment requirements.
@@ -1167,6 +1190,7 @@ static int swiotlb_search_area(struct device *dev, int start_cpu,
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
+	dma_addr_t tbl_dma_addr;
 	int area_index;
 	int index = -1;
 
@@ -1175,9 +1199,15 @@ static int swiotlb_search_area(struct device *dev, int start_cpu,
 		if (cpu_offset >= pool->nareas)
 			continue;
 		area_index = (start_cpu + cpu_offset) & (pool->nareas - 1);
+
+		if (mem->unencrypted)
+			tbl_dma_addr = phys_to_dma_unencrypted(dev, pool->start);
+		else
+			tbl_dma_addr = phys_to_dma_encrypted(dev, pool->start);
+
 		index = swiotlb_search_pool_area(dev, pool, area_index,
-						 orig_addr, alloc_size,
-						 alloc_align_mask);
+						 orig_addr, tbl_dma_addr,
+						 alloc_size, alloc_align_mask);
 		if (index >= 0) {
 			*retpool = pool;
 			break;
@@ -1207,6 +1237,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
+	dma_addr_t tbl_dma_addr;
 	unsigned long nslabs;
 	unsigned long flags;
 	u64 phys_limit;
@@ -1232,11 +1263,17 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	nslabs = nr_slots(alloc_size);
 	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
 	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
+				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
 				  GFP_NOWAIT);
 	if (!pool)
 		return -1;
 
-	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr,
+	if (mem->unencrypted)
+		tbl_dma_addr = phys_to_dma_unencrypted(dev, pool->start);
+	else
+		tbl_dma_addr = phys_to_dma_encrypted(dev, pool->start);
+
+	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr, tbl_dma_addr,
 					 alloc_size, alloc_align_mask);
 	if (index < 0) {
 		swiotlb_dyn_free(&pool->rcu);
@@ -1281,15 +1318,23 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask,
 		struct io_tlb_pool **retpool)
 {
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
+	dma_addr_t tbl_dma_addr;
 	int start, i;
 	int index;
 
-	*retpool = pool = &dev->dma_io_tlb_mem->defpool;
+	*retpool = pool = &mem->defpool;
+	if (mem->unencrypted)
+		tbl_dma_addr = phys_to_dma_unencrypted(dev, pool->start);
+	else
+		tbl_dma_addr = phys_to_dma_encrypted(dev, pool->start);
+
 	i = start = raw_smp_processor_id() & (pool->nareas - 1);
 	do {
 		index = swiotlb_search_pool_area(dev, pool, i, orig_addr,
-						 alloc_size, alloc_align_mask);
+						 tbl_dma_addr, alloc_size,
+						 alloc_align_mask);
 		if (index >= 0)
 			return index;
 		if (++i >= pool->nareas)
@@ -1372,9 +1417,19 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
  *			any pre- or post-padding for alignment
  * @alloc_align_mask:	Required start and end alignment of the allocated buffer
  * @dir:		DMA direction
- * @attrs:		Optional DMA attributes for the map operation
+ * @attrs:		Optional DMA attributes for the map operation, updated
+ *			to match the selected SWIOTLB pool
  *
  * Find and allocate a suitable sequence of IO TLB slots for the request.
+ * The device's SWIOTLB pool must match the device's current DMA encryption
+ * requirements. If the device requires decrypted DMA, bouncing is done through
+ * an unencrypted pool and the mapping is marked shared. If the device can DMA
+ * to encrypted memory, bouncing is done through an encrypted pool even when the
+ * original DMA address was unencrypted. Enabling encrypted DMA for a device is
+ * therefore expected to update its default io_tlb_mem to an encrypted pool, so
+ * later bounce mappings for both encrypted and decrypted original memory use
+ * that encrypted pool.
+ *
  * The allocated space starts at an alignment specified by alloc_align_mask,
  * and the size of the allocated space is rounded up so that the total amount
  * of allocated space is a multiple of (alloc_align_mask + 1). If
@@ -1411,6 +1466,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
+	/* swiotlb pool is incorrect for this device */
+	if (unlikely(mem->unencrypted != force_dma_unencrypted(dev)))
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	/* Force attrs to match the kind of memory in the pool */
+	if (mem->unencrypted)
+		*attrs |= DMA_ATTR_CC_SHARED;
+	else
+		*attrs &= ~DMA_ATTR_CC_SHARED;
+
 	/*
 	 * The default swiotlb memory pool is allocated with PAGE_SIZE
 	 * alignment. If a mapping is requested with larger alignment,
@@ -1608,8 +1673,11 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-	/* Ensure that the address returned is DMA'ble */
-	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
+	if (attrs & DMA_ATTR_CC_SHARED)
+		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
+	else
+		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
+
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
 		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC,
@@ -1773,7 +1841,7 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-struct page *swiotlb_alloc(struct device *dev, size_t size)
+struct page *swiotlb_alloc(struct device *dev, size_t size, unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
@@ -1784,6 +1852,9 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (!mem)
 		return NULL;
 
+	if (mem->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
+		return NULL;
+
 	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
 	index = swiotlb_find_slots(dev, 0, size, align, &pool);
 	if (index == -1)
@@ -1859,9 +1930,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			kfree(mem);
 			return -ENOMEM;
 		}
+		/*
+		 * if platform supports memory encryption,
+		 * restricted mem pool is decrypted by default
+		 */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+			mem->unencrypted = true;
+			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
+					     rmem->size >> PAGE_SHIFT);
+		} else {
+			mem->unencrypted = false;
+		}
 
-		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
 					 false, nareas);
 		mem->force_bounce = true;
-- 
2.43.0

