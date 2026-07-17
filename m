Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3454376A10;
	Fri, 17 Jul 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311631; cv=none; b=RXZ4WfSWY1TTS46oYw9Kuz8Z2/evbazGRUZdJWerECwpgj33bB1YnB+H1D45gtQXotpowgwfS+A47wRw1dsCYN7sAGsLec2DmvE6cvTEC/yYrC1swWOY8vUVTVD+75MzJ3mlfXg+GrWjWsuwyF3u7sBg1SPx5QbA8PBBnp68A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311631; c=relaxed/simple;
	bh=cAFZioD4AMqqSP52hQFgVt1KAj+aPXZcAUrSxBKhWMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpQfrE3R2/yWKnrA/VqRVJKzfY0NC5CGaSCDR3KS2/DOy5CnyPGQTNWrnDdtjMjt41AzjAmrf2/tVFRZ2CM48l1wjfyY6vDpAks/nr86dO7zAvUA7uYHsaAKHsFLmS/qZZZNPCFF/Zbpoi1RpP7TuJv8BSZHSqqPrTX1k5tC9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0+VA3JA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0+VA3JA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B21F00A3A;
	Fri, 17 Jul 2026 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311629;
	bh=zhoVNQSfeQOGKOCtTTE1JWqlBu+3klDpNUZDVpGU7EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0+VA3JAWbdPoQbmXdHAnN7Sv+U3kKQpLHcPqeUfp+S9evEFyzUdhcfTDpFNXOjD9
	 P9+F3EkKGXxjHMrJiS1uJYkGabvlQvQpRP/ELqNyIgwG98qHAY+3IUF9mMbG98w80s
	 d8X2E4U1c18+TF1WK6LAe76qxSGxqM/Rge8yGopiua76qhfkDRZOymmjvwh3qmWFmj
	 BhjdqVY4Kl9eRfvujqJ69fNHZKD0poZnESHrvy63gOpXtTnHr3qVNhAj+YVdN+EbP5
	 adSJLvL6OrqDlYdgovZ7JyjmCUyRA50YKZo1XWojFLQKf9MnPN4r9lP//aj8leL6Wy
	 cbQvWXYVHaljg==
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
Subject: [PATCH v8 11/23] dma-pool: track decrypted atomic pools and select them via attrs
Date: Fri, 17 Jul 2026 23:34:29 +0530
Message-ID: <20260717180442.110954-12-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the atomic DMA pool code to distinguish between encrypted and
unencrypted pools, and make pool allocation select the matching pool based
on DMA attributes.

Introduce a dma_gen_pool wrapper that records whether a pool is
unencrypted, initialize that state when the atomic pools are created, and
use it when expanding and resizing the pools. Update dma_alloc_from_pool()
to take attrs and skip pools whose encrypted state does not match
__DMA_ATTR_ALLOC_CC_SHARED. Update dma_free_from_pool() accordingly.

Also pass __DMA_ATTR_ALLOC_CC_SHARED from the swiotlb atomic allocation
path so decrypted swiotlb allocations are taken from the correct atomic
pool.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c   |   7 +-
 include/linux/dma-map-ops.h |   2 +-
 kernel/dma/direct.c         |  14 ++-
 kernel/dma/pool.c           | 182 +++++++++++++++++++++++-------------
 kernel/dma/swiotlb.c        |   8 +-
 5 files changed, 139 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6a45acbbfb0c..83bf15ae9777 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1660,9 +1660,14 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	bool is_alloc_cc_shared = attrs & __DMA_ATTR_ALLOC_CC_SHARED;
 	struct page *page = NULL;
 	void *cpu_addr;
 
+	/* Not yet supported */
+	if (is_alloc_cc_shared)
+		return NULL;
+
 	gfp |= __GFP_ZERO;
 
 	if (gfpflags_allow_blocking(gfp) &&
@@ -1673,7 +1678,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent) {
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					   gfp, NULL);
+					   gfp, attrs, NULL);
 		if (!page)
 			return NULL;
 	} else {
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 137e015c1750..8fae2b7deb20 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t flags,
+		void **cpu_addr, gfp_t flags, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1b49ba5e0a60..6960ee1cfefe 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -154,7 +154,8 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 }
 
 static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
+		unsigned long attrs)
 {
 	struct page *page;
 	u64 phys_limit;
@@ -163,7 +164,8 @@ static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
+				   dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
@@ -240,11 +242,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	/*
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
+	 * FIXME: With CONFIG_DMA_DIRECT_REMAP, the pool is also mapped as
+	 * DMA-coherent (non-cacheable). We may want to create a separate pool
+	 * dedicated to CC_SHARED atomic allocations.
 	 */
 	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
 		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  &ret, gfp);
