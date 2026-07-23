Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703A3AE184;
	Thu, 23 Jul 2026 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793430; cv=none; b=Mmv77+SfQDjAq8+hWKGIFPx/RPYOB9OpxU0Q/Fr4zLTUn5CRg97d+d6/DV7gglahrU0VK72Lz8YngJICjLu6rSO7AE0BzhXl//suqcQW2QwAQrVzzlFXAVCwYTkNiT/W52yd9dhMHC9DkI8TTQMvjILM4wsYd5ubL8hSG8znuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793430; c=relaxed/simple;
	bh=c4vhT9kYQoQuOODF3qVRg0f9ZMULx4+stzKFjWkULBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+31QdlwwT438JKvEqesLxDGeHyoqp1dJB3tRuAMFSRYIrCOmwOoOv+HFz9Dxvul7G3X187Dq/XJBO8LiSKFk64aG16wIsSkfG9udBvEYnRK8O0AQo8MMNee1tmJMejDTGiACB0nYOzz4qjTAjISSs9H9qRLeCXzR+VfRbE223A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3xmLXvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3xmLXvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF221F000E9;
	Thu, 23 Jul 2026 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793429;
	bh=MV/ddKhkOPrQoZ9vfnIwVbLJK9zML3biWg/uhRgYT0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3xmLXvwi2GMENZnteIxAJT9s/vth/ydaB8jnGiDbnoJQUcvxVpdQ4CJ0u/BR5Y29
	 qaZW01Tiv8f4zxAh9MGXy85RlTXDqDPcKcAejcfjjHjyYTYGbVh/52WQY1d0+CsjH4
	 ZXpYH0x/j/a+NIv+xUiENTmrpZC3T7+frmDwNIUG6kyP4miDxfjWLm2Kn7T3DD2S1N
	 Rr5EEKagMJePKW4DfUuaR2sNSURnR2wMcS+E4LnTti/I86ga4mpseDz/aSW2/dFH2l
	 lQt2pE4DfhbMPDcGZRVqphfYVCpTaURvHtyxvsl8CTFjve+0WEFD5IouvdUm0NhOK9
	 QYRocdPIUyYIw==
Date: Thu, 23 Jul 2026 10:57:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260723075704.GC110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amEhEKQW0_HJ9cLN@ziepe.ca>

On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
> 
> > Something like, but probably void* needs to be phys_addr_t:
> > 
> > static inline struct page *dma_phys_to_page(void *addr)
> > {
> > #ifdef CONFIG_DMA_DIRECT_REMAP
> > 	return vmalloc_to_page(addr);
> > #else
> > 	return virt_to_page(addr);
> > #endif
> > }
> 
> I don't like this, we don't know for sure the addr will be in a vmap
> and this will fail if it isn't.

Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
relevant for addresses acquired from pool.

dma_phys_to_page() is a bad name for some low-level conversion function.
It needs to be internal to DMA logic, in the level when we convert from
phys to page.

Thanks

> 
> Jason
> 
