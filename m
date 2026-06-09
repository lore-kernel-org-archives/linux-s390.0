Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73E2C3261
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011987; cv=none; b=pjkNcdmkhFiE0sGf2GP/TMYbPl9NR70Az1gn6kh0R83nZpqp/gW3z7mfPjoL7SCFhbtfd/D526Q6DvFf8L0VXs8VL53ugOtmLqSW79WvtNw4o+2Nnz+3PFEbdsr4qO3Zc568XlfCYOEmsooUWUJ0msHyumQvLUv9Axiz3D7BhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011987; c=relaxed/simple;
	bh=NSfwu7yoXAF8kfvPRt9yzyQddZc4/pZJmcex0Ww7tmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izuvtbYL7xPbJ8v38UHi1Jv4lHLIMsv0VlFiCtLjcNpdtNlH9Z1uE93etpXz0AXR+wL8N+JNI9LXoQAnlpSNTeUPYobi2jlPttZnCbb90iP5XOJFowiFSKpwFxavZ8PWLF6slz6fkYz68tT1Nbgko34YsNyKioK6Vth8f+USDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EMQYNxmo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EMQYNxmo"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef9df68bcso325230f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011984; x=1781616784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+UubitX36JVc6CTd2RtBwcVL2yqRgVyLq15MXv0auc=;
        b=EMQYNxmofkdd2f/1nRB4Rt33v5h2nKv8FPYjsKzqsFUlrjwMQ6O831HohZ4CVaevH6
         FwmblREX19yKBGyomBXsLECzsSFh7Gtj2lG7nN4Fyo2IgDTvH8+6pEaRzg9vAUD1UTNd
         A1IQPCZl42YB9FHn3r9hxM+cZPWQzwt3vHWq94VU+u7nqeR8Twbu0GxX8r9JSjeSGSvQ
         XmeBce7Q3NJ8cPGMVu+WPCI+RER7EmepipfllLrNQxU5B5mfDa1/HqR7ySlEDk0OOBYe
         Y5ynmKGA4f9kIDRgrcuQFOrzIwN19rrwapZul/QTe+uXRdQz8zFdlqungKoEllhNeCbU
         JuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011984; x=1781616784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+UubitX36JVc6CTd2RtBwcVL2yqRgVyLq15MXv0auc=;
        b=rI7UnZHBOkD2fAY7RfZpaKmkPB8RzW+gB0uIp76cysZ8XTd9fCvtIZArA5ktr1pYzS
         vPXssqy/buhD0PnLYFHveVJz8m1yDHxQxOZFk/lKsJiOeFc2YVFsu3ADS4+2jKlR/4oa
         05zCelySgCjohcqyWA2yB3RwinIpq5VRgNyjLZWd5kpysKc6lQ2IxsgUZyFOGj7NNJNv
         m4BEIt6z8cLM9xZvJfFF6c8TTVUJt1Edm22oheCrhPup3Nx95qGcLBBGsgh+8LjzcZMy
         AwZzfxKRX9UVKLNnxWfU+wt8WyXzEZYXMkBxQ0g+gyvEVUVwbqf1vLQU2t038ow4SxPj
         M2Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+fmuk2pwe1B/MgV38rkC7lgms6QG+WohvattrGDlL1AAHF6iDSXWTzztjLPEydDx6sTx0ghdm6b8JW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OXT3WjhJgNcNfRn1SaUpfY/8UbYMGToHoh3v1SEwczjaF9/i
	0T3d7XbD9b2sHLbojDGOThjIb7OV4HQPq8XjeuIE9lIN69JXffd6fkcSs9AzZuE/rQU=
X-Gm-Gg: Acq92OF/Z7+2T0Ka4Fww6JOmC41YUDpyS4hVGSj0f9sx06GNwtaKT2fQ7xTOzYWRW7B
	mjirFYfmECPfRqc5mThUZNCy+aitVSZ7Gp7h4QsZghL6jfI8faWQfkbLgPU7PGddEkoRhYXJ658
	rS+3H1SOigg38+3OfwcpLOs76IDZelDMrHioxQjbhtKTBln6b7zCOEGqyrtOWg5XOMXEH+JPyPI
	OsjqPyPIVXNoNw5zwLmmvEZDhK3OuqgZ4yi84F84XvWA2R+PDRnqr8uT5QhD1biGbiSxPErF1Fx
	xxLP/8o1Mw3aMssAYYmc5m0F7djeDe/74OD/EMEe6yf49bdOUTzKFr7wHsUj//Wlaq87sIkPghQ
	MSEA1liqt9Wp15eqPP/imR6pF34rOc1o5xh6lNhxOHfJNr8+jCnqqIjG01+Kj/3JaDxNNe/BfCp
	ss0lxhk3nDIbCt7mFn95vlooY=
X-Received: by 2002:a05:6000:4022:b0:45e:f68d:e7ac with SMTP id ffacd0b85a97d-46056439196mr1887515f8f.0.1781011984149;
        Tue, 09 Jun 2026 06:33:04 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46059346676sm1079048f8f.26.2026.06.09.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:32:58 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:32:55 +0200
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
Subject: Re: [PATCH v6 17/20] dma: swiotlb: handle set_memory_decrypted()
 failures
Message-ID: <20260609153255.4b9e9373@mordecai>
In-Reply-To: <20260604083959.1265923-18-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-18-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:56 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Check the return value when converting swiotlb pools between encrypted and
> decrypted mappings. If the default pool cannot be decrypted after early
> initialization, mark the pool fully used so it cannot satisfy future bounce
> allocations.
> 
> For late initialization, return the `set_memory_decrypted()` failure. For
> restricted DMA pools, fail device initialization if the reserved pool
> cannot be decrypted.
> 
> This prevents swiotlb from using pools whose encryption attributes do not
> match their metadata, and avoids returning pages with uncertain encryption
> state back to the allocator.

