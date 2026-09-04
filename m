Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012E4746C1;
	Fri,  4 Sep 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520954; cv=none; b=I1BhoMop6BMW4aDoh2+zCjsFocviQUn5xyC5t6nYayHWAVIRDcQDriF7jiwgkHnddp/vITu255tWPI0DKSGrOBwl4T+hIG94whAHSwmFtAX+o4orbXOG3wgRwWUR3IHGZyAdNoFJYgpXvALn1zZ17A3ue3MDu0l7SBx0PBLZk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520954; c=relaxed/simple;
	bh=1OJ8OEceBtLoU11yuXztES2ERg0THZboio7cDVZU84c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p2B1pD5FZivKkt6sIQ1RSOpj7HSE9qs/dD7kQe6VSqlY/wXXHG5eiBLP/33pgN7/THYTF1KAL9KyMo0k/GeNrGwDyklzuR2v8rkwK7P+JC7EM/uDPi4IaCSJIH8ZV7IjKQ6ijSsJOl9GUFinOACIqjcfWmx9k8WRlmZgc5GXBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+H1IUQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+H1IUQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDAB1F00A3D;
	Fri,  4 Sep 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520952;
	bh=+O7tQlPvBZA98q2AjoKIyg6tgq/TkM085PHnF+s/fF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+H1IUQmAvHiI+tZ5goWmK22+M7MDRjROqWsQ2/TRpSY8vP8YHMsaUbS6Nw3ywoZo
	 kiA8ZnBygsH53x53uq5AClxeGKkjSUschcUAbVCbAwlFaaFZDQW6RniYJC0w+7RPXK
	 cdoNp1oSJBTyJR5iJyBn9cVDypKGST92B0xyqsAUtFXck7hWqh5LGd78WpznZ5+0m3
	 zf3+pqlJ8Xc0IxkgRmwzWnE6eNpEWxYlnxKB4EV22pNK387/nT8WYJFC2c3TbHj8OL
	 wjT7XkynLjiYT++a5otcv0nrDMjHZiUcbxCfRZktT3A/VNmd6V7tenHREjpl69B5vT
	 29UGmsB1bDGmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/12] mm/cma: Introduce cma_alloc_at() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, media-ci@linuxtv.org, "Vasily Gorbik" <gor@linux.ibm.com>, devicetree@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-7-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-7-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:22:31 +0000
Message-Id: <20260904112232.0DDAB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Infinite loop in `cma_range_alloc()` when the found page range=
 is not contiguous.
- [High] Unit mismatch in `cma_range_alloc()` causes out-of-bounds bitmap a=
ccesses when `cma->order_per_bit > 0`.
- [Medium] `__cma_alloc_frozen()` dereferences the `cma` pointer before ver=
ifying that it is not NULL.
- [Medium] `cma_alloc_at()` with offset 0 bypasses multi-range protection, =
allowing incorrect fallback allocations.
- [Medium] `cma_alloc_at()` lacks alignment validation for `offset`, leadin=
g to silent truncation.
- [Low] The newly defined trace events `cma_alloc_at_start` and `cma_alloc_=
at_finish` are never emitted.
--

commit 14084cc27d73ffca7f55e0856f2f9a10ae91ca42
Author: Thierry Reding <treding@nvidia.com>
Date:   Fri Sep 4 10:44:58 2026 +0000

mm/cma: Introduce cma_alloc_at() API

This commit introduces a new cma_alloc_at() API to allocate contiguous=20
memory starting at a fixed page offset. The cma_range_alloc() function=20
is refactored to support range-bounded allocations, enabling the new=20
API to reuse the existing allocation path.

> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 37195edf24986..4e0ab63e303f0 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
[ ... ]
> @@ -132,6 +140,69 @@ TRACE_EVENT(cma_alloc_busy_retry,
>  		  __entry->align)
>  );
> =20
> +TRACE_EVENT(cma_alloc_at_start,
> +
> +	TP_PROTO(const char *name, unsigned long pfn,
> +		 unsigned long request_count, unsigned long available_count,
> +		 unsigned long total_count),

[Severity: Low]
Are these new trace events actually emitted anywhere?

It looks like cma_alloc_at() calls __cma_alloc_frozen(), which continues
to use the existing trace_cma_alloc_start() and trace_cma_alloc_finish()
events. Do we need these new definitions if they remain unused?

> diff --git a/mm/cma.c b/mm/cma.c
> index a10ea37a261da..f92d3a1882098 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
[ ... ]
>  static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
> -				unsigned long count, unsigned int align,
> -				struct page **pagep, gfp_t gfp)
> +			   unsigned long start, unsigned long end,
> +			   unsigned long count, unsigned int align,
> +			   struct page **pagep, gfp_t gfp)
>  {
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> -	unsigned long start, pfn, mask, offset;
> -	int ret =3D -EBUSY;
> +	unsigned long pfn, mask, offset;
>  	struct page *page =3D NULL;
> +	int ret =3D -EBUSY;
> =20
>  	mask =3D cma_bitmap_aligned_mask(cma, align);
>  	offset =3D cma_bitmap_aligned_offset(cma, cmr, align);
> -	bitmap_maxno =3D cma_bitmap_maxno(cma, cmr);
> +	bitmap_maxno =3D (end > start) ? end : cma_bitmap_maxno(cma, cmr);
>  	bitmap_count =3D cma_bitmap_pages_to_bits(cma, count);
> =20
>  	if (bitmap_count > bitmap_maxno)
>  		goto out;
> =20
> -	for (start =3D 0; ; start =3D bitmap_no + mask + 1) {
> +	while (true) {
>  		spin_lock_irq(&cma->lock);
[ ... ]
> +		bitmap_no =3D bitmap_find_next_zero_area_off(cmr->bitmap,
> +				bitmap_maxno, start, bitmap_count, mask,
> +				offset);

[Severity: High]
Does this code use page counts where bit indices are expected?

The end and start parameters are passed in as unscaled page counts from
cma_alloc_at(), and end is assigned directly to bitmap_maxno. If
cma->order_per_bit > 0, a single bit represents multiple pages.

Passing unscaled page counts directly as bit indices to
bitmap_find_next_zero_area_off() could cause it to read past the end of the
bitmap, and subsequently cause bitmap_set() to write out of bounds.

>  		if (bitmap_no >=3D bitmap_maxno) {
>  			spin_unlock_irq(&cma->lock);
>  			break;
>  		}
> =20
>  		pfn =3D cmr->base_pfn + (bitmap_no << cma->order_per_bit);
>  		page =3D pfn_to_page(pfn);
> =20
>  		/*
>  		 * Do not hand out page ranges that are not contiguous, so
>  		 * callers can just iterate the pages without having to worry
>  		 * about these corner cases.
>  		 */
>  		if (!page_range_contiguous(page, count)) {
>  			spin_unlock_irq(&cma->lock);
>  			pr_warn_ratelimited("%s: %s: skipping incompatible area [0x%lx-0x%lx]=
",
>  					    __func__, cma->name, pfn, pfn + count - 1);
>  			continue;
>  		}

[Severity: Critical]
Could this continue statement cause an infinite loop?

Since this was changed from a for loop to a while (true) loop, the
continue statement jumps directly back to the loop condition. This skips
the 'start =3D bitmap_no + mask + 1;' update at the end of the loop body.

The loop will retry with the exact same start index and unmodified bitmap
state, find the exact same incompatible area, and loop without terminating.

[ ... ]
> -static struct page *__cma_alloc_frozen(struct cma *cma,
> -		unsigned long count, unsigned int align, gfp_t gfp)
> +static struct page *__cma_alloc_frozen(struct cma *cma, unsigned long st=
art,
> +				       unsigned long end, unsigned long count,
> +				       unsigned int align, gfp_t gfp)
>  {
>  	struct page *page =3D NULL;
>  	int ret =3D -ENOMEM, r;
>  	unsigned long i;
> -	const char *name =3D cma ? cma->name : NULL;
> +
> +	/* cma_alloc_at() and friends will only work with single-range CMA */
> +	if (WARN_ON_ONCE(start > 0 && cma->nranges !=3D 1))
> +		return page;

[Severity: Medium]
Is there a risk of a NULL pointer dereference here?

If __cma_alloc_frozen() is called with a NULL cma pointer and a non-zero
start offset via the exported cma_alloc_at() API, cma->nranges is
evaluated before the '!cma || !cma->count' safety check below it.

[Severity: Medium]
Does this check properly guard exact-offset allocations if offset is 0?

If a caller requests an allocation exactly at offset 0, start will be 0,
which evaluates to false for the 'start > 0' condition.

This bypasses the single-range enforcement. If the first range is busy, the
code could erroneously fall back and iterate over subsequent ranges,
potentially returning an allocation at an arbitrary physical offset.

> =20
>  	if (!cma || !cma->count)
>  		return page;
[ ... ]
> +/**
> + * cma_alloc_at() - allocate pages from contiguous area at fixed offset
> + * @cma:     Contiguous memory region for which the allocation is perfor=
med.
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

[Severity: Medium]
Does this API need to validate that the requested offset is aligned with
the CMA block size?

CMA allocates memory in chunks of (1 << cma->order_per_bit) pages. The
offset is passed in pages without validation. If properly scaled to bits
later, an unaligned offset would be silently truncated, allocating a block
at a rounded-down physical address instead of the exact requested offset.

> +	struct page *page;
> +
> +	page =3D cma_alloc_at_frozen(cma, offset, count, no_warn);
> +	if (page)
> +		set_pages_refcounted(page, count);
> +
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(cma_alloc_at);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D7
