Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF42C08C8
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680652; cv=none; b=tf+XTCTSbPYVpDkm8vCsRS/lSU0o1PtUJy2ZTCWh+sx8wuFPOLXYLYbAvKlvEawhEqC7jyk1oOzwqVrqF42FgzxdgZx33vsj/muKQS0wXmGS5t86ttBoJuyMtmrR46tqpOjHYE5rzljVvU5xGEEWeKtPnNKpTFSSSCsAilN7dVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680652; c=relaxed/simple;
	bh=zdeu/GAfbg3xOBoi1lmzn96u9C0hMleMcLIylzJcuRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTA7B9zanZOqL0biBJffDsOhDTYwpP+YK2h7dLSxDGikkpV3WSgwNXuvTaf35M5L9zOy1azQ7FzerbooXjt4VXAECW8n9z81Fe284n9yz8+AhKDXp9MA+ChZTHBUhQKWoJayVosDRc4CUnOfsjy595XP36iFvkTpKIQWrbj9zGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIcvbIt3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIcvbIt3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d864c23bdso16501cf.1
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778680649; x=1779285449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RC0MVOdN5acyyI+7Hj0grkgWIyN6rVofWs5PThfM++E=;
        b=cIcvbIt3rreN5XDrP0nJYXYiAKWqNGn2hz5qtnTmuwTPwMuk02iux661mzdNqv+Nv/
         +GMQ7PcW8GcTEtn0pcTz52gxHZtOqsszFlKiqoNahUIrQOkgMjWWWgT/FP2IvSPDb8aa
         3W+EWEKRNIeVgWb6hpdYTu4Ss/2e6QsfCTfyJJaZM3kVFi+LdChof5MwEqjXsZNwdOo6
         pPuxGZVgK7cjZTOC7X4i320rU9xG1GOps1S2CONydBMCLqid1Ev2LWEMevrgWUyBbaom
         GbbENue2h3hgnFLxzAFnGk3LsausEuAsv9CFALzg2ImUvku+SoCOYKfN5FGJmUEqAADM
         yYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680649; x=1779285449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC0MVOdN5acyyI+7Hj0grkgWIyN6rVofWs5PThfM++E=;
        b=Z8+FQTqE+jDa4GGbZjuqTuemTTC5/Bedvamx/xWJ2os2ugHhTJ68POqxN8M/w8nv2Z
         APB/9dmS8b0ViFuIXZ7kpS1tT33Jb5NPSWkEW4kR1K7HZ152h5PA4TueM/+i8OoyV2zm
         gMXOAuq1lNmmogwZmxWqWfqIH7DVi6dZoYieyt08W9GMUA2W+53vtpUXGgnKc+ER6fH3
         mQwzIPyCVC3T5jp9sc36KUt9m1Z5tjAD1cGm+wNGKLIViTRGZI9RUv7rnGl3qBrxeBhU
         Xm/dJnUiFbvUwv3eEDVsgjYAtlw4XlvUBAziHg9FgFMal8PZGAr105l05dnPdtoNQ5l/
         z5Zg==
X-Forwarded-Encrypted: i=1; AFNElJ+qJf/AOER2kMErhlFsdMjmCbBFQPdauy9Q7a/EyAlznCthhScMqZKQKrUcn4NGRy+RDsfdFWXbFLm9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyv+lYdd8hHfjsVcqhKML1/NJNDzACB61mLfxt2C/dnzXQWgCR
	eNe4HQhvqjkLP1vTRHNW3XwPdoz/maAmvBFPFyYoJCntxeoFdvUmlLdX38rBsIYowg==
X-Gm-Gg: Acq92OFTNuMUcopTZH/yX+TaApNb5I3IjBCDK/QQAnNn7Ffq0MyRnbCgJ92HMAXqB/C
	oAcgHB6yfzqc0xyizx1AyVAby3F1WOKJ9vlG9M2iOwLuxGDn7ruDWx4eJ0KNyef3ZKGOTBr+GMm
	xUmsCzWK1pd62XEctulp0RD+ptC4XtDJt/9V0s7bJft9lzXTzIM+Q7I5ISgDa1H+eEJUSAKDymi
	XHVI4TfcuYwYGaEx3wo+jiEjuzfxFLaAtplJtRyZo4a79YFpj2iaVBA7Gx+pSsY1ahq++O1IzUJ
	pHOj5nqxet2RZaVX2cah1gTHQK62mCPVlBvtO8jg4LArfK+Tz5c57xVtgPURjT5EE5bLf5VyIey
	urrxXq0JhavEvjIgCgDxH7vZKmt0YfU3pvr9bFjt00+0ASnt0dv4F6ERfjzLY0ltmU7nd9ssgxy
	q7l9qGwA043tDVhkdkScexBf7GZOg2xWo7EBMW+cr7n8A2RMeGZxMHvKaIOJVB1CjDmxGO
