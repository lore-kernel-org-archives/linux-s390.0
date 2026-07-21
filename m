Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6223451DA;
	Tue, 21 Jul 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634902; cv=none; b=sseII17FAHW8V+OfLw1ZY3SJm0dzw7NHvZxRgeyX7W/M9jqouSc+fdP7+bhiH491uoLyfiepbCRb+WETOak6fRvkSKhCUGOP6FcYrkfMmgtwM2nfuzSOSi7+wrKL8m37LKBj0dkLq05wVJ/lDbmlUiV54Yk++gImdm3cw8dmZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634902; c=relaxed/simple;
	bh=HrRnlRYOWd4exP/xb6Ja0QgFLkgR/qPS44miWSX0j2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU5ny0io+p+UwlHjsjATTEh5twmpC3mFkV9eZAf9xeSUpG5ZmM0Wb+HF1tPZ+igyr7mJeMeDsi/WwGFes6nf7O+h66kihBDa2xPkjSHiKjmNv+/20KRmLlLiZ3oAjKkYQLLucUVXydvtfC/9vo2tv4IVY5GOA+w8UEE7c4g14Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F95kPevl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F95kPevl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50E81F000E9;
	Tue, 21 Jul 2026 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634901;
	bh=UJXno+NE2LaIdHpYv/4s8ue4/cjDLWXaEa8lFS8q5GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F95kPevlSn1NQmmXdgfNRRHtm8wP1sXWeSsajbmTVkqIVzEt4omP7+o8h/zzqgon8
	 aO2X352TPWBumHybCH5wICorK7tHQOJ+DLfga1PMxYtgGyqAr1d75R36jZQcoAZQ0G
	 u4Ltzvzc8UN19pVa60sSITfwm9xlmo7Hr5kTf7or5X1dbKVS99JrE6bfnBoFbv+ckQ
	 REkQsHFwee8HrNaRT8lHJe7QWLL3u2KfR4piTx/+d8f8FoJDJV6XZZXLGbwgVG6/2w
	 R3oYpiCOUEawrQ7xZmqfEe7FPeRTR/3x9h6o8gh9596QPZeiwtdrlz0QLXVFYHGROp
	 Opr9JesAwQ3ow==
Date: Tue, 21 Jul 2026 14:54:56 +0300
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260721115456.GI110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-2-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:19PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
> helper") changed dma_direct_alloc_from_pool() to return the CPU address
> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
> 
> Fix this by making dma_direct_alloc_from_pool() return the struct page *
> again, and pass the CPU address back through an out-parameter for the
> dma_direct_alloc() caller.
> 
> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> Cc: stable@vger.kernel.org
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index d8219efe3273..363d984d90e7 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -164,22 +164,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
>  }
>  
> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp)
> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> -	void *ret;
>  
>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> -	return ret;
> +	return page;
>  }
>  
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> @@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || force_dma_unencrypted(dev)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  &ret, gfp);
> +		return page ? ret : NULL;

Sorry for joining the discussion late, but the line above caught my
attention.

Why do we need both ret and page? We can derive cpu_addr from page and
vice versa. Do we really need the &ret parameter? Or, more generally, do
we really need "struct page *"?

static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
		struct gen_pool *pool, void **cpu_addr,
		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
{
...
	*cpu_addr = (void *)addr;
	memset(*cpu_addr, 0, size);
	return pfn_to_page(__phys_to_pfn(phys));
}

Why 

> +	}
>  
>  	/* we always manually zero the memory once we are done */
>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> @@ -357,7 +359,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	void *ret;
>  
>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
>  
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)
> -- 
> 2.43.0
> 
> 
