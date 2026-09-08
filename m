Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FB3F327A
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855673; cv=none; b=OEEtdVIWOP10hMnyemdVs4aq8b2s1yv402mzkfIeP+hCDsAERbD7bOji2FTZ7B0yiNGi2MUesLvy5iY6MrxLgRxMkKcH3udW7bp5CFLWx6jtZbhqRAvgql4OmMlxq56i1APPttg7Ngxt2diV7+Wz7TwtFZFARg85n42V8yyBAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855673; c=relaxed/simple;
	bh=2GPv3CSE0qVbAhsN2Kki3IjcD+uwTwSi7RbmJjZRcIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=a9ww9LTaFS9Ej+Zwj/bea3TiavpnytulBzAEtxRib6OnagPLh1+6z3YBfnbYbQGyb8OcDQwmPiBQ65oBlqdT8olU72i33qK1lbTloYZFTGyy2HOdHE0t56x2g74nubt5LeaRNOcmW212p+bZLpHpfTY8AnVqcBpwZhnzzfemajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KmAefoZG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KmAefoZG"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260908082102euoutp0210f0171962a912d7439089d7c03d40fb~TSr86R_3h0561805618euoutp02S
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 08:21:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260908082102euoutp0210f0171962a912d7439089d7c03d40fb~TSr86R_3h0561805618euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788855662;
	bh=Sfx91CShzrdAeYPF8QQviGdlRmGljU972NsYhPjm+hY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KmAefoZGlo4tlmfgmycp5ej0k1xg7W7ABt9FWYLRrWFZZNx9ougFH/ZmcCnWZGvya
	 f+WAV8zZQ464ojpc5Sv21SuCvzi/f98EEKTVuIGoWrWR0y5Tp+Zg7yIH5vZMWUZgRX
	 Pr9DllXIxRHLWDddd/tr97W6bfWXSq0Vr9Vhu5cQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260908082101eucas1p1b98597ee7866e0889bb1a853c318175c~TSr8gW6EM0711007110eucas1p1J;
	Tue,  8 Sep 2026 08:21:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260908082100eusmtip2b264cdb1a3edc330096d5427b9dc35a5~TSr7mezgn3204232042eusmtip2C;
	Tue,  8 Sep 2026 08:21:00 +0000 (GMT)
Message-ID: <fa91f9e3-ae45-44b2-9429-348fbc73c285@samsung.com>
Date: Tue, 8 Sep 2026 10:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 07/12] mm/cma: Introduce cma_alloc_at() API
To: Thierry Reding <thierry.reding@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260904-tegra-vpr-v6-7-79042cfa8de5@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260908082101eucas1p1b98597ee7866e0889bb1a853c318175c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904104542eucas1p15f23d1ef005ed971314ee29521fc1e9d
X-EPHeader: CA
X-CMS-RootMailID: 20260904104542eucas1p15f23d1ef005ed971314ee29521fc1e9d
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
	<CGME20260904104542eucas1p15f23d1ef005ed971314ee29521fc1e9d@eucas1p1.samsung.com>
	<20260904-tegra-vpr-v6-7-79042cfa8de5@nvidia.com>

