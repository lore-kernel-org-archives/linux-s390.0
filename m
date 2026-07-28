Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD83B585F
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248724; cv=none; b=aAwzlmoGQazHhmu1AYjRxAM85RDqUgX6IDDz8gUsL5K5803kQC1GNKWQOgDO5nVZgB6B2e0ceLIzbGh+d/NEYIL5FvjdpUpDbumKlh8j9ovqaT6ridesKOwLBCdn6okERKKpFh+aP25H1gusjYf5kC3scpL9MzzW2sAOwYloH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248724; c=relaxed/simple;
	bh=egNeZU/QDoq/vLDQYCkE07iRqxJcGDGKBgWjXVKB+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGjYWN7y3miQAxHhlExndytW3No/4IULfRPFCkur074bCOTeDbcWxsNz15vnewFvSSB0qfE7jfhTU7efD819cDndHsxNT6EmQZfIaPMIotvjJIZ3LA/mC0p0XY+tJW4Cl45flvTouWOuQQG7PUn5ScTT6RUVRKM7r80TIcQT3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRMC/0FJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRMC/0FJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954bb689dfso42475e9.1
        for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248721; x=1785853521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
        b=SRMC/0FJvWahTMVytBM5rtJpfV70+M847+aPhLcKhy0l4etb/qsjxjpGcu7Eq20yjW
         ILXqCcd5Io4epUEM2bBStEdqnrtN7I2oT2tEr5upd58Ikzg2nuD0nqSOnyJtQxRu87pP
         Q7Q5d6TyNP6zP2Fpdo9ByfNGjvMX4Nh09tKsC00zXCTo7M0X4UAv9nhuSnfcEqh6R/Ku
         Ab4SA+BWg5kGNESnr1YMl3u/2++v8hO+mJs9ysQxncXp6jzbfIWF1QJml/bvdiJCI9Hs
         2xCSIZOR0CBuCzTonRiAoU0AYACpWlvYflODnHJsyFZ8kEZC4ZBrwBpm15pyFJT9oqBj
         bQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248721; x=1785853521;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
        b=hA9uMyu1hay3yT/6cTOaww7o2skFAh73O+WMdLb/vEcVN5dLBynj9rjlk0E+o0EWn8
         PQnqS9dprEmOZDOa3j4Wj4G/EZEdJgpg57FTCEU49CimOmO8o+Ue0rGqAvWb1Ajm51ra
         D04yLA5hzlwldQ0g3PotafYqbMlU2PPodOZaS8yhcW3refHDmQF45TzMIlUKeO70pUS1
         of/xOoeu3pGcXN4OXJzZDaMiRs8YRrGW/6yc8DK/u5p0RcW7XTE3EzbgEcCypAEpgmAe
         J9MXvDOp6uf3go/TAdukv4AA8KuHblwOYGbkfNhgJELRRwp7lPOdlBvC+gAeFY569Vw0
         aSNA==
X-Forwarded-Encrypted: i=1; AHgh+RrK3asVEo3ZsmeuJEkFb0qH+Js6seBfibFF75nIYUnpVQ2HpIRPKwBsIuvwhEklF14N5dVqccwXfRC+@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvuDrNDC0NR9fig0I5Ebph7fRqJILeZO0c7PyFW9et9v8KCXy
	vS28wFuuJ/5WGKO8aBpZQeByQ8FQlhT7TCbt0qtTbH//PWhd+MeSlIjc1sZA6L+OoQ==
