Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E841C2F4
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012424; cv=none; b=MwSHnG6KBjKXo1yp2MTlC2+RpbucNfxwFULi/KwDkqFVINEmgNoRm1mpvaiSu8cHfRZbbLUbkN2CuS8t9sX0xZg3leYDIeN9ZCTDAh+3az3PX3L8q3thYz3BQ4vWr85oGJoKQUiDeGELhlOP6Hz4oO6/0i3ptPjsh9KASx+lYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012424; c=relaxed/simple;
	bh=nnKNuur4W2YzFI14z8xVfVyyXPMv1Qb2sp3tq/hBgmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyjZdXYFdJC4n3gzNBHoCWuybOkdQbSiaWfbTHhHdEISG8EREjp5cli/oEwW0zVn3aX5y4G02QXiCvXGChzVtBw9FSXj6wqVBmkrgo3l54+dSxFOnxzQCjnGdLcrea7qtl2vUF9mwVpJ7FJt/KMceoY0J2pyqBE1zDkBvysKb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dcm5CUJ3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dcm5CUJ3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b1aefe1cso5909485e9.2
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781012421; x=1781617221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LapnW6RyijtMlBbcLjGQ51I+00mOkKRbnIVzAqqw2OE=;
        b=Dcm5CUJ3gsAF3B2BhVd9zeAamdLqvZECgCE+c2yx8WbQYrl2ByyLy2omV+bGHPm+Oy
         fmUdreT0sSEwiGlzEYOaq2nk16qWObaQ0IDwB6POEkfEptWPrQyiLcWntfBr8oNDHfMb
         ecSW1Uxi1VTi+zA6kxJxY3Mzf0iniDKVori+7eccYig3U97+b9UImbWeiSiCNYgC0ws/
         iUYURT9P+IKa07+84eraxXKFw+KW5eyXIh7p6pLB+f+sjJbVrnRUfCvFO6sCAWaq9nsq
         if8URhIbsTgfRzhQXHuB+p7LF2CP3AddkoRKucVHwua7kf2BPQ4SnEW1X/lwza0ck9Fe
         KiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012421; x=1781617221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LapnW6RyijtMlBbcLjGQ51I+00mOkKRbnIVzAqqw2OE=;
        b=VOvFwfjt9fzhQdGY9XDw0TrFNMdsBlbGvNHCbCChh7qE6hSXPiUgxfDRLxbVJ22iGn
         gockjXUMW78UwZUhf5qaJ9l2IxIacq8DNfG7G9812DvWblHqjlYY+BRvL0CrQ2+lxlo6
         wTKZYPWC17Wh3WuoFmM5TYu/BSbiac4oLyfqegGVarJpKHZq1wQmR/efRt8sHIQpebSC
         NBwWKXL5W2f/gwqHtAur3/W4QanwUDWZs5BY3dl/8nWFLva7S2dG7YCkC6g8c6YKhBBz
         /EeQ/zvSBzf59mOrh01IZeUIQsuoNMHgZzj19Elq0khPDVPY7Rw1EH8dfi4uUOloRfK4
         vGWw==
X-Forwarded-Encrypted: i=1; AFNElJ9nxOBQnviXBSesbmh7PN+/AYV8Pjs5gtXu0lpmabFP6tSzZtm0QtDwK7EBkrJLboUpwj9rRrFN0bVN@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdW0yDhow12NKbSrJXpf6u0DgkP0sYUBQ04tuMOxTUNiE+Hd6
	J7gQRb9r7igdqDpz6rBSdG37ozb3S7wp5hqAFwsNBcGugzHICefyYzwg8baG6uF0sZY=
X-Gm-Gg: Acq92OFjLG80IWHgez28dzexkMzJVh8iHsfhCWNTU1eOuMKZQlojnVrpicq2WjNwyZV
	TYQFtRDtOdifhSHe06RsNwpefQTsKG/kQHusz37fy+R5HdE4iNwYA7YxJlqmkYIpIiGekZ58OaP
	or9y5d/WtyK7TeFim4VICfFpwbFonFFQwxNyHmVHIg3JqKvzdtABsQjWE6DhmC0yc7k7hW/AxHi
	rI94y5G+7+1DEKehme83pBlHTWhkVc/yGLKD8UkHKDVHJZv3HsNj0KVBbukzxhyWj1clM2OuAT5
	owHK9WrwRZlA9lEV0SAnmh1hCyBjdWLHSclmSuovdz0faFFy2PEdOt+onNoNYslRGZXx8EB8HQ7
	mTFshW0hXWKD5/dTNWHF9GbidGQhjo9t/+VjOwTlj9l92MYb/dGTbak7PZTPLPSZGk2v56sd6zl
	ZC9GtpH6o/oSeInrcuJv5yfmy8ndBhNUXC2Q==
