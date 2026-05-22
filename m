Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A877B1B6CE9;
	Fri, 22 May 2026 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424255; cv=none; b=NgGl/LFPPDIsEncR5J3D2rc1bsKj1g8H9tT50J6phxNL+QcDQZbKXAynt3YorkOriVo4/KmoBqg9TqJemWHnGnKngekJObzxEWG9qQzMSYSwH0ap5pDy/86rfgvao4LZQULWM7x1K2m+kNfVRNvmcr4Uw7XEFBUP+VUXRHQhU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424255; c=relaxed/simple;
	bh=/8UQbJFSflm14frKSxWfIhVf5QX1/sjbU1+q7i87uEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU0SOwaR0Zt7Ic6PYgJr0Uh34hd95FzbohhXeK6iYgsiiY144GEDVQG/OL69IxDbozDWk8v3drN1pSjrY1rYW1BowMOCZ+1Yz29UcUSnwNFb3BV9+qUqpJlioa4EHWwkatpdp5EIio2ToiIYLZOuEFFj9k3nQiBC9iFNsiczeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVVwpu4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVVwpu4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36641F000E9;
	Fri, 22 May 2026 04:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424254;
	bh=mVHtjAJQlp0gV8B0Nq6WpIH3y5hTEG8y8BlmpuaiuX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVVwpu4U5NOqV4Ms01DgRonDxuS/cyHuEXXmiRp6ZPvczMe2Aq0PjseIgGYy1H7wl
	 6L6+eVeJOapMW4Ziz4RAKAPRXmc/ojvzypwHGhNXvOrZHoW//v+/uFdLphsT2FJ5ng
	 c5nthmnYe0A68XIxH0E0z7Olac5Ld+nZHzihjKafuw0kvVBBlhgjDqyuyaBanC9WAl
	 Me8X84fE1ushAOr06vo2BX2sEK5sO2EjJjOnlktKupeSgOYK8LUKwWvklf2fslffbt
	 iWYSJ/68iPU83wUmNs+VE/eD0ImMJUiwAkKfY3FpXv6zLIfDPNRbi4NIgVEUe2BUpt
	 iL4niyYWhRLVw==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH v5 12/20] dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
Date: Fri, 22 May 2026 09:58:07 +0530
Message-ID: <20260522042815.370873-13-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the dma-direct helpers derive the DMA address encoding from
DMA_ATTR_CC_SHARED instead of implicitly relying on
force_dma_unencrypted() inside phys_to_dma_direct()

Pass an explicit unencrypted/decrypted state into phys_to_dma_direct(),
make the alloc paths return DMA addresses that match the requested buffer
encryption state. Also only call dma_set_decrypted() when
DMA_ATTR_CC_SHARED is actually set.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d7eee77f95af..6f3aff8448a0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -24,11 +24,11 @@
 u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
-		phys_addr_t phys)
+		phys_addr_t phys, bool unencrypted)
 {
-	if (force_dma_unencrypted(dev))
+	if (unencrypted)
 		return phys_to_dma_unencrypted(dev, phys);
-	return phys_to_dma(dev, phys);
+	return phys_to_dma_encrypted(dev, phys);
 }
 
 static inline struct page *dma_direct_to_page(struct device *dev,
@@ -39,8 +39,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -69,7 +70,8 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	bool require_decrypted = force_dma_unencrypted(dev);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -79,17 +81,18 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
-		return 0;
-	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
+	int ret;
+
+	ret = set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
+	if (ret)
+		pr_warn_ratelimited("leaking DMA memory that can't be decrypted\n");
+	return ret;
 }
 
 static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
 		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
@@ -169,7 +172,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 				   dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return ret;
 }
 
@@ -185,9 +189,11 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 	/* remove any dirty cache lines on the kernel alias */
 	if (!PageHighMem(page))
 		arch_dma_prep_coherent(page, size);
-
-	/* return the page pointer as the opaque cookie */
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	/*
+	 * return the page pointer as the opaque cookie.
+	 * Never used for unencrypted allocation
+	 */
+	*dma_handle = phys_to_dma_encrypted(dev, page_to_phys(page));
 	return page;
 }
 
@@ -332,7 +338,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = uncached_cpu_addr;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return ret;
 
 
@@ -455,11 +462,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 setup_page:
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return page;
 out_leak_pages:
 	return NULL;
-- 
2.43.0