+						  &ret, gfp, attrs);
 		return page ? ret : NULL;
 	}
 
@@ -392,7 +397,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  &ret, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index e981c1faaadf..00f422a1e896 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -12,12 +12,18 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/cc_platform.h>
 
-static struct gen_pool *atomic_pool_dma __ro_after_init;
+struct dma_gen_pool {
+	bool cc_shared;
+	struct gen_pool *pool;
+};
+
+static struct dma_gen_pool atomic_pool_dma __ro_after_init;
 static unsigned long pool_size_dma;
-static struct gen_pool *atomic_pool_dma32 __ro_after_init;
+static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
 static unsigned long pool_size_dma32;
-static struct gen_pool *atomic_pool_kernel __ro_after_init;
+static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
@@ -76,7 +82,7 @@ static bool cma_in_zone(gfp_t gfp)
 	return true;
 }
 
-static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
@@ -84,6 +90,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	bool leak_pages = false;
 	void *addr;
 	int ret = -ENOMEM;
+	pgprot_t prot __maybe_unused;
 
 	/* Cannot allocate larger than MAX_PAGE_ORDER */
 	order = min(get_order(pool_size), MAX_PAGE_ORDER);
@@ -102,8 +109,12 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	arch_dma_prep_coherent(page, pool_size);
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
-	addr = dma_common_contiguous_remap(page, pool_size,
-			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+	if (dma_pool->cc_shared)
+		prot = pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL));
+	else
+		prot = pgprot_dmacoherent(PAGE_KERNEL);
+
+	addr = dma_common_contiguous_remap(page, pool_size, prot,
 			__builtin_return_address(0));
 	if (!addr)
 		goto free_page;
@@ -114,14 +125,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
 	 * shrink so no re-encryption occurs in dma_direct_free().
 	 */
-	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
-				   1 << order);
-	if (ret) {
-		leak_pages = true;
-		goto remove_mapping;
+	if (dma_pool->cc_shared) {
+		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+					   1 << order);
+		if (ret) {
+			leak_pages = true;
+			goto remove_mapping;
+		}
 	}
-	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
-				pool_size, NUMA_NO_NODE);
+
+	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
+				page_to_phys(page), pool_size, NUMA_NO_NODE);
 	if (ret)
 		goto encrypt_mapping;
 
@@ -129,12 +143,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return 0;
 
 encrypt_mapping:
-	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
-				   1 << order);
-	if (WARN_ON_ONCE(ret)) {
-		/* Decrypt succeeded but encrypt failed, purposely leak */
+	if (dma_pool->cc_shared &&
+	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
 		leak_pages = true;
-	}
+
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
@@ -146,46 +158,52 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return ret;
 }
 
-static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
+static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
 {
-	if (pool && gen_pool_avail(pool) < atomic_pool_size)
-		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
+	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
+		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
 }
 
 static void atomic_pool_work_fn(struct work_struct *work)
 {
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		atomic_pool_resize(atomic_pool_dma,
+		atomic_pool_resize(&atomic_pool_dma,
 				   GFP_KERNEL | GFP_DMA);
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		atomic_pool_resize(atomic_pool_dma32,
+		atomic_pool_resize(&atomic_pool_dma32,
 				   GFP_KERNEL | GFP_DMA32);
-	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
+	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
 }
 
-static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
-						      gfp_t gfp)
+static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
+		size_t pool_size, gfp_t gfp)
 {
-	struct gen_pool *pool;
 	int ret;
 
-	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
-	if (!pool)
+	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!dma_pool->pool)
 		return NULL;
 
-	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
+	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
 
-	ret = atomic_pool_expand(pool, pool_size, gfp);
+	/* if platform is using memory encryption atomic pools are by default shared. */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		dma_pool->cc_shared = true;
+	else
+		dma_pool->cc_shared = false;
+
+	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
 	if (ret) {
-		gen_pool_destroy(pool);
+		gen_pool_destroy(dma_pool->pool);
+		dma_pool->pool = NULL;
 		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
 		       pool_size >> 10, &gfp);
 		return NULL;
 	}
 
 	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
-		gen_pool_size(pool) >> 10, &gfp);
-	return pool;
+		gen_pool_size(dma_pool->pool) >> 10, &gfp);
+	return dma_pool;
 }
 
 #ifdef CONFIG_ZONE_DMA32
