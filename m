Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAF3EBF07;
	Thu,  4 Jun 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562442; cv=none; b=JPP3VYHOUW6q39YGWLuOaMsoDs8znHNgU7QNBm6yStKxASaZzu15io4Yajro+kj3Q3+yRl4XOkzO0jR3CNjHSFiHfM0ritvxAKeUX5ujBKwS6jtDQzmkyINrp1vSbDtSwBPn8Qy8RKE288fU3FD8gNg+87gdfDLFQw6T0sEIh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562442; c=relaxed/simple;
	bh=hUzEjBt2CN4lvcmmnF6q4DdaDW2TUw243P2pjhqN5MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuJBQK79/nA/VJwvV4ECEtZJaJuOPv6gbgP9IHdt1Ao/PE2v0slsSMCZPa6VCaImGQvgFLjGtOGP8jQfTwwabuAHWiZFWL0eul+5XL4OISKCvYj9Mggaz0gh+eFjlIYvWHVjbd2Rvlekb1A8c4tvKcGZI4hTc8RWvdPCODsPCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcu6QwQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcu6QwQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4186B1F00893;
	Thu,  4 Jun 2026 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562431;
	bh=06/l/ie87JUAu214M+kEjiVedXrxQg5tsimMv1iyt+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rcu6QwQ9robwXxBRcRoz7H6FcgSpQ+z2a9MiWQDQnkLRiP/1XvzL4YOAhZ2DCiYLy
	 ZRX8sqVN6RaqxwZ9gJtRFVE7kOsFapaZmGluem+X+y9YxXgyItgZ0ByYJyOOj7yz9j
	 h2wWznu29IfIuiumuAI7FOsblzm4Al8VE9NQ9R9jfoNsLvr7WOtMemAeavTYTr+Pwy
	 BSMhuu0S0GQH9kE/I1/FXmWZz5M1lm/uwE1u+oyiuTHKo/nw28v5JkxQOYoiauKTHc
	 M98C2fXvV7hcknQfWMHtIitHI+keJxH8mN4Pjgxx5r1GFPvik/MMwn5MCxowoNw9Zy
	 6+S6j7i4QbIdg==
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
Subject: [PATCH v6 02/20] dma-direct: swiotlb: handle swiotlb alloc/free outside __dma_direct_alloc_pages
Date: Thu,  4 Jun 2026 14:09:41 +0530
Message-ID: <20260604083959.1265923-3-aneesh.kumar@kernel.org>
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
index 3dae0f592063..133bb8ca9032 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -284,6 +284,8 @@ extern void swiotlb_print_info(void);
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
+void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, struct io_tlb_pool *pool);
 
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
@@ -299,6 +301,10 @@ static inline bool swiotlb_free(struct device *dev, struct page *page,
 {
 	return false;
 }
+static inline void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, struct io_tlb_pool *pool)
+{
+}
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
 	return false;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 583c5922bca2..a741c8a2ee66 100644
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
@@ -204,6 +193,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
+	bool mark_mem_decrypt = true;
 	struct page *page;
 	void *ret;
 
@@ -250,11 +240,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
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
@@ -281,7 +281,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
+		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
 			goto out_leak_pages;
 	}
 
@@ -298,10 +298,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
@@ -310,6 +311,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
+	phys_addr_t phys;
+	bool mark_mem_encrypted = true;
+	struct io_tlb_pool *swiotlb_pool;
 	unsigned int page_order = get_order(size);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
@@ -338,16 +342,25 @@ void dma_direct_free(struct device *dev, size_t size,
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
+		swiotlb_free_from_pool(dev, phys, size, swiotlb_pool);
+	else
+		dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -359,6 +372,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
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
@@ -366,6 +388,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	ret = page_address(page);
 	if (dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
+setup_page:
 	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
@@ -377,16 +400,28 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		struct page *page, dma_addr_t dma_addr,
 		enum dma_data_direction dir)
 {
+	phys_addr_t phys;
 	void *vaddr = page_address(page);
+	struct io_tlb_pool *swiotlb_pool;
+	bool mark_mem_encrypted = true;
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(dev, vaddr, size))
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
+		swiotlb_free_from_pool(dev, phys, size, swiotlb_pool);
+	else
+		dma_free_contiguous(dev, page, size);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f4..ac03a6856c2e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1809,6 +1809,12 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 	return true;
 }
 
+void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr, size_t size,
+		struct io_tlb_pool *pool)
+{
+	swiotlb_release_slots(dev, tlb_addr, pool);
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.43.0

