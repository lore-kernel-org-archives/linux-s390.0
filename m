Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F639D6DA;
	Tue, 12 May 2026 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576694; cv=none; b=Nu3+4mt2JkLd158gjASQj1EVMSjLzu20UwITbH+WsvCnE4mAQggGGOaUVZMXTa5NV9bsvnqgwslazmPfMbO/K+GSEZHCTDtgIzpUqe+jza90Z8A7/qeiL+bkCojPvvN1PX1iNwSOxUAXf5cAbg1/zIH6NNkQxjPAbOhNsgYim9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576694; c=relaxed/simple;
	bh=4MW7wMvDoqITfLwkJTW6/lwo+jU4h0pFXHWOV1R6rJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsaQowLKWSf+hRHDDNCrIklfMaG4LHPbLcb4afYUR7MltTNTyTHAOxKUu8LM8jtT/wiQI+lvB7y6r6xwos2yxuCnGaeV89rkgsOYtmKlJHU/43AwUrFIS5LSmDwWzbYh957frYCq7ltrq01cUmwAhjTC7IZUhZKOOmg1pGNMclc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbwCoE0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbwCoE0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8431C2BCF5;
	Tue, 12 May 2026 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576694;
	bh=4MW7wMvDoqITfLwkJTW6/lwo+jU4h0pFXHWOV1R6rJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbwCoE0ASwdaQ0sDqenX3eV2dOoxqZ1/TFckfyJW6wsl78OCEz7fdBRLlIWH2WVy/
	 sFRV8gkQD9L/Mqs80GkVY2hI9N/Zl7IpCNaaBGUabr02N0g8a8xHQVKvE27qFMc22Y
	 Moc5qKLCRlFqPVQFD6o8OfprtKqgn6hObtzcYyV/ja3ahXjLP/J7BSn41O6emV6XZM
	 j44eIFpfSCPhdsNwc6gVoAwh43+ZTWY1hvO0qfOUkcIY8lyuB3mKF2isu0H2bj7lcx
	 0qMWtvyB5JjqGX+H3+qQAlmugtaUALG3nubVqCuniv+CCUgcdEkzGirzgWBjcgdr1o
	 Hvr5pzU6q77Eg==
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
	x86@kernel.org
Subject: [PATCH v4 02/13] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
Date: Tue, 12 May 2026 14:33:57 +0530
Message-ID: <20260512090408.794195-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b958f150718a..0c2e1f8436ce 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -201,16 +201,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = false;
 	struct page *page;
 	void *ret;
 
+	/*
+	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
+	 * attribute. The direct allocator uses it internally after it has
+	 * decided that the backing pages must be shared/decrypted, so the
+	 * rest of the allocation path can consistently select DMA addresses,
+	 * choose compatible pools and restore encryption on free.
+	 */
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return NULL;
+
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_decrypt = true;
+	}
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -244,7 +259,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -318,11 +333,20 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = false;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_encrypted = true;
+	}
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
-- 
2.43.0

