Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DA3A1B5;
	Tue, 21 Jul 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637076; cv=none; b=ntobu4zj/ors07iWGnTq6pkpRpSvUbMATfADElhhI/YGuBq/LikuRBsL4URI7dn15kMJw/keAvDY1r2mxnF/mLNutBglMxGPgaNN8JOmqhren9UjkVUAZAV/KU2vKJOI91Gq24Py3xOOUfkPg4XlGCLLeYWsyL+al6Gmij5+TBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637076; c=relaxed/simple;
	bh=RZJYY7NreOrBetIHwgCvk+KePUfc7TVul1eAgyI5gf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/hvnPLmqdHsFPJoNiJMETd/a0NAWxGiGxaeGWmuvu4No2m+AdRnFg1dsjhoqB5GXrWwD0WzXh47yKLkd2s36sQwkl0EtDOZBICt8e8s16NHwokQ9sMaywqi8XwEj/3aJNxL1ZYwU3CLMvxC7lcSGB8Mn7CiaK7MDjlkE9LMe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMAaRN/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMAaRN/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D601F000E9;
	Tue, 21 Jul 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637074;
	bh=wWSrAB9EVKT/XWaemQKPpIPZcdC2pMdFep2pkjliXa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NMAaRN/0pR1UXrKesy1NVUZZb3tGCe/Vlw+6q4IisWckyQHrk7t8f9UFf/nD3eOc2
	 cDCyPrN6wzIW97ofA8f2c/wOZcBa5yT6IRAiQ8btVup6aqmVGAsCaPvNMbuEE0ea+q
	 gdY7WVBH3xSnTaTrfUnVBaVXFPSS6ziUrVglN++YJIJJeonhivjr96HgNl/cpK8ecU
	 NGtirSdm7tyorkJEWFNzDuIDdmKgeLCYl928d21hGD0TfQj7dV7V7bAxdG5f06L2hm
	 kigSERMdxJZyFtBgL6QvorkJiWKTsBMC3d4eEgC9yuIQX2gmXno0ZvJ/a70zLANA5C
	 C987wbhcZtg2A==
Date: Tue, 21 Jul 2026 15:31:07 +0300
From: Leon Romanovsky <leon@kernel.org>
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
	Mostafa Saleh <smostafa@google.com>,
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
Subject: Re: [PATCH v8 02/23] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260721123107.GJ110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-3-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> atomic_pool_expand() frees the allocated pages from the remove_mapping
> error path only when CONFIG_DMA_DIRECT_REMAP is enabled.
> 
> When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
> such as gen_pool_add_virt(), jump to remove_mapping and return without
> freeing the pages.
> 
> Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
> that cleanup paths always release the allocation.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/pool.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..b0303efbc153 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  {
>  	unsigned int order;
>  	struct page *page = NULL;
> +	bool leak_pages = false;
>  	void *addr;
>  	int ret = -ENOMEM;
>  
> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 */
>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>  				   1 << order);
> -	if (ret)
> +	if (ret) {
> +		leak_pages = true;
>  		goto remove_mapping;
> +	}
>  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
>  				pool_size, NUMA_NO_NODE);
>  	if (ret)
> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  				   1 << order);
>  	if (WARN_ON_ONCE(ret)) {
>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +		leak_pages = true;

Instead of doing this dance with temporal variable, change "goto out" to
be "return true".

>  	}
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  	dma_common_free_remap(addr, pool_size);
>  free_page:

Remove free_page label, and change leftover of "goto free_page" to be
"goto out"

> -	__free_pages(page, order);
>  #endif
> +	if (!leak_pages)
> +		__free_pages(page, order);

Put these checks under out label and rely on page != NULL as a marker.
if (page)
 __free_pages(page, order);

>  out:
>  	return ret;
>  }
> -- 
> 2.43.0
> 
> 
