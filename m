Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAD227B9A
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625381; cv=none; b=Pi5dYn0Sf7sxE/F3XeHeU/SqqLBEDXOIRsWc7qHtQEpyySEBwuH3g6wOakm14egvSEW4SCawalH7Rh3+gVwFp/CjC27WP1wCFVhRG2SYu9wOQWqTpgTR1bzeCg8kx57Erwm0kfJhNE63Ofw76zsn7S7kbmBkyy8OLWfr8rIOtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625381; c=relaxed/simple;
	bh=O1015Jjt8Zi4AnJHdxA9wFz5JMI2AFNWHSc8A8HPWKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPKEtXxBd1YBwH9qgpagzacVFY/hWPlLTi1Kfo3i6+lATH3VHYD5qllReuKzlhxaaMoZwNf1zfEwLOodsW1BCL4zwrUtvSMDs2OBvFiHE8e8ZWcEPjp6PzIxT6JDBzxakXTbPwOZCNfwm6IxOIM+JVDZvJFW992MekJf2PekV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iyGvd9G7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iyGvd9G7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+uDUWEhmCup4taYr27BiJb9p3jgCmdPaevfqezl8nf8=; b=iyGvd9G7F8RyF+SdXlAk9enjFV
	K6OPKMcgAUQplroZ/cgam3+4N8qC+h55SZjzRk1sRuPt1ju8xGrdnBGv21xIai862bCCOWYLTGVZf
	AG+q7TUbkGxrLB2f2+Kzu1TsbWeev70Vs5/6UOfoe/HCJanUtr2U9BsStgAOLTO1VBy9civAPtsxl
	8Vk4FUyFktJ7gF3fsw8O/boGI8jV10Ufw+6qCkuA3ThFCeroWkduW4xG3uV1VEmhRtq7adjK7jLcU
	yp7sWiatmEe6A6SzTDFvMLaFqsJItw2V2Er9LZcZkWEPTkDyDnCk3pY0V8HPywbfzObSZ+pVPG1WB
	t4AFfEjw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJIc-00000004Ijv-0ezX;
	Thu, 19 Dec 2024 16:22:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390: Convert gmap code to use ptdesc
Date: Thu, 19 Dec 2024 16:22:49 +0000
Message-ID: <20241219162252.1025317-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219162252.1025317-1-willy@infradead.org>
References: <20241219162252.1025317-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was originally some doubt about whether these page tables
should be represented by a vanilla struct page or whether they
should be a ptdesc.  As we continue on our quest to shrink
struct page, we seem to have crossed the line into believing that
thse page tables should be a ptdesc.  At least for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/mm/gmap.c | 181 ++++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 92 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 16b8a36c56de..2ca100aae1f7 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -26,15 +26,15 @@
 
 #define GMAP_SHADOW_FAKE_TABLE 1ULL
 
