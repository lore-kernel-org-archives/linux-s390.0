Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1722579E;
	Thu, 14 May 2026 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734502; cv=none; b=giU5bgDSmM9R3aY0Pu5yshRB4r9Fq/lTqgluCOV7v7VVSuEUbIBIHBPzH7Yr5fWWgcGzJ2IqLP2l1O2ZdUQXdp3DM4k38l/0crBf8Q2Li5oAYgLmJHJrsYbOiIS26vXBUpzyVgYrUJMwZ6rhLUfq574P9U80tJdNupvA0cHT+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734502; c=relaxed/simple;
	bh=fu7oXRCbIoWpCM9m0hogLZBBtl5wi1raRQxMal17Dpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFX/H9Ufcic2+g396oCBEizz9+qUZVXk72vqreo1VCahKSkJX/oGVhuP65MB0wxdiqreJntN290UzdWjiKqBe1hL9q0GPJb7wheZjtq6ppAwvCOoaW6V8+1AUXfECmiWWRjp4e3QPhFP02Uk1ZQ6cwNFjjrSShekw4K3MjueqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFCph6hS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFCph6hS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476D8C2BCC6;
	Thu, 14 May 2026 04:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734502;
	bh=fu7oXRCbIoWpCM9m0hogLZBBtl5wi1raRQxMal17Dpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KFCph6hSEzPHK7GqKDUVXJORT0zNsXTfmL5QAQhzcX4WbO3qw4ujtAuQguNgeyd3H
	 CSceWj3p7WAk2dpblQNMcPAxdaUw0Tig2hb5zNLJdzTK3Ogu4XzNBWcE4P7fQvW2Ea
	 5o86fJr5f6XsrjeiTT75An4aGUxuWombHeEcvPLmR8br9mI2bIoytnr59dLHs/N502
	 7Cg+bGgRBWmZJNu8xQgBCM5jFYrkf9YmMJ4omYCRBWCzA40ETjak3sxsltd9CT1ddk
	 Rh4O+tQXw8VcS09Ce5v6E2jzhAxeamdFApa/kNtDzdDn+A1F+JoKxeJpig8f/+tvyt
	 +LEL/oeZgAPoQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 01/13] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
In-Reply-To: <agSDPJMZkcI-uH8f@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-2-aneesh.kumar@kernel.org>
 <agSDPJMZkcI-uH8f@google.com>