On 04.09.2026 12:44, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> This API can be used to allocate a number of CMA pages starting at a
> fixed offset. This is useful, for example, if the CMA area is used as
> backing storage for a nested allocator that has stricter requirements
> than CMA itself.
>
> In order to reuse most of the existing code, the cma_range_alloc()
> function is enhanced to take as inputs a range of pages to look for a
> free region. If this range encompasses the entire CMA range, the
> behavior is as before, but the range can also be specified to match
> the offset and size passed in from cma_alloc_at(), in which case that
> is the range that will be allocated (or allocation will fail if the
> range is not available).
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changes in v6:
> - refactor cma_range_alloc() so it can be reused for _at() code paths
> ---
>  include/linux/cma.h        |  4 +++
>  include/trace/events/cma.h | 77 ++++++++++++++++++++++++++++++++++++++--
>  mm/cma.c                   | 88 +++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 146 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 8555d38a97b1..844404459a42 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -49,11 +49,15 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					struct cma **res_cma);
>  extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>  			      bool no_warn);
> +extern struct page *cma_alloc_at(struct cma *cma, unsigned long offset,
> +				 unsigned long count, bool no_warn);
>  extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
>  
>  struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>  		unsigned int align, bool no_warn);
>  struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
> +struct page *cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
> +				 unsigned long count, bool no_warn);
>  bool cma_release_frozen(struct cma *cma, const struct page *pages,
>  		unsigned long count);
>  
> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 37195edf2498..4e0ab63e303f 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
> @@ -38,13 +38,17 @@ TRACE_EVENT(cma_release,
>  
>  TRACE_EVENT(cma_alloc_start,
>  
> -	TP_PROTO(const char *name, unsigned long request_count, unsigned long available_count,
> +	TP_PROTO(const char *name, unsigned long start, unsigned long end,
> +		unsigned long request_count, unsigned long available_count,
>  		unsigned long total_count, unsigned int align),
>  
> -	TP_ARGS(name, request_count, available_count, total_count, align),
> +	TP_ARGS(name, start, end, request_count, available_count, total_count,
> +		align),
>  
>  	TP_STRUCT__entry(
>  		__string(name, name)
> +		__field(unsigned long, start)
> +		__field(unsigned long, end)
>  		__field(unsigned long, request_count)
>  		__field(unsigned long, available_count)
>  		__field(unsigned long, total_count)
> @@ -53,14 +57,18 @@ TRACE_EVENT(cma_alloc_start,
>  
>  	TP_fast_assign(
>  		__assign_str(name);
> +		__entry->start = start;
> +		__entry->end = end;
>  		__entry->request_count = request_count;
>  		__entry->available_count = available_count;
>  		__entry->total_count = total_count;
>  		__entry->align = align;
>  	),
>  
> -	TP_printk("name=%s request_count=%lu available_count=%lu total_count=%lu align=%u",
> +	TP_printk("name=%s start=%lu end=%lu request_count=%lu available_count=%lu total_count=%lu align=%u",
>  		  __get_str(name),
> +		  __entry->start,
> +		  __entry->end,
>  		  __entry->request_count,
>  		  __entry->available_count,
>  		  __entry->total_count,
> @@ -132,6 +140,69 @@ TRACE_EVENT(cma_alloc_busy_retry,
>  		  __entry->align)
>  );
>  
> +TRACE_EVENT(cma_alloc_at_start,
> +
> +	TP_PROTO(const char *name, unsigned long pfn,
> +		 unsigned long request_count, unsigned long available_count,
> +		 unsigned long total_count),
> +
> +	TP_ARGS(name, pfn, request_count, available_count, total_count),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned long, pfn)
> +		__field(unsigned long, request_count)
> +		__field(unsigned long, available_count)
> +		__field(unsigned long, total_count)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->pfn = pfn;
> +		__entry->request_count = request_count;
> +		__entry->available_count = available_count;
> +		__entry->total_count = total_count;
> +	),
> +
> +	TP_printk("name=%s pfn=%lx, request_count=%lu available_count=%lu total_count=%lu",
> +		  __get_str(name),
> +		  __entry->pfn,
> +		  __entry->request_count,
> +		  __entry->available_count,
> +		  __entry->total_count)
> +);
> +
> +TRACE_EVENT(cma_alloc_at_finish,
> +
> +	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> +		 unsigned long count, int errorno),
> +
> +	TP_ARGS(name, pfn, page, count, errorno),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned long, pfn)
> +		__field(const struct page *, page)
> +		__field(unsigned long, count)
> +		__field(int, errorno)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->pfn = pfn;
> +		__entry->page = page;
> +		__entry->count = count;
> +		__entry->errorno = errorno;
> +	),
> +
> +	TP_printk("name=%s pfn=0x%lx page=%p count=%lu errorno=%d",
> +		  __get_str(name),
> +		  __entry->pfn,
> +		  __entry->page,
> +		  __entry->count,
> +		  __entry->errorno)
> +);
> +
>  #endif /* _TRACE_CMA_H */
>  
>  /* This part must be outside protection */
> diff --git a/mm/cma.c b/mm/cma.c
> index a10ea37a261d..f92d3a188209 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -783,25 +783,32 @@ static void cma_debug_show_areas(struct cma *cma)
>  	spin_unlock_irq(&cma->lock);
>  }
>  
> +/*
> + * Searches the CMA memrange, from @start to @end, for a free region of
> + * @count bits. If @end is less or equal to @start, will search the entire
> + * memrange.
> + */
>  static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
> -				unsigned long count, unsigned int align,
> -				struct page **pagep, gfp_t gfp)
> +			   unsigned long start, unsigned long end,
> +			   unsigned long count, unsigned int align,
> +			   struct page **pagep, gfp_t gfp)
>  {
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> -	unsigned long start, pfn, mask, offset;
> -	int ret = -EBUSY;
> +	unsigned long pfn, mask, offset;
>  	struct page *page = NULL;
> +	int ret = -EBUSY;
>  
>  	mask = cma_bitmap_aligned_mask(cma, align);
>  	offset = cma_bitmap_aligned_offset(cma, cmr, align);
> -	bitmap_maxno = cma_bitmap_maxno(cma, cmr);
> +	bitmap_maxno = (end > start) ? end : cma_bitmap_maxno(cma, cmr);
>  	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>  
>  	if (bitmap_count > bitmap_maxno)
>  		goto out;
>  
> -	for (start = 0; ; start = bitmap_no + mask + 1) {
> +	while (true) {
>  		spin_lock_irq(&cma->lock);
> +
>  		/*
>  		 * If the request is larger than the available number
>  		 * of pages, stop right away.
> @@ -810,6 +817,7 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
>  			spin_unlock_irq(&cma->lock);
>  			break;
>  		}
> +
>  		bitmap_no = bitmap_find_next_zero_area_off(cmr->bitmap,
>  				bitmap_maxno, start, bitmap_count, mask,
>  				offset);
> @@ -835,10 +843,11 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
>  
>  		bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
>  		cma->available_count -= count;
> +
>  		/*
> -		 * It's safe to drop the lock here. We've marked this region for
> -		 * our exclusive use. If the migration fails we will take the
> -		 * lock again and unmark it.
> +		 * It's safe to drop the lock here. We've marked this region
> +		 * for our exclusive use. If the migration fails we will take
> +		 * the lock again and unmark it.
>  		 */
>  		spin_unlock_irq(&cma->lock);
>  
> @@ -856,37 +865,45 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
>  			 __func__, pfn, page);
>  
>  		trace_cma_alloc_busy_retry(cma->name, pfn, page, count, align);
> +		start = bitmap_no + mask + 1;
>  	}
> +
>  out:
>  	if (!ret)
>  		*pagep = page;
> +
>  	return ret;
>  }
>  
> -static struct page *__cma_alloc_frozen(struct cma *cma,
> -		unsigned long count, unsigned int align, gfp_t gfp)
> +static struct page *__cma_alloc_frozen(struct cma *cma, unsigned long start,
> +				       unsigned long end, unsigned long count,
> +				       unsigned int align, gfp_t gfp)
>  {
>  	struct page *page = NULL;
>  	int ret = -ENOMEM, r;
>  	unsigned long i;
> -	const char *name = cma ? cma->name : NULL;
> +
> +	/* cma_alloc_at() and friends will only work with single-range CMA */
> +	if (WARN_ON_ONCE(start > 0 && cma->nranges != 1))
> +		return page;
>  
>  	if (!cma || !cma->count)
>  		return page;
>  
> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> -		(void *)cma, cma->name, count, align);
> +	pr_debug("%s(cma %p, name: %s, start %lu, end %lu, count %lu, align %d)\n",
> +		 __func__, (void *)cma, cma->name, start, end, count, align);
>  
>  	if (!count)
>  		return page;
>  
> -	trace_cma_alloc_start(name, count, cma->available_count, cma->count, align);
> +	trace_cma_alloc_start(cma->name, start, end, count,
> +			      cma->available_count, cma->count, align);
>  
>  	for (r = 0; r < cma->nranges; r++) {
>  		page = NULL;
>  
> -		ret = cma_range_alloc(cma, &cma->ranges[r], count, align,
> -				       &page, gfp);
> +		ret = cma_range_alloc(cma, &cma->ranges[r], start, end,
> +				      count, align, &page, gfp);
>  		if (ret != -EBUSY || page)
>  			break;
>  	}
> @@ -908,7 +925,7 @@ static struct page *__cma_alloc_frozen(struct cma *cma,
>  	}
>  
>  	pr_debug("%s(): returned %p\n", __func__, page);
> -	trace_cma_alloc_finish(name, page ? page_to_pfn(page) : 0,
> +	trace_cma_alloc_finish(cma->name, page ? page_to_pfn(page) : 0,
>  			       page, count, align, ret);
>  	if (page) {
>  		count_vm_event(CMA_ALLOC_SUCCESS);
> @@ -926,14 +943,22 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>  {
>  	gfp_t gfp = GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0);
>  
> -	return __cma_alloc_frozen(cma, count, align, gfp);
> +	return __cma_alloc_frozen(cma, 0, 0, count, align, gfp);
>  }
>  
>  struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
>  {
>  	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
>  
> -	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
> +	return __cma_alloc_frozen(cma, 0, 0, 1 << order, order, gfp);
> +}
> +
> +struct page *cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
> +				 unsigned long count, bool no_warn)
> +{
> +	gfp_t gfp = GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0);
> +
> +	return __cma_alloc_frozen(cma, offset, offset + count, count, 0, gfp);
>  }
>  
>  /**
> @@ -959,6 +984,29 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  }
>  EXPORT_SYMBOL_GPL(cma_alloc);
>  
> +/**
> + * cma_alloc_at() - allocate pages from contiguous area at fixed offset
> + * @cma:     Contiguous memory region for which the allocation is performed.
> + * @offset:  Index of the first page to allocate.
> + * @count:   Requested number of pages (in PAGE_SIZE order).
> + * @no_warn: Avoid printing message about failed allocation.
> + *
> + * This function allocates a part of the contiguous memory on a specific
> + * contiguous memory area.
> + */
> +struct page *cma_alloc_at(struct cma *cma, unsigned long offset,
> +			  unsigned long count, bool no_warn)
> +{
> +	struct page *page;
> +
> +	page = cma_alloc_at_frozen(cma, offset, count, no_warn);
> +	if (page)
> +		set_pages_refcounted(page, count);
> +
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(cma_alloc_at);
> +
>  static struct cma_memrange *find_cma_memrange(struct cma *cma,
>  		const struct page *pages, unsigned long count)
>  {
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