X-Received: by 2002:a05:622a:5885:b0:50e:5e19:587a with SMTP id d75a77b69052e-5162f6cdb43mr14055691cf.3.1778680648735;
        Wed, 13 May 2026 06:57:28 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652744asm186174597b3.1.2026.05.13.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:57:27 -0700 (PDT)
Date: Wed, 13 May 2026 13:57:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 01/13] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <agSDPJMZkcI-uH8f@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512090408.794195-2-aneesh.kumar@kernel.org>

On Tue, May 12, 2026 at 02:33:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
> dma_direct_alloc() / dma_direct_alloc_pages().
> 
> This is needed for follow-up changes that simplify the handling of
> memory encryption/decryption based on the DMA attribute flags.
> 
> swiotlb backing pages are already mapped decrypted by
> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
> dma-direct should not call dma_set_decrypted() on allocation nor
> dma_set_encrypted() on free for swiotlb-backed memory.
> 
> Update alloc/free paths to detect swiotlb-backed pages and skip
> encrypt/decrypt transitions for those paths. Keep the existing highmem
> rejection in dma_direct_alloc_pages() for swiotlb allocations.
> 
> Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
> typically used together with "shared-dma-pool", where the shared region is
> accessed after remap/ioremap and the returned address is suitable for
> decrypted memory access. So existing code paths remain valid.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 44 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..b958f150718a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -125,9 +125,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>  
> -	if (is_swiotlb_for_alloc(dev))
> -		return dma_direct_alloc_swiotlb(dev, size);
> -
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>  	page = dma_alloc_contiguous(dev, size, gfp);
>  	if (page) {
> @@ -204,6 +201,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> +	bool mark_mem_decrypt = true;
>  	struct page *page;
>  	void *ret;
>  
> @@ -250,11 +248,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (page) {
> +			mark_mem_decrypt = false;
> +			goto setup_page;
> +		}
> +		return NULL;
> +	}
> +
>  	/* we always manually zero the memory once we are done */
>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>  	if (!page)
>  		return NULL;
>  
> +setup_page:
>  	/*
>  	 * dma_alloc_contiguous can return highmem pages depending on a
>  	 * combination the cma= arguments and per-arch setup.  These need to be
> @@ -281,7 +289,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  			goto out_free_pages;
>  	} else {
>  		ret = page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> +		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))

I am ok with that approach, but Jason was mentioning we shouldn’t
special case swiotlb and make the allocator return the memory state
(similar to the dma_page [1]) . I am also OK if you want to merge that
part of my series with is.

[1] https://lore.kernel.org/linux-iommu/20260408194750.2280873-1-smostafa@google.com/

>  			goto out_leak_pages;
>  	}
>  
> @@ -298,7 +306,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return ret;
>  
>  out_encrypt_pages:
> -	if (dma_set_encrypted(dev, page_address(page), size))
> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
>  		return NULL;
>  out_free_pages:
>  	__dma_direct_free_pages(dev, page, size);
> @@ -310,6 +318,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
> +	bool mark_mem_encrypted = true;
>  	unsigned int page_order = get_order(size);
>  
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> @@ -338,12 +347,15 @@ void dma_direct_free(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>  		return;
>  
> +	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
> +		mark_mem_encrypted = false;
> +
>  	if (is_vmalloc_addr(cpu_addr)) {
>  		vunmap(cpu_addr);
>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> -		if (dma_set_encrypted(dev, cpu_addr, size))
> +		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
>  			return;
>  	}
>  
> @@ -359,6 +371,19 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (!page)
> +			return NULL;
> +
> +		if (PageHighMem(page)) {

My understanding is that rmem_swiotlb_device_init() asserts that there
is no PageHighMem()? Also a similar check doesn’t exist in
dma_direct_alloc().

Thanks,
Mostafa


> +			swiotlb_free(dev, page, size);
> +			return NULL;
> +		}
> +		ret = page_address(page);
> +		goto setup_page;
> +	}
> +
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)
>  		return NULL;
> @@ -366,6 +391,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	ret = page_address(page);
>  	if (dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
> +setup_page:
>  	memset(ret, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>  	return page;
> @@ -378,13 +404,17 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  		enum dma_data_direction dir)
>  {
>  	void *vaddr = page_address(page);
> +	bool mark_mem_encrypted = true;
>  
>  	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>  	    dma_free_from_pool(dev, vaddr, size))
>  		return;
>  
> -	if (dma_set_encrypted(dev, vaddr, size))
> +	if (swiotlb_find_pool(dev, page_to_phys(page)))
> +		mark_mem_encrypted = false;
> +
> +	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
>  		return;
>  	__dma_direct_free_pages(dev, page, size);
>  }
> -- 
> 2.43.0
> 
