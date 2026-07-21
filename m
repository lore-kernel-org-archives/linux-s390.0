Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2E39EF16;
	Tue, 21 Jul 2026 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644169; cv=none; b=TFb3PdFFfKNRB2tbP1ZLymyatrt5wd2q9YZtBo/MsYeGmW2Q24uZr/bSRWnURvKB3DCYdF7EZJ/48labjIsulTkq1t+rIzxXosB6yOuhfRDJvZmNxR+snd6di5Ypo4cgp85Gr479z+n3KQIm/ZycIrQOU5dDfFYbCTqx5YpbQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644169; c=relaxed/simple;
	bh=QH4RFAHkBOrpSezy4lFQGFmp/CUrmtoTSqvH8wmrqe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex7h5g8wZunCZ2ssFTK+PIGrqtKFLS/2xw+dv2kuH+gGxhTxmPHD27dfRkaokA4NV/kRHNm9PzG5HvU5nxgcFCNxyWL++o919nDPXxl3SLWyB2T2kg52qPji+6HfchZ2VI3C4w1+V1/Sx1oUp02AGa4pQjrl/FH+lU4br3VdQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Y53Eln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Y53Eln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F491F000E9;
	Tue, 21 Jul 2026 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644168;
	bh=1soRxN4hiDcUXCxjs1PA7SeZGbKgmvbO8BnI4N1ZFe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6Y53ElnThJz/QmjNlBI90Yu7tbBuCvQU60QJ4DbRT5TXWdL7w3KuZzUdsCjKtoL/
	 71ZaLms1OHJ+aJGCsLyIDPyM7gGELMJkUoUEEKbfKXlEoG+CcCrbpbAg43lxbizIqO
	 yXWwFnJWX4Ru3nShSGjh7T+m6/UYy1o50khWKiQF8rvhylkfkDK/1Kki7v+jYxq5aI
	 gO/tbH5nUZoF4TeZXpFnsJTsnW6/YStJLzyv9G5e7g6RhjKNbNUznJMyPNGHNkYE0+
	 ZTUeuFNaF4ExWmaFhhdtjEOn8TaeQv52hbnyhHF4K8laJqqVGxQz+/SpgRyB1FtKpa
	 iraCr9pMDtqtA==
Date: Tue, 21 Jul 2026 17:29:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <20260721142921.GN110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsps77c5.fsf@kernel.org>

On Tue, Jul 21, 2026 at 07:50:10PM +0530, Aneesh Kumar K.V wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> > On Fri, Jul 17, 2026 at 11:34:19PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
> >> helper") changed dma_direct_alloc_from_pool() to return the CPU address
> >> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
> >> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
> >> 
> >> Fix this by making dma_direct_alloc_from_pool() return the struct page *
> >> again, and pass the CPU address back through an out-parameter for the
> >> dma_direct_alloc() caller.
> >> 
> >> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> >> Cc: stable@vger.kernel.org
> >> Tested-by: Michael Kelley <mhklinux@outlook.com>
> >> Tested-by: Mostafa Saleh <smostafa@google.com>
> >> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  kernel/dma/direct.c | 18 ++++++++++--------
> >>  1 file changed, 10 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >> index d8219efe3273..363d984d90e7 100644
> >> --- a/kernel/dma/direct.c
> >> +++ b/kernel/dma/direct.c
> >> @@ -164,22 +164,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
> >>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
> >>  }
> >>  
> >> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> >> -		dma_addr_t *dma_handle, gfp_t gfp)
> >> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> >> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
> >>  {
> >>  	struct page *page;
> >>  	u64 phys_limit;
> >> -	void *ret;
> >>  
> >>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
> >>  		return NULL;
> >>  
> >>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> >> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> >> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
> >>  	if (!page)
> >>  		return NULL;
> >>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> >> -	return ret;
> >> +	return page;
> >>  }
> >>  
> >>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> >> @@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >>  	 * the atomic pools instead if we aren't allowed block.
> >>  	 */
> >>  	if ((remap || force_dma_unencrypted(dev)) &&
> >> -	    dma_direct_use_pool(dev, gfp))
> >> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> >> +	    dma_direct_use_pool(dev, gfp)) {
> >> +		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
> >> +						  &ret, gfp);
> >> +		return page ? ret : NULL;
> >
> > Sorry for joining the discussion late, but the line above caught my
> > attention.
> >
> > Why do we need both ret and page? We can derive cpu_addr from page and
> > vice versa. Do we really need the &ret parameter? Or, more generally, do
> > we really need "struct page *"?
> >
> > static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
> > 		struct gen_pool *pool, void **cpu_addr,
> > 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
> > {
> > ...
> > 	*cpu_addr = (void *)addr;
> > 	memset(*cpu_addr, 0, size);
> > 	return pfn_to_page(__phys_to_pfn(phys));
> > }
> >
> > Why
> >
> 
> With CONFIG_DMA_DIRECT_REMAP the cpu_addr can be different from
> page_address.

Can you please point to the code there it can happen?
__dma_alloc_from_pool() has direct connection between physical address
and struct page.

Thanks

> 
> -aneesh
> 
