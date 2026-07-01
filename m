Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDD397691;
	Wed,  1 Jul 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885130; cv=none; b=W66tEVy47MOk7xpuTBYlg6gm0cL/Dmwne/10N6QZWbsL34OACVhLpIEGE0eARUh+1pMlXP0Pbbz1BhRiQ4E2AoR5G9l8gTCF6/Dffg9BQJBIWBTDOeU21yv6DXhQOyMYiNm9c/xIC7eAGb28sS9/IUnk1RR0A7lNwAvw+0zg2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885130; c=relaxed/simple;
	bh=SQYNyHZj6+nYbDL9WNrj5WVL2BmvjtFWFyJngem+gpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHCyyDB/mBuPTy/N9kWXd3HMNiqpeW8Ec+6XHjT43VYAvgdWwbejvTnXJ+uaL3yPMpvKT5JjE21rHvficC8Ea3vrvRlY2IGfnhRDK/TfRw+eiyuyEVhgmCAOeYtKMN6YkIQ8rlW6wx8g9sJwPMVKDLZSSNIqby51ReUI9J0bdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyRZU/QF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyRZU/QF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD991F000E9;
	Wed,  1 Jul 2026 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885127;
	bh=wIxLep1mD/eknymX2Qr1M4uqCL+HgMworT5UPL6Zh1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyRZU/QFW+/IxGNIBH60VmPTE/MbfetYCbzKgpTa2r5rbVLbJEEgdpl6UHNmNFXaN
	 2qWrnmP/sv8udQNInqnpTjzB2Zk524wxRgMfrjhPpxCAagq9tWTYcvtE6RKS6bi5FA
	 O6LoNSH+ig8ZeaCnwhk1f0t5r5BCu98WObltz0E4ZZdRhfFnwNTVbp1rMDh7nFgZVr
	 SxWep76OMuMqcSD0H5NqlfD9qc50QvPM7nPfu+2TtS2MMk1Auj50saU9i+N+z2Dynj
	 2qlHinkZIWddD/s8GAe3/myVLHmld73S4SfhTZiHPv1c9GZiFGtiew04DvdRy0Rofp
	 ro6inY6KpaNbw==
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
Subject: [PATCH v7 13/22] dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
Date: Wed,  1 Jul 2026 11:19:17 +0530
Message-ID: <20260701054926.825925-14-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
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

Add a cc_shared flag to io_tlb_mem, initialize it for the default and
restricted pools, and propagate __DMA_ATTR_ALLOC_CC_SHARED into swiotlb
pool allocation. Reject swiotlb alloc/map requests when the selected pool
does not match the required encrypted/decrypted state.

Also return DMA addresses with the matching phys_to_dma_{encrypted,
unencrypted} helper so the DMA address encoding stays consistent with the
chosen pool.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/dma-direct.h |  10 +++
 include/linux/swiotlb.h    |  10 ++-
 kernel/dma/direct.c        |  13 ++-
 kernel/dma/swiotlb.c       | 177 ++++++++++++++++++++++++++++---------
 4 files changed, 162 insertions(+), 48 deletions(-)

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
index ea4c0a292dea..ee42f7588847 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -66,6 +66,7 @@ extern void __init swiotlb_update_mem_attributes(void);
  * @node:	Member of the IO TLB memory pool list.
  * @rcu:	RCU head for swiotlb_dyn_free().
  * @transient:  %true if transient memory pool.
