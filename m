Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69594483825;
	Fri, 14 Aug 2026 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721387; cv=none; b=E7qYBijTk3Pmw8il5mku604XTGXUSnjet1/xVhni/Y8PQXAS8UZcvJuHx2+ad5WqgdQjsXzOi5GrzpOBTWIL0Edp54lw1reOyb99SEGqP8oJIK+UXnUFqxp8vti4luu1VjMcpQu256CDRyoPJzBR6lIQZKjhwdwbMcjBax6TIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721387; c=relaxed/simple;
	bh=XAFz+SlRkr3oLsGhWb+vz2UMbT7IzvhZ4e5TecR8Zh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKLztBZfKHjmzPz4IIGGxh3B29S2IKGb+m1xlK6PzWexu15q5Eli9yoQY1IYvdq/payWo+vTia6ce4GkW6+E6wu4iOC0QGnRvQuxIYQxprmCfyXvY0oams2qaqjL79Qwy9DneDeYpnDuRWKTDP9QeDCjdduqkKiETsDQUVGhU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TScaB6W5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TScaB6W5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE2E1F00A3A;
	Fri, 14 Aug 2026 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721386;
	bh=B53xWDqmYfvZa6yJt4TYLNzQ/iHTo3TnmEOY4voWzrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TScaB6W55A1XzLOs9xyIaRwxfTpsnVeQy7Hw7gY4T0vzkPHa34BHGIDl8dXxlmPht
	 Is1oNRF6tUrbIt7Qn2doBmlcD9HW2DAGec1qhE22heDpRb83FehxKyjZr5fuJkrKW6
	 Bru6wOnkqW/05EEoZrUeEksj0uXPp+OnrWt7vbXt1c/A3mZBA9OROw6aNhUqA5o8Ln
	 7LnZ7ybAclo26+0pH5wtoqhZM6Aa9UwHim0oPTym/+I8e4YImUfQNyQo+2zdEMQB/+
	 bylEwJPtSgZuQLH3Q/2qfPqt/YYHNeK13XIfa0Xw0yzHjw/tamf12H85kdbxCz/dXU
	 YcHKHjrYYgMlg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:13 +0200
Subject: [PATCH v5 05/10] mm/cma: Introduce cma_alloc_at() API
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-5-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
In-Reply-To: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
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
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8085; i=treding@nvidia.com;
 h=from:subject:message-id; bh=97QBeL/p4gnA3oWbuc8nrY9frCucOEa/VZaNaGGd800=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRY/u1pTDN2EuvbJ7MtOiBc2NgUeKpZTxbki
 m2HnepxKLmJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80WAAKCRDdI6zXfz6z
 odAOD/9kLPUFEP21LxFVMtux6KprhSVJgcaJFoEJBtTsoAw9oyP8EJoYCN1UmWZavseTSU+qYOF
 71q7NwUwVjtPJCzL0j6fZBN2xx6OYV4CP/QrNI3z07bZQQQirkcEEgIIQXkG0o8ZeSgMSgVxcT/
 geQuWUaIIwi0HVsEwLGeC29XAGVCTMqfm8seg9Lgxaz8UnzYThlmYepyarN3mMN/dfFWioWSxYD
 F9uyN+i8CMONXACTPK0UygpJrcGSNWoH0wrTZrHDmYnX/OTTPFoWB4ZeJpFB75H8AWhVJRqHrN+
 cxdolngsD60237ZleJ2YJoe/cZwyzYbxOS06un7Tz36PRcdoS6WUwgIghINL4gk1eMKDSrhhEHM
 b4WufrnUPOVtCXShNDlxtWdnxmaEiOr8cvgkCIwRkH6pmreX0N702LI5E0gAKEawmhlw3PadbEn
 UPYrzoCV3B1eJrqLTp33GG/zoNTkOUNplGQT/Sfj7qIPllj+myGVgRCHhZUtCDX6++OAqQ+tIbW
 wKEikbC1BNgSGm+dmDCi0USaL6909+rLzp1TEA4mBOzn34trVi4avbnntXA4+AN4Z9/1JFHvQs/
 2DXDyShuozSi12MOxFQB28lWF9cLduNXpxloQeKFwJ41Hpf99xGCa+Cct+k2qHPNlYj1UNMTSbA
 UhYxhrn/nZbNkcg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

This API can be used to allocate a number of CMA pages starting at a
fixed offset. This is useful, for example, if the CMA area is used as
backing storage for a nested allocator that has stricter requirements
than CMA itself.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/cma.h        |   4 ++
 include/trace/events/cma.h |  63 +++++++++++++++++++
 mm/cma.c                   | 148 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)

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
index 37195edf2498..00b622a9da97 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -132,6 +132,69 @@ TRACE_EVENT(cma_alloc_busy_retry,
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
index a10ea37a261d..1e1ebae79090 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -936,6 +936,141 @@ struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
 	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
 }
 