X-Gm-Gg: AR+sD10rOjRrykENYzVrPtj826kOz1SSRjj7ADQ18K4B7EQnKPZFgyh4zGMtWP98WBj
	DWO45eWZaYT8FSLnQwFpb0gclJZdB0cnfFYZfYSkqXFVWxLQ2fnrQeoRmynLQ/KZOjZhOsmiWrp
	acoTw7atbii1RQQBWcGqe+npyuJ6EaLrragjsGiefyIm7+m4XK4+iLg5HI0kPwRuXmK2NRAk0Pn
	I2xlrk+dCy3dcpDaAfxoci5pkaReOCo9lkhe6pbUBR+r3VuWxLEqjoPsV5e1FRkQBNv/MOVdgQC
	xrVI/jHZlZf6L2naXEZ4NW6bHlVxQIIw7NsMbIZ/CF+P5emNJcMPVUlTqVwWw6ofSNhnyMzthsm
	dT6L6Tl5zF04pqm0WTrunB0gQwUGFu8gdCV6vPJM3qa+0gIUT4JmDWntizfeiG4UyJwr+3bvi5e
	puj9GucHmaQarw6Nesd8DQBBpG2oMpQIWHHB4BGC9oWis=
X-Received: by 2002:a05:600c:6a8d:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-496b4d2f236mr4342575e9.6.1785248720307;
        Tue, 28 Jul 2026 07:25:20 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45e0424sm84654015e9.13.2026.07.28.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:25:19 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:25:11 +0000
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 05/23] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <ami7x9uXfRLmjVhK@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-6-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-6-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:23PM +0530, Aneesh Kumar K.V (Arm) wrote:
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
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  kernel/dma/swiotlb.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..6e8db52866bf 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -266,9 +266,9 @@ void __init swiotlb_update_mem_attributes(void)
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
> @@ -409,7 +409,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		return;
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
> +	swiotlb_init_io_tlb_pool(mem, __pa(tlb), tlb, nslabs, false, nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -507,7 +507,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  
>  	set_memory_decrypted((unsigned long)vstart,
>  			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> -	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> +	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
>  				 nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
> @@ -605,25 +605,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>   * @bytes:	Size of the buffer.
>   * @phys_limit:	Maximum allowed physical address of the buffer.
>   * @gfp:	GFP flags for the allocation.
> + * @vaddr:	Receives the virtual address for the allocated buffer.
>   *
>   * Return: Allocated pages, or %NULL on allocation failure.
>   */
>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> -		u64 phys_limit, gfp_t gfp)
> +		u64 phys_limit, gfp_t gfp, void **vaddr)
>  {
>  	struct page *page;
>  
> +	*vaddr = NULL;
> +
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
>  	 * the allocation is atomic, because decrypting may block.
>  	 */
>  	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
> -		void *vaddr;
> -
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> -		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> +		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
>  					   dma_coherent_ok);
>  	}
>  
> @@ -645,6 +646,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  			return NULL;
>  	}
>  
> +	if (page)
> +		*vaddr = phys_to_virt(page_to_phys(page));
>  	return page;
>  }
>  
> @@ -685,6 +688,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  {
>  	struct io_tlb_pool *pool;
>  	unsigned int slot_order;
> +	void *tlb_vaddr;
>  	struct page *tlb;
>  	size_t pool_size;
>  	size_t tlb_size;
> @@ -701,7 +705,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	pool->areas = (void *)pool + sizeof(*pool);
>  
>  	tlb_size = nslabs << IO_TLB_SHIFT;
> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp,
> +					 &tlb_vaddr))) {
>  		if (nslabs <= minslabs)
>  			goto error_tlb;
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -715,11 +720,12 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	if (!pool->slots)
>  		goto error_slots;
>  
> -	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
> +	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), tlb_vaddr, nslabs,
> +				 true, nareas);
>  	return pool;
>  
>  error_slots:
> -	swiotlb_free_tlb(page_address(tlb), tlb_size);
> +	swiotlb_free_tlb(tlb_vaddr, tlb_size);
>  error_tlb:
>  	kfree(pool);
>  error:
> @@ -1851,7 +1857,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  
>  		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>  				     rmem->size >> PAGE_SHIFT);
> -		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
> +		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
> +					 nslabs,
>  					 false, nareas);
>  		mem->force_bounce = true;
>  		mem->for_alloc = true;
> -- 
> 2.43.0
> 