-static struct page *gmap_alloc_crst(void)
+static struct ptdesc *gmap_alloc_crst(void)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return NULL;
-	__arch_set_page_dat(page_to_virt(page), 1UL << CRST_ALLOC_ORDER);
-	return page;
+	__arch_set_page_dat(ptdesc_to_virt(ptdesc), 1UL << CRST_ALLOC_ORDER);
+	return ptdesc;
 }
 
 /**
@@ -46,7 +46,7 @@ static struct page *gmap_alloc_crst(void)
 static struct gmap *gmap_alloc(unsigned long limit)
 {
 	struct gmap *gmap;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long *table;
 	unsigned long etype, atype;
 
@@ -79,12 +79,12 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	spin_lock_init(&gmap->guest_table_lock);
 	spin_lock_init(&gmap->shadow_lock);
 	refcount_set(&gmap->ref_count, 1);
-	page = gmap_alloc_crst();
-	if (!page)
+	ptdesc = gmap_alloc_crst();
+	if (!ptdesc)
 		goto out_free;
-	page->index = 0;
-	list_add(&page->lru, &gmap->crst_list);
-	table = page_to_virt(page);
+	ptdesc->pt_index = 0;
+	list_add(&ptdesc->pt_list, &gmap->crst_list);
+	table = ptdesc_to_virt(ptdesc);
 	crst_table_init(table, etype);
 	gmap->table = table;
 	gmap->asce = atype | _ASCE_TABLE_LENGTH |
@@ -193,23 +193,21 @@ static void gmap_rmap_radix_tree_free(struct radix_tree_root *root)
  */
 static void gmap_free(struct gmap *gmap)
 {
-	struct page *page, *next;
+	struct ptdesc *ptdesc, *next;
 
 	/* Flush tlb of all gmaps (if not already done for shadows) */
 	if (!(gmap_is_shadow(gmap) && gmap->removed))
 		gmap_flush_tlb(gmap);
 	/* Free all segment & region tables. */
-	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
-		__free_pages(page, CRST_ALLOC_ORDER);
+	list_for_each_entry_safe(ptdesc, next, &gmap->crst_list, pt_list)
+		pagetable_free(ptdesc);
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
-		struct ptdesc *ptdesc, *n;
-
 		/* Free all page tables. */
-		list_for_each_entry_safe(ptdesc, n, &gmap->pt_list, pt_list)
+		list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
 			page_table_free_pgste(ptdesc);
 		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
 		/* Release reference to the parent */
@@ -287,26 +285,26 @@ EXPORT_SYMBOL_GPL(gmap_remove);
 static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 			    unsigned long init, unsigned long gaddr)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long *new;
 
 	/* since we dont free the gmap table until gmap_free we can unlock */
-	page = gmap_alloc_crst();
-	if (!page)
+	ptdesc = gmap_alloc_crst();
+	if (!ptdesc)
 		return -ENOMEM;
-	new = page_to_virt(page);
+	new = ptdesc_to_virt(ptdesc);
 	crst_table_init(new, init);
 	spin_lock(&gmap->guest_table_lock);
 	if (*table & _REGION_ENTRY_INVALID) {
-		list_add(&page->lru, &gmap->crst_list);
+		list_add(&ptdesc->pt_list, &gmap->crst_list);
 		*table = __pa(new) | _REGION_ENTRY_LENGTH |
 			(*table & _REGION_ENTRY_TYPE_MASK);
-		page->index = gaddr;
-		page = NULL;
+		ptdesc->pt_index = gaddr;
+		ptdesc = NULL;
 	}
 	spin_unlock(&gmap->guest_table_lock);
-	if (page)
-		__free_pages(page, CRST_ALLOC_ORDER);
+	if (ptdesc)
+		pagetable_free(ptdesc);
 	return 0;
 }
 
@@ -318,13 +316,13 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
  */
 static unsigned long __gmap_segment_gaddr(unsigned long *entry)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long offset;
 
 	offset = (unsigned long) entry / sizeof(unsigned long);
 	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
-	page = pmd_pgtable_page((pmd_t *) entry);
-	return page->index + offset;
+	ptdesc = pmd_ptdesc((pmd_t *) entry);
+	return ptdesc->pt_index + offset;
 }
 
 /**
@@ -1458,7 +1456,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 {
 	unsigned long r3o, *r3e;
 	phys_addr_t sgt;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r3e = gmap_table_walk(sg, raddr, 2); /* get region-3 pointer */
@@ -1471,9 +1469,9 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	*r3e = _REGION3_ENTRY_EMPTY;
 	__gmap_unshadow_sgt(sg, raddr, __va(sgt));
 	/* Free segment table */
-	page = phys_to_page(sgt);
-	list_del(&page->lru);
-	__free_pages(page, CRST_ALLOC_ORDER);
+	ptdesc = page_ptdesc(phys_to_page(sgt));
+	list_del(&ptdesc->pt_list);
+	pagetable_free(ptdesc);
 }
 
 /**
@@ -1487,7 +1485,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 				unsigned long *r3t)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t sgt;
 	int i;
 
@@ -1499,9 +1497,9 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 		r3t[i] = _REGION3_ENTRY_EMPTY;
 		__gmap_unshadow_sgt(sg, raddr, __va(sgt));
 		/* Free segment table */