+static int cma_range_alloc_at(struct cma *cma, struct cma_memrange *cmr,
+			      unsigned long offset, unsigned long count,
+			      struct page **pagep, gfp_t gfp)
+{
+	struct page *page = NULL;
+	unsigned long pfn;
+	int ret = -EBUSY;
+
+	spin_lock_irq(&cma->lock);
+
+	/*
+	 * If the request is larger than the available number of pages, stop
+	 * right away.
+	 */
+	if (count > cma->available_count)
+		goto unlock;
+
+	ret = bitmap_allocate(cmr->bitmap, offset, count);
+	if (ret < 0)
+		goto unlock;
+
+	pfn = cmr->base_pfn + offset;
+	page = pfn_to_page(pfn);
+
+	/*
+	 * Do not hand out page ranges that are not contiguous, so
+	 * callers can just iterate the pages without having to worry
+	 * about these corner cases.
+	 */
+	if (!page_range_contiguous(page, count)) {
+		pr_warn_ratelimited("%s: %s: skipping non-contiguous area [0x%lx-0x%lx]",
+				    __func__, cma->name, pfn, pfn + count - 1);
+		ret = -EBUSY;
+		goto clear;
+	}
+
+	cma->available_count -= count;
+
+	/*
+	 * It's safe to drop the lock here. We've marked this region for
+	 * our exclusive use. If the migration fails we will take the
+	 * lock again and unmark it.
+	 */
+	spin_unlock_irq(&cma->lock);
+
+	mutex_lock(&cma->alloc_mutex);
+	ret = alloc_contig_frozen_range(pfn, pfn + count, ACR_FLAGS_CMA, gfp);
+	mutex_unlock(&cma->alloc_mutex);
+
+	if (ret < 0)
+		goto free;
+
+	*pagep = page;
+
+	return 0;
+
+free:
+	/* we need to reacquire the lock to clean up the internal state */
+	spin_lock_irq(&cma->lock);
+	cma->available_count += count;
+clear:
+	bitmap_clear(cmr->bitmap, offset, count);
+unlock:
+	spin_unlock_irq(&cma->lock);
+	return ret;
+}
+
+static struct page *__cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
+					  unsigned long count, gfp_t gfp)
+{
+	const char *name = cma ? cma->name : NULL;
+	struct page *page = NULL;
+	int ret = -ENOMEM, r;
+	unsigned long i;
+
+	if (!cma || !cma->count)
+		return page;
+
+	pr_debug("%s(cma %p, name: %s, offset %lu, count %lu)\n", __func__,
+		 (void *)cma, cma->name, offset, count);
+
+	if (!count)
+		return page;
+
+	trace_cma_alloc_at_start(name, offset, count, cma->available_count,
+				 cma->count);
+
+	for (r = 0; r < cma->nranges; r++) {
+		page = NULL;
+
+		ret = cma_range_alloc_at(cma, &cma->ranges[r], offset, count,
+					 &page, gfp);
+		if (ret != -EBUSY || page)
+			break;
+	}
+
+	/*
+	 * CMA can allocate multiple page blocks, which results in different
+	 * blocks being marked with different tags. Reset the tags to ignore
+	 * those page blocks.
+	 */
+	if (page) {
+		for (i = 0; i < count; i++)
+			page_kasan_tag_reset(page + i);
+	}
+
+	if (ret && !(gfp & __GFP_NOWARN)) {
+		pr_err_ratelimited("%s: %s: alloc failed, request: %lu, %lu pages, ret: %d\n",
+				   __func__, cma->name, offset, count, ret);
+		cma_debug_show_areas(cma);
+	}
+
+	pr_debug("%s(): returned %p\n", __func__, page);
+	trace_cma_alloc_at_finish(name, page ? page_to_pfn(page) : 0, page,
+				  count, ret);
+
+	if (page) {
+		count_vm_event(CMA_ALLOC_SUCCESS);
+		cma_sysfs_account_success_pages(cma, count);
+	} else {
+		count_vm_event(CMA_ALLOC_FAIL);
+		cma_sysfs_account_fail_pages(cma, count);
+	}
+
+	return page;
+}
+
+struct page *cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
+				 unsigned long count, bool no_warn)
+{
+	gfp_t gfp = GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0);
+
+	return __cma_alloc_at_frozen(cma, offset, count, gfp);
+}
+
 /**
  * cma_alloc() - allocate pages from contiguous area
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -959,6 +1094,19 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 }
 EXPORT_SYMBOL_GPL(cma_alloc);
 
+struct page *cma_alloc_at(struct cma *cma, unsigned long pfn,
+			  unsigned long count, bool no_warn)
+{
+	struct page *page;
+
+	page = cma_alloc_at_frozen(cma, pfn, count, no_warn);
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