Date: Thu, 14 May 2026 10:24:48 +0530
Message-ID: <yq5amry2a8vb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, May 12, 2026 at 02:33:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it =
in
>> dma_direct_alloc() / dma_direct_alloc_pages().
>>=20
>> This is needed for follow-up changes that simplify the handling of
>> memory encryption/decryption based on the DMA attribute flags.
>>=20
>> swiotlb backing pages are already mapped decrypted by
>> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
>> dma-direct should not call dma_set_decrypted() on allocation nor
>> dma_set_encrypted() on free for swiotlb-backed memory.
>>=20
>> Update alloc/free paths to detect swiotlb-backed pages and skip
>> encrypt/decrypt transitions for those paths. Keep the existing highmem
>> rejection in dma_direct_alloc_pages() for swiotlb allocations.
>>=20
>> Only for "restricted-dma-pool", we currently set `for_alloc =3D true`, w=
hile
>> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
>> typically used together with "shared-dma-pool", where the shared region =
is
>> accessed after remap/ioremap and the returned address is suitable for
>> decrypted memory access. So existing code paths remain valid.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  kernel/dma/direct.c | 44 +++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 37 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index ec887f443741..b958f150718a 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -125,9 +125,6 @@ static struct page *__dma_direct_alloc_pages(struct =
device *dev, size_t size,
>>=20=20
>>  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>>=20=20
>> -	if (is_swiotlb_for_alloc(dev))
>> -		return dma_direct_alloc_swiotlb(dev, size);
>> -
>>  	gfp |=3D dma_direct_optimal_gfp_mask(dev, &phys_limit);
>>  	page =3D dma_alloc_contiguous(dev, size, gfp);
>>  	if (page) {
>> @@ -204,6 +201,7 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>  {
>>  	bool remap =3D false, set_uncached =3D false;
>> +	bool mark_mem_decrypt =3D true;
>>  	struct page *page;
>>  	void *ret;
>>=20=20
>> @@ -250,11 +248,21 @@ void *dma_direct_alloc(struct device *dev, size_t =
size,
>>  	    dma_direct_use_pool(dev, gfp))
>>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>=20=20
>> +	if (is_swiotlb_for_alloc(dev)) {
>> +		page =3D dma_direct_alloc_swiotlb(dev, size);
>> +		if (page) {
>> +			mark_mem_decrypt =3D false;
>> +			goto setup_page;
>> +		}
>> +		return NULL;
>> +	}
>> +
>>  	/* we always manually zero the memory once we are done */
>>  	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>>  	if (!page)
>>  		return NULL;
>>=20=20
>> +setup_page:
>>  	/*
>>  	 * dma_alloc_contiguous can return highmem pages depending on a
>>  	 * combination the cma=3D arguments and per-arch setup.  These need to=
 be
>> @@ -281,7 +289,7 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  			goto out_free_pages;
>>  	} else {
>>  		ret =3D page_address(page);
>> -		if (dma_set_decrypted(dev, ret, size))
>> +		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
>
> I am ok with that approach, but Jason was mentioning we shouldn=E2=80=99t
> special case swiotlb and make the allocator return the memory state
> (similar to the dma_page [1]) . I am also OK if you want to merge that
> part of my series with is.
>
> [1] https://lore.kernel.org/linux-iommu/20260408194750.2280873-1-smostafa=
@google.com/
>

I was not sure whether we need dma_page. As shown in this series, we can
simplify the allocation and free paths without adding new abstractions
like dma_page.

>
>>  			goto out_leak_pages;
>>  	}
>>=20=20
>> @@ -298,7 +306,7 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  	return ret;
>>=20=20
>>  out_encrypt_pages:
>> -	if (dma_set_encrypted(dev, page_address(page), size))
>> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), siz=
e))
>>  		return NULL;
>>  out_free_pages:
>>  	__dma_direct_free_pages(dev, page, size);
>> @@ -310,6 +318,7 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  void dma_direct_free(struct device *dev, size_t size,
>>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>>  {
>> +	bool mark_mem_encrypted =3D true;
>>  	unsigned int page_order =3D get_order(size);
>>=20=20
>>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> @@ -338,12 +347,15 @@ void dma_direct_free(struct device *dev, size_t si=
ze,
>>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>>  		return;
>>=20=20
>> +	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
>> +		mark_mem_encrypted =3D false;
>> +
>>  	if (is_vmalloc_addr(cpu_addr)) {
>>  		vunmap(cpu_addr);
>>  	} else {
>>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>>  			arch_dma_clear_uncached(cpu_addr, size);
>> -		if (dma_set_encrypted(dev, cpu_addr, size))
>> +		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
>>  			return;
>>  	}
>>=20=20
>> @@ -359,6 +371,19 @@ struct page *dma_direct_alloc_pages(struct device *=
dev, size_t size,
>>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>=20=20
>> +	if (is_swiotlb_for_alloc(dev)) {
>> +		page =3D dma_direct_alloc_swiotlb(dev, size);
>> +		if (!page)
>> +			return NULL;
>> +
>> +		if (PageHighMem(page)) {
>
> My understanding is that rmem_swiotlb_device_init() asserts that there
> is no PageHighMem()? Also a similar check doesn=E2=80=99t exist in
> dma_direct_alloc().
>

The reason I added that HighMem check is that __dma_direct_alloc_pages()
already has that check.

	page =3D dma_alloc_contiguous(dev, size, gfp);
	if (page) {
		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
		    (allow_highmem || !PageHighMem(page)))
			return page;

		dma_free_contiguous(dev, page, size);
	}

I understand that the current usage of swiotlb alloc is restricted to
restricted memory, and it will not return HighMem pages. I will drop
this hunk from the patch.

-aneesh
