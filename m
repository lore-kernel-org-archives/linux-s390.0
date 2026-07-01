Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550731531E8;
	Wed,  1 Jul 2026 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885216; cv=none; b=J6u2zLOjsNwja1RaT4RzdAQYsVsBYDjdFwso9eD5zrdilG4GTEtqzRaPLOQNJfJ7MLtJ9U5VlWjl0+Rc50aJoQ5Zz2MRCTKwz2YnQ8KOEtfp2oER1or6qRoF3iWQux7mGR4pcl+0O0ywj+AzaY17Z7DMg4/ghKiDLVD2OaFPBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885216; c=relaxed/simple;
	bh=VKZxYEDwajshkwfXbKzK49qJVjC0kT6XpdhtOY3PmG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqysy45wWtOYWQNbHQ/ei2ocg+SfExNdw4h+lBdfIlCD11LASzTyvPbm9YTz7LhGXxxFJaP8XWFB3+ih8d6s7uK0EJIeUBG1UMIfPul9LRv0uFL/eM0gP7vN/x4JbMZWXBH7wpi8cIc3cCt2zAs1gNGYRcIYy3y5fCKXyQj9YUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfeku7BD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfeku7BD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DDF1F00A3A;
	Wed,  1 Jul 2026 05:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885215;
	bh=+L069aWcjLrB3wappLbuGG8uPbPUjJehCiHPiPcnjiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nfeku7BDXTkIy8A310rCK/bLDUec4Q6+EStCdhDLuKplUKfkzzbEA1N+9Qu1PK4uB
	 DeXHVZgxZaBeTm41qj17yyASNycpUjPazL5zuE9gE+NBcmVlltOuq9SAciZMWbHlcr
	 kz9h2kHnJ5VlGcCh5hjCUePDYG9qdYeAZCnR6rro0ndPy84SOZ66j3E3RRnXjJZvYD
	 GWfxQLtbuOHUXjP9IOT1ywuIelJyynfyEP9FBGXpvolQlhyYw7WDAE7wUG8OAaJIFr
	 iLXsVYsIoELudjnDKAm3BFbrLHsG0zrVwX3FX6s+GNeqTktiNcvSnD2rAP96vh8LCQ
	 C0z3J+SCHHVVg==
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
Subject: [PATCH v7 21/22] dma: swiotlb: handle set_memory_decrypted() failures
Date: Wed,  1 Jul 2026 11:19:25 +0530
Message-ID: <20260701054926.825925-22-aneesh.kumar@kernel.org>
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

Check the return value when converting swiotlb pools between encrypted and
decrypted mappings. If the default pool cannot be decrypted after early
initialization, mark the pool fully used so it cannot satisfy future bounce
allocations.

For late initialization, return the `set_memory_decrypted()` failure. For
restricted DMA pools, fail device initialization if the reserved pool
cannot be decrypted.

This prevents swiotlb from using pools whose encryption attributes do not
match their metadata, and avoids returning pages with uncertain encryption
state back to the allocator.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4d0f2c04d891..8b7e47504304 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -248,6 +248,23 @@ static inline unsigned long nr_slots(u64 val)
 	return DIV_ROUND_UP(val, IO_TLB_SIZE);
 }
 
+static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
+{
+	unsigned long i;
+
+	for (i = 0; i < pool->nareas; i++) {
+		pool->areas[i].index = 0;
+		pool->areas[i].used = pool->area_nslabs;
+	}
+
+	for (i = 0; i < pool->nslabs; i++) {
+		pool->slots[i].list = 0;
+		pool->slots[i].orig_addr = INVALID_PHYS_ADDR;
+		pool->slots[i].alloc_size = 0;
+		pool->slots[i].pad_slots = 0;
+	}
+}
+
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
  * perform the desired operations.  This function allows the architecture to