-		page = phys_to_page(sgt);
-		list_del(&page->lru);
-		__free_pages(page, CRST_ALLOC_ORDER);
+		ptdesc = page_ptdesc(phys_to_page(sgt));
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -1516,7 +1514,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 {
 	unsigned long r2o, *r2e;
 	phys_addr_t r3t;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r2e = gmap_table_walk(sg, raddr, 3); /* get region-2 pointer */
@@ -1529,9 +1527,9 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	*r2e = _REGION2_ENTRY_EMPTY;
 	__gmap_unshadow_r3t(sg, raddr, __va(r3t));
 	/* Free region 3 table */
-	page = phys_to_page(r3t);
-	list_del(&page->lru);
-	__free_pages(page, CRST_ALLOC_ORDER);
+	ptdesc = page_ptdesc(phys_to_page(r3t));
+	list_del(&ptdesc->pt_list);
+	pagetable_free(ptdesc);
 }
 
 /**
@@ -1546,7 +1544,7 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 				unsigned long *r2t)
 {
 	phys_addr_t r3t;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int i;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1557,9 +1555,9 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 		r2t[i] = _REGION2_ENTRY_EMPTY;
 		__gmap_unshadow_r3t(sg, raddr, __va(r3t));
 		/* Free region 3 table */
-		page = phys_to_page(r3t);
-		list_del(&page->lru);
-		__free_pages(page, CRST_ALLOC_ORDER);
+		ptdesc = page_ptdesc(phys_to_page(r3t));
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -1573,7 +1571,7 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 {
 	unsigned long r1o, *r1e;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t r2t;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1587,9 +1585,9 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	*r1e = _REGION1_ENTRY_EMPTY;
 	__gmap_unshadow_r2t(sg, raddr, __va(r2t));
 	/* Free region 2 table */
-	page = phys_to_page(r2t);
-	list_del(&page->lru);
-	__free_pages(page, CRST_ALLOC_ORDER);
+	ptdesc = page_ptdesc(phys_to_page(r2t));
+	list_del(&ptdesc->pt_list);
+	pagetable_free(ptdesc);
 }
 
 /**
@@ -1604,7 +1602,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 				unsigned long *r1t)
 {
 	unsigned long asce;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t r2t;
 	int i;
 
@@ -1619,9 +1617,9 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 		gmap_idte_one(asce, raddr);
 		r1t[i] = _REGION1_ENTRY_EMPTY;
 		/* Free region 2 table */
-		page = phys_to_page(r2t);
-		list_del(&page->lru);
-		__free_pages(page, CRST_ALLOC_ORDER);
+		ptdesc = page_ptdesc(phys_to_page(r2t));
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -1819,18 +1817,18 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	unsigned long raddr, origin, offset, len;
 	unsigned long *table;
 	phys_addr_t s_r2t;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	/* Allocate a shadow region second table */
-	page = gmap_alloc_crst();
-	if (!page)
+	ptdesc = gmap_alloc_crst();
+	if (!ptdesc)
 		return -ENOMEM;
-	page->index = r2t & _REGION_ENTRY_ORIGIN;
+	ptdesc->pt_index = r2t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
-	s_r2t = page_to_phys(page);
+		ptdesc->pt_index |= GMAP_SHADOW_FAKE_TABLE;
+	s_r2t = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
@@ -1851,7 +1849,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		 _REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= (r2t & _REGION_ENTRY_PROTECT);
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1879,7 +1877,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	__free_pages(page, CRST_ALLOC_ORDER);
+	pagetable_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
@@ -1903,18 +1901,18 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	unsigned long raddr, origin, offset, len;
 	unsigned long *table;
 	phys_addr_t s_r3t;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	/* Allocate a shadow region second table */
-	page = gmap_alloc_crst();
-	if (!page)
+	ptdesc = gmap_alloc_crst();
+	if (!ptdesc)
 		return -ENOMEM;
