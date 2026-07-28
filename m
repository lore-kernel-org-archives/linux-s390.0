Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17644E03B
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249701; cv=none; b=iHsBWc+cIAneTQLEACtcpdkQH1a7MSQpQ6PTRB32NU2AFZXX8gkxNGmsWf8TmapRvuReT1viWu9inVwBt0Gry80qKeW2JfGzlKhwRXupZB+QgwoOb0hAMTklK2TPkg2qvU+wiQgsSM9isO+vWNJevKI/3yt68/P+EJOfYHgpDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249701; c=relaxed/simple;
	bh=HyNNoVnivWfWMKFmKPjajYoM7OeYhzbKX854ccuv5SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riM5GOCmOT82DVdFDQF/6NzM2Kb9suFoXMUnZDmZi8sXC76cpBQzNJie6cgPZKt17IUo6bctUd7mPs6ioGNlLivQCJzlhWfHAtfDmawJILQj5/kdvYmxcck9lnwYkQgBjWqVfOlVntlfPrZSU0njrVQ7EKPzLTpXnVxrRqfe6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYtQNDK6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYtQNDK6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so64045e9.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785249698; x=1785854498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCZrUOE9kwIF4hUfSxEIdPGLi7SYMbxXEbVOya3wkPE=;
        b=FYtQNDK60yPFl7XNt7g7Yy32DgZf6bsVE9K+1P2/m0pX41GlqmyVUBZsJkJ44CL5pt
         hhk4skBsOSkJzdStZIBE1HyKnEJLO7iFW/dvfeZLfdIkMHfqynDsw2ztC7u+hOWoUstg
         jaEufRocRje+0xeLBqogBz0ZwuH5FxWJIPYrzoEmiftIfY86+8g23VCS+Qmw2lfdyqYQ
         npp3L2NlIf5V9KiBbC/zuPXbcZY1S5jfN/Mg4/LSMltAlob1X1+hs17nZB9dBDLBOhbE
         81mkiXlRg97WplonnP6qsMh6nikFVB2JmuTE1hrHzvQ1/Dkp9LkM2neOXN0OLOmLs7B4
         m/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249698; x=1785854498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCZrUOE9kwIF4hUfSxEIdPGLi7SYMbxXEbVOya3wkPE=;
        b=fvo/M/8AYikHC6qxoh3o6N3FnyHjUflKrafbAXHJMNBF76wLOeRJXKjElB8aGYEixR
         ULOu6q58b2rPrE37YD+2Q4h/lXU2sxMQ2i/wpMls1Jo5hlBb69ctctZdK0mwzmztfoGz
         QfFcg45zk8ykfjp+HmK8dEJtM0DE75EG/j+ZZszXNmo73FJa0StDZ40xHZt6y8kOC/za
         9rxCG2X4c7od82g6yikz/1VP29WU1cVZcLd1wO/pnakR9STtc4l9TLCXmlRlTKY/TGpK
         rL9zowEIz2IGg3jfOndjVi+RXkNOzTDgxjyllwxs/XFvGAH2DrEpx6aHMw6JVPuWp2Jc
         vCuQ==
X-Forwarded-Encrypted: i=1; AHgh+RomJD7bho1OKhvvAYI2UdXmd6o33tUDSB7zEFAgiRWLN6WiEkeN37uzAvvYmoA9U4TTb4ura6onVC/d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KwP+j5SDQLPqRfcqsT2wOCVW+2EBw6X7fFviduUZTL2P8aOU
	XcvIqMHi81oUHYwxCqXs9PlC2DjjN6dTPXxXA5pZDEgZVbYh1Sy1yyWwGNRYSJyrpQ==
X-Gm-Gg: AR+sD134xMCV9YGY/FZWVDehT6da/Yrv88TVB0uNOwIz2d1HAxvtPM/Q7HCn0wJMNrL
	zA2drlvIvlodgxCUlJaphhAO6sR5oJIf/lNk6QCfN5AHWdzTb/pgVCmHJsPbLwUBup/xt8KJp0z
	LMGv6MAY91KLwUcUg75EPR6nIkS1d/FQGmRA2L4Cbv5V3HLjYZjlflbDfEhwySJwlk8hR65fV6C
	EkbbwOKycXxBfgKD3dPjXbFS3wg204GRN5HGfc2A0q9lodDIooAE96Fbo9O7Tm0sASeGsQiY6Zk
	oMv7lHz7tDnzsCirdZ2RgVa7wBHJsd6OMU/RKFdy6Yfo1kELT6opqB9GW+3tN/ObS3wPKEpSmTq
	2zWLCCoI5UAmr19IbVpnLuPVmFeI8EPWOJGloqCZiVl0DbY5AqoxV8tE2Qf/ov9f57M+2e3jQGC
	4dFlwIb+V5QdEGFQpf6LyFkbWNWjRLnSBzfzs9QmHXjlk=
X-Received: by 2002:a05:600c:528c:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-496b944f535mr5111045e9.2.1785249696887;
        Tue, 28 Jul 2026 07:41:36 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45c338fsm83874795e9.8.2026.07.28.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:41:36 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:41:30 +0000
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
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <ami_mpd_1pF4Tmdu@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-13-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 

I do not understand the point of this, why would
swiotlb_tbl_map_single() force attrs over the caller which should
already know the context (whether DMA is shared or not) which case
would this be useful to force from the SWIOTLB code?

Thanks,
Mostafa


> No functional change in this patch.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 83bf15ae9777..c42e40e60575 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1180,7 +1180,7 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  	trace_swiotlb_bounced(dev, phys, size);
>  
>  	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
> -			attrs);
> +				      &attrs);
>  
>  	/*
>  	 * Untrusted devices should not see padding areas with random leftover
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2cbf2b588f5b..8c4abe65cd49 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -243,7 +243,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  	 */
>  	trace_swiotlb_bounced(dev, dev_addr, size);
>  
> -	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, attrs);
> +	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, &attrs);
>  	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index c92ff6791595..ea4c0a292dea 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -238,7 +238,7 @@ static inline phys_addr_t default_swiotlb_limit(void)
>  
>  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
>  		size_t mapping_size, unsigned int alloc_aligned_mask,
> -		enum dma_data_direction dir, unsigned long attrs);
> +		enum dma_data_direction dir, unsigned long *attrs);
>  dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs);
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 908de28aceb2..046ae92c4832 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1396,7 +1396,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
>   */
>  phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  		size_t mapping_size, unsigned int alloc_align_mask,
> -		enum dma_data_direction dir, unsigned long attrs)
> +		enum dma_data_direction dir, unsigned long *attrs)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  	unsigned int offset;
> @@ -1430,7 +1430,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
>  	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
>  	if (index == -1) {
> -		if (!(attrs & DMA_ATTR_NO_WARN))
> +		if (!(*attrs & DMA_ATTR_NO_WARN))
>  			dev_warn_ratelimited(dev,
>  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
>  				 size, mem->nslabs, mem_used(mem));
> @@ -1609,7 +1609,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  
>  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
>  
> -	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
> +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
>  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> -- 
> 2.43.0
> 