This works fine, but instead of effectively leaking the memory, we
could return it to the buddy allocator and reset nslabs to zero as if
SWIOTLB was not even initialized.

OTOH I don't want to overthink this, because the system is probably not
too useful after such a boot-time failure, so unless you _want_ to
improve the error path, you can simply add:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4c56f64602ea..14d834ca298b 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -248,6 +248,23 @@ static inline unsigned long nr_slots(u64 val)
>  	return DIV_ROUND_UP(val, IO_TLB_SIZE);
>  }
>  
> +static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < pool->nareas; i++) {
> +		pool->areas[i].index = 0;
> +		pool->areas[i].used = pool->area_nslabs;
> +	}
> +
> +	for (i = 0; i < pool->nslabs; i++) {
> +		pool->slots[i].list = 0;
> +		pool->slots[i].orig_addr = INVALID_PHYS_ADDR;
> +		pool->slots[i].alloc_size = 0;
> +		pool->slots[i].pad_slots = 0;
> +	}
> +}
> +
>  /*
>   * Early SWIOTLB allocation may be too early to allow an architecture to
>   * perform the desired operations.  This function allows the architecture to
> @@ -272,8 +289,16 @@ void __init swiotlb_update_mem_attributes(void)
>  		return;
>  	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
>  
> -	if (io_tlb_default_mem.unencrypted)
> -		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted) {
> +		int ret;
> +
> +		ret = set_memory_decrypted((unsigned long)mem->vaddr,
> +					   bytes >> PAGE_SHIFT);
> +		if (ret) {
> +			pr_warn("Failed to decrypt default memory pool, disabling it\n");
> +			swiotlb_mark_pool_used(mem);
> +		}
> +	}
>  }
>  
>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> @@ -442,9 +467,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  {
>  	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
>  	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
> +	unsigned int order, area_order, slot_order;
> +	bool leak_pages = false;
>  	unsigned int nareas;
>  	unsigned char *vstart = NULL;
> -	unsigned int order, area_order;
>  	bool retried = false;
>  	int rc = 0;
>  
> @@ -504,6 +530,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  			(PAGE_SIZE << order) >> 20);
>  	}
>  
> +	rc = -ENOMEM;
>  	nareas = limit_nareas(default_nareas, nslabs);
>  	area_order = get_order(array_size(sizeof(*mem->areas), nareas));
>  	mem->areas = (struct io_tlb_area *)
> @@ -511,14 +538,20 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	if (!mem->areas)
>  		goto error_area;
>  
> +	slot_order = get_order(array_size(sizeof(*mem->slots), nslabs));
>  	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -		get_order(array_size(sizeof(*mem->slots), nslabs)));
> +					      slot_order);
>  	if (!mem->slots)
>  		goto error_slots;
>  
> -	if (io_tlb_default_mem.unencrypted)
> -		set_memory_decrypted((unsigned long)vstart,
> -				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted) {
> +		rc = set_memory_decrypted((unsigned long)vstart,
> +					  (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +		if (rc) {
> +			leak_pages = true;
> +			goto error_decrypt;
> +		}
> +	}
>  
>  	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
>  				 nareas);
> @@ -527,16 +560,20 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	swiotlb_print_info();
>  	return 0;
>  
> +error_decrypt:
> +	free_pages((unsigned long)mem->slots, slot_order);
>  error_slots:
>  	free_pages((unsigned long)mem->areas, area_order);
>  error_area:
> -	free_pages((unsigned long)vstart, order);
> -	return -ENOMEM;
> +	if (!leak_pages)
> +		free_pages((unsigned long)vstart, order);
> +	return rc;
>  }
>  
>  void __init swiotlb_exit(void)
>  {
>  	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
> +	bool leak_pages = false;
>  	unsigned long tbl_vaddr;
>  	size_t tbl_size, slots_size;
>  	unsigned int area_order;
> @@ -552,19 +589,23 @@ void __init swiotlb_exit(void)
>  	tbl_size = PAGE_ALIGN(mem->end - mem->start);
>  	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
>  
> -	if (io_tlb_default_mem.unencrypted)
> -		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted) {
> +		if (set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT))
> +			leak_pages = true;
> +	}
>  
>  	if (mem->late_alloc) {
>  		area_order = get_order(array_size(sizeof(*mem->areas),
>  			mem->nareas));
>  		free_pages((unsigned long)mem->areas, area_order);
> -		free_pages(tbl_vaddr, get_order(tbl_size));
> +		if (!leak_pages)
> +			free_pages(tbl_vaddr, get_order(tbl_size));
>  		free_pages((unsigned long)mem->slots, get_order(slots_size));
>  	} else {
>  		memblock_free(mem->areas,
>  			array_size(sizeof(*mem->areas), mem->nareas));
> -		memblock_phys_free(mem->start, tbl_size);
> +		if (!leak_pages)
> +			memblock_phys_free(mem->start, tbl_size);
>  		memblock_free(mem->slots, slots_size);
>  	}
>  
> @@ -1938,9 +1979,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  		 * restricted mem pool is decrypted by default
>  		 */
>  		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> +			int ret;
> +
>  			mem->unencrypted = true;
> -			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> -					     rmem->size >> PAGE_SHIFT);
> +			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> +						   rmem->size >> PAGE_SHIFT);
> +			if (ret) {
> +				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
> +				kfree(pool->areas);
> +				kfree(pool->slots);
> +				kfree(mem);
> +				return ret;
> +			}
>  		} else {
>  			mem->unencrypted = false;
>  		}

