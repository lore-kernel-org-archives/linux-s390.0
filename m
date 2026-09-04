Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221D46D579;
	Fri,  4 Sep 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518741; cv=none; b=I+rgngM0CDH680/1/nYHCheuwOkcFgu2a1JXymbez7XoCzBB7mkbBIOZ4gz2I5vF3ohpU3Lht2iTFsKzB8vo7K+P3EUZA1+e7jpithdyl14V/efoMgefZDbIFGpSgTN6f2nCV7eF8nE9ry3HpHdaaXBKw9OtZS5EZp+wIOwMUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518741; c=relaxed/simple;
	bh=HmDZm2lDx5I7ds4AUc/GlLZK1YHhHb4aHjuyJlBvC1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNd9Qov89iU5N36NTEB/yrSJThXnBiGV5pn2KhaZljvcXmzDe4ZKDid5t7PKlz3MMPtjiW+EJZ3qHGl++HPTIM2PLCxeuTAcLLpLWjXr1FCxkyyvH9wRluLeE2tqYecrROACknPCTs+xEtzlFDcrfKay6zgEA+qsIcEmWpTFuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPOmoLYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPOmoLYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F3B1F00ACA;
	Fri,  4 Sep 2026 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518738;
	bh=5vNNvzKdHsOvV9OyhJTU/lOueTFevJJO4XmoYOQ+eTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IPOmoLYAsIj3FJJW1IqX+/l6C4WsfKJvtAb4ioQHEWQimGrkjT3/UDN9eS/XSsazP
	 QnpcT5dLz251vFGtth6XVSzuO3S8HHwoQkmScXOo/yrpOo18RNAPMpKZ6t8TjfChEO
	 927FWdOsqLjOJJV7pYWYy7x0tqhx03vfSemHrrCMDtsQiLu1MtFPi8e2JmOUclWhH8
	 5yXFANh7s+CEDhUPH0kgrTyLpa0aegEyCiQdE2X1tJ4EWEqcUge3+dH+ARHfjM4UTS
	 k/ongUpu3rtV2/rM+1xv7P7fnLD517TXmoy8XL9bFVoXS8BzDjr0AWoKXwsvvKqwNt
	 hJqFW0ow9F6OA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:58 +0200
Subject: [PATCH v6 07/12] mm/cma: Introduce cma_alloc_at() API
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-7-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
In-Reply-To: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11699; i=treding@nvidia.com;
 h=from:subject:message-id; bh=g3+Web5AipUed1NoZ7SwnVTMq8b6YiuYb269+8LMDXw=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6zic+A28EOvvjRlHYgr0bkc1hg/XFjhwuR
 58+1xN4tUeJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 oUbcD/4+HDzO44GDVKd8Xfif1Nth0zgLdLG9tJ7rK14JFcNlVH+y/LTxAjade3W5hl3uKhaIOdc
 qso8AWeMpzAse9Scgy+/AWG39dtQ7GclINBLTE7jg9HkAdTAPePfeJC2jvNMzbPfGfVgflwzDgo
 /pTjUcDN257WOqkZtx1dbh7NtC5Llej64onoQXse5ucTIuylefWWrK/6d7peF7ZMP3vNFqSSeT2
 FjgcZDBJA9o6KeTc/TlFcjGR8+stmDjOgt2OD/Bm5izczhwyPtsSqbiDVSgM/G17lSmGv7ZeduH
 anjq5SF4geSTVLaiE0++gi8pc9cuvUzc4TyJzgD/kc1ybjFRmpdhfkkPvlGOeY1gzvQVGea6NT3
 7vGw7wuAVZM80T4JJJJTrluFCrfYeCv7g9Y/pI9MEeuPauS3FlwpBYnUTOGk5nz/QQKQZo0fylm
 r+UIv3vnK5jQ7ozx0XX+f06q8acg5ei1qSKrtGRL/4LQ6lisPOPInpMC83qANdxwz3/Mk9s/kSa
 kJ356dsAQqFG05EOyQOyritpq+mdv0zTcR3lDfyyRx+URbNXUPiVQddq2lcUWoJRiOi4p3bewF5
 x7qpq9Z8tE2ljsepTBYvxNJUreNddRCXHRrymarty6Jb6t2ZaHQbHyZhyM018vOFFHQz/Ck8fuV
 TPBoSmPG44LYgtA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

This API can be used to allocate a number of CMA pages starting at a
fixed offset. This is useful, for example, if the CMA area is used as
backing storage for a nested allocator that has stricter requirements
than CMA itself.

In order to reuse most of the existing code, the cma_range_alloc()
function is enhanced to take as inputs a range of pages to look for a
free region. If this range encompasses the entire CMA range, the
behavior is as before, but the range can also be specified to match
the offset and size passed in from cma_alloc_at(), in which case that
is the range that will be allocated (or allocation will fail if the
range is not available).

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v6:
- refactor cma_range_alloc() so it can be reused for _at() code paths
---
 include/linux/cma.h        |  4 +++
 include/trace/events/cma.h | 77 ++++++++++++++++++++++++++++++++++++++--
 mm/cma.c                   | 88 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 146 insertions(+), 23 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1..844404459a42 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -49,11 +49,15 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
