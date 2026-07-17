Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA2374A1D;
	Fri, 17 Jul 2026 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311688; cv=none; b=OTtJrQfyFRn34CTJW3FrsS6HaM+coSOkq+J1z0cTTbMTKSMTj8MTPkr1BPF4Jzhhwcu/ty/gCUumUnMdxIT3FSBiFLDrmPqgh1fDEJtEbNTFig8TcbvHmK3UOoyJuMc8CcBvDOXuLrYxJx7AbQ553CIC5A1iCvWEt5spbJcAOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311688; c=relaxed/simple;
	bh=nMgLq/UbqOEm2Qt5oKdXfCYamVKavI4EwsnV2gmHiug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmCw7hXsfBq+JWcSDalcL8L5WvK3LaG+cy8A7MyKb9iRisM80llNKO24ygdRo0mjSkVqXtTk/g1ivITVFoLj2BmrszcL5orW4gXhKxoO2Rqw9G2XED7pa3IaHGVMVOjaM819fL+NbzbYxNAjT1d9ZLMQsoI2tJMdrKaT0bAxsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP5iTTw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP5iTTw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABC81F000E9;
	Fri, 17 Jul 2026 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311687;
	bh=PwGwo2v1bc/tfRKKTB7zzFn/AHGX4mQVp7Ym9P3mvNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BP5iTTw71m+JzUVT4oQamNjA8tRrSdlrhJHPabvG4jvbiWwSchW6LscApjzvzfSYm
	 MQCa8o0m1ipdDX7SdMuLHgTZ4IWXQxJktMmbiNLIQ+gJUPsFyi0XLXhJwYwxMpWaiL
	 SWcUDH7wvsith+5+bko8GxVl0wq3lBLtnfCOZfDXmaHKztP/qHL3IowfvzKQ5EzoBP
	 h4t+FDvFCW6cSzB18rA8aSxbkoiIIlsu9iUi8pNYrKPB6S3FtoxcP4so3dP5UOSKr3
	 fNoA1XnRHK/caUQEAWeczcbWRQAFkU5QeVq6grwcH/uSyIyJ/o5fqvAYN618S/gMjP
	 dLx40xNRBhQtw==
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
Subject: [PATCH v8 16/23] dma-direct: Move dma_direct_map_phys() to dma/direct.c
Date: Fri, 17 Jul 2026 23:34:34 +0530
Message-ID: <20260717180442.110954-17-aneesh.kumar@kernel.org>
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

dma_direct_map_phys() is too large to benefit from being inlined. Move its
implementation to direct.c and leave the declaration in direct.h.

No functional change in this patch

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h | 56 +++------------------------------------------
 2 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f54c7929b97f..2413235c50f0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -620,6 +620,59 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
 
+dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs, bool flush)
+{
+	dma_addr_t dma_addr;
+
+	if (is_swiotlb_force_bounce(dev)) {
+		if (!(attrs & DMA_ATTR_CC_SHARED)) {
+			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+				return DMA_MAPPING_ERROR;
+
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		}
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		return DMA_MAPPING_ERROR;
+	}
+
+	if (attrs & DMA_ATTR_MMIO) {
+		dma_addr = phys;
+		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
+			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
+			goto err_overflow;
+	} else {
+		dma_addr = phys_to_dma(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
+		    dma_kmalloc_needs_bounce(dev, size, dir)) {
+			if (is_swiotlb_active(dev) &&
+			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
+				return swiotlb_map(dev, phys, size, dir, attrs);
+
+			goto err_overflow;
+		}
+	}
+
+	if (!dev_is_dma_coherent(dev) &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
+		arch_sync_dma_for_device(phys, size, dir);
+		if (flush)
+			arch_sync_dma_flush();
+	}
+	return dma_addr;
+
+err_overflow:
+	dev_WARN_ONCE(
+		dev, 1,
+		"DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+		&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+	return DMA_MAPPING_ERROR;
+}
+
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 	u64 min_mask = ((u64)max_pfn << PAGE_SHIFT) - 1;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e05dc7649366..a7adadb1b2a5 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -17,6 +17,9 @@ bool dma_direct_can_mmap(struct device *dev);
 int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
+dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs, bool flush);
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
@@ -82,59 +85,6 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 	swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 }
 
-static inline dma_addr_t dma_direct_map_phys(struct device *dev,
-		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs, bool flush)
-{
-	dma_addr_t dma_addr;
-
-	if (is_swiotlb_force_bounce(dev)) {
-		if (!(attrs & DMA_ATTR_CC_SHARED)) {
-			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
-				return DMA_MAPPING_ERROR;
-
-			return swiotlb_map(dev, phys, size, dir, attrs);
-		}
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
-		return DMA_MAPPING_ERROR;
-	}
-
-	if (attrs & DMA_ATTR_MMIO) {
-		dma_addr = phys;
-		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
-			goto err_overflow;
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
-		dma_addr = phys_to_dma_unencrypted(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
-			goto err_overflow;
-	} else {
-		dma_addr = phys_to_dma(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
-		    dma_kmalloc_needs_bounce(dev, size, dir)) {
-			if (is_swiotlb_active(dev) &&
-			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
-				return swiotlb_map(dev, phys, size, dir, attrs);
-
-			goto err_overflow;
-		}
-	}
-
-	if (!dev_is_dma_coherent(dev) &&
-	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
-		arch_sync_dma_for_device(phys, size, dir);
-		if (flush)
-			arch_sync_dma_flush();
-	}
-	return dma_addr;
-
-err_overflow:
-	dev_WARN_ONCE(
-		dev, 1,
-		"DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-		&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-	return DMA_MAPPING_ERROR;
-}
-
 static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs,
 		bool flush)
-- 
2.43.0

