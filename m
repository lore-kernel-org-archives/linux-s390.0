Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF83AFCF7;
	Tue, 19 May 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203286; cv=none; b=eGcxswgc9qa/8bc1rHtxVfDdPeHEf9H65NaRxb5LFKfUbMLYls79T9wIbW/587p3fyZCfVWKZnbfq+qr/EZUET139qj3gsHPT3kdlnGoHMLmgTNUWuJ4N1fqbD6jYV7PwGHxxLk697GytIKoODNtgTynlxqYFh2l1emVDpqVZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203286; c=relaxed/simple;
	bh=KyaOKUufk660jyAnyO4dwLztr2A/5z8gocMgG2ZXcQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FS+MecAv+8QO5NaNvz3YIVOik63U0a5pmGVYFtrjYLpesLzPGXzy2lvw+rEITaeEaYFZsTb9QO7WwQI4NluCOnZEYAi7pLUUp8dsSQRUwewnOU1XIX3BOm8inc3nptkQu3p6mHVUr1IW5AMG1hnPozSEiwP9SSoE6WclgEgvybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfCVmqRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfCVmqRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB7C2BCB3;
	Tue, 19 May 2026 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203285;
	bh=KyaOKUufk660jyAnyO4dwLztr2A/5z8gocMgG2ZXcQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gfCVmqRQQdy8M8HA+XstwwoOpKN65jH/uDBv2iWJ6wdryzFjV5aqQ5J5zLKpnXd1R
	 MFePXRwJdlj0GE7vzB9h3mSdyYx+ToaECrqs8QXecIfN1ZsN3uSEg/aPjk5q3dnHDd
	 6x79LO3IArWLhr/nYRTv/X7YOfD7PNsBnNqxTreMAIV0LA5SmVfv87HgZUtCD/QPrU
	 ZbPRwVbbTLSoiNY4KtbyRJLSxc77SM+MLRmeWIXpFli++we4iwZ1y+H0UFcDRjYdiy
	 f3BUle31jswVsGu+sQx5NS55VsHZxmeQelzm2Y/aOpkLXTQLxhx9k+011Cn+nvKBVz
	 CMNlOzS75r7pw==
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <yq5amrxvshxg.fsf@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com> <yq5amrxvshxg.fsf@kernel.org>
Date: Tue, 19 May 2026 20:37:54 +0530
Message-ID: <yq5abjebsaid.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Mostafa Saleh <smostafa@google.com> writes:
>
>> On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
>>> >>=20
>>> >> What I meant was that we need a generic way to identify a pKVM guest=
, so
>>> >> that we can use it in the conditional above.
>>> >
>>> > I have this patch, with that I can boot with your series unmodified,
>>> > but I will need to do more testing.
>>> >
>>>=20
>>> Thanks, I can add this to the series once you complete the required tes=
ting.
>>>=20
>>
>> I am still running more tests, but looking more into it. Setting
>> force_dma_unencrypted() to true for pKVM guests is wrong, as the
>> guest shouldn=E2=80=99t try to decrypt arbitrary memory as it can include
>> sensitive information (for example in case of virtio sub-page
>> allocation) and should strictly rely on the restricted-dma-pool
>> for that.
>>
>> However, with my patch and setting force_dma_unencrypted() to false
>> on top of this series, it fails on pKVM due to a missing shared
>> attribute as Alexey mentioned, as now SWIOTLB rejects non shared
>> attrs, so, the DMA-API has to pass it. With that, I can boot again:
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 5103a04df99f..b19aeec03f27 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -286,6 +286,8 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  	}
>>=20=20
>>  	if (is_swiotlb_for_alloc(dev)) {
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +
>>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>>  		if (page) {
>>  			/*
>> @@ -449,6 +451,8 @@ struct page *dma_direct_alloc_pages(struct device *d=
ev, size_t size,
>>  						  &cpu_addr, gfp, attrs);
>>=20=20
>>  	if (is_swiotlb_for_alloc(dev)) {
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +
>>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>>  		if (!page)
>>  			return NULL;
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index 4e35264ab6f8..8ee5bbf78cfb 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -92,6 +92,7 @@ static inline dma_addr_t dma_direct_map_phys(struct de=
vice *dev,
>>  		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>  			return DMA_MAPPING_ERROR;
>>=20=20
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>>  		return swiotlb_map(dev, phys, size, dir, attrs);
>>  	}
>>=20=20
>> --
>>
>
> How about the below?
>
> modified   kernel/dma/direct.c
> @@ -278,6 +278,10 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>  	}
>=20=20
>  	if (is_swiotlb_for_alloc(dev)) {
> +
> +		if (dev->dma_io_tlb_mem->unencrypted)
> +			attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>  		if (page) {
>  			/*
> @@ -451,6 +455,10 @@ struct page *dma_direct_alloc_pages(struct device *d=
ev, size_t size,
>  						  &cpu_addr, gfp, attrs);
>=20=20
>  	if (is_swiotlb_for_alloc(dev)) {
> +
> +		if (dev->dma_io_tlb_mem->unencrypted)
> +			attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>  		if (!page)
>  			return NULL;
> modified   kernel/dma/direct.h
> @@ -92,6 +92,9 @@ static inline dma_addr_t dma_direct_map_phys(struct dev=
ice *dev,
>  		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  			return DMA_MAPPING_ERROR;
>=20=20
> +		if (dev->dma_io_tlb_mem->unencrypted)
> +			attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>=20=20
>
>

if we get force_dma_unencrypted(dev) correct, we won't need the above.

for dma_direct_alloc and dma_direct_alloc_pages() we have

	if (force_dma_unencrypted(dev))
		attrs |=3D DMA_ATTR_CC_SHARED;


for dma_direct_map_phys(), if we have swiotlb bouncing forced,

swiotlb_tbl_map_single():

	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
		require_decrypted =3D true;

-aneesh
