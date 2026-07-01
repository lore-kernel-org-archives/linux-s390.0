Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB5248873;
	Wed,  1 Jul 2026 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885063; cv=none; b=jy7O8meLs81V2UJroOP8uEBacjv9oIk44Ab5gwNo2gYBjq97Dp1BVgH3Q/8Qp+QQmGVUpSWMKBIUVQ5NozBwRxR79AzEaWqJKmd/tmps0AoKDvAn45sEO3kC3UCoUC1CSv25BD0KIHZGVsiBZotDVG8kQSwW0pzXFiIZDlxC4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885063; c=relaxed/simple;
	bh=tpJHn3llVSPqSs0wrMiA5YnBbWs8DzT/xg67f9HCwAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmQCkcMwKsUgFDMmKA7Ssu3GtFbStZ6EsZIZ7q/6tVT4erLcKr5eak7iISqNzU/pBMkBIvemDbXy5MfHFLO7ros4taOmkvxtjZMh92+5BP7NAcUNtmJE2nMCxCNxrWyaf2dn5MbklOWaVDjbjDu82uopQh3OL5hRe/djzzW+gLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4ummu0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4ummu0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256851F000E9;
	Wed,  1 Jul 2026 05:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885061;
	bh=l6vXauQthLLhdcQOpUcRGM0FaCqR81pFc4C7P/GgWik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F4ummu0X8Wir7Nw6xWmwZAyRZ+AK7/s9a02kdgNz0oCc2Drm4fBe1ETldV7IY9IUg
	 6q5hQ1t8O+nzfqV9TYP0pfeiTabwrSu5PeUy1xLlKqXTgYDxRbFEckIrx7NASxpfKv
	 6tlPc3Csz+901F6Gx6xHBJ9GbS74owT/lSxsaT0tvcEx846RA9Cr+Jhd3SO0A/irwF
	 3SaR1opeDQvdNZVXLe4MidG73ZeFuSuTyV2hujIDoCP5KoURYe8yF7nNeGMrKnxJVQ
	 I9M6ebcxlnTCUgCsFsUvAN2swgdtsh63Xjwu6rOiL0ybviGZe6Dw7niLCfFqJHP1QU
	 W0T8PvG7qbqXA==
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
Subject: [PATCH v7 07/22] dma-direct: swiotlb: handle swiotlb alloc/free outside __dma_direct_alloc_pages
Date: Wed,  1 Jul 2026 11:19:11 +0530
Message-ID: <20260701054926.825925-8-aneesh.kumar@kernel.org>
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

Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
dma_direct_alloc() / dma_direct_alloc_pages().

This is needed for follow-up changes that simplify the handling of
memory encryption/decryption based on the DMA attribute flags.

swiotlb backing pages are already mapped decrypted by
swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
dma-direct should not call dma_set_decrypted() on allocation nor
dma_set_encrypted() on free for swiotlb-backed memory.

Update alloc/free paths to detect swiotlb-backed pages and skip
encrypt/decrypt transitions for those paths. Keep the existing highmem
rejection in dma_direct_alloc_pages() for swiotlb allocations.

Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
typically used together with "shared-dma-pool", where the shared region is
accessed after remap/ioremap and the returned address is suitable for
decrypted memory access. So existing code paths remain valid.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h |  6 ++++
 kernel/dma/direct.c     | 71 ++++++++++++++++++++++++++++++-----------
 kernel/dma/swiotlb.c    |  6 ++++
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..c92ff6791595 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -284,6 +284,8 @@ extern void swiotlb_print_info(void);
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
+void swiotlb_free_from_pool(struct device *dev,
+		phys_addr_t tlb_addr, struct io_tlb_pool *pool);
 
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
@@ -299,6 +301,10 @@ static inline bool swiotlb_free(struct device *dev, struct page *page,
 {
 	return false;
 }
+static inline void swiotlb_free_from_pool(struct device *dev,
+		phys_addr_t tlb_addr, struct io_tlb_pool *pool)
+{
+}
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
 	return false;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 17f1e097499e..0cbf2b0835c4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -96,14 +96,6 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 	return ret;
 }
 
