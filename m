Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69AA39901A;
	Tue, 12 May 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576812; cv=none; b=Qy6q18UhW9WyxarBQkQmMocDXbmtaVbBmnIjGusY6JEXkBnr5vP/jkTl+K3uCZ6LNbs56UKf/HmoxE8XDPrR6/Jlkd8J1FYbGB6sqevbHpsxiq2OX8Nj6hvDa7X09MvnTbsnazCb5yZ8lIzPYBA+2fUaJTBk4BEVaJInFq6o8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576812; c=relaxed/simple;
	bh=EFbwf4neRkinC/ATvnrHtnHJ+BgFTSGwE4EsQ470+pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSM++DHrwUNnrUhlsYaIvOiKE/ysVvSyMtSYN0Wxv8h9NODrkASTYhXkuUxPVcy1wfzeARzPYP8egBwzJxKQI4+Gvx1IM0S6QQHP50ZkaDVqVTtlZav1SIDd1d8L6twdGijgW9/YYb2SzzaUQbj1o9zfPPzCQEZb71FQwZ/AiW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeM9Ag0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeM9Ag0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDA7C2BCB0;
	Tue, 12 May 2026 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576811;
	bh=EFbwf4neRkinC/ATvnrHtnHJ+BgFTSGwE4EsQ470+pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeM9Ag0NUZG3/Alld9F85jKroRaeGZLjnhdQgGf7eBXyj/HG02jgnYVbGzp1bWIRN
	 vsBf49P35alkP64j8E8vIkjsK9QXygnkp6lnXZ7hp0nTSIMncyar9LV5hPjSmCuGij
	 J2hzJEiK6xajbQWH8kGIKhH13tq1geY23fbh9pN708IqrnHi6E8tyGq3gJLqo4AoC2
	 CP/7dc9AbgaPx+Zi6cK4+KsnhCKfye6n5JfF+g0V6btS6/fkjFDIyiH6XLs9HmhoI4
	 dlBCrXXur1ypXtp92XRZx+w2F8IXqyaU7iiGtua5IjzaSyD8e/sDzCrC8SSTK0g4rT
	 MCZlBt21G/GGg==
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
	stable@vger.kernel.org
Subject: [PATCH v4 12/13] dma-direct: return struct page from dma_direct_alloc_from_pool()
Date: Tue, 12 May 2026 14:34:07 +0530
Message-ID: <20260512090408.794195-13-aneesh.kumar@kernel.org>
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

Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
helper") changed dma_direct_alloc_from_pool() to return the CPU address
from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
dma_direct_alloc_pages() also uses the helper and expects a struct page *.

Fix this by making dma_direct_alloc_from_pool() return the struct page *
again, and pass the CPU address back through an out-parameter for the
dma_direct_alloc() caller.

Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
Cc: stable@vger.kernel.org

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 902008e40ea1..5103a04df99f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -165,24 +165,24 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
+		unsigned long attrs)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
 				   dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
-	return ret;
+	return page;
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
@@ -278,9 +278,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * the atomic pools instead if we aren't allowed block.
 	 */
 	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  gfp, attrs);
+	    dma_direct_use_pool(dev, gfp)) {
+		page = dma_direct_alloc_from_pool(dev, size,
+					dma_handle, &cpu_addr,
+					gfp, attrs);
+		return page ? cpu_addr : NULL;
+	}
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
@@ -443,7 +446,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  gfp, attrs);
+						  &cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
-- 
2.43.0