@@ -272,8 +289,16 @@ void __init swiotlb_update_mem_attributes(void)
 		return;
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 
-	if (io_tlb_default_mem.cc_shared)
-		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
+	if (io_tlb_default_mem.cc_shared) {
+		int ret;
+
+		ret = set_memory_decrypted((unsigned long)mem->vaddr,
+					   bytes >> PAGE_SHIFT);
+		if (ret) {
+			pr_warn("Failed to decrypt default memory pool, disabling it\n");
+			swiotlb_mark_pool_used(mem);
+		}
+	}
 }
 
 static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
@@ -442,9 +467,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	unsigned int order, area_order, slot_order;
+	bool leak_pages = false;
 	unsigned int nareas;
 	unsigned char *vstart = NULL;
-	unsigned int order, area_order;
 	bool retried = false;
 	int rc = 0;
 
@@ -504,6 +530,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
+	rc = -ENOMEM;
 	nareas = limit_nareas(default_nareas, nslabs);
 	area_order = get_order(array_size(sizeof(*mem->areas), nareas));
 	mem->areas = (struct io_tlb_area *)
@@ -511,14 +538,20 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->areas)
 		goto error_area;
 
+	slot_order = get_order(array_size(sizeof(*mem->slots), nslabs));
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-		get_order(array_size(sizeof(*mem->slots), nslabs)));
+					      slot_order);
 	if (!mem->slots)
 		goto error_slots;
 
-	if (io_tlb_default_mem.cc_shared)
-		set_memory_decrypted((unsigned long)vstart,
-				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+	if (io_tlb_default_mem.cc_shared) {
+		rc = set_memory_decrypted((unsigned long)vstart,
+					  (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+		if (rc) {
+			leak_pages = true;
+			goto error_decrypt;
+		}
+	}
 
 	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
 				 nareas);
@@ -527,16 +560,20 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	swiotlb_print_info();
 	return 0;
 
+error_decrypt:
+	free_pages((unsigned long)mem->slots, slot_order);
 error_slots:
 	free_pages((unsigned long)mem->areas, area_order);
 error_area:
-	free_pages((unsigned long)vstart, order);
-	return -ENOMEM;
+	if (!leak_pages)
+		free_pages((unsigned long)vstart, order);
+	return rc;
 }
 
 void __init swiotlb_exit(void)
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
+	bool leak_pages = false;
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
 	unsigned int area_order;
@@ -552,19 +589,23 @@ void __init swiotlb_exit(void)
 	tbl_size = PAGE_ALIGN(mem->end - mem->start);
 	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
 
-	if (io_tlb_default_mem.cc_shared)
-		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+	if (io_tlb_default_mem.cc_shared) {
+		if (set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT))
+			leak_pages = true;
+	}
 
 	if (mem->late_alloc) {
 		area_order = get_order(array_size(sizeof(*mem->areas),
 			mem->nareas));
 		free_pages((unsigned long)mem->areas, area_order);
-		free_pages(tbl_vaddr, get_order(tbl_size));
+		if (!leak_pages)
+			free_pages(tbl_vaddr, get_order(tbl_size));
 		free_pages((unsigned long)mem->slots, get_order(slots_size));
 	} else {
 		memblock_free(mem->areas,
 			array_size(sizeof(*mem->areas), mem->nareas));
-		memblock_phys_free(mem->start, tbl_size);
+		if (!leak_pages)
+			memblock_phys_free(mem->start, tbl_size);
 		memblock_free(mem->slots, slots_size);
 	}
 
@@ -1957,9 +1998,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		 * restricted mem pool is shared by default
 		 */
 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+			int ret;
+
 			mem->cc_shared = true;
-			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-					     rmem->size >> PAGE_SHIFT);
+			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
+						   rmem->size >> PAGE_SHIFT);
+			if (ret) {
+				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
+				kfree(pool->areas);
+				kfree(pool->slots);
+				kfree(mem);
+				return ret;
+			}
 		} else {
 			mem->cc_shared = false;
 		}
-- 
2.43.0

