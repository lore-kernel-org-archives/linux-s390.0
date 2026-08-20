Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20163377A82;
	Thu, 20 Aug 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249067; cv=none; b=QAH92oDKeN9G48VzxsKA6jJ4qWHrSzVr648215B+Ep1rPD2ksf4R/dn/4tzIpmUO9i6HysvrowrRtTFeJaXmlJfIn2qaXP1QG6Ow4RAV5wmmqb30aVkdzKj5YJnP4CeupcxjI1xsTFj7JHjO99/OEbs3p7Q1xFUZeCieI9WZR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249067; c=relaxed/simple;
	bh=KVdbAVTnk5hfvI5Vl7bEmwzD6WiBof/X+WjRvvyOBtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHWO4cr/HzsLXNHf2jQG0tSUkgrZRoq/HZ43ZBRogmWD2PyTc3Tu7rgAAHOImZ68+3rM/DzDcz27g4Z24DX9U4YxHAmGo2WDk6h59WtN5tgSZ5RQ3cBLEViEvQ3g7tn9eMXKU2Bhm3GiEbk+zXjy3BGCb9DUQ2vsLsK0gWT7dSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8okw7BR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8okw7BR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9621F000E9;
	Thu, 20 Aug 2026 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249065;
	bh=m3qrj+DL9uEso2X6MTIsEHUQC1V8fM2Rlt+MQVnuAxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L8okw7BR1E/5RimVg/1EDxrCZxuIBjTDfouneBnY5FzQATWpJvFBVnwvzrBp1tu4h
	 P8dhL3kXkEp3fyut0ouByeDUHGK7mTOuCcr8RItl12hvAOKWuWVbfBMt6RYk7wyRPO
	 Qe+vDRlhE1YURdow/DrxZ2r05BGdQaxq332JoDD9YrpQys4pvo2dQJ2cu6vpSIonb+
	 v5XU7S4iQP4xwamfAJgWRyWHTaFpWpQZ/cAE/2yjVQYSSH/8MxlHfPGj/cwRuChCPZ
	 gsaRxLTlp7a526U0zazwcjSi2rQ2r+SsiC0dNr6pU+9WZ66RzV11HlCEcKodcUB3Cl
	 r5jamZMCZm6Dg==
Message-ID: <ae6c93e6-10f2-4bac-be61-118bbfc3c05d@kernel.org>
Date: Thu, 20 Aug 2026 20:04:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] mm/cma: Introduce cma_alloc_at() API
To: Thierry Reding <thierry.reding@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-5-71832b5d0246@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260814-tegra-vpr-v5-5-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>  /* This part must be outside protection */> diff --git a/mm/cma.c b/mm/cma.c
> index a10ea37a261d..1e1ebae79090 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -936,6 +936,141 @@ struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
>  	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
>  }
>  
> +static int cma_range_alloc_at(struct cma *cma, struct cma_memrange *cmr,
> +			      unsigned long offset, unsigned long count,
> +			      struct page **pagep, gfp_t gfp)
> +{
> +	struct page *page = NULL;
> +	unsigned long pfn;
> +	int ret = -EBUSY;
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
> +	ret = bitmap_allocate(cmr->bitmap, offset, count);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	pfn = cmr->base_pfn + offset;
> +	page = pfn_to_page(pfn);
> +
> +	/*
> +	 * Do not hand out page ranges that are not contiguous, so
> +	 * callers can just iterate the pages without having to worry
> +	 * about these corner cases.
> +	 */
> +	if (!page_range_contiguous(page, count)) {
> +		pr_warn_ratelimited("%s: %s: skipping non-contiguous area [0x%lx-0x%lx]",
> +				    __func__, cma->name, pfn, pfn + count - 1);
> +		ret = -EBUSY;
> +		goto clear;
> +	}
> +
> +	cma->available_count -= count;
> +
> +	/*
> +	 * It's safe to drop the lock here. We've marked this region for
> +	 * our exclusive use. If the migration fails we will take the
> +	 * lock again and unmark it.
> +	 */
> +	spin_unlock_irq(&cma->lock);
> +
> +	mutex_lock(&cma->alloc_mutex);
> +	ret = alloc_contig_frozen_range(pfn, pfn + count, ACR_FLAGS_CMA, gfp);
> +	mutex_unlock(&cma->alloc_mutex);
> +

There is quite some code duplication with cma_range_alloc(). Please try harder
to factor common code out and reuse it.



> +	if (ret < 0)
> +		goto free;
> +
> +	*pagep = page;
> +
> +	return 0;
> +
> +free:
> +	/* we need to reacquire the lock to clean up the internal state */
> +	spin_lock_irq(&cma->lock);
> +	cma->available_count += count;
> +clear:
> +	bitmap_clear(cmr->bitmap, offset, count);
> +unlock:
> +	spin_unlock_irq(&cma->lock);
> +	return ret;
> +}
> +
> +static struct page *__cma_alloc_at_frozen(struct cma *cma, unsigned long offset,
> +					  unsigned long count, gfp_t gfp)
> +{
> +	const char *name = cma ? cma->name : NULL;
> +	struct page *page = NULL;
> +	int ret = -ENOMEM, r;
> +	unsigned long i;
> +
> +	if (!cma || !cma->count)
> +		return page;
> +
> +	pr_debug("%s(cma %p, name: %s, offset %lu, count %lu)\n", __func__,
> +		 (void *)cma, cma->name, offset, count);
> +
> +	if (!count)
> +		return page;
> +
> +	trace_cma_alloc_at_start(name, offset, count, cma->available_count,
> +				 cma->count);
> +
> +	for (r = 0; r < cma->nranges; r++) {
> +		page = NULL;
> +
> +		ret = cma_range_alloc_at(cma, &cma->ranges[r], offset, count,
> +					 &page, gfp);
> +		if (ret != -EBUSY || page)
> +			break;
> +	}
> +
> +	/*
> +	 * CMA can allocate multiple page blocks, which results in different
> +	 * blocks being marked with different tags. Reset the tags to ignore
> +	 * those page blocks.
> +	 */
> +	if (page) {
> +		for (i = 0; i < count; i++)
> +			page_kasan_tag_reset(page + i);
> +	}
> +
> +	if (ret && !(gfp & __GFP_NOWARN)) {
> +		pr_err_ratelimited("%s: %s: alloc failed, request: %lu, %lu pages, ret: %d\n",
> +				   __func__, cma->name, offset, count, ret);
> +		cma_debug_show_areas(cma);
> +	}
> +
> +	pr_debug("%s(): returned %p\n", __func__, page);
> +	trace_cma_alloc_at_finish(name, page ? page_to_pfn(page) : 0, page,
> +				  count, ret);
> +
> +	if (page) {
> +		count_vm_event(CMA_ALLOC_SUCCESS);
> +		cma_sysfs_account_success_pages(cma, count);
> +	} else {
> +		count_vm_event(CMA_ALLOC_FAIL);
> +		cma_sysfs_account_fail_pages(cma, count);
> +	}

Also here, way too much code duplication with __cma_alloc_frozen().

There must be a better way :)

(I really prefer this direction of the patch set)


-- 
Cheers,

David
