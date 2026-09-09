Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032F242D70;
	Wed,  9 Sep 2026 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935485; cv=none; b=i+8XVxFHo8o0KJDuEKoHu2nxWP2TlxNOMQ1mhwawgILUDoWIZ1UgcyJ/0BLDeauV3UAIXb4vw8j2vt+89Phh/42CdJP9Enz9UxBLKbtNSTZljI33wrhlDG2jAxRZLQ4JGJmjL+PJfGMjNqMbJ33RvO34t4l5ta/sn3dX5YxYGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935485; c=relaxed/simple;
	bh=+eczGHHgyzWIJ6e7ALRA/TzWORTm7UNJdizAwpHRp90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYC0KyqC0E70u2YTidICtkZ2LCBIpc6ngsjzrLxpT58edEZF9w6pxk9ZcQdelo+5rCCASNbkl6VGdIWr/MlUGVaYxea83L0gS87ZwWAohGdRwAfc4JvSGoOZn23eqXwFYaAK+k7JyJJzDPGDuhoqBjdJTihDz6+0DfyHQ4qQIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLAKGe7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLAKGe7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE01F00A3A;
	Wed,  9 Sep 2026 06:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935480;
	bh=D9hHF5uCVTi6DjXsBsO1YPmAoF97KCA+x5kHHHm+v0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bLAKGe7Vdqm3/eBTxP7Jrln65tPxCic2p2Wm9crWjo3ZEu7YoHiIBv6jw0yxotQuW
	 MmnM7jKbBsDvxRK/L2Ocyd2HqouZ3XRo0JrzcarGlOmfJ2tyzA/9stljdBgyXlO16N
	 cEaYY3O9TvsSubyG41XmVMS4x7naSpQgKgUTcHK6tocwQXl4pD1VjRwA4TpeSIKVFY
	 oiLxL4740VmjrnpWqGfFlQqc/Ue6TZvmRPMEBxyba4eEYACuOcqqAoRcD7X/YtSEpY
	 +K9NeBI3IDrLS39jX0qNB0usBJAL4r2BulqwtJbjNBkQ1q1uQUBwlaYxD7AD/8fVQr
	 +qFXMLZtMtgRg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, x86@kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org> 
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] dma: swiotlb: Remove SWIOTLB_ANY
In-Reply-To: <yq5azexrdjlr.fsf@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-5-aneesh.kumar@kernel.org>
 <20260904103533.DCC191F00AC4@smtp.kernel.org>
 <yq5azexrdjlr.fsf@kernel.org>
Date: Wed, 09 Sep 2026 12:01:12 +0530
Message-ID: <yq5awlsvdjgv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