+extern struct page *cma_alloc_at(struct cma *cma, unsigned long offset,
+				 unsigned long count, bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
 
 struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 		unsigned int align, bool no_warn);
 struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
+struct page *cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
+				 unsigned long count, bool no_warn);
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count);
 
diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 37195edf2498..4e0ab63e303f 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -38,13 +38,17 @@ TRACE_EVENT(cma_release,
 
 TRACE_EVENT(cma_alloc_start,
 
-	TP_PROTO(const char *name, unsigned long request_count, unsigned long available_count,
+	TP_PROTO(const char *name, unsigned long start, unsigned long end,
+		unsigned long request_count, unsigned long available_count,
 		unsigned long total_count, unsigned int align),
 
-	TP_ARGS(name, request_count, available_count, total_count, align),
+	TP_ARGS(name, start, end, request_count, available_count, total_count,
+		align),
 
 	TP_STRUCT__entry(
 		__string(name, name)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
 		__field(unsigned long, request_count)
 		__field(unsigned long, available_count)
 		__field(unsigned long, total_count)
@@ -53,14 +57,18 @@ TRACE_EVENT(cma_alloc_start,
 
 	TP_fast_assign(
 		__assign_str(name);
+		__entry->start = start;
+		__entry->end = end;
 		__entry->request_count = request_count;
 		__entry->available_count = available_count;
 		__entry->total_count = total_count;
 		__entry->align = align;
 	),
 
-	TP_printk("name=%s request_count=%lu available_count=%lu total_count=%lu align=%u",
+	TP_printk("name=%s start=%lu end=%lu request_count=%lu available_count=%lu total_count=%lu align=%u",
 		  __get_str(name),
+		  __entry->start,
+		  __entry->end,
 		  __entry->request_count,
 		  __entry->available_count,
 		  __entry->total_count,
@@ -132,6 +140,69 @@ TRACE_EVENT(cma_alloc_busy_retry,
 		  __entry->align)
 );
 
+TRACE_EVENT(cma_alloc_at_start,
+
+	TP_PROTO(const char *name, unsigned long pfn,
+		 unsigned long request_count, unsigned long available_count,
+		 unsigned long total_count),
+
+	TP_ARGS(name, pfn, request_count, available_count, total_count),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned long, pfn)
+		__field(unsigned long, request_count)
+		__field(unsigned long, available_count)
+		__field(unsigned long, total_count)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->pfn = pfn;
+		__entry->request_count = request_count;
+		__entry->available_count = available_count;
+		__entry->total_count = total_count;
+	),
+
+	TP_printk("name=%s pfn=%lx, request_count=%lu available_count=%lu total_count=%lu",
+		  __get_str(name),
+		  __entry->pfn,
+		  __entry->request_count,
+		  __entry->available_count,
+		  __entry->total_count)
+);
+
+TRACE_EVENT(cma_alloc_at_finish,
+
+	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
+		 unsigned long count, int errorno),
+
+	TP_ARGS(name, pfn, page, count, errorno),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned long, pfn)
+		__field(const struct page *, page)
+		__field(unsigned long, count)
+		__field(int, errorno)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->pfn = pfn;
+		__entry->page = page;
+		__entry->count = count;
+		__entry->errorno = errorno;
+	),
+
+	TP_printk("name=%s pfn=0x%lx page=%p count=%lu errorno=%d",
+		  __get_str(name),
+		  __entry->pfn,
+		  __entry->page,
+		  __entry->count,
+		  __entry->errorno)
+);
+
 #endif /* _TRACE_CMA_H */
 
 /* This part must be outside protection */
diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261d..f92d3a188209 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -783,25 +783,32 @@ static void cma_debug_show_areas(struct cma *cma)
 	spin_unlock_irq(&cma->lock);
 }
 
+/*
+ * Searches the CMA memrange, from @start to @end, for a free region of
+ * @count bits. If @end is less or equal to @start, will search the entire
+ * memrange.
+ */
 static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
