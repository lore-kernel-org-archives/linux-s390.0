Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04442413629
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007699; cv=none; b=GpS7ZznkVkDOLHpBaaiVA8zTJXJm+JSTqaVOSnSwG6IUquB/XU/vfsIQxMy1HDhubmUyW/t0XI6+5HUqEpIhRMrL24KdffaVGKwjxXWdwF/+NHEjxsCYDaG3pxHr3Gw8/0suVzmrub2zE6GjNwWi1osHIoBauGWSaN0lVj7w2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007699; c=relaxed/simple;
	bh=Rl8HUjA4aTjCFQhj+HDrB9xZW8uuYTv5x9JyXO2I/rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THuQCYcQauPFr+smKavrrD7W20UImxnVKaaca7ZXodGmZ7EC7CEqrwFgtFUJsvo8f+wWQue7NrX9eoBvIQe84bIWKw3tC5HuVQ3geRUzXGmXqfUf/PbLQ6f2vo0RO+usrnfSSCoek9RwbKkiJO5rpLq1vopFtjQ//YR3xO8pf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rk/QcWQ3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rk/QcWQ3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef74860bfso330162f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781007696; x=1781612496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y47BTKkIONM0+RQeKdRPDrTRuu7HqPM7iSbtp8PzT1o=;
        b=Rk/QcWQ33MDHA6e3UhB5lybzKmmq4PDU5Qec7UhLyK0hpPIz0MpF3upBK45tjCcvTS
         rsxJYoS3lK9IXuL8ZTBIJ0v/5RTBnvbS1n9Kt4u3DWnZeqAV5/qAELiWnZtK3v9QcUAt
         pU+tHsVajoUHudt2SwYTyckmPUP6Gd9K7f3es6tnZMNvug7yXBnR8cWz4LpenHB9c6KO
         vJ7OP53lUrYQd37T4KTKn8USj2MXGwP6ZX0v1U9PvV9Zim8f+8W6l8uoFPNyFFbawdFV
         jUpgEqTRgIWiOIfaLVN7Vp33SUbWVy0fx/KzEuJgpTtYeJEjK+EUlNS4IJ4uFJIi1jiH
         PkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007696; x=1781612496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y47BTKkIONM0+RQeKdRPDrTRuu7HqPM7iSbtp8PzT1o=;
        b=HakZMc1++93ExB4vw34lCjm73QAsP0bmp9+9sy+5IQxCLlQpk/PDfWHq0PS79IHxC9
         ZSaVSgKfs3bhWWAajlwDsdl5LfPlXABxp6QMByqUaM/3W0MlKZ2NMlH0Cgtnu8FrJQfq
         1odST4xpjywYFsiBVJS9wXougkKHA3YnZSZRtXjt0GhaktXEbBk1v1vFP/wLCKMr/yQL
         1rBTbJK5cRwMTDcVsIPPS/UtvE5qXMVEM+y677b1tktopQwwptFfNEBD0zAyiGQBya2d
         4Qw4MZYmjstDLecUmnxRjoAPXSPGLV3vcBPhDnmqkdo68LW8cfUFIzMsTGmzGXdAGUZQ
         9XRg==
X-Forwarded-Encrypted: i=1; AFNElJ8iKa64xo7Am7PjccTGtUdq77jF6bCyuBXxSvvIwNcXytxVdJeqk2DELHf3z8fK/xf2Ri/GHp4ZeFjy@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8sNHH2d3wYdm1meZbpk5UHcW5Oamv3/Mvkczn3hfq5rdYfcG
	XoU3jxeZvlclvR47cRg8jzSdeL9jHV6HaujdqQafYWw8quuWT7dp9wkfkwcEAP6bJyA=
X-Gm-Gg: Acq92OH3XcjWqd9ZKloJtjEhI10nYjmft3NtOxXkkewREStRFhj8VuMwP5gF3bExAdv
	8SP9pj79H9ifJzM1zDD/86JvGzqcHrCAgKbDK4pmzR0MDMX3a819qDmL3I7vbQz6Zfff5l6YLAj
	KGTw1AiYOOBulG3ul2vFeyHLxp3MSvmsUSDTPqo4SDBakiqZvIsx1+9KRQzTHPVLQ88iEtSuYkp
	0/ZRoFp8eB9fG/LT6pOlx28cRR3VGeK0kbExJFAUUR+Y+/ekmQV18dOgfKkSWOZMmDa07Ks9pwt
	lD3gjCHO0sRO0UuX2OHDn4Pkdib7Oc4MRzr5xrLGpfOGDPl4NOg5Ji9OYZjxHCQKnWhRZlAwbtQ
	3wx/DbVBRIFPbi5t4+OpZIQU3tp3aqIWDiEtqZmb93bIHMNjfohgMYXiM2hAXFRCZdpQC0UPLU0
	gBUm7SjBtqq/lDF5cE2r1cwfI=
X-Received: by 2002:a05:6000:1a88:b0:460:11ac:d58 with SMTP id ffacd0b85a97d-4603064331fmr16626567f8f.3.1781007696224;
        Tue, 09 Jun 2026 05:21:36 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm60125048f8f.12.2026.06.09.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:21:35 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:21:22 +0200
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
Subject: Re: [PATCH v6 05/20] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260609142122.7e721621@mordecai>
In-Reply-To: <20260604083959.1265923-6-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-6-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:44 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 
> No functional change in this patch.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Thanks
Petr T

> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c2595bee3d41..725c7adb0a8d 100644
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
> index 133bb8ca9032..29187cec90d8 100644
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
> index be4d418d92ac..78ce05857c00 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1391,7 +1391,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
>   */
>  phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  		size_t mapping_size, unsigned int alloc_align_mask,
> -		enum dma_data_direction dir, unsigned long attrs)
> +		enum dma_data_direction dir, unsigned long *attrs)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  	unsigned int offset;
> @@ -1425,7 +1425,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
>  	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
>  	if (index == -1) {
> -		if (!(attrs & DMA_ATTR_NO_WARN))
> +		if (!(*attrs & DMA_ATTR_NO_WARN))
>  			dev_warn_ratelimited(dev,
>  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
>  				 size, mem->nslabs, mem_used(mem));
> @@ -1604,7 +1604,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  
>  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
>  
> -	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
> +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
>  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  

