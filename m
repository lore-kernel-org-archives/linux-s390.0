Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D53E1224;
	Thu,  4 Jun 2026 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562589; cv=none; b=GkYm74GArQmJp01MI3GgWlSNUyyRqsEA3onQHV2TYlKiKL6hQt0aWDOKowTItNml6VZ3zKR4zjAcFMRoiTlBYFp77ere8cSb3eljOyRHn2v4yq7ZAa5B6FfW7klNC10UtuCQlTA2ld7/isj1ix5T119AMF7eGVCEyTWRGUydsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562589; c=relaxed/simple;
	bh=TegZPjM3rQ+HL/D+iEWYjVCfP3sBZRjsMLXnOkhdCHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O777Bcy3Ontk1Xj8ti+nlfzLvfhvKFzKFZl8NAu71souscijAsvw3QWlhE5lJOdSJSRz4bPpdbkB+1rBkULSA3y0c2Qckbm5pTdkRHjv5CVZVYK6kQJ79HiOlShZx41/qvmDE8+yvAARbaNRIbiEExUozyYFqecuxClhebN7RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB9gQ4aF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB9gQ4aF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D721F00893;
	Thu,  4 Jun 2026 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562587;
	bh=28gAGxAT6yyFPOrZbknmeVeC1tPuyb3t0ezhz06WVCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nB9gQ4aFlKUpGUcihtsmI/cFkRNvSLQlBMVfFfId6za3U9oIZifeElqfvJ/gMMYLV
	 kK9nLDYi/76JeTYI0eOMh6Ev87PICHvhy0d1ZKgpW4V7V0HhFFF5pltK8QUwBgbaaU
	 AfTbyxMYiMbryQfwJ65A2G2jc3RkvI/TeFKscmT4OobGaUuPuVSaPsf+Y9qMoAzQ+w
	 qQShsxWWYTx1w+YWqV2DLGX6UxvSmK9OjRoCDsr0peBDdamrU4PWYXtZy55sxBwaSo
	 WpS//rd8RA5c1c8l+zl23/OHY/f2k3XfRfr004sW3x9c754aQDpKx39tz9vKXx6uZO
	 kzFmq6SY4lRqw==
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v6 19/20] swiotlb: Preserve allocation virtual address for dynamic pools
Date: Thu,  4 Jun 2026 14:09:58 +0530
Message-ID: <20260604083959.1265923-20-aneesh.kumar@kernel.org>
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

swiotlb_alloc_tlb() can allocate from the DMA atomic pool when a decrypted
pool is needed from atomic context. With CONFIG_DMA_DIRECT_REMAP, the
atomic pool is backed by remapped virtual addresses, which are not the same
as the direct-map addresses returned by phys_to_virt().

swiotlb_init_io_tlb_pool() currently reconstructs the pool virtual address
from the physical start address. For atomic-pool backed allocations this
stores the wrong address in pool->vaddr. Later, swiotlb_free_tlb() passes
that address to dma_free_from_pool(), which will fail to recognize the
chunk

Pass the virtual address returned by the allocation path into
swiotlb_init_io_tlb_pool(), and store that address in pool->vaddr. This
keeps the pool free path using the same virtual address as the allocator.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 14d834ca298b..e4bd8c9eaeda 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -302,9 +302,9 @@ void __init swiotlb_update_mem_attributes(void)
 }
 
 static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
-		unsigned long nslabs, bool late_alloc, unsigned int nareas)
+		void *vaddr, unsigned long nslabs, bool late_alloc,
+		unsigned int nareas)
 {
-	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 
 	mem->nslabs = nslabs;
@@ -445,7 +445,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		return;
 	}
 
-	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
+	swiotlb_init_io_tlb_pool(mem, __pa(tlb), tlb, nslabs, false, nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
 
 	if (flags & SWIOTLB_VERBOSE)
@@ -553,7 +553,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		}
 	}
 
-	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
+	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
 				 nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
 
@@ -664,25 +664,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
  * @phys_limit:	Maximum allowed physical address of the buffer.
  * @attrs:	DMA attributes for the allocation.
  * @gfp:	GFP flags for the allocation.
+ * @vaddr:	Receives the virtual address for the allocated buffer.
  *
  * Return: Allocated pages, or %NULL on allocation failure.
  */
 static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
-		u64 phys_limit, unsigned long attrs, gfp_t gfp)
+		u64 phys_limit, unsigned long attrs, gfp_t gfp, void **vaddr)
 {
 	struct page *page;
 
+	*vaddr = NULL;
+
 	/*
 	 * Allocate from the atomic pools if memory is encrypted and
 	 * the allocation is atomic, because decrypting may block.
 	 */
 	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
-		void *vaddr;
-
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
-		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
+		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
 					   attrs, dma_coherent_ok);
 	}
 
@@ -705,6 +706,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 			return NULL;
 	}
 
+	if (page)
+		*vaddr = phys_to_virt(page_to_phys(page));
 	return page;
 }
 
@@ -750,6 +753,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 {
 	struct io_tlb_pool *pool;
 	unsigned int slot_order;
+	void *tlb_vaddr;
 	struct page *tlb;
 	size_t pool_size;
 	size_t tlb_size;
@@ -767,7 +771,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	pool->unencrypted = !!(attrs & DMA_ATTR_CC_SHARED);
 
 	tlb_size = nslabs << IO_TLB_SHIFT;
-	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp))) {
+	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp,
+					 &tlb_vaddr))) {
 		if (nslabs <= minslabs)
 			goto error_tlb;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
@@ -781,12 +786,12 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	if (!pool->slots)
 		goto error_slots;
 
-	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
+	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), tlb_vaddr, nslabs,
+				 true, nareas);
 	return pool;
 
 error_slots:
-	swiotlb_free_tlb(page_address(tlb), tlb_size,
-			 !!(attrs & DMA_ATTR_CC_SHARED));
+	swiotlb_free_tlb(tlb_vaddr, tlb_size, !!(attrs & DMA_ATTR_CC_SHARED));
 error_tlb:
 	kfree(pool);
 error:
@@ -1995,7 +2000,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			mem->unencrypted = false;
 		}
 
-		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
+		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
+					 nslabs,
 					 false, nareas);
 		mem->force_bounce = true;
 		mem->for_alloc = true;
-- 
2.43.0

