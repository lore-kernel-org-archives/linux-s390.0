Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACD242D67;
	Tue, 14 Jul 2026 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003279; cv=none; b=mdJJcdoKBn7uakf5bgVQZp7s7SEwsLYLnnCSiHu5efE/gxI1bouxOUdbZlHApY0d3tq3+TZAJ7QQTj8TaD7a+RaTJVbgzzHiUvePUWdD2ChQ+hnAaIUNVskAikczRMxseEe9+mDN4C13pDIGAM3mfxqn1QrKSXm8vPDyTZuHzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003279; c=relaxed/simple;
	bh=hFNDSfm0iAG1HoCrJRZJJz48PMPVKZgaZFFhazD6HEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tF48OZFPOn/y+j4iL3MK60Dylnnmrgwt6OHm6+W/6zZt5bG/ybq96bEPKE6KKA7stZ6GWKHXCgNk9epP0AgdJih4kcaHmhAMiGfHLF59EDogX946lOYnOHZaqzo9KEBM7C0s364LkANJKmJC7CE7Dqm0yQCzrXTqfukRbtpIKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJHJ1nkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJHJ1nkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25181F000E9;
	Tue, 14 Jul 2026 04:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003277;
	bh=NgdeQo2TB81zknr7ANK1aIrRxeu3MOxic6XnLAtyCXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NJHJ1nkTI1FRoIrGQfUrmz/9sKaOTlPMfecxhsBJjkAryeyRg38SqXMsX+CgDLuGR
	 4Q+jx3b6NEJbgs8uemLCGN7Zkoj5723IXe4JdKf63X4D+ZVXsg0HpD4CBSG/Igtr2m
	 iN5AaVHORWnFjRo7d87PKE0EuKEC5tvMH/+rVtulslDEm0/njvC512nUuoYQj8gPg2
	 cWL5XiAM1KnkjzfrdR/N+hPFm8qQM/wctqv6dolHYgKwbun/QgJKr7pwtkQ+6ma+04
	 OBdUqTBT1d9bGsHovryg0z+BKJjY3K/q0L0r2iALawfRiRXGezWmC0KKAIImrBlaDY
	 5Ls8gREIG7Nzg==
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
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260713184810.GM3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713184810.GM3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:57:43 +0530
Message-ID: <yq5aqzl6mc00.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:15AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>>  	 * shrink so no re-encryption occurs in dma_direct_free().
>>  	 */
>> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> -				   1 << order);
>> -	if (ret) {
>> -		leak_pages = true;
>> -		goto remove_mapping;
>> +	if (dma_pool->cc_shared) {
>> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> +					   1 << order);
>> +		if (ret) {
>> +			leak_pages = true;
>> +			goto remove_mapping;
>> +		}
>>  	}
>
> This makes the memory_decrypted conditional, but it doesn't change
> the lines a few above:
>
> 	addr = dma_common_contiguous_remap(page, pool_size,
> 			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
>                             ^^^^^^^^^^^^
> 			__builtin_return_address(0));
> 	if (!addr)
> 		goto free_page;
>
> It is wrong to pass pgprot_decrypted() to the arch code if
> set_memory_decrypted() was not called.
>
> Also it looks at some point the nature of the atomic pool has become
> confused. Originally it was just to allocate atomic memory that had
> been vmap'd outside the atomic context (to set the non-coherent
> pgprot), so every caller was expecting non-cached memory.
>
> Then it was reused to also allocate CC shared memory outside the
> atomic context. That was fine for x86 that doesn't use DMA_REMAP but
> on ARM64 it now means all atomic pool CC memory is uncached? That
> doesn't seem to make any sense...
>
> I suppose along the lines of this patch the solution is to add a
> noncoherent property to the pool so we can select the correct
> combination:
>
>  noncoherent !SHARED = vmap pgprot_noncached
> !noncoherent  SHARED= vmap pgprot_decrypted + set_memory_decrypted
>  noncoherent  SHARED = (probably unrealistic in real systems)
> !noncoherent !SHARED = normal __dma_direct_alloc_pages()
>
> But I don't view this as that important, the CC hypervisor is probably
> going to use the S2 page table to force cachable on all system memory
> so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
> it is confusing.. So maybe a little fixme is all that is needed here.
>

Something like?

modified   kernel/dma/direct.c
@@ -260,6 +260,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	/*
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
+	 * FIXME!! With CONFIG_DMA_DIRECT_REMAP, the pool is also mapped as
+	 * DMA-coherent (non-cacheable). We may want to create a separate pool
+	 * dedicated to CC_SHARED atomic allocations.
 	 */
 	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
modified   kernel/dma/pool.c
@@ -88,6 +88,7 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	unsigned int order;
 	struct page *page = NULL;
 	bool leak_pages = false;
+	pgprot_t prot;
 	void *addr;
 	int ret = -ENOMEM;
 	unsigned int min_encrypt_order = get_order(mem_cc_shared_granule_size());
@@ -110,8 +111,12 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	arch_dma_prep_coherent(page, pool_size);
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
-	addr = dma_common_contiguous_remap(page, pool_size,
-			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+	if (dma_pool->cc_shared)
+		prot = pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL));
+	else
+		prot = pgprot_dmacoherent(PAGE_KERNEL);
+
+	addr = dma_common_contiguous_remap(page, pool_size, prot,
 			__builtin_return_address(0));
 	if (!addr)
 		goto free_page;