@@ -211,21 +229,22 @@ static int __init dma_atomic_pool_init(void)
 
 	/* All memory might be in the DMA zone(s) to begin with */
 	if (has_managed_zone(ZONE_NORMAL)) {
-		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
-						    GFP_KERNEL);
-		if (!atomic_pool_kernel)
+		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
+		if (!atomic_pool_kernel.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma()) {
-		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
-		if (!atomic_pool_dma)
+		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA);
+		if (!atomic_pool_dma.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma32) {
-		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
+		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA32);
+		if (!atomic_pool_dma32.pool)
 			ret = -ENOMEM;
 	}
 
@@ -234,19 +253,44 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
+static inline struct dma_gen_pool *__dma_guess_pool(struct dma_gen_pool *first,
+		struct dma_gen_pool *second, struct dma_gen_pool *third)
 {
-	if (prev == NULL) {
+	if (first->pool)
+		return first;
+	if (second && second->pool)
+		return second;
+	if (third && third->pool)
+		return third;
+	return NULL;
+}
+
+static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev,
+		gfp_t gfp)
+{
+	if (!prev) {
 		if (gfp & GFP_DMA)
-			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
+			return __dma_guess_pool(&atomic_pool_dma,
+						&atomic_pool_dma32,
+						&atomic_pool_kernel);
+
 		if (gfp & GFP_DMA32)
-			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
-		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
+			return __dma_guess_pool(&atomic_pool_dma32,
+						&atomic_pool_dma,
+						&atomic_pool_kernel);
+
+		return __dma_guess_pool(&atomic_pool_kernel,
+					&atomic_pool_dma32,
+					&atomic_pool_dma);
 	}
-	if (prev == atomic_pool_kernel)
-		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
-	if (prev == atomic_pool_dma32)
-		return atomic_pool_dma;
+
+	if (prev == &atomic_pool_kernel)
+		return __dma_guess_pool(&atomic_pool_dma32,
+					&atomic_pool_dma, NULL);
+
+	if (prev == &atomic_pool_dma32)
+		return __dma_guess_pool(&atomic_pool_dma, NULL, NULL);
+
 	return NULL;
 }
 
@@ -276,16 +320,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
 }
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t gfp,
+		void **cpu_addr, gfp_t gfp, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 	struct page *page;
 	bool pool_found = false;
 
-	while ((pool = dma_guess_pool(pool, gfp))) {
+	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
+
+		if (dma_pool->cc_shared != !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED))
+			continue;
+
 		pool_found = true;
-		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
+		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
 					     phys_addr_ok);
 		if (page)
 			return page;
@@ -300,12 +348,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
+
+	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
 
-	while ((pool = dma_guess_pool(pool, 0))) {
-		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
 			continue;
-		gen_pool_free(pool, (unsigned long)start, size);
+
+		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
 		return true;
 	}
 
@@ -337,7 +387,7 @@ static void dma_pool_find_phys(struct gen_pool *pool, struct gen_pool_chunk *chu
 	match->found = true;
 }
 
-static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
+static bool dma_free_from_pool_phys(struct dma_gen_pool *dma_pool, phys_addr_t phys,
 				    size_t size)
 {
 	struct dma_pool_phys_match match = {
@@ -345,11 +395,11 @@ static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
 		.size = size,
 	};
 
-	gen_pool_for_each_chunk(pool, dma_pool_find_phys, &match);
+	gen_pool_for_each_chunk(dma_pool->pool, dma_pool_find_phys, &match);
 	if (!match.found)
 		return false;
 
-	gen_pool_free(pool, match.addr, size);
+	gen_pool_free(dma_pool->pool, match.addr, size);
 	return true;
 }
 
@@ -359,14 +409,14 @@ static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
  */
 bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 	phys_addr_t phys = page_to_phys(page);
 
 	if (!IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
 		return dma_free_from_pool(dev, page_address(page), size);
 
-	while ((pool = dma_guess_pool(pool, 0))) {
-		if (dma_free_from_pool_phys(pool, phys, size))
+	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
+		if (dma_free_from_pool_phys(dma_pool, phys, size))
 			return true;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d54154c165e5..908de28aceb2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -613,9 +613,9 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 		u64 phys_limit, gfp_t gfp, void **vaddr)
 {
 	struct page *page;
+	unsigned long attrs = 0;
 
 	*vaddr = NULL;
-
 	/*
 	 * Allocate from the atomic pools if memory is encrypted and
 	 * the allocation is atomic, because decrypting may block.
@@ -624,8 +624,12 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
+		/* swiotlb considered decrypted by default */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+			attrs = __DMA_ATTR_ALLOC_CC_SHARED;
+
 		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
-					   dma_coherent_ok);
+					   attrs, dma_coherent_ok);
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-- 
2.43.0

