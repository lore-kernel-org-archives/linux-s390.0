Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C033E7BC5;
	Thu,  4 Jun 2026 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562580; cv=none; b=pPHm3zIkQbhvawyJAw+YASV7kSoaopR4sShASeiMDnpHNN7+df6f56FvQDml86AR/Sc77GYsY3riZIU6fbgMqx9NkdzC7Rbhep20ZoabPgQ+3YsjyUFBTpPXO+w+rXQU8cnTiEVOZiW30eooU7bDEHKmCe8HKu2yptxjnAoIi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562580; c=relaxed/simple;
	bh=g/wtgfIecl6o8kwHeLkDvFzrvI6n8z3n5Cw9liWsHGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv/k16on6i0zdDBOu3sJa6+IhIFCZv8oU4PsczDWICH/mI9AoxMytKuOql+eDywaeIgLKGeW2AXtGiFHKa6DjcOc0G4CnvokxmDL+UYS3+SZRLjkylnosIzeAhKwQMB4Yy43db5sy3g1k6LYpsNW2nBf4liddruF0hKWifhPVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPwkUEOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPwkUEOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415181F00898;
	Thu,  4 Jun 2026 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562578;
	bh=5WeykkaLRY84/gMTdzzVPplQJSrHkGjIEUjp2FUb45E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPwkUEOk1WgnrF0lOV0PcG8AQaiVhngfx/W0TVtjGwpDNk1Baj72OsUUlUxaxIdxt
	 GCMc3uO9dZ0y+4DmEajexLfTCy0njgJdDKWFY9hNA6cHq5Mr0VzYb075IVKnz09ylZ
	 mhURdS/1AaP9I7PUlOb/20/S5Qac8flUQ4Ku/7TmUPowi2LXf/qpYsGBY67dQRdlSr
	 BJppQVtzWfkLsFwBGMpoLv4SBMYJXdg+a+LtnxbzH90+JUMUfoODtJ8bcesSA/7/Q7
	 ep7tfYzuBiwuLbY57SGVqmXpr1NYNfK8KsDo5ZI/oY1hIt+e9hbCAbrkFpKYImCFdg
	 JlZGreIpvlfMA==
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
Subject: [PATCH v6 18/20] dma: free atomic pool pages by physical address
Date: Thu,  4 Jun 2026 14:09:57 +0530
Message-ID: <20260604083959.1265923-19-aneesh.kumar@kernel.org>
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

dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
atomic pools. The pool allocation is keyed by the virtual address stored in
the gen_pool, but the pages API returns only the backing struct page.

On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
to the gen_pool using their remapped virtual address.
dma_direct_free_pages() reconstructs a linear-map address with
page_address(page) and passes that to dma_free_from_pool(). That address
does not match the gen_pool virtual range, so the pool lookup can fail and
the code can fall through to freeing a pool-owned page through the normal
page allocator path.

Add a page-based pool free helper that looks up the owning pool chunk by
physical address, translates it back to the gen_pool virtual address, and
frees that address to the pool. Use it from dma_direct_free_pages() while
keeping the existing virtual-address helper for coherent allocation frees.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/direct.c         |  4 +--
 kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 696b2c3a2305..8be059e69935 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -215,6 +215,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		void **cpu_addr, gfp_t flags, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size);
 
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index e0ab9ff3f1d6..58f7ea1be963 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -488,9 +488,9 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	 */
 	bool mark_mem_encrypted = force_dma_unencrypted(dev);
 
-	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
+	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    dma_free_from_pool(dev, vaddr, size))
+	    dma_free_from_pool_page(dev, page, size))
 		return;
 
 	phys = page_to_phys(page);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index e7df8d279e75..43b8101d860f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -356,3 +356,57 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+struct dma_pool_phys_match {
+	phys_addr_t phys;
+	size_t size;
+	unsigned long addr;
+	bool found;
+};
+
+static void dma_pool_find_phys(struct gen_pool *pool, struct gen_pool_chunk *chunk,
+			       void *data)
+{
+	struct dma_pool_phys_match *match = data;
+	phys_addr_t end = match->phys + match->size - 1;
+	phys_addr_t chunk_end;
+
+	if (match->found)
+		return;
+
+	chunk_end = chunk->phys_addr + (chunk->end_addr - chunk->start_addr);
+	if (match->phys < chunk->phys_addr || end > chunk_end)
+		return;
+
+	match->addr = chunk->start_addr + (match->phys - chunk->phys_addr);
+	match->found = true;
+}
+
+static bool dma_free_from_pool_phys(struct dma_gen_pool *dma_pool, phys_addr_t phys,
+				    size_t size)
+{
+	struct dma_pool_phys_match match = {
+		.phys = phys,
+		.size = size,
+	};
+
+	gen_pool_for_each_chunk(dma_pool->pool, dma_pool_find_phys, &match);
+	if (!match.found)
+		return false;
+
+	gen_pool_free(dma_pool->pool, match.addr, size);
+	return true;
+}
+
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)
+{
+	struct dma_gen_pool *dma_pool = NULL;
+	phys_addr_t phys = page_to_phys(page);
+
+	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
+		if (dma_free_from_pool_phys(dma_pool, phys, size))
+			return true;
+	}
+
+	return false;
+}
-- 
2.43.0

