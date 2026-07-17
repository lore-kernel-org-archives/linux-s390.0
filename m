Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93142376A10;
	Fri, 17 Jul 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311724; cv=none; b=Y/VyTe3lkJgSNzeNr9GhvrzESvlbdt0LXz9dTHfddUAeg725plH6chA/sgR0mitjkm11h6jcYTubPgW3OGHrj5fEgYNhAWv/50eJ0CbH0cCVPx7EvYAB7G0rJFC9OtgysV7wNiMLyfOOuElMZqKf86vv8EocO17Y6HMtSdS12HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311724; c=relaxed/simple;
	bh=IWt4DT8zbxEVNr7Hsx2WH1ZhX/xIxKzGuVhjRtq3j+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYttpz5q4EPZ8t2q8SN3Y4pF+7zeolDrquS2902IXRUi5TdWIyFdVlgreZu6ALdRevfuqS+s1wvh6B3ChBIH5jad22dFWY9vyxlfRB+l1chm/enMMJyyf4nc4NKDQileFSdls6ciX5meaNhQ7CV5R4TrE/1lnyX22fLqRBENgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8fJtpWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8fJtpWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC221F00A3A;
	Fri, 17 Jul 2026 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311723;
	bh=5bS+J6Rwxh/WXwnquOaDBNcfrARTnQLlbkZ3NkMBgPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8fJtpWwBWHB9Ahirb07ZBZx03wpyr0HvEFiaOWqchFPaIHlOfOF8nIxp255RlCqc
	 SA5lvDtSPSORHGBbXXe4ESMuP1HJ9TN2IktHo7lqFU4dEvpGz6SdLKKWBU3Jqy3dX8
	 dgDnw9Z4VAp5LeDo7M07SWRQ0ucTOCo4445a2InOiCz+dHLvzFSjW+KIWHYr6MTTid
	 HCl/6afcZD5n5aVyJfVbbvZmRaMv9fI/ZA6mzhnlGUuldBmAZMvl8HImPa6Kb2BaTj
	 aXPintlcklxZ6GlqObb+V/NV2vZBAQxpaENAkHBkzy/kvt74XPCY9FobR3QT/5MGXi
	 u4DoaX4q93Pqg==
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v8 19/23] dma-direct: select DMA address encoding from __DMA_ATTR_ALLOC_CC_SHARED
Date: Fri, 17 Jul 2026 23:34:37 +0530
Message-ID: <20260717180442.110954-20-aneesh.kumar@kernel.org>
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

Make the dma-direct helpers derive the DMA address encoding from
__DMA_ATTR_ALLOC_CC_SHARED instead of implicitly relying on
force_dma_unencrypted() inside phys_to_dma_direct()

Pass an explicit unencrypted/decrypted state into phys_to_dma_direct(),
make the alloc paths return DMA addresses that match the requested buffer
encryption state. Also only call dma_set_decrypted() when
__DMA_ATTR_ALLOC_CC_SHARED is actually set.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f7f064323bd9..eb0ce0787885 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -26,11 +26,11 @@
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
@@ -41,8 +41,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -71,7 +72,8 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	bool require_decrypted = force_dma_unencrypted(dev);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -81,17 +83,18 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
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
@@ -171,7 +174,8 @@ static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 				   dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 attrs & __DMA_ATTR_ALLOC_CC_SHARED);
 	return page;
 }
 
@@ -187,9 +191,11 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
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
 
@@ -329,7 +335,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = uncached_cpu_addr;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 attrs & __DMA_ATTR_ALLOC_CC_SHARED);
 	return ret;
 
 
@@ -450,11 +457,13 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) &&
+	    dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 setup_page:
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 attrs & __DMA_ATTR_ALLOC_CC_SHARED);
 	return page;
 out_leak_pages:
 	return NULL;
-- 
2.43.0

