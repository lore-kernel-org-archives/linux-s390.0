Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D624749DF;
	Fri, 14 Aug 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721898; cv=none; b=gDSKq3A2G0lLj7yBLs2jkk5qhQjpgo1OxDOGDX2iqhau66I0YwqnaHnfBIFAULpt2XoxUymSbcCgIBuczcZSYzjh4jGv2NibEesLcET1kj2DVQ1qg7K4DphOKgza4eSlioVRiTOOGGNqwygypWXC39xx22y7c4/vvEZZx6BSOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721898; c=relaxed/simple;
	bh=CngfvDzXBoP0h3Gz5CG205aJbVzOftMP9dKGT/egcpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkBkWj1+E4aQEFfyNAx2wFRxfnUjobiAn35JfghdjQO2Royegaj3dlWti3oGOhAqseX4iiEwtQl4dCc22mEy7wLJAEIlAoiyeIUbqfukMKj0Q8RUZLafRaeESqjgUaPyYgDW6XlqtoNkOB2qXoH0ZjQy5Z7psBQsqZ6Cvq7ekkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc2mb+2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc2mb+2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A451F000E9;
	Fri, 14 Aug 2026 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721897;
	bh=wkZclO5EFfp/AsPP9NT1ry0Ob1y27MoSJujNhZw0tu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bc2mb+2WZkgvu2sdfBbYCscAJDY1wLlb6/bI9WWlzGEjrAqXdeHjy74HbiC3a/VuF
	 usrd1zcOvadZUgTqBsdEuS+SDRqFhOQDbXCg63nGjG9WPs+3qICwUK4tuauzG07Tfj
	 NRIpGZjDF2cAcQ/rPcF2pFwef5mL2KWebMaCEXkltmUrrWQL8UQo/WPqIByuQlF1qX
	 dJkH/wad8dzpUd7uDtrAIbSNABe+5Efp7OoflKd3nu2pE+mTwfg27I/3LcrL0/4yng
	 CG1B4iKej2g2Sih7canzxJX1mM1fB5N1lPKDKZYmH2EI8yUMjFIe/YW7jnTz7SftS+
	 RfUElZEZw4jFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/10] mm/cma: Introduce cma_alloc_at() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org, media-ci@linuxtv.org, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260814-tegra-vpr-v5-5-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-5-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:38:16 +0000
Message-Id: <20260814153816.B9A451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Missing bounds check on `offset` and `count` in `cma_range_all=
oc_at()` allows out-of-bounds heap read/write.
- [High] Failure to scale offsets and counts by `cma->order_per_bit` causes=
 state corruption and memory leaks.
- [High] `__cma_alloc_at_frozen()` illogically applies the exact same relat=
ive `offset` to every disjoint range.
- [Medium] Misleading parameter naming (`pfn` vs `offset`) in `cma_alloc_at=
()` leads to dangerous misinterpretations.
--

--- Patch [5]: [PATCH v5 05/10] mm/cma: Introduce cma_alloc_at() API ---
commit 86953b3fddeca8ceb93fb736c755a0bfda094530
Author: Thierry Reding <treding@nvidia.com>

mm/cma: Introduce cma_alloc_at() API
   =20
This API can be used to allocate a number of CMA pages starting at a
fixed offset. This is useful, for example, if the CMA area is used as
backing storage for a nested allocator that has stricter requirements
than CMA itself.

> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 37195edf24986..00b622a9da97b 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
[ ... ]
> @@ -132,6 +132,69 @@ TRACE_EVENT(cma_alloc_busy_retry,
>  		  __entry->align)
>  );
> =20
> +TRACE_EVENT(cma_alloc_at_start,
> +
> +	TP_PROTO(const char *name, unsigned long pfn,

[Severity: Medium]
Could this parameter name cause confusion? The function signature in cma.h =
uses
offset, but this tracepoint logs it as pfn. If a caller mistakenly passes an
absolute physical frame number instead of a relative offset, could this lead
to an incorrect allocation address computation later in cma_range_alloc_at(=
)?

> +		 unsigned long request_count, unsigned long available_count,
> +		 unsigned long total_count),
[ ... ]
> diff --git a/mm/cma.c b/mm/cma.c
> index a13ce4999b39f..4bc6eef8b6060 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
[ ... ]
> +static int cma_range_alloc_at(struct cma *cma, struct cma_memrange *cmr,
> +			      unsigned long offset, unsigned long count,
> +			      struct page **pagep, gfp_t gfp)
> +{
> +	struct page *page =3D NULL;
> +	unsigned long pfn;
> +	int ret =3D -EBUSY;
> +
> +	spin_lock_irq(&cma->lock);
> +
> +	/*
> +	 * If the request is larger than the available number of pages, stop
> +	 * right away.
> +	 */
> +	if (count > cma->available_count)
> +		goto unlock;
> +
> +	ret =3D bitmap_allocate(cmr->bitmap, offset, count);

[Severity: Critical]
Does this code allow an out-of-bounds read or write on the bitmap? It does =
not
appear to check if offset + count is within cma_bitmap_maxno(cma, cmr).
Because bitmap_allocate() scans and sets bits without knowing the allocation
bounds, a large offset + count could overrun the bitmap.

[Severity: High]
Does this code treat page counts as raw bit indices? The offset and count
parameters represent pages, but are passed directly to bitmap_allocate()
without scaling by cma->order_per_bit.

> +	if (ret < 0)
> +		goto unlock;
> +
> +	pfn =3D cmr->base_pfn + offset;

[Severity: High]
If offset represents raw pages, shouldn't it be consistent with how the
bitmap was updated above? If cma->order_per_bit is non-zero, this treats
offset as pages while the bitmap logic treated it as bits.

> +	page =3D pfn_to_page(pfn);
[ ... ]
> +free:
> +	/* we need to reacquire the lock to clean up the internal state */
> +	spin_lock_irq(&cma->lock);
> +	cma->available_count +=3D count;
> +clear:
> +	bitmap_clear(cmr->bitmap, offset, count);

[Severity: High]
Does this similarly fail to convert the page offset and count to bit indice=
s?
If cma_release() later frees these pages, it will convert the PFNs to bits,
potentially clearing different bits than were set and permanently leaking t=
he
original allocation.

> +unlock:
> +	spin_unlock_irq(&cma->lock);
> +	return ret;
> +}
> +
> +static struct page *__cma_alloc_at_frozen(struct cma *cma, unsigned long=
 offset,
> +					  unsigned long count, gfp_t gfp)
> +{
[ ... ]
> +	for (r =3D 0; r < cma->nranges; r++) {
> +		page =3D NULL;
> +
> +		ret =3D cma_range_alloc_at(cma, &cma->ranges[r], offset, count,
> +					 &page, gfp);

[Severity: High]
Does this apply the same unadjusted offset to every physical memrange? If t=
he
allocation falls back to a subsequent range, it will attempt the allocation=
 at
ranges[r].base_pfn + offset. If offset is meant to be a logical index across
the contiguous CMA area, it seems it should be decremented by the size of
preceding ranges as the loop iterates.

> +		if (ret !=3D -EBUSY || page)
> +			break;
> +	}
[ ... ]
> +struct page *cma_alloc_at(struct cma *cma, unsigned long pfn,
> +			  unsigned long count, bool no_warn)

[Severity: Medium]
Is pfn the correct name for this parameter? It appears to be used as a
relative offset in cma_range_alloc_at(). Passing an absolute physical frame
number could result in computing cmr->base_pfn + pfn, producing an incorrect
physical address.

> +{
> +	struct page *page;
> +
> +	page =3D cma_alloc_at_frozen(cma, pfn, count, no_warn);
> +	if (page)
> +		set_pages_refcounted(page, count);
> +
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(cma_alloc_at);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D5
