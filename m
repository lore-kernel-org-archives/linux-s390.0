Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC943F8AE
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248828; cv=none; b=OAZuEvimMpJ8W7dMJIQn/ApCE4IFE5+jQseateewgp4WdAcYp/Bxus8X9vdgeJlfS/zSJ9yYhN7U0wqWrZjaCEF3ZUrlQq0MEt11hne6ZQo6eSsMCisEyKE4J/HQYHIFSKb5+ZZZ+vzpatN2vEBY3avnuocS1w5rsA+qKKBPeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248828; c=relaxed/simple;
	bh=gVq0Fz3g+XDQCPf7dOicHGB4Jxifut+ZUEFvN2XpjTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkZd8FiiM90suI+utAiycEXLG/gm6uj24PPrJvlEFFY7d2LQeSc3TwngWrhuAQJy4nF9uDz0g27DhcbD6Et5078NSQ3FIqd6m3DAZq0GwUNyoJBvsFd9gbqVDTztJMlfNxqwXp62LxJW7rtdXFP+SyMt0cCqHqryzdITiuSoNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1uxR3xG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1uxR3xG"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so12821a12.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248825; x=1785853625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xBoFAKEkC+vfpGEapr3+3YEZ3mSu2No6TKaGaOQmWRI=;
        b=N1uxR3xGwIOq3PFLjIc6nOFegsWg56RS5bY7qck/BUgZKWbVI4yWC57v/iNdGa4OPB
         cR67wB0qJ+XWsjELe9Nk9y73I1Fs/YjyqRb0V/mdezT1lmjwq0JLPMj9IeiKhnpmn620
         F/ou0btUiIdS+iWn3D45hMIiIwRkADIFS+Xo9xN2+n05u/nbkjJGjr0Sy3XHAiXxde79
         q+Ne9jqPnfJbSo0ZkZPZEIulcVH0nlCPauuhQgGe9lKA9d+aHwslE3+tzkwxsSz30VhL
         YDJe2YODmO8yj53MqhcDu9VTqa25ArVzSPAxwMQsv7lt91a6gf6+aeD4QD2PS2I3kMVz
         kP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248825; x=1785853625;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBoFAKEkC+vfpGEapr3+3YEZ3mSu2No6TKaGaOQmWRI=;
        b=pz3/acCPraXu2wJkQs76oIr9xwW8D2/cOM6BxFDy+d8o1j4biuzoOXnWJaYaLeF1VX
         d3wfj/59EL5obOAZGxKVJ2VOs7fuz92roGjRg+Fj+GdFNeBrou09rKHU/JFNkYR0SEQX
         /GNPv4qYZo/JTqCJdXH/3CJC1zdQgnyKRmTmmjmHVbzn/09ZD6y1rkvlPiNrZcdmK9T9
         g6ZRDEV5pc0zYm5eL5LseyCOtt08wo9JYGpK2pJfs9nij7toz3D3TQ5bAiW3k6wEWNi1
         r4V61/8Im07JPAJvH1XYxu3HhWZIQtVw4GObsILFjdwOKX/WMn6bsynLSNdXIUfA4KsP
         /Dvw==
X-Forwarded-Encrypted: i=1; AHgh+RpWuWi6vVwNOoDoGJ4o/n5/igeN7DxRbamHRBeje5WTxQ30BYnHLKuC4PYuWGqPyqfeFra0QymYsB52@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuv8B5ZhTzNGohL44Ae/HipTJVWE5bU9dGDulGSRIJ0N9JxcLE
	NqC1b2R7zrb5XAtdI5DkoivuDwN/XQn/c44p9EIXSeebmGmhIK3vAjNCcaDIBUM0Mw==
X-Gm-Gg: AR+sD12gsAcSGYrgkKMcEebz8FR7TKzt/tQSWDnDsafi/6XfipJmvAdGrzmzGnVkZby
	H8HvlvKUUANIYZ4y1aI4O9ULDi6jkOOKBPbpeO3T5NHyja0hkunU/XsXBHYDFzNBwr5VqOcVBOe
	Z/f6Mj+Xw1prk65U1w9vV978BJvh8c/SXplB4GmMMsV+//CbWvPxDNf6GnJAZ0Rr27h3w3jddZN
	BrPgr4g3/XFThE+Sm8C8LF91Pccax0XNcCJHa+DwUUrz8sWGAx17vgDh+XpWQp+o5iuedAN9E6+
	nodMU1fGqPY29CNxNpp6HGD3OC1tJgJO/y/A58jAVKsku42NeN7sbpIJr8+z3HJl6npthNOKIQp
	Ya8PfikyN94bN2H1z4BH6rE5gHAED9o0K0YktoIFTIEMYnZOoc2ep03GMKjU/L/osVUu6zyuApm
	hWsadrCAaIDkwWs1LbxJnUgkbBKO4ySOnwXbyiE4e+r8E=
