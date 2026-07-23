Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEBB40680F;
	Thu, 23 Jul 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793082; cv=none; b=U9slqFdwyGKPOjA20aTj/yPn5FnQqiXA4xViZIS7dzRWE/h3NmVYlJVnKnJXb+KnWkJf8oZbqcKj9CFVcGvaUAYQgBrI4z73tVb5CN5t74VuZ80pO3unD7nIfoV03wt0Yel+rlijv3nqslT6DokvuonVMFoMMb0Ttni1qPGMl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793082; c=relaxed/simple;
	bh=tDUFO0vLmWrLeoaSVmk16KindEOv1rbAReMd2abxSk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8DWsh4CQw/vRP+FyQ31JcJnYilYyzeTPvAHFZddns2+OoKeMVAMU/6zIQXSQZO4LIeyRmRjSSMFNS38Uhr7Y6dkvMJyTGSR7kA+9snrMRMxSkAiG5PtYRnVURI7EIY4iVlZK7paoxZ7tKLBuNE66bZoZCl0nD2sRw6EHqzbJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5yVtX07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5yVtX07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBAF1F000E9;
	Thu, 23 Jul 2026 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793081;
	bh=oS1NMvx865gW2UoErMylGfTUK0dtoB1K+HlWaCkJDOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C5yVtX07ZkUJj3b2b+kYtfuR23XpTFRkdHRdENTWAARDLYmTf2IRILt6XAP3lcQ3i
	 guxWOSpqvbZxIkPudGanZc9oRLKmaWg7jWE5nWdWWffLISp3ZQ+ad4Ihoe02/FYjI0
	 zawcqNvZ4YMD98rRRw9KmxbnYTZO2a2pevFxO+lic7WvlenUPBRb/qjJSo021Hq+fK
	 RnJUL29qw9dIMmgyNVWejeSnfUWslCr7nlHO+wb/2jqEuc0/cAk14jRWF5Uc2ySZeT
	 fSQ5DwAeoStwg7yjuT2gjGQyNTVPQV9uRZe39mcHkbKAqEo5c/lhrEDQ+DHZjlr32v
	 nL9nveFp0YtMA==
Date: Thu, 23 Jul 2026 10:51:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <20260723075108.GB110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260721124056.GK110966@unreal>
 <amEglRH3u6UFFnIQ@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amEglRH3u6UFFnIQ@ziepe.ca>

On Wed, Jul 22, 2026 at 04:57:09PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 21, 2026 at 03:40:56PM +0300, Leon Romanovsky wrote:
> 
> > Why don't we continue the effort to remove "struct page" entirely
> > from the DMA API internals?
> > 
> > IMHO, everything not exposed to DMA API users should use
> > phys_addr_t, including the DMA address pool.
> 
> The alloc interfaces return a struct page, that is why this stuff is
> organized like this. Look at dma_alloc_pages()

And I didn't say that we should change dma_alloc_pages(). It is external
API, which needs to be struct *page. I'm talking about internals.

Even dma_alloc_pages() flow shows how convoluted and non-uniform
the code underneath which performs translations all the time.

dma_alloc_pages()
	->  __dma_alloc_pages()
		-> dma_direct_alloc_pages()
....
	ret = page_address(page);             <--- here we need virt address
	if (dma_set_decrypted(dev, ret, size))
		goto out_leak_pages;
	memset(ret, 0, size);
	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page)); <- and here we need phys address
	return page;

So my point is that internal flows should not require struct page
and should not depend on it.

> 
> There is also an API that forms a scatterlist that has to be struct
> page as well
> 
> Jason
> 