+x86@kernel.org and maintainers

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> sashiko-bot@kernel.org writes:
>
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [High] Inverting the default SWIOTLB allocation behavior from `membloc=
k_alloc_low()` to `memblock_alloc()` breaks DMA for legacy 32-bit devices o=
n x86 systems with `iommu=3Doff` when memory encryption or `swiotlb=3Dforce=
` is used.
>> --
>>
>> commit 35955ff88ad01e61df3c901065f4e509abaab7d0
>> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>
>> dma: swiotlb: Remove SWIOTLB_ANY
>>
>> SWIOTLB_ANY permits the swiotlb pool to be allocated outside the
>> architecture's low address limit. This is already implied when
>> SWIOTLB_INIT_ADDRESSING_LIMIT is not set, making SWIOTLB_ANY redundant.
>>
>> Use SWIOTLB_INIT_ADDRESSING_LIMIT as the sole indication that the
>> default pool and any dynamically allocated pools must reside below
>> ARCH_LOW_ADDRESS_LIMIT. Otherwise, allow the pools to use any directly
>> mapped memory.
>>
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index c4611b2c45403..2715833a21f8a 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -448,15 +448,10 @@ static void __init *swiotlb_memblock_alloc(unsign=
ed long nslabs,
>>>  	size_t bytes =3D PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>>>  	void *tlb;
>>>=20=20
>>> -	/*
>>> -	 * By default allocate the bounce buffer memory from low memory, but
>>> -	 * allow to pick a location everywhere for hypervisors with guest
>>> -	 * memory encryption.
>>> -	 */
>>> -	if (flags & SWIOTLB_ANY)
>>> -		tlb =3D memblock_alloc(bytes, PAGE_SIZE);
>>> -	else
>>> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>>>  		tlb =3D memblock_alloc_low(bytes, PAGE_SIZE);
>>> +	else
>>> +		tlb =3D memblock_alloc(bytes, PAGE_SIZE);
>>
>> [Severity: High]
>> Does inverting the default SWIOTLB allocation behavior from memblock_all=
oc_low()
>> to memblock_alloc() break DMA for legacy 32-bit devices on x86 systems?
>>
>> If a system boots with iommu=3Doff and swiotlb=3Dforce (or memory encryp=
tion),
>> pci_swiotlb_detect() leaves x86_swiotlb_flags as 0 because no_iommu is t=
rue:
>>
>> arch/x86/kernel/pci-dma.c:pci_swiotlb_detect() {
>> 	/* don't initialize swiotlb if iommu=3Doff (no_iommu=3D1) */
>> 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
>> 		x86_swiotlb_enable =3D true;
>> 		x86_swiotlb_flags |=3D SWIOTLB_INIT_ADDRESSING_LIMIT;
>> 	}
>>     ...
>> }
>>
>> Because SWIOTLB_INIT_ADDRESSING_LIMIT is not set, this new logic uses
>> memblock_alloc() instead of the previous memblock_alloc_low(), placing t=
he
>> bounce buffer pool anywhere, including above 4GB.
>>
>> Legacy 32-bit devices will then fail DMA mappings because they receive b=
ounce
>> buffers allocated above 4GB, failing dma_capable() checks and causing
>> swiotlb_map() to return DMA_MAPPING_ERROR.
>>
>
> I can fix this by adding a SWIOTLB_INIT_FORCE_DISABLE flag, which will
> be checked after swiotlb_force_disable and swiotlb_force_bounce.
>
> modified   arch/x86/kernel/pci-dma.c
> @@ -43,10 +43,13 @@ unsigned int x86_swiotlb_flags;
>=20=20
>  static void __init pci_swiotlb_detect(void)
>  {
> -	/* don't initialize swiotlb if iommu=3Doff (no_iommu=3D1) */
> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
> -		x86_swiotlb_enable =3D true;
> +	if (no_iommu)
> +		x86_swiotlb_flags |=3D SWIOTLB_INIT_FORCE_DISABLE;
> +
> +	if (max_possible_pfn > MAX_DMA32_PFN) {
>  		x86_swiotlb_flags |=3D SWIOTLB_INIT_ADDRESSING_LIMIT;
> +		if (!no_iommu)
> +			x86_swiotlb_enable =3D true;
>  	}
>=20=20
>
> Should we do this, or simply remove the !no_iommu check from the
> conditional? Is it OK to create a swiotlb pool when no_iommu is true?
>
>>
>> [ ... ]
>>
>>> @@ -598,10 +593,10 @@ void __init swiotlb_init_remap(unsigned int flags,
>>>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>>>  	if (!remap)
>>>  		io_tlb_default_mem.can_grow =3D true;
>>> -	if (flags & SWIOTLB_ANY)
>>> -		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
>>> -	else
>>> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>>>  		io_tlb_default_mem.phys_limit =3D ARCH_LOW_ADDRESS_LIMIT;
>>> +	else
>>> +		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
>>>  #endif
>>
>> [Severity: High]
>> Similarly, does this incorrectly record an unrestricted phys_limit for t=
he pool
>> when SWIOTLB_INIT_ADDRESSING_LIMIT is missing under the same iommu=3Doff
>> conditions?
>>
>> --=20
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904101810.1=
193505-1-aneesh.kumar@kernel.org?part=3D4
>
> -aneesh