X-Received: by 2002:a05:6402:a20f:10b0:697:e82f:e4f2 with SMTP id 4fb4d7f45d1cf-69fb80feebemr4712a12.4.1785248824492;
        Tue, 28 Jul 2026 07:27:04 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb594622asm4455060a12.26.2026.07.28.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:27:03 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:26:56 +0000
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 07/23] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <ami8MLFLGrvihL_W@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-8-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-8-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:25PM +0530, Aneesh Kumar K.V (Arm) wrote:
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
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  include/linux/swiotlb.h |  6 ++++
>  kernel/dma/direct.c     | 71 ++++++++++++++++++++++++++++++-----------
>  kernel/dma/swiotlb.c    |  6 ++++
>  3 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..c92ff6791595 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -284,6 +284,8 @@ extern void swiotlb_print_info(void);
>  #ifdef CONFIG_DMA_RESTRICTED_POOL
>  struct page *swiotlb_alloc(struct device *dev, size_t size);
>  bool swiotlb_free(struct device *dev, struct page *page, size_t size);
> +void swiotlb_free_from_pool(struct device *dev,
> +		phys_addr_t tlb_addr, struct io_tlb_pool *pool);
>  
>  static inline bool is_swiotlb_for_alloc(struct device *dev)
>  {
> @@ -299,6 +301,10 @@ static inline bool swiotlb_free(struct device *dev, struct page *page,
>  {
>  	return false;
>  }
> +static inline void swiotlb_free_from_pool(struct device *dev,
> +		phys_addr_t tlb_addr, struct io_tlb_pool *pool)
> +{
> +}
>  static inline bool is_swiotlb_for_alloc(struct device *dev)
>  {
>  	return false;
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index a81597f8c3ed..171c89fe99c9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -96,14 +96,6 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>  	return ret;
>  }
>  
> -static void __dma_direct_free_pages(struct device *dev, struct page *page,
> -				    size_t size)
> -{
> -	if (swiotlb_free(dev, page, size))
> -		return;
> -	dma_free_contiguous(dev, page, size);
> -}
> -
>  static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>  {
>  	struct page *page = swiotlb_alloc(dev, size);
> @@ -125,9 +117,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>  
> -	if (is_swiotlb_for_alloc(dev))
> -		return dma_direct_alloc_swiotlb(dev, size);
> -
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>  	page = dma_alloc_contiguous(dev, size, gfp);
>  	if (page) {
> @@ -203,6 +192,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> +	bool mark_mem_decrypt = true;
>  	struct page *page;
>  	void *ret;
>  
> @@ -252,11 +242,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		return page ? ret : NULL;
>  	}
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
> @@ -283,7 +283,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  			goto out_free_pages;
>  	} else {
>  		ret = page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> +		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
>  			goto out_leak_pages;
>  	}
>  
> @@ -300,10 +300,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return ret;
>  
>  out_encrypt_pages:
> -	if (dma_set_encrypted(dev, page_address(page), size))
> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
>  		return NULL;
>  out_free_pages:
> -	__dma_direct_free_pages(dev, page, size);
> +	if (!swiotlb_free(dev, page, size))
> +		dma_free_contiguous(dev, page, size);
>  	return NULL;
>  out_leak_pages:
>  	return NULL;
> @@ -312,6 +313,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
> +	phys_addr_t phys;
> +	bool mark_mem_encrypted = true;
> +	struct io_tlb_pool *swiotlb_pool;
>  	unsigned int page_order = get_order(size);
>  
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> @@ -340,16 +344,25 @@ void dma_direct_free(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>  		return;
>  
> +	phys = dma_to_phys(dev, dma_addr);
> +	swiotlb_pool = swiotlb_find_pool(dev, phys);
> +	if (swiotlb_pool)
> +		/* Swiotlb doesn't need a page attribute update on free */
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
> -	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
> +	if (swiotlb_pool)
> +		swiotlb_free_from_pool(dev, phys, swiotlb_pool);
> +	else
> +		dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
>  }
>  
>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
> @@ -361,6 +374,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (!page)
> +			return NULL;
> +
> +		ret = page_address(page);
> +		goto setup_page;
> +	}
> +
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)
>  		return NULL;
> @@ -368,6 +390,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	ret = page_address(page);
>  	if (dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
> +setup_page:
>  	memset(ret, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>  	return page;
> @@ -379,16 +402,28 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  		struct page *page, dma_addr_t dma_addr,
>  		enum dma_data_direction dir)
>  {
> +	phys_addr_t phys;
>  	void *vaddr = page_address(page);
> +	struct io_tlb_pool *swiotlb_pool;
> +	bool mark_mem_encrypted = true;
>  
>  	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>  	    dma_free_from_pool_page(dev, page, size))
>  		return;
>  
> -	if (dma_set_encrypted(dev, vaddr, size))
> +	phys = page_to_phys(page);
> +	swiotlb_pool = swiotlb_find_pool(dev, phys);
> +	if (swiotlb_pool)
> +		mark_mem_encrypted = false;
> +
> +	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
>  		return;
> -	__dma_direct_free_pages(dev, page, size);
> +
> +	if (swiotlb_pool)
> +		swiotlb_free_from_pool(dev, phys, swiotlb_pool);
> +	else
> +		dma_free_contiguous(dev, page, size);
>  }
>  
>  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 6e8db52866bf..d54154c165e5 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1815,6 +1815,12 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
>  	return true;
>  }
>  
> +void swiotlb_free_from_pool(struct device *dev,
> +		phys_addr_t tlb_addr, struct io_tlb_pool *pool)
> +{
> +	swiotlb_release_slots(dev, tlb_addr, pool);
> +}
> +
>  static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  				    struct device *dev)
>  {
> -- 
> 2.43.0
> 
