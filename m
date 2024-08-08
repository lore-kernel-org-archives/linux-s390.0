Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9881751;
	Thu,  8 Aug 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111317; cv=none; b=K5GKVc5Gh1hKDY4QGgXTiAuQiOA/9obLzdQnQNztt5SWiy0IScxsCIdo4+k53Kh4qgYRgpAma4ZGBg7lgWcvQHOnb0da/hzcHmv5g9MZ57n+mRVDkM8AnOEKQj/u540vLnw+/5NaNFXOq38ngTcIW9KFEfmPfHXz4h0hp1Pko88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111317; c=relaxed/simple;
	bh=u0V4rojaf1olpTRsylY1jFpw8o8H0mjn/ZzL2wkLuHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/3AWicFGLERiaF/9jxbWCB/MFWUsb+2lKFOpXMuXi26Xm53e46Qg9aIrv8x/bJ7KGyutMFE/ceq4Lz7H9ptr8ykLAO+oBmger48MTwy3eU1153gVUrLpAAXagBNtWjdu2k2TetoJjRDrDWJbfp9KfkgglWZdi/hriU0mT/HQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8944F139F;
	Thu,  8 Aug 2024 03:02:20 -0700 (PDT)
Received: from [10.57.48.153] (unknown [10.57.48.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 340AF3F6A8;
	Thu,  8 Aug 2024 03:01:50 -0700 (PDT)
Message-ID: <18166885-127d-492d-8b9f-cc70a7ad2562@arm.com>
Date: Thu, 8 Aug 2024 11:01:45 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>,
 Elad Nachman <enachman@marvell.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
 <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
 <Zqyo4qjPRHUeUfS5@arm.com> <20240807161938.5729b656@mordecai.tesarici.cz>
 <ZrO5okGUljTc9E7N@arm.com> <20240808113501.4fde4cb0@mordecai.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240808113501.4fde4cb0@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-08 10:35 am, Petr Tesařík wrote:
> On Wed, 7 Aug 2024 19:14:58 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
>> On Wed, Aug 07, 2024 at 04:19:38PM +0200, Petr Tesařík wrote:
>>> On Fri, 2 Aug 2024 10:37:38 +0100
>>> Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>> On Fri, Aug 02, 2024 at 09:03:47AM +0300, Baruch Siach wrote:
>>>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>>>> index 3b4be4ca3b08..62b36fda44c9 100644
>>>>> --- a/kernel/dma/direct.c
>>>>> +++ b/kernel/dma/direct.c
>>>>> @@ -20,7 +20,7 @@
>>>>>    * it for entirely different regions. In that case the arch code needs to
>>>>>    * override the variable below for dma-direct to work properly.
>>>>>    */
>>>>> -unsigned int zone_dma_bits __ro_after_init = 24;
>>>>> +u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>>>>
>>>> u64 here makes sense even if it may be larger than phys_addr_t. It
>>>> matches the phys_limit type in the swiotlb code. The compilers should no
>>>> longer complain.
>>>
>>> FTR I have never quite understood why phys_limit is u64, but u64 was
>>> already used all around the place when I first looked into swiotlb.
>>>    
>>>>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>>>>> index d10613eb0f63..7b04f7575796 100644
>>>>> --- a/kernel/dma/pool.c
>>>>> +++ b/kernel/dma/pool.c
>>>>> @@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
>>>>>   	/* CMA can't cross zone boundaries, see cma_activate_area() */
>>>>>   	end = cma_get_base(cma) + size - 1;
>>>>>   	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
>>>>> -		return end <= DMA_BIT_MASK(zone_dma_bits);
>>>>> +		return end <= zone_dma_limit;
>>>>>   	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>>>>> -		return end <= DMA_BIT_MASK(32);
>>>>> +		return end <= max(DMA_BIT_MASK(32), zone_dma_limit);
>>>>>   	return true;
>>>>>   }
>>>>>   
>>>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>>>> index 043b0ecd3e8d..bb51bd5335ad 100644
>>>>> --- a/kernel/dma/swiotlb.c
>>>>> +++ b/kernel/dma/swiotlb.c
>>>>> @@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>>>>>   	if (!remap)
>>>>>   		io_tlb_default_mem.can_grow = true;
>>>>>   	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mhttps://lpc.events/event/18/contributions/1776/ask & __GFP_DMA))
>>>>> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
>>>>> +		io_tlb_default_mem.phys_limit = zone_dma_limit;
>>>>>   	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
>>>>> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
>>>>> +		io_tlb_default_mem.phys_limit = max(DMA_BIT_MASK(32), zone_dma_limit);
>>>>>   	else
>>>>>   		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
>>>>>   #endif
>>>>
>>>> These two look correct to me now and it's the least intrusive (the
>>>> alternative would have been a zone_dma32_limit). The arch code, however,
>>>> needs to ensure that zone_dma_limit can always support 32-bit devices
>>>> even if it is above 4GB (with the relevant dma offsets in place for such
>>>> devices).
>>>
>>> Just to make sure, the DMA zone (if present) must map to at most 32-bit
>>> bus address space (possibly behind a bridge). Is that what you're
>>> saying?
>>
>> No exactly. What I'm trying to say is that on arm64 zone_dma_limit can
>> go beyond DMA_BIT_MASK(32) when the latter is treated as a CPU address.
>> In such cases, ZONE_DMA32 is empty.
>>
>> TBH, this code is confusing and not entirely suitable for a system where
>> the CPU address offsets are not 0. The device::dma_coherent_mask is
>> about the bus address range and phys_limit is calculated correctly in
>> functions like dma_direct_optimal_gfp_mask(). But that's about it w.r.t.
>> DMA bit masks because zone_dma_bits and DMA_BIT_MASK(32) are assumed to
>> be about the CPU address ranges in some cases (in other cases
>> DMA_BIT_MASK() is used to initialise dma_coherent_mask, so more of a bus
>> address).
> 
> Yes, I know.
> 
>> On the platform Baruch is trying to fix, RAM starts at 32GB and ZONE_DMA
>> should end at 33GB. That's 30-bit mask in bus address terms but
>> something not a power of two for the CPU address, hence the
>> zone_dma_limit introduced here.
> 
> Yes, I was watching the discussion.
> 
>> With ZONE_DMA32, since all the DMA code assumes that ZONE_DMA32 ends at
>> 4GB CPU address, it doesn't really work for such platforms. If there are
>> 32-bit devices with a corresponding CPU address offset, ZONE_DMA32
>> should end at 36GB on Baruch's platform. But to simplify things, we just
>> ignore this on arm64 and make ZONE_DMA32 empty.
> 
> Ah. That makes sense. It also seems to support my theory that Linux
> memory zones are an obsolete concept and should be replaced by a
> different mechanism.
> 
>> In some cases where we have the device structure we could instead do a
>> dma_to_phys(DMA_BIT_MASK(32)) but not in the two cases above. I guess if
>> we really want to address this properly, we'd need to introduce a
>> zone_dma32_limit that's initialised by the arch code. For arm64, I'm
>> happy with just having an empty ZONE_DMA32 on such platforms.
> 
> The obvious caveat is that zone boundaries are system-wide, but the
> mapping between bus addresses and CPU addresses depends on the device
> structure. After all, that's why dma_to_phys takes the device as a
> parameter... In fact, a system may have multiple busses behind
> different bridges with a different offset applied by each.

Right, that's why the *_dma_get_max_cpu_address() functions already walk 
all known bus translations backwards to find the lowest common 
denominator in the CPU address space. In principle we could also 
calculate the lowest translated 32-bit DMA address from every >32-bit 
range in the same way, however that represents enough extra complexity 
that it doesn't seem worth trying to implement unless and until someone 
actually has a clear need for it.

Thanks,
Robin.

> 
> FYI I want to make more people aware of these issues at this year's
> Plumbers, see https://lpc.events/event/18/contributions/1776/
> 
> Petr T