-static void __dma_direct_free_pages(struct device *dev, struct page *page,
-				    size_t size)
-{
-	if (swiotlb_free(dev, page, size))
-		return;
-	dma_free_contiguous(dev, page, size);
-}
-
 static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
 {
 	struct page *page = swiotlb_alloc(dev, size);
@@ -125,9 +117,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
-	if (is_swiotlb_for_alloc(dev))
-		return dma_direct_alloc_swiotlb(dev, size);
-
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
@@ -203,6 +192,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
+	bool mark_mem_decrypt = true;
 	struct page *page;
 	void *ret;
 
@@ -252,11 +242,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return page ? ret : NULL;
 	}
 
+	if (is_swiotlb_for_alloc(dev)) {
+		page = dma_direct_alloc_swiotlb(dev, size);
+		if (page) {
+			mark_mem_decrypt = false;
+			goto setup_page;
+		}
+		return NULL;
+	}
+
 	/* we always manually zero the memory once we are done */
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
 		return NULL;
 
+setup_page:
 	/*
 	 * dma_alloc_contiguous can return highmem pages depending on a
 	 * combination the cma= arguments and per-arch setup.  These need to be
@@ -283,7 +283,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
+		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
 			goto out_leak_pages;
 	}
 
@@ -300,10 +300,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	if (dma_set_encrypted(dev, page_address(page), size))
+	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
 		return NULL;
 out_free_pages:
-	__dma_direct_free_pages(dev, page, size);
+	if (!swiotlb_free(dev, page, size))
+		dma_free_contiguous(dev, page, size);
 	return NULL;
 out_leak_pages:
 	return NULL;
@@ -312,6 +313,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
+	phys_addr_t phys;
+	bool mark_mem_encrypted = true;
+	struct io_tlb_pool *swiotlb_pool;
 	unsigned int page_order = get_order(size);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
@@ -340,16 +344,25 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
+	phys = dma_to_phys(dev, dma_addr);
+	swiotlb_pool = swiotlb_find_pool(dev, phys);
+	if (swiotlb_pool)
+		/* Swiotlb doesn't need a page attribute update on free */
+		mark_mem_encrypted = false;
+
 	if (is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (dma_set_encrypted(dev, cpu_addr, size))
+		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
 			return;
 	}
 
-	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
+	if (swiotlb_pool)
+		swiotlb_free_from_pool(dev, phys, swiotlb_pool);
+	else
+		dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -361,6 +374,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
+	if (is_swiotlb_for_alloc(dev)) {
+		page = dma_direct_alloc_swiotlb(dev, size);
+		if (!page)
+			return NULL;
+
+		ret = page_address(page);
+		goto setup_page;
+	}
+
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
 		return NULL;
@@ -368,6 +390,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	ret = page_address(page);
 	if (dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
+setup_page:
 	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
@@ -379,16 +402,28 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		struct page *page, dma_addr_t dma_addr,
 		enum dma_data_direction dir)
 {
+	phys_addr_t phys;
 	void *vaddr = page_address(page);
+	struct io_tlb_pool *swiotlb_pool;
+	bool mark_mem_encrypted = true;
 
 	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool_page(dev, page, size))
 		return;
 
-	if (dma_set_encrypted(dev, vaddr, size))
+	phys = page_to_phys(page);
+	swiotlb_pool = swiotlb_find_pool(dev, phys);
+	if (swiotlb_pool)
+		mark_mem_encrypted = false;
+
+	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
 		return;
-	__dma_direct_free_pages(dev, page, size);
+
+	if (swiotlb_pool)
+		swiotlb_free_from_pool(dev, phys, swiotlb_pool);
+	else
+		dma_free_contiguous(dev, page, size);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6e8db52866bf..d54154c165e5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1815,6 +1815,12 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 	return true;
 }
 
+void swiotlb_free_from_pool(struct device *dev,
+		phys_addr_t tlb_addr, struct io_tlb_pool *pool)
+{
+	swiotlb_release_slots(dev, tlb_addr, pool);
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.43.0

