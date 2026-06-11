Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D74313545;
	Thu, 11 Jun 2026 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153526; cv=none; b=FuQOHC6m5/rkeHh47AqmQ4emVCz2tsqWzejJXQuvzdBdvpPuu76hMuJJ1avKgveWVvgG95XhCUj2LJBXrXEbhQj/zhRdNEPWoIRQZkRnkjuyIr2E1E+Dgcg9Ue/8CQ5XQoqh0nekzWZAmZ36H/Q1J+DUY6r+bE7XlHTnN4fogrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153526; c=relaxed/simple;
	bh=TQqRWe0+FozeEzR6uKVYnrV5UOI3yegwRRbHf1TS3FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6kfdFE6npJJXamM5xNn0aOL2oYwPLkkoY+FmfpcYSJTEmhUkUbWs+Sidfo6Xc1EEeO3HjMhF78T4R8bsy3l9r5MKj1UwsZ8px1vV5phBnPZI/VU8xVSwbzMRJ/3VcFa3w+0EwJJIAvWzCUrv/pwEeI+N9gR+a+CPgZSZw1Xe0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts3BC0lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts3BC0lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7F91F00893;
	Thu, 11 Jun 2026 04:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781153524;
	bh=wBiy+4NJTiyF3LHnq3yC4vQA0dZTq2HR/NSC6xodkWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ts3BC0lkCTucNM5739E2sZWz64sGR4ecSh89snHNUabM8DL3qL/i5Kq+0zSdhZxPE
	 3IZAI7m2ZKxzRkXYvD0cOOn1kHucsWMKFDN2YQCOWL2HCAGBQJRJYdYgdhuXgQDoB0
	 xS76QAA6BADLXCd8Uk9rx8RDBZWdltgbcZD/G/g9NCSJg3YPNIf09a1hOZb5YsaWNW
	 cTHImEPPmMXXBur/QKqsc2TV1/RXePiFHwN1KlK7PzRnOpzDixMzwOgpz7B2Xc9BNt
	 b2S6KKPd/v/Y8W+d40YF35LmJhBqAvMdRQd3T+uCEhgOq+dTseOnBJ3ptzf22P8UiP
	 EzBsszicXXFaA==
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
In-Reply-To: <20260610164153.GQ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca> <yq5afr2uzum9.fsf@kernel.org>
 <20260610164153.GQ2764304@ziepe.ca>
Date: Thu, 11 Jun 2026 10:21:50 +0530
Message-ID: <yq5acxxxn0gp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jun 10, 2026 at 01:37:26PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>> 
>> > On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> >> -		void **cpu_addr, gfp_t gfp,
>> >> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>> >>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>> >>  {
>> >> -	struct gen_pool *pool = NULL;
>> >> +	struct dma_gen_pool *dma_pool = NULL;
>> >>  	struct page *page;
>> >>  	bool pool_found = false;
>> >>  
>> >> -	while ((pool = dma_guess_pool(pool, gfp))) {
>> >> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
>> >> +
>> >> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
>> >> +			continue;
>> >
>> > I don't think you should be overloading DMA_ATTR_CC_SHARED like this.
>> >
>> > 	/*
>> > 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
>> > 	 * attribute. The direct allocator uses it internally after it has
>> > 	 * decided that the backing pages must be shared/decrypted, so the
>> > 	 * rest of the allocation path can consistently select DMA addresses,
>> > 	 * choose compatible pools and restore encryption on free.
>> > 	 */
>> > 	if (attrs & DMA_ATTR_CC_SHARED)
>> > 		return NULL;
>> >
>> > 	if (force_dma_unencrypted(dev)) {
>> > 		attrs |= DMA_ATTR_CC_SHARED;
>> > 		mark_mem_decrypt = true;
>> > 	}
>> >
>> > It is fine to have a bit inside the attrs that is only used by the
>> > internal logic, but it needs to have a clearer name
>> > __DMA_ATTR_REQUIRE_CC_SHARED perhaps.
>> >
>> 
>> Are you suggesting adding another attribute in addition to
>> DMA_ATTR_CC_SHARED?
>> 
>> Is the idea that __DMA_ATTR_REQUIRE_CC_SHARED would be used in the
>> allocation path to request a CC_SHARED allocation, while
>> DMA_ATTR_CC_SHARED would be used in the mapping path to describe the
>> attribute of the address?
>
> Yeah, it is a thought at least
>
> Maybe a comment is good enough.
>
> I just find it hard to follow when we have this dual usage. Like the
> code above for dma_pool->unencrypted is completely wrong if it is an
> "attribute of an address". Easy to cut & paste that into the wrong
> context.
>
> Especially if you move things up higher.. having the alloc set both
> CC_SHARED and REQUIRE_CC_SHARED or maybe ALLOC_CC_SHARED would make it
> clearer that the alloc code lives under that callchain
>
> Jason
>

If we are adding DMA_ATTR_ALLOC_SHARED, should we also allow
dma_alloc_attrs() to take that attribute value?

Does this look okay? 
(Note: Parts of the documentation text were updated using Codex.)

modified   Documentation/core-api/dma-attributes.rst
@@ -179,3 +179,32 @@ interface when building their uAPIs, when possible.
 
 It must never be used in an in-kernel driver that only works with
 kernel memory.
+
+DMA_ATTR_CC_SHARED
+------------------
+
+This attribute indicates that a DMA mapping is shared, or decrypted, for
+confidential computing guests. For normal system memory, the caller must
+already have marked the memory decrypted with set_memory_decrypted(). CPU
+PTEs for the mapping must use pgprot_decrypted(), and the same shared
+semantic may be passed to a vIOMMU when it sets up the IOPTE.
+
+This attribute describes an existing mapping. It does not allocate shared
+backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
+this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
+DMA_ATTR_MMIO is provided, the mapping requires a struct page.
+
+DMA_ATTR_ALLOC_CC_SHARED
+------------------------
+
+This attribute indicates that a dma_alloc_attrs() allocation must use
+shared, or decrypted, backing pages for confidential computing guests.
+Allocation paths use this request when they select shared DMA pools,
+decrypt newly allocated pages or restore encryption on free.
+
+DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it
+requests shared backing memory from the allocation path. DMA_ATTR_CC_SHARED
+describes an already-shared mapping and requires the caller to have
+prepared normal system memory before mapping it. Callers that need shared
+memory from dma_alloc_attrs() should request DMA_ATTR_ALLOC_CC_SHARED
+instead of DMA_ATTR_CC_SHARED.
modified   include/linux/dma-mapping.h
@@ -103,6 +103,13 @@
  */
 #define DMA_ATTR_CC_SHARED	(1UL << 13)
 
+/*
+ * DMA_ATTR_ALLOC_CC_SHARED: Allocates DMA memory as shared (decrypted) for
+ * confidential computing guests. Unlike DMA_ATTR_CC_SHARED, this attribute
+ * is used by dma_alloc_attrs() paths that create shared backing pages;
+ * DMA_ATTR_CC_SHARED describes an already-shared mapping.
+ */
+#define DMA_ATTR_ALLOC_CC_SHARED	(1UL << 14)
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
