Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6741531E8;
	Wed,  1 Jul 2026 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885194; cv=none; b=K9PRdkCvda/+/WcHA5JQsDDPfLG6rwKfjZ2QqzFkuW6lGv5sHWj3SRFcdMki3269OTLKCSh0YhHtqY00qmk3u/AxCuLuljKIU8siLSz+2/2k4nctheAoe8W+0lmaztsuEPD/srgkcm47GVC7nJ6P5wtjewHthVDiIXPyFnlHlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885194; c=relaxed/simple;
	bh=9/h1rDJYImd2vg0Zea+Z+2JIomccWpwQCdFcSoHnbfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhaaAKa/icA8duq8Z26fraUhuCYR1/yFhsTe/vlU38OYe2jB87gqZ2aiUh4CTKSWwHKtPjVMpFqsbsDq/a9R0DTVaBDAqRXHcgVrjr7nwZnP0jNlNQDg3COzFn+r/shmdd8+HtU4CwGIXn1vP+QBvBVeDHy6qE2cIVBowstJgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWddKrSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWddKrSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0341F00A3A;
	Wed,  1 Jul 2026 05:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885193;
	bh=sFy0T0BPD4FTs9VATm8J4K174dhU5J4SovBu98CGNDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWddKrSbxtDPe8luUGelJ6MWY43nC08Ww28qDX/t8paeV1iCBGOMgyIJdzf/Zsx3m
	 s+IGdDeNDlY5mH3YTZnYimC3lGcYM7Hymvm2AHC7gTMObt2nOgVRnbR/s9bdqk5HkZ
	 3/sz79b1U7XUDdfJdEToG7MroG20KL2fzyQlnrNuJBF2+lX19gyfM/HtwAHfyyo9J+
	 smSD0rHkzoDQDnbJlY6zScx8po3RzeV1VTfnRnHA281BHiYO+E+J/kOYGdqxSupgso
	 rbbKRMQnvfSrlanhMnZ2AxlwqJoUuHPFNywBBh5qHPopLmQ7F/gSEeT/J2UyGkDfqp
	 lA1nezz2ylFXQ==
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
Subject: [PATCH v7 19/22] dma-direct: rename ret to cpu_addr in alloc helpers
Date: Wed,  1 Jul 2026 11:19:23 +0530
Message-ID: <20260701054926.825925-20-aneesh.kumar@kernel.org>
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

ret in dma_direct_alloc() and dma_direct_alloc_pages() holds the returned
CPU mapping, not a generic return value. Rename it to cpu_addr and update
the remaining uses to match.

This makes the allocation paths easier to follow and keeps the local naming
consistent with what the variable actually represents.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 23138519cf22..9575d68571bf 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -204,7 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	bool mark_mem_decrypt = false;
 	bool allow_highmem = true;
 	struct page *page;
-	void *ret;
+	void *cpu_addr;
 
 	if (force_dma_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
@@ -261,9 +261,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 */
 	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
-		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  &ret, gfp, attrs);
-		return page ? ret : NULL;
+		page = dma_direct_alloc_from_pool(dev, size,
+					dma_handle, &cpu_addr,
+					gfp, attrs);
+		return page ? cpu_addr : NULL;
 	}
 
 	if (is_swiotlb_for_alloc(dev)) {
@@ -310,34 +311,33 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
-		ret = dma_common_contiguous_remap(page, size, prot,
-				__builtin_return_address(0));
-		if (!ret)
+		cpu_addr = dma_common_contiguous_remap(page, size, prot,
+					__builtin_return_address(0));
+		if (!cpu_addr)
 			goto out_encrypt_pages;
 	} else {
-		ret = page_address(page);
+		cpu_addr = page_address(page);
 	}
 
-	memset(ret, 0, size);
+	memset(cpu_addr, 0, size);
 
 	if (set_uncached) {
 		void *uncached_cpu_addr;
 
 		arch_dma_prep_coherent(page, size);
-		uncached_cpu_addr = arch_dma_set_uncached(ret, size);
+		uncached_cpu_addr = arch_dma_set_uncached(cpu_addr, size);
 		if (IS_ERR(uncached_cpu_addr))
 			goto out_free_remap_pages;
-		ret = uncached_cpu_addr;
+		cpu_addr = uncached_cpu_addr;
 	}
 
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));
-	return ret;
-
+	return cpu_addr;
 
 out_free_remap_pages:
 	if (remap)
-		dma_common_free_remap(ret, size);
+		dma_common_free_remap(cpu_addr, size);
 
 out_encrypt_pages:
 	if (mark_mem_decrypt &&
@@ -429,21 +429,21 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 {
 	unsigned long attrs = 0;
 	struct page *page;
-	void *ret;
+	void *cpu_addr;
 
 	if (force_dma_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  &ret, gfp, attrs);
+						  &cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
 
-		ret = page_address(page);
+		cpu_addr = page_address(page);
 		goto setup_page;
 	}
 
@@ -451,12 +451,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	ret = page_address(page);
+	cpu_addr = page_address(page);
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) &&
-	    dma_set_decrypted(dev, ret, size))
+	    dma_set_decrypted(dev, cpu_addr, size))
 		goto out_leak_pages;
 setup_page:
-	memset(ret, 0, size);
+	memset(cpu_addr, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));
 	return page;
-- 
2.43.0

