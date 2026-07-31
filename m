Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650E23394B;
	Fri, 31 Jul 2026 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483250; cv=none; b=X46TgaWML0Q1tkYdlieVVTG5v1vpOejI0/qbpJt3Uh3oZtIXbyQnZMKhWSnCcvdWUHHGdk9wV4/+ONIwQVH5K0WCgJXamUP50eHLfYn3xEDQcJvGVg3NLR2ywoORLVfz+XYD/R/EtL55AnHvAjZRinu62EZNoVEK4VT/m59ZlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483250; c=relaxed/simple;
	bh=gt/cqMD5KNfHJG+3PoldXcwl4vYWkvMaM5QiMj5ArPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=f3EhoDLhscsRdy2bd8tKq850ppfNFo63eIPPCtrYymZwcXhxP4L6nIbhRKBRA8xJ2RNDuLYflcs9iGIHwhDg3hYbVhIm3Yu+Y8/dMUb4BOaPGf2mOpnMpcedrky/L8Xze/UHHhzaNqW1oF7LQiP+7smVK9LHdk5ZXAa9iB2XNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h2vFzdGP; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h2vFzdGP"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260731073359euoutp01b326523e6f9dce2fa68dcdf5a4089e5b~HT4vhc6Cs1162311623euoutp01Z;
	Fri, 31 Jul 2026 07:33:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260731073359euoutp01b326523e6f9dce2fa68dcdf5a4089e5b~HT4vhc6Cs1162311623euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785483239;
	bh=N3Jgur6eGpI5uF6i9kwDYaTQ48SNIpZ5QYt0ueN9Z1A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=h2vFzdGPU5rK6aIg9RL7QWF075tsWv+IJpqYD+rwoehY/vNWBMRBWGrq2fWusmWGk
	 J790EJlBOERW4eikBs6SJ0XQKF/mLNr0HDnXFmef70VwH7PnAlB0ueKl/8aXpOpDw3
	 NAWoNOdVoKDxcVtSBMhZr5p81NEbyYPO8PB+QGI0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260731073359eucas1p2ff8cd0f84dea171a8b4f0061154dc5ae~HT4vTnQXs1993519935eucas1p2y;
	Fri, 31 Jul 2026 07:33:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260731073350eusmtip181b6e9861358d1e9a24ec292d0634e20~HT4nVsXtj0839208392eusmtip1O;
	Fri, 31 Jul 2026 07:33:50 +0000 (GMT)
Message-ID: <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
Date: Fri, 31 Jul 2026 09:33:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Marc
	Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
	Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5azezfeeax.fsf@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260731073359eucas1p2ff8cd0f84dea171a8b4f0061154dc5ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb
X-EPHeader: CA
X-CMS-RootMailID: 20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
	<CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
	<yq5azezfeeax.fsf@kernel.org>

On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>> This series tracks confidential-computing shared DMA state through the
>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>> DMA buffers are handled consistently.
>>
>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> shared/decrypted buffer handling. This series consolidates the
>> force_dma_unencrypted() checks in the top-level functions and ensures
>> that the remaining DMA interfaces use DMA attributes to make the correct
>> decisions.
>>
>> The series separates mapping and allocation state:
>> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>>   mapping. It tells the DMA mapping path that the DMA address must target
>>   shared/decrypted memory.
>> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>>   by allocation paths after the DMA core decides that the backing pages
>>   must be allocated as shared/decrypted memory.
>>
>> The series:
>> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
>> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
>> - teaches the atomic DMA pools to track encrypted versus decrypted
>>   state
>> - tracks swiotlb pool encryption state and enforces strict pool
>>   selection
>> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>>   DMA attributes
>> - passes DMA attributes down to dma_capable() so capability checks can
>>   validate whether the selected DMA address encoding matches
>>   DMA_ATTR_CC_SHARED
>> - makes dma_direct_map_phys() choose the DMA address encoding from
>>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>>   relying on SWIOTLB_FORCE for DMA mappings
>> - use the selected swiotlb pool state to derive the returned DMA
>>   address
>> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>>   guests, and s390 protected virtualization guests.
>>
>> Dependency:
>> This series depends on the pKVM changes posted at:
>> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>>
>> Please merge this series only after the pKVM changes above are merged.
>> Otherwise pKVM will be broken.
>>
> pKVM topic branch is now available 
>
> https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
I've just got back from my holiday's and I see that there is everything ready to give
this patchset some tests in linux-next. I hope nothing will break.

I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with
patch "[PATCH v8 17/23] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"
rebased onto latest changes in arch/arm64/mm/init.c.

The remaining items pointed in the review can be fixed incrementally.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