-	page->index = r3t & _REGION_ENTRY_ORIGIN;
+	ptdesc->pt_index = r3t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
-	s_r3t = page_to_phys(page);
+		ptdesc->pt_index |= GMAP_SHADOW_FAKE_TABLE;
+	s_r3t = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
@@ -1935,7 +1933,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		 _REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= (r3t & _REGION_ENTRY_PROTECT);
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1963,7 +1961,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	__free_pages(page, CRST_ALLOC_ORDER);
+	pagetable_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
@@ -1987,18 +1985,18 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	unsigned long raddr, origin, offset, len;
 	unsigned long *table;
 	phys_addr_t s_sgt;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg) || (sgt & _REGION3_ENTRY_LARGE));
 	/* Allocate a shadow segment table */
-	page = gmap_alloc_crst();
-	if (!page)
+	ptdesc = gmap_alloc_crst();
+	if (!ptdesc)
 		return -ENOMEM;
-	page->index = sgt & _REGION_ENTRY_ORIGIN;
+	ptdesc->pt_index = sgt & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
-	s_sgt = page_to_phys(page);
+		ptdesc->pt_index |= GMAP_SHADOW_FAKE_TABLE;
+	s_sgt = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
@@ -2019,7 +2017,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		 _REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= sgt & _REGION_ENTRY_PROTECT;
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -2047,7 +2045,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	__free_pages(page, CRST_ALLOC_ORDER);
+	pagetable_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
@@ -2070,7 +2068,7 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 			   int *fake)
 {
 	unsigned long *table;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -2078,10 +2076,10 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
 	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
 		/* Shadow page tables are full pages (pte+pgste) */
-		page = pfn_to_page(*table >> PAGE_SHIFT);
-		*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
+		ptdesc = page_ptdesc(pfn_to_page(*table >> PAGE_SHIFT));
+		*pgt = ptdesc->pt_index & ~GMAP_SHADOW_FAKE_TABLE;
 		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
-		*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
+		*fake = !!(ptdesc->pt_index & GMAP_SHADOW_FAKE_TABLE);
 		rc = 0;
 	} else  {
 		rc = -EAGAIN;
@@ -2961,11 +2959,10 @@ EXPORT_SYMBOL_GPL(__s390_uv_destroy_range);
  */
 void s390_unlist_old_asce(struct gmap *gmap)
 {
-	struct page *old;
+	struct ptdesc *old;
 
-	old = virt_to_page(gmap->table);
+	old = virt_to_ptdesc(gmap->table);
 	spin_lock(&gmap->guest_table_lock);
-	list_del(&old->lru);
 	/*
 	 * Sometimes the topmost page might need to be "removed" multiple
 	 * times, for example if the VM is rebooted into secure mode several
@@ -2980,7 +2977,7 @@ void s390_unlist_old_asce(struct gmap *gmap)
 	 * pointers, so list_del can work (and do nothing) without
 	 * dereferencing stale or invalid pointers.
 	 */
-	INIT_LIST_HEAD(&old->lru);
+	list_del_init(&old->pt_list);
 	spin_unlock(&gmap->guest_table_lock);
 }
 EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
@@ -3001,7 +2998,7 @@ EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
 int s390_replace_asce(struct gmap *gmap)
 {
 	unsigned long asce;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	void *table;
 
 	s390_unlist_old_asce(gmap);
@@ -3010,11 +3007,11 @@ int s390_replace_asce(struct gmap *gmap)
 	if ((gmap->asce & _ASCE_TYPE_MASK) == _ASCE_TYPE_SEGMENT)
 		return -EINVAL;
 
-	page = gmap_alloc_crst();
-	if (!page)
+	ptdesc = gmap_alloc_crst();
+	if (!ptdesc)
 		return -ENOMEM;
-	page->index = 0;
-	table = page_to_virt(page);
+	ptdesc->pt_index = 0;
+	table = ptdesc_to_virt(ptdesc);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
 	/*
@@ -3023,7 +3020,7 @@ int s390_replace_asce(struct gmap *gmap)
 	 * it will be freed when the VM is torn down.
 	 */
 	spin_lock(&gmap->guest_table_lock);
-	list_add(&page->lru, &gmap->crst_list);
+	list_add(&ptdesc->pt_list, &gmap->crst_list);
 	spin_unlock(&gmap->guest_table_lock);
 
 	/* Set new table origin while preserving existing ASCE control bits */
-- 
2.45.2

