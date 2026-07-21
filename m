Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA946AA75;
	Tue, 21 Jul 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648103; cv=none; b=gk29bsYvyi+EkuxxbZatqSWOsJIbygnjjrMTRPm51G65XWjnSNr9tF7QX+eotu0tlFSs+jMb2HRV9S+MYXLELhNl4r/LEp2ybEWDYqJJfsPG7PcFC4B2UBQWitE3r9F2C5YaL2599ZPcYcaUXTQCgozI2b5ohQROTBXV5eTXVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648103; c=relaxed/simple;
	bh=Bqwha5kXvb7TkgwPCF2JnFGEmZ01G6XWlFoe+BlIrTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eunnHZsQe/CD91dlUCXz3w/kroemd/DkaNvv29mVlbojktKTJ8aOGjMGzhRqduI2r3JUwFlrCGYDVSp8Lk/co55hNVA2HWOAvLmEU+4NZmqCP/xfjcF27I8ickl4OVmHhGfDJEdm57Ti4GXVDGYWCYxRyAapeTAyHtqlHe09/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJiPu+RZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJiPu+RZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D001F000E9;
	Tue, 21 Jul 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648102;
	bh=QVePzAEvk/HRAZDkJnNSAQ/f5uWHK1anOdVi7+q3VC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IJiPu+RZcRhgVPKAHX5VV+zkTpGbxlaIRt8LxXNBYciu1fuMPhhgYPKJQ96TwVCRB
	 3n+JiLog3a27/oOTINg2GG5gDlhgSmxXdIOL+JxMBbJBKdkjaOmMJ+qUFIRhCQswJt
	 RyFoKN8CBSq9d43YYEEbCAToMoDtSj2osByB1nu529L9d5iwVIM8Chf46dxyH7IXiF
	 mv6Mt4mlVUU73mvkDpfQ+y/6Ov42XFQI740FHvBbKbsKR0gJgcOGnQAHeOGj1DRBJo
	 RVu3b7leBlQogcOqXBk0V9pb/AfRcNa77YB1xLEHV8PPgq6WzgTFVNUdArT+9LHotq
	 mk+vfcLOSch0w==
Date: Tue, 21 Jul 2026 18:34:57 +0300
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 02/23] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260721153457.GP110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-3-aneesh.kumar@kernel.org>
 <20260721123107.GJ110966@unreal>
 <yq5aqzkw76ch.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzkw76ch.fsf@kernel.org>

On Tue, Jul 21, 2026 at 08:11:34PM +0530, Aneesh Kumar K.V wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> > On Fri, Jul 17, 2026 at 11:34:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> atomic_pool_expand() frees the allocated pages from the remove_mapping
> >> error path only when CONFIG_DMA_DIRECT_REMAP is enabled.
> >> 
> >> When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
> >> such as gen_pool_add_virt(), jump to remove_mapping and return without
> >> freeing the pages.
> >> 
> >> Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
> >> that cleanup paths always release the allocation.
> >> 
> >> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Tested-by: Michael Kelley <mhklinux@outlook.com>
> >> Tested-by: Mostafa Saleh <smostafa@google.com>
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  kernel/dma/pool.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> >> index 2b2fbb709242..b0303efbc153 100644
> >> --- a/kernel/dma/pool.c
> >> +++ b/kernel/dma/pool.c
> >> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  {
> >>  	unsigned int order;
> >>  	struct page *page = NULL;
> >> +	bool leak_pages = false;
> >>  	void *addr;
> >>  	int ret = -ENOMEM;
> >>  
> >> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  	 */
> >>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> >>  				   1 << order);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		leak_pages = true;
> >>  		goto remove_mapping;
> >> +	}
> >>  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> >>  				pool_size, NUMA_NO_NODE);
> >>  	if (ret)
> >> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  				   1 << order);
> >>  	if (WARN_ON_ONCE(ret)) {
> >>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> >> -		goto out;
> >> +		leak_pages = true;
> >
> > Instead of doing this dance with temporal variable, change "goto out" to
> > be "return true".
> >
> 
> 
> I didn't follow the return true part. A failure in
> set_memory_encrypted() or set_memory_decrypted() requires the pages to
> be leaked, so this is not the only call site that sets leak_pages =
> true. There is a similar case a few lines above.

Comment about "leaked" is enough. There is no need to introduce
convoluted flow just to check that page != NULL.

Thanks

> 
> 
> >
> >>  	}
> >>  remove_mapping:
> >>  #ifdef CONFIG_DMA_DIRECT_REMAP
> >>  	dma_common_free_remap(addr, pool_size);
> >>  free_page:
> >
> > Remove free_page label, and change leftover of "goto free_page" to be
> > "goto out"
> >
> >> -	__free_pages(page, order);
> >>  #endif
> >> +	if (!leak_pages)
> >> +		__free_pages(page, order);
> >
> > Put these checks under out label and rely on page != NULL as a marker.
> > if (page)
> >  __free_pages(page, order);
> >
> >>  out:
> >>  	return ret;
> >>  }
> >> -- 
> >> 2.43.0
> >> 
> >> 
> 
> -aneesh
> 
