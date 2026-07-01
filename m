Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20107279DCA;
	Wed,  1 Jul 2026 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885095; cv=none; b=GJNO6UO/T2iBiYpdj7sCZMT+zzZK2XLFaj7X10jYXHBHWTcf+8ccATli4VgRefjSM6l3Dc/WN1SxRVL2sscD/66Wi4HSm47EPX3WfITVCkmJi5thBSyVDLOUrHAObuZ+p+2fGeeotY1c5P6+LWl2ObN9GAiTNh8C/y5Qdl8+d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885095; c=relaxed/simple;
	bh=eGjQpW20ZDis/hfCmp+TIg44Iy7vXmRa7MdWK0TFAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR8+RIiVsEnEux33aFlSdb+i78E/0o71z/H5JCZWL6EBU5iCWcgMH5j3/oP7qDmvrJ9qUT1q6L1OifsmNYmITrFJ3wpDxRcRNmW538hROSr4MDgeqjgRNpJdOl7bBNheGw6aZCEPFg7jfxMOugXVudZcEAyIHx143Ywnbt4Dmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9eddkM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9eddkM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F781F00A3A;
	Wed,  1 Jul 2026 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885093;
	bh=HkzqvFMXi/PgU+6F3kPwXboJDV9YU/zrJk+hhy58TBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9eddkM1K/T7RTCiQTgtIU6lixFvLYa9EeEaz+wMOZQ+xlTWidBriJTTjKfVC/I5F
	 DbEPOBhOq7rwUYznEf4REm9gXDeEp1M3sYIra0nuSE3fkyI6Su34Q67tLIRZacdrE8
	 EQ67aDfoPb3WmKbV8nNeJ4/20Zc1nX5lkSsP/2WmRmc1YI1xa0CTlyTefzlOAy/YGj
	 Vd4sOpYAA/vjSVMCGCJNxPejK40j4RHBqNtyUxe8TUuSo7feSUehna+CJJvcFNrkLv
	 kITtam5OAcs3m+jsILWL7XYWWvyqi0qndiFfiNXk+Mh6+l8mlKpTRdn0hEFQ8T4/ST
	 /puqkd/i1b9OA==
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
Subject: [PATCH v7 10/22] dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in alloc/free paths
Date: Wed,  1 Jul 2026 11:19:14 +0530
Message-ID: <20260701054926.825925-11-aneesh.kumar@kernel.org>
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

Propagate force_dma_unencrypted() into __DMA_ATTR_ALLOC_CC_SHARED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  | 42 +++++++++++++++++++++++++++++++++---------
 kernel/dma/mapping.c |  9 +++++++++
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0cbf2b0835c4..98e47e0b332d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -192,16 +192,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = false;
 	struct page *page;
 	void *ret;
 
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
+	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
+		mark_mem_decrypt = true;
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -235,7 +241,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
 		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
 						  &ret, gfp);
@@ -314,12 +320,22 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	phys_addr_t phys;
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = false;
 	struct io_tlb_pool *swiotlb_pool;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/*
+	 * If the allocation used decrypted/shared backing pages, restore
+	 * the encryption state on free.
+	 */
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
+	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
+		mark_mem_encrypted = true;
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -368,10 +384,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
+	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
@@ -405,7 +425,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	phys_addr_t phys;
 	void *vaddr = page_address(page);
 	struct io_tlb_pool *swiotlb_pool;
-	bool mark_mem_encrypted = true;
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	bool mark_mem_encrypted = force_dma_unencrypted(dev);
 
 	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 4fe04669e5e6..d2f70b6ccd0f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -638,6 +638,15 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (WARN_ON_ONCE(flag & __GFP_COMP))
 		return NULL;
 
+	if (attrs & (DMA_ATTR_CC_SHARED | __DMA_ATTR_ALLOC_CC_SHARED)) {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
+		return NULL;
+	}
+
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
 		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
 				DMA_BIDIRECTIONAL, flag, attrs);
-- 
2.43.0