X-Received: by 2002:a05:600c:8b82:b0:490:abf1:2ddb with SMTP id 5b1f17b1804b1-490c2603825mr146744795e9.6.1781012421133;
        Tue, 09 Jun 2026 06:40:21 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm68263785f8f.5.2026.06.09.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:40:20 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:40:18 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 19/20] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <20260609154018.554e5448@mordecai>
In-Reply-To: <20260604083959.1265923-20-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-20-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:58 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> swiotlb_alloc_tlb() can allocate from the DMA atomic pool when a decrypted
> pool is needed from atomic context. With CONFIG_DMA_DIRECT_REMAP, the
> atomic pool is backed by remapped virtual addresses, which are not the same
> as the direct-map addresses returned by phys_to_virt().
> 
> swiotlb_init_io_tlb_pool() currently reconstructs the pool virtual address
> from the physical start address. For atomic-pool backed allocations this
> stores the wrong address in pool->vaddr. Later, swiotlb_free_tlb() passes
> that address to dma_free_from_pool(), which will fail to recognize the
> chunk
> 
> Pass the virtual address returned by the allocation path into
> swiotlb_init_io_tlb_pool(), and store that address in pool->vaddr. This
> keeps the pool free path using the same virtual address as the allocator.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Hm, so the old code was broken; you may want to add:

Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")

And of course:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Thank you!
Petr T

> ---
>  kernel/dma/swiotlb.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 14d834ca298b..e4bd8c9eaeda 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -302,9 +302,9 @@ void __init swiotlb_update_mem_attributes(void)
>  }
>  
>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> -		unsigned long nslabs, bool late_alloc, unsigned int nareas)
> +		void *vaddr, unsigned long nslabs, bool late_alloc,
> +		unsigned int nareas)
>  {
> -	void *vaddr = phys_to_virt(start);
>  	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
>  
>  	mem->nslabs = nslabs;
> @@ -445,7 +445,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		return;
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
> +	swiotlb_init_io_tlb_pool(mem, __pa(tlb), tlb, nslabs, false, nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -553,7 +553,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  		}
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> +	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
>  				 nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
> @@ -664,25 +664,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
>   * @phys_limit:	Maximum allowed physical address of the buffer.
>   * @attrs:	DMA attributes for the allocation.
>   * @gfp:	GFP flags for the allocation.
> + * @vaddr:	Receives the virtual address for the allocated buffer.
>   *
>   * Return: Allocated pages, or %NULL on allocation failure.
>   */
>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> -		u64 phys_limit, unsigned long attrs, gfp_t gfp)
> +		u64 phys_limit, unsigned long attrs, gfp_t gfp, void **vaddr)
>  {
>  	struct page *page;
>  
> +	*vaddr = NULL;
> +
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
>  	 * the allocation is atomic, because decrypting may block.
>  	 */
>  	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
> -		void *vaddr;
> -
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> -		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> +		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
>  					   attrs, dma_coherent_ok);
>  	}
>  
> @@ -705,6 +706,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  			return NULL;
>  	}
>  
> +	if (page)
> +		*vaddr = phys_to_virt(page_to_phys(page));
>  	return page;
>  }
>  
> @@ -750,6 +753,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  {
>  	struct io_tlb_pool *pool;
>  	unsigned int slot_order;
> +	void *tlb_vaddr;
>  	struct page *tlb;
>  	size_t pool_size;
>  	size_t tlb_size;
> @@ -767,7 +771,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	pool->unencrypted = !!(attrs & DMA_ATTR_CC_SHARED);
>  
>  	tlb_size = nslabs << IO_TLB_SHIFT;
> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp))) {
> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp,
> +					 &tlb_vaddr))) {
>  		if (nslabs <= minslabs)
>  			goto error_tlb;
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -781,12 +786,12 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	if (!pool->slots)
>  		goto error_slots;
>  
> -	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
> +	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), tlb_vaddr, nslabs,
> +				 true, nareas);
>  	return pool;
>  
>  error_slots:
> -	swiotlb_free_tlb(page_address(tlb), tlb_size,
> -			 !!(attrs & DMA_ATTR_CC_SHARED));
> +	swiotlb_free_tlb(tlb_vaddr, tlb_size, !!(attrs & DMA_ATTR_CC_SHARED));
>  error_tlb:
>  	kfree(pool);
>  error:
> @@ -1995,7 +2000,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  			mem->unencrypted = false;
>  		}
>  
> -		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
> +		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
> +					 nslabs,
>  					 false, nareas);
>  		mem->force_bounce = true;
>  		mem->for_alloc = true;

