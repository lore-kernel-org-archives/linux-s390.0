Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAC38550E;
	Wed,  1 Jul 2026 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885107; cv=none; b=OJUxlBtTLhKrOaouh6RKHFrerZ9mnUNhm7wf38hla7waHoeggAM63b/e57morWGlneWIn+13zSqjJQSAMPxM1b9e+yp7JyL9wsWQEqASnoib3W/EWscdyXhaPPEG1d33/E8AozqcYePR6EMMwLYvkCK7wTVxIzevPIQS+ksl9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885107; c=relaxed/simple;
	bh=ifHAcrwPyS0XkQ6ngytneOu8Mmd8jC1niaLWTD+9Pu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2PfQS2pUcap2ejimI5rLc3UaJ37oDEEvzO6lYYr70o/Olr1S/E8PcAfaJtxwIVkPSA/ZFOYAo3zrbnqr44Dnlwq4Wvu5Y03o8gym9AIZKxtnO6YmOFoieCl3Ozgij1LljG1eUauou/8JdKhL1MCXfNrMIOCxQtR2KK9BTG3Rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKjpL103; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKjpL103"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D51F000E9;
	Wed,  1 Jul 2026 05:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885105;
	bh=vmGprFqXRuVbKD9OVfCO4x7FuqysMs6LItnIaQS7dqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKjpL103dR9QmENcjOHjAh8wj/cFfSNB10rOhdqRaMCM5bPZdSN+gd9ylPJuTQY4t
	 3ju6wH/KQQtFKNmXqNgCb1iAkGUzN0BScD1cIRhZu3ZMQa36UD26CHAPOswjMdBddo
	 lrjDNAGyH6NBtUJV8oGj60nc1y2YfajDr7+8Ee90GmCyT/JaxaOWg63uV5Hji+2qQw
	 tXvM3wXcjrVoGNmytJuNlVB+AS59Np7uJNN9z2s3IkL7m35Z8OxXeBDxxEHDviYY36
	 2FKg2YX9lG97234u4b+I/CSpUSn1XRNmQMmJ+cvhJ/hmddeywngzwB7idCEvFFIHc2
	 F3eEXAPqZ+n3w==
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
Subject: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and select them via attrs
Date: Wed,  1 Jul 2026 11:19:15 +0530
Message-ID: <20260701054926.825925-12-aneesh.kumar@kernel.org>
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
 kernel/dma/direct.c         |  11 ++-
 kernel/dma/pool.c           | 173 +++++++++++++++++++++++-------------
 kernel/dma/swiotlb.c        |   8 +-
 5 files changed, 129 insertions(+), 72 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 68c686c1e81a..a7b1da5e06e6 100644
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
index 98e47e0b332d..c50d6987438e 100644
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
@@ -244,7 +246,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
 		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  &ret, gfp);
+						  &ret, gfp, attrs);
 		return page ? ret : NULL;
 	}
 
@@ -392,7 +394,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  &ret, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 76bcafe03e44..5115a3e8c722 100644
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
@@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
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
 
@@ -129,12 +138,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
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
@@ -146,46 +153,52 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
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
+
+	/* if platform is using memory encryption atomic pools are by default shared. */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		dma_pool->cc_shared = true;
+	else
+		dma_pool->cc_shared = false;
 
-	ret = atomic_pool_expand(pool, pool_size, gfp);
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
@@ -211,21 +224,22 @@ static int __init dma_atomic_pool_init(void)
 
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
 
@@ -234,19 +248,44 @@ static int __init dma_atomic_pool_init(void)
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
 
@@ -276,16 +315,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
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
@@ -300,12 +343,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 
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
 
@@ -337,7 +382,7 @@ static void dma_pool_find_phys(struct gen_pool *pool, struct gen_pool_chunk *chu
 	match->found = true;
 }
 
-static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
+static bool dma_free_from_pool_phys(struct dma_gen_pool *dma_pool, phys_addr_t phys,
 				    size_t size)
 {
 	struct dma_pool_phys_match match = {
@@ -345,21 +390,21 @@ static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
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
 
 bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 	phys_addr_t phys = page_to_phys(page);
 
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

