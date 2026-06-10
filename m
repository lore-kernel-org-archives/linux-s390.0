Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D62397AF2;
	Wed, 10 Jun 2026 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078859; cv=none; b=aOtTJWNksnV9oj9+Z5xOS43DVLREV2FDSLBrax18NIGq3/PTW/sUXiM+GMcvJar4vNQ5vI6W/JgjQPmp9O8zqFV9oFXVfLYia1Me6Vgj135kzShimNfEliisureAdd4UfQiE+hvPLB9JWp782WIbwxfspDPiy2/RlJxttb8sSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078859; c=relaxed/simple;
	bh=tTgAGDYe1TJX+0ei7rO+whTdSP047m6+BqwpQYtEKtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GMH4pdgCLVjd6WJVt8wylQ0pjPogH7GV5hqvb2pIUDujygNfxMB42V4ufTenCr2rwZG6szO5qOg3XeoHYTzXN2if70EyGsj+YFqKn/EAGYi3VStcgGZp9XFFHhEBbjO2cqcKNfrWob/eICB+QVOgMDer8AYpwhHgdEbDmTJSkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZtvV0j4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZtvV0j4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4241F00893;
	Wed, 10 Jun 2026 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781078858;
	bh=0QHcq+ldvvjOXKYe7v0SGXcqZmQygGGJknrasUV2jDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UZtvV0j4JPtGHjZWg1UsD2g+GxuSXIcXg6UMmssH9fOxo7BYN9s2Ha3MdttDa9dbZ
	 Y3LzCfYH3mse4KAw7UN/JV6C0wueAFYRrIGQ2UJ5pq6jRXX5P53Ch4aOs4N4umLYYs
	 nxpDHYwre7gShpAf+irvZS6VbqPnGX2pway8OyS6BalzGhpCmqjZn2itF7oRY6PEU+
	 SWXC9gxC0MFuAqRGUuuWYv1ujhTOYVz8b0PbDvuNVvVsTNPknSMUQy9Bm3/tqwgaF8
	 CI7mgB3EIJsBnPozx7Kng480IYc8IOGEBcGtUzsuIOR3Srq3phPC6r3VzcvBTdg+8I
	 keGWA+6ChZARA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
Date: Wed, 10 Jun 2026 13:37:26 +0530
Message-ID: <yq5afr2uzum9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> -		void **cpu_addr, gfp_t gfp,
>> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>>  {
>> -	struct gen_pool *pool = NULL;
>> +	struct dma_gen_pool *dma_pool = NULL;
>>  	struct page *page;
>>  	bool pool_found = false;
>>  
>> -	while ((pool = dma_guess_pool(pool, gfp))) {
>> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
>> +
>> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
>> +			continue;
>
> I don't think you should be overloading DMA_ATTR_CC_SHARED like this.
>
> 	/*
> 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> 	 * attribute. The direct allocator uses it internally after it has
> 	 * decided that the backing pages must be shared/decrypted, so the
> 	 * rest of the allocation path can consistently select DMA addresses,
> 	 * choose compatible pools and restore encryption on free.
> 	 */
> 	if (attrs & DMA_ATTR_CC_SHARED)
> 		return NULL;
>
> 	if (force_dma_unencrypted(dev)) {
> 		attrs |= DMA_ATTR_CC_SHARED;
> 		mark_mem_decrypt = true;
> 	}
>
> It is fine to have a bit inside the attrs that is only used by the
> internal logic, but it needs to have a clearer name
> __DMA_ATTR_REQUIRE_CC_SHARED perhaps.
>

Are you suggesting adding another attribute in addition to
DMA_ATTR_CC_SHARED?

Is the idea that __DMA_ATTR_REQUIRE_CC_SHARED would be used in the
allocation path to request a CC_SHARED allocation, while
DMA_ATTR_CC_SHARED would be used in the mapping path to describe the
attribute of the address?



>
> The sashiko note does look legit though:
>
> 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> 					   gfp, attrs, NULL);
> 		if (!page)
> 			return NULL;
>
> I don't see anything doing the force_dma_unencrypted test along this
> callchain..
>
> I guess it should be done one step up in dma_alloc_attrs() instead of
> in dma_direct_alloc()?
>

Yes, I'll move it there.

-aneesh