+ * @cc_shared:	%true if the pool memory is shared for confidential computing.
  */
 struct io_tlb_pool {
 	phys_addr_t start;
@@ -81,6 +82,7 @@ struct io_tlb_pool {
 	struct list_head node;
 	struct rcu_head rcu;
 	bool transient;
+	bool cc_shared;
 #endif
 };
 
@@ -92,6 +94,7 @@ struct io_tlb_pool {
  * @debugfs:	The dentry to debugfs.
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
+ * @cc_shared:	%true if the pool memory is shared for confidential computing.
  * @can_grow:	%true if more pools can be allocated dynamically.
  * @phys_limit:	Maximum allowed physical address.
  * @lock:	Lock to synchronize changes to the list.
@@ -111,6 +114,7 @@ struct io_tlb_mem {
 	struct dentry *debugfs;
 	bool force_bounce;
 	bool for_alloc;
+	bool cc_shared;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	bool can_grow;
 	u64 phys_limit;
@@ -282,7 +286,8 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
 extern void swiotlb_print_info(void);
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-struct page *swiotlb_alloc(struct device *dev, size_t size);
+struct page *swiotlb_alloc(struct device *dev, size_t size,
+		unsigned long attrs);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
 void swiotlb_free_from_pool(struct device *dev,
 		phys_addr_t tlb_addr, struct io_tlb_pool *pool);
@@ -292,7 +297,8 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
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
index c50d6987438e..64cb9f13ef03 100644
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
@@ -251,8 +252,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
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
@@ -398,7 +403,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 						  &ret, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
-		page = dma_direct_alloc_swiotlb(dev, size);
+		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 046ae92c4832..335e27bc1e1f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -259,10 +259,21 @@ void __init swiotlb_update_mem_attributes(void)
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long bytes;
 
+	/*
+	 * if platform support memory encryption, swiotlb buffers are
+	 * shared by default.
+	 */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		io_tlb_default_mem.cc_shared = true;
+	else
+		io_tlb_default_mem.cc_shared = false;
+
 	if (!mem->nslabs || mem->late_alloc)
 		return;
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
-	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
+
+	if (io_tlb_default_mem.cc_shared)
+		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
 }
 
 static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
@@ -505,8 +516,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->slots)
 		goto error_slots;
 
-	set_memory_decrypted((unsigned long)vstart,
-			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+	if (io_tlb_default_mem.cc_shared)
+		set_memory_decrypted((unsigned long)vstart,
+				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+
 	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
 				 nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
@@ -539,7 +552,9 @@ void __init swiotlb_exit(void)
 	tbl_size = PAGE_ALIGN(mem->end - mem->start);
 	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
 
-	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+	if (io_tlb_default_mem.cc_shared)
+		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+
 	if (mem->late_alloc) {
 		area_order = get_order(array_size(sizeof(*mem->areas),
 			mem->nareas));
@@ -563,6 +578,7 @@ void __init swiotlb_exit(void)
  * @gfp:	GFP flags for the allocation.
  * @bytes:	Size of the buffer.
  * @phys_limit:	Maximum allowed physical address of the buffer.
+ * @attrs:	DMA attributes for the allocation.
  *
  * Allocate pages from the buddy allocator. If successful, make the allocated
  * pages decrypted that they can be used for DMA.
@@ -570,9 +586,11 @@ void __init swiotlb_exit(void)
  * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
  * if the allocated physical address was above @phys_limit.
  */
-static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
+		u64 phys_limit, unsigned long attrs)
 {
 	unsigned int order = get_order(bytes);
+	bool cc_shared = attrs & __DMA_ATTR_ALLOC_CC_SHARED;
 	struct page *page;
 	phys_addr_t paddr;
 	void *vaddr;
@@ -588,13 +606,13 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 	}
 
 	vaddr = phys_to_virt(paddr);
-	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (cc_shared && set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		goto error;
 	return page;
 
 error:
 	/* Intentional leak if pages cannot be encrypted again. */
-	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (cc_shared && !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		__free_pages(page, order);
 	return NULL;
 }
@@ -602,6 +620,7 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 /**
  * swiotlb_alloc_tlb() - allocate a dynamic IO TLB buffer
  * @dev:	Device for which a memory pool is allocated.
+ * @mem:	SWIOTLB allocator for the pool.
  * @bytes:	Size of the buffer.
  * @phys_limit:	Maximum allowed physical address of the buffer.
  * @gfp:	GFP flags for the allocation.
@@ -609,25 +628,23 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
  *
  * Return: Allocated pages, or %NULL on allocation failure.
  */
-static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
+static struct page *swiotlb_alloc_tlb(struct device *dev,
+		struct io_tlb_mem *mem, size_t bytes,
 		u64 phys_limit, gfp_t gfp, void **vaddr)
 {
 	struct page *page;
-	unsigned long attrs = 0;
+	unsigned long attrs = mem->cc_shared ? __DMA_ATTR_ALLOC_CC_SHARED : 0;
 
 	*vaddr = NULL;
 	/*
 	 * Allocate from the atomic pools if memory is encrypted and
 	 * the allocation is atomic, because decrypting may block.
 	 */
-	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
+	if (!gfpflags_allow_blocking(gfp) && dev && mem->cc_shared) {
+
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
-		/* swiotlb considered decrypted by default */
-		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-			attrs = __DMA_ATTR_ALLOC_CC_SHARED;
-
 		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
 					   attrs, dma_coherent_ok);
 	}
@@ -638,7 +655,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
 
-	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
+	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit, attrs))) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
@@ -659,21 +676,25 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
  * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
  * @vaddr:	Virtual address of the buffer.
  * @bytes:	Size of the buffer.
+ * @cc_shared: true if @vaddr was allocated decrypted and must be
+ *	re-encrypted before being freed
  */
-static void swiotlb_free_tlb(void *vaddr, size_t bytes)
+static void swiotlb_free_tlb(void *vaddr, size_t bytes, bool cc_shared)
 {
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(NULL, vaddr, bytes))
 		return;
 
 	/* Intentional leak if pages cannot be encrypted again. */
-	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (!cc_shared ||
+	    !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		__free_pages(virt_to_page(vaddr), get_order(bytes));
 }
 
 /**
  * swiotlb_alloc_pool() - allocate a new IO TLB memory pool
  * @dev:	Device for which a memory pool is allocated.
+ * @mem:	SWIOTLB allocator for the pool.
  * @minslabs:	Minimum number of slabs.
  * @nslabs:	Desired (maximum) number of slabs.
  * @nareas:	Number of areas.
@@ -687,8 +708,9 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
  * Return: New memory pool, or %NULL on allocation failure.
  */
 static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
-		unsigned long minslabs, unsigned long nslabs,
-		unsigned int nareas, u64 phys_limit, gfp_t gfp)
+		struct io_tlb_mem *mem, unsigned long minslabs,
+		unsigned long nslabs, unsigned int nareas, u64 phys_limit,
+		gfp_t gfp)
 {
 	struct io_tlb_pool *pool;
 	unsigned int slot_order;
@@ -707,10 +729,11 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	if (!pool)
 		goto error;
 	pool->areas = (void *)pool + sizeof(*pool);
+	pool->cc_shared = mem->cc_shared;
 
 	tlb_size = nslabs << IO_TLB_SHIFT;
-	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp,
-					 &tlb_vaddr))) {
+	while (!(tlb = swiotlb_alloc_tlb(dev, mem, tlb_size,
+					 phys_limit, gfp, &tlb_vaddr))) {
 		if (nslabs <= minslabs)
 			goto error_tlb;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
@@ -729,7 +752,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	return pool;
 
 error_slots:
-	swiotlb_free_tlb(tlb_vaddr, tlb_size);
+	swiotlb_free_tlb(tlb_vaddr, tlb_size, mem->cc_shared);
 error_tlb:
 	kfree(pool);
 error:
@@ -746,7 +769,7 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
 		container_of(work, struct io_tlb_mem, dyn_alloc);
 	struct io_tlb_pool *pool;
 
-	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
+	pool = swiotlb_alloc_pool(NULL, mem, IO_TLB_MIN_SLABS, default_nslabs,
 				  default_nareas, mem->phys_limit, GFP_KERNEL);
 	if (!pool) {
 		pr_warn_ratelimited("Failed to allocate new pool");
@@ -767,7 +790,7 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
 	size_t tlb_size = pool->end - pool->start;
 
 	free_pages((unsigned long)pool->slots, get_order(slots_size));
-	swiotlb_free_tlb(pool->vaddr, tlb_size);
+	swiotlb_free_tlb(pool->vaddr, tlb_size, pool->cc_shared);
 	kfree(pool);
 }
 
@@ -1031,6 +1054,7 @@ static void dec_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
  * @pool:	Memory pool to be searched.
  * @area_index:	Index of the IO TLB memory area to be searched.
  * @orig_addr:	Original (non-bounced) IO buffer address.
+ * @tbl_dma_addr: DMA address of the bounce buffer.
  * @alloc_size: Total requested size of the bounce buffer,
  *		including initial alignment padding.
  * @alloc_align_mask:	Required alignment of the allocated buffer.
@@ -1042,13 +1066,11 @@ static void dec_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
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
@@ -1061,6 +1083,8 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	tbl_dma_addr &= boundary_mask;
+
 	/*
 	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
 	 * page-aligned in the absence of any other alignment requirements.
@@ -1172,6 +1196,7 @@ static int swiotlb_search_area(struct device *dev, int start_cpu,
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
+	dma_addr_t tbl_dma_addr;
 	int area_index;
 	int index = -1;
 
@@ -1180,9 +1205,15 @@ static int swiotlb_search_area(struct device *dev, int start_cpu,
 		if (cpu_offset >= pool->nareas)
 			continue;
 		area_index = (start_cpu + cpu_offset) & (pool->nareas - 1);
+
+		if (mem->cc_shared)
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
@@ -1212,6 +1243,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
+	dma_addr_t tbl_dma_addr;
 	unsigned long nslabs;
 	unsigned long flags;
 	u64 phys_limit;
@@ -1236,12 +1268,17 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 	nslabs = nr_slots(alloc_size);
 	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
-	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
+	pool = swiotlb_alloc_pool(dev, mem, nslabs, nslabs, 1, phys_limit,
 				  GFP_NOWAIT);
 	if (!pool)
 		return -1;
 
-	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr,
+	if (mem->cc_shared)
+		tbl_dma_addr = phys_to_dma_unencrypted(dev, pool->start);
+	else
+		tbl_dma_addr = phys_to_dma_encrypted(dev, pool->start);
+
+	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr, tbl_dma_addr,
 					 alloc_size, alloc_align_mask);
 	if (index < 0) {
 		swiotlb_dyn_free(&pool->rcu);
@@ -1286,15 +1323,23 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
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
+	if (mem->cc_shared)
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
@@ -1377,9 +1422,19 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
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
@@ -1416,6 +1471,30 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+
+		/* swiotlb pool is incorrect for this device */
+		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
+			return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/*
+		 * On hosts with memory encryption, SWIOTLB-backed memory is
+		 * unencrypted. DMA addresses returned for bounce buffers must
+		 * therefore be marked unencrypted, even for devices that can
+		 * address encrypted memory. This also preserves swiotlb=force
+		 * behavior for those devices.
+		 */
+		if (unlikely(!mem->cc_shared))
+			return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	/* Force attrs to match the kind of memory in the pool */
+	if (mem->cc_shared)
+		*attrs |= DMA_ATTR_CC_SHARED;
+	else
+		*attrs &= ~DMA_ATTR_CC_SHARED;
+
 	/*
 	 * The default swiotlb memory pool is allocated with PAGE_SIZE
 	 * alignment. If a mapping is requested with larger alignment,
@@ -1613,8 +1692,11 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
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
@@ -1778,7 +1860,7 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-struct page *swiotlb_alloc(struct device *dev, size_t size)
+struct page *swiotlb_alloc(struct device *dev, size_t size, unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
@@ -1789,6 +1871,9 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (!mem)
 		return NULL;
 
+	if (mem->cc_shared != !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED))
+		return NULL;
+
 	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
 	index = swiotlb_find_slots(dev, 0, size, align, &pool);
 	if (index == -1)
@@ -1864,12 +1949,20 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			kfree(mem);
 			return -ENOMEM;
 		}
+		/*
+		 * if platform supports memory encryption,
+		 * restricted mem pool is shared by default
+		 */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+			mem->cc_shared = true;
+			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
+					     rmem->size >> PAGE_SHIFT);
+		} else {
+			mem->cc_shared = false;
+		}
 
-		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
-					 nslabs,
-					 false, nareas);
+					 nslabs, false, nareas);
 		mem->force_bounce = true;
 		mem->for_alloc = true;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
-- 
2.43.0

