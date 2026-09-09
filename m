Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7EC27281E;
	Wed,  9 Sep 2026 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935303; cv=none; b=jVmMwQj0ScT2haGAaNxGq97LzglOFZ1lq1Z+KgeLgYudBawfs3tk2qFsgDf+Yn6lhQFjcclzlMiwEHv0a/SYXGHsJ83CUWH1akTVz2/yvnwruN48CbmEdXbNEbeUN/McFgRC8Y9OpnKxn7c6DDYGQAHxFkbJx8RASwIT6VOd5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935303; c=relaxed/simple;
	bh=8t0gz/lVAew87lojj6zNdapKJ9YR32LDCGjIXNSmN7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=shIcZPpVNgioAd1y3bjOP8tGGE8bS8Ziu2J/vPTAVCgOHEtSn+iwLa5xNRd9rn3XkWYCq6tPL1PcJowA7Ot++ufQ/qwXB5PO9/997fUFo9w0nfX91tRruEL4YjEKiE1gVJ51pOvaCLwSg/Pg17NOIP8YuESQ9sdwiQBkBeps9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjsysj8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjsysj8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4BC1F00A3A;
	Wed,  9 Sep 2026 06:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935301;
	bh=HvSeaxGFB27A0h0qKC3NvCMnAj7C/2Zh1XsHbKFHKnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cjsysj8ZRmjJakaPNQNIAeNRcd+RGpXfB/lURura0dxngV/V1VtMAcP/MYQLFBd/3
	 QtTxes8H9131HtTw9HDRU/ciI3mQSdDB+NLhtgz0sriFdER6EcpUPFCHiirLEOlMfO
	 C7q6zg1qZ6zYKRtaXuKZBWo/oZY9nMXSV2lWgXWcdYc8rzNpZdS1wI1DrttdAr9SLM
	 RcBkzMYPzOwV+Cyb1jv0vf8W3qiXqmZPn/EvFbOcCW+2S/LkAtmEhT41vZglsVkdlD
	 WetRo1GoBHDGfDJ9x+IY4mXVMaZsAG4Nvn02fM5nRoVzZQo9jXvi7pbwZ0YiViYv/2
	 wWIAUJyzG2bzw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] dma: swiotlb: Remove SWIOTLB_ANY
In-Reply-To: <20260904103533.DCC191F00AC4@smtp.kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-5-aneesh.kumar@kernel.org>
 <20260904103533.DCC191F00AC4@smtp.kernel.org>
Date: Wed, 09 Sep 2026 11:58:16 +0530
Message-ID: <yq5azexrdjlr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Inverting the default SWIOTLB allocation behavior from `memblock=
_alloc_low()` to `memblock_alloc()` breaks DMA for legacy 32-bit devices on=
 x86 systems with `iommu=3Doff` when memory encryption or `swiotlb=3Dforce`=
 is used.
> --
>
> commit 35955ff88ad01e61df3c901065f4e509abaab7d0
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> dma: swiotlb: Remove SWIOTLB_ANY
>
> SWIOTLB_ANY permits the swiotlb pool to be allocated outside the
> architecture's low address limit. This is already implied when
> SWIOTLB_INIT_ADDRESSING_LIMIT is not set, making SWIOTLB_ANY redundant.
>
> Use SWIOTLB_INIT_ADDRESSING_LIMIT as the sole indication that the
> default pool and any dynamically allocated pools must reside below
> ARCH_LOW_ADDRESS_LIMIT. Otherwise, allow the pools to use any directly
> mapped memory.
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index c4611b2c45403..2715833a21f8a 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -448,15 +448,10 @@ static void __init *swiotlb_memblock_alloc(unsigne=
d long nslabs,
>>  	size_t bytes =3D PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>>  	void *tlb;
>>=20=20
>> -	/*
>> -	 * By default allocate the bounce buffer memory from low memory, but
>> -	 * allow to pick a location everywhere for hypervisors with guest
>> -	 * memory encryption.
>> -	 */
>> -	if (flags & SWIOTLB_ANY)
>> -		tlb =3D memblock_alloc(bytes, PAGE_SIZE);
>> -	else
>> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>>  		tlb =3D memblock_alloc_low(bytes, PAGE_SIZE);
>> +	else
>> +		tlb =3D memblock_alloc(bytes, PAGE_SIZE);
>
> [Severity: High]
> Does inverting the default SWIOTLB allocation behavior from memblock_allo=
c_low()
> to memblock_alloc() break DMA for legacy 32-bit devices on x86 systems?
>
> If a system boots with iommu=3Doff and swiotlb=3Dforce (or memory encrypt=
ion),
> pci_swiotlb_detect() leaves x86_swiotlb_flags as 0 because no_iommu is tr=
ue:
>
> arch/x86/kernel/pci-dma.c:pci_swiotlb_detect() {
> 	/* don't initialize swiotlb if iommu=3Doff (no_iommu=3D1) */
> 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
> 		x86_swiotlb_enable =3D true;
> 		x86_swiotlb_flags |=3D SWIOTLB_INIT_ADDRESSING_LIMIT;
> 	}
>     ...
> }
>
> Because SWIOTLB_INIT_ADDRESSING_LIMIT is not set, this new logic uses
> memblock_alloc() instead of the previous memblock_alloc_low(), placing the
> bounce buffer pool anywhere, including above 4GB.
>
> Legacy 32-bit devices will then fail DMA mappings because they receive bo=
unce
> buffers allocated above 4GB, failing dma_capable() checks and causing
> swiotlb_map() to return DMA_MAPPING_ERROR.
>

I can fix this by adding a SWIOTLB_INIT_FORCE_DISABLE flag, which will
be checked after swiotlb_force_disable and swiotlb_force_bounce.

modified   arch/x86/kernel/pci-dma.c
@@ -43,10 +43,13 @@ unsigned int x86_swiotlb_flags;
=20
 static void __init pci_swiotlb_detect(void)
 {
-	/* don't initialize swiotlb if iommu=3Doff (no_iommu=3D1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
-		x86_swiotlb_enable =3D true;
+	if (no_iommu)
+		x86_swiotlb_flags |=3D SWIOTLB_INIT_FORCE_DISABLE;
+
+	if (max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_flags |=3D SWIOTLB_INIT_ADDRESSING_LIMIT;
+		if (!no_iommu)
+			x86_swiotlb_enable =3D true;
 	}
=20

Should we do this, or simply remove the !no_iommu check from the
conditional? Is it OK to create a swiotlb pool when no_iommu is true?

>
> [ ... ]
>
>> @@ -598,10 +593,10 @@ void __init swiotlb_init_remap(unsigned int flags,
>>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>>  	if (!remap)
>>  		io_tlb_default_mem.can_grow =3D true;
>> -	if (flags & SWIOTLB_ANY)
>> -		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
>> -	else
>> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>>  		io_tlb_default_mem.phys_limit =3D ARCH_LOW_ADDRESS_LIMIT;
>> +	else
>> +		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
>>  #endif
>
> [Severity: High]
> Similarly, does this incorrectly record an unrestricted phys_limit for th=
e pool
> when SWIOTLB_INIT_ADDRESSING_LIMIT is missing under the same iommu=3Doff
> conditions?
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904101810.11=
93505-1-aneesh.kumar@kernel.org?part=3D4

-aneesh