-				unsigned long count, unsigned int align,
-				struct page **pagep, gfp_t gfp)
+			   unsigned long start, unsigned long end,
+			   unsigned long count, unsigned int align,
+			   struct page **pagep, gfp_t gfp)
 {
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
-	unsigned long start, pfn, mask, offset;
-	int ret = -EBUSY;
+	unsigned long pfn, mask, offset;
 	struct page *page = NULL;
+	int ret = -EBUSY;
 
 	mask = cma_bitmap_aligned_mask(cma, align);
 	offset = cma_bitmap_aligned_offset(cma, cmr, align);
-	bitmap_maxno = cma_bitmap_maxno(cma, cmr);
+	bitmap_maxno = (end > start) ? end : cma_bitmap_maxno(cma, cmr);
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
 		goto out;
 
-	for (start = 0; ; start = bitmap_no + mask + 1) {
+	while (true) {
 		spin_lock_irq(&cma->lock);
+
 		/*
 		 * If the request is larger than the available number
 		 * of pages, stop right away.
@@ -810,6 +817,7 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 			spin_unlock_irq(&cma->lock);
 			break;
 		}
+
 		bitmap_no = bitmap_find_next_zero_area_off(cmr->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
@@ -835,10 +843,11 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 
 		bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
 		cma->available_count -= count;
+
 		/*
-		 * It's safe to drop the lock here. We've marked this region for
-		 * our exclusive use. If the migration fails we will take the
-		 * lock again and unmark it.
+		 * It's safe to drop the lock here. We've marked this region
+		 * for our exclusive use. If the migration fails we will take
+		 * the lock again and unmark it.
 		 */
 		spin_unlock_irq(&cma->lock);
 
@@ -856,37 +865,45 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 			 __func__, pfn, page);
 
 		trace_cma_alloc_busy_retry(cma->name, pfn, page, count, align);
+		start = bitmap_no + mask + 1;
 	}
+
 out:
 	if (!ret)
 		*pagep = page;
+
 	return ret;
 }
 
-static struct page *__cma_alloc_frozen(struct cma *cma,
-		unsigned long count, unsigned int align, gfp_t gfp)
+static struct page *__cma_alloc_frozen(struct cma *cma, unsigned long start,
+				       unsigned long end, unsigned long count,
+				       unsigned int align, gfp_t gfp)
 {
 	struct page *page = NULL;
 	int ret = -ENOMEM, r;
 	unsigned long i;
-	const char *name = cma ? cma->name : NULL;
+
+	/* cma_alloc_at() and friends will only work with single-range CMA */
+	if (WARN_ON_ONCE(start > 0 && cma->nranges != 1))
+		return page;
 
 	if (!cma || !cma->count)
 		return page;
 
-	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
-		(void *)cma, cma->name, count, align);
+	pr_debug("%s(cma %p, name: %s, start %lu, end %lu, count %lu, align %d)\n",
+		 __func__, (void *)cma, cma->name, start, end, count, align);
 
 	if (!count)
 		return page;
 
-	trace_cma_alloc_start(name, count, cma->available_count, cma->count, align);
+	trace_cma_alloc_start(cma->name, start, end, count,
+			      cma->available_count, cma->count, align);
 
 	for (r = 0; r < cma->nranges; r++) {
 		page = NULL;
 
-		ret = cma_range_alloc(cma, &cma->ranges[r], count, align,
-				       &page, gfp);
+		ret = cma_range_alloc(cma, &cma->ranges[r], start, end,
+				      count, align, &page, gfp);
 		if (ret != -EBUSY || page)
 			break;
 	}
@@ -908,7 +925,7 @@ static struct page *__cma_alloc_frozen(struct cma *cma,
 	}
 
 	pr_debug("%s(): returned %p\n", __func__, page);
-	trace_cma_alloc_finish(name, page ? page_to_pfn(page) : 0,
+	trace_cma_alloc_finish(cma->name, page ? page_to_pfn(page) : 0,
 			       page, count, align, ret);
 	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
@@ -926,14 +943,22 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 {
 	gfp_t gfp = GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0);
 
-	return __cma_alloc_frozen(cma, count, align, gfp);
+	return __cma_alloc_frozen(cma, 0, 0, count, align, gfp);
 }
 
 struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
 {
 	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
 
-	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
+	return __cma_alloc_frozen(cma, 0, 0, 1 << order, order, gfp);
+}
+
+struct page *cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
+				 unsigned long count, bool no_warn)
+{
+	gfp_t gfp = GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0);
+
+	return __cma_alloc_frozen(cma, offset, offset + count, count, 0, gfp);
 }
 
 /**
@@ -959,6 +984,29 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 }
 EXPORT_SYMBOL_GPL(cma_alloc);
 
+/**
+ * cma_alloc_at() - allocate pages from contiguous area at fixed offset
+ * @cma:     Contiguous memory region for which the allocation is performed.
+ * @offset:  Index of the first page to allocate.
+ * @count:   Requested number of pages (in PAGE_SIZE order).
+ * @no_warn: Avoid printing message about failed allocation.
+ *
+ * This function allocates a part of the contiguous memory on a specific
+ * contiguous memory area.
+ */
+struct page *cma_alloc_at(struct cma *cma, unsigned long offset,
+			  unsigned long count, bool no_warn)
+{
+	struct page *page;
+
+	page = cma_alloc_at_frozen(cma, offset, count, no_warn);
+	if (page)
+		set_pages_refcounted(page, count);
+
+	return page;
+}
+EXPORT_SYMBOL_GPL(cma_alloc_at);
+
 static struct cma_memrange *find_cma_memrange(struct cma *cma,
 		const struct page *pages, unsigned long count)
 {

-- 
2.55.0

