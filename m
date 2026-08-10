Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BF3DA5C1;
	Mon, 10 Aug 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367727; cv=none; b=s4O/FFlIUccXLsSVtMWvF5ci5YZEr0M8H+PhVOUi6+40pq4DoZl2x1l2rXBUmbovRp2ifEz3yQIUrLncHRDzLGQrL64OTMZ0MLATeNZTnzrLmgcw4g4AAoSgD0yPfiQ0Q46hLSfKIJ6eWCjCy5i7mOrgu6ZkGLxRh1jg9OoVY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367727; c=relaxed/simple;
	bh=08CNSczzlMqJLfhVP4oR0gP5UnNIku1FbqhnKdMgNJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cscsVMAQDoicsrrPzP4PVitwBKLoTWWGK3w/YY7UqgwS6bKL6OGteolHO1yEF18zP1N//VXH+rkmc7D62/acTaur4yTUhD0+QIZgRTXewTZQUvEfk6qUcMzSx9HEdBzmpnhD2DoiTekRTymYER/nSmFYuUBslEBZoUun8IhsN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UIG0VKRV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UIG0VKRV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6411477;
	Mon, 10 Aug 2026 06:15:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D193F632;
	Mon, 10 Aug 2026 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786367724; bh=08CNSczzlMqJLfhVP4oR0gP5UnNIku1FbqhnKdMgNJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIG0VKRVpcnQsntb8X+MUw+Rl1RmKSYUuGIobrr6tKs0/KwrfxLsM0TWwGDOfumFm
	 6LNootm9c7LoakxRkMKnwDln+V6lL05lHro61O8CO3txcH2RBRl/GFDkKz44saVCkc
	 dgt/4K30gMdQMt+9zq0K3hFK4pldKbqC/7ig2Aqk=
Message-ID: <850675b8-1858-4314-85cf-b174daf8693e@arm.com>
Date: Mon, 10 Aug 2026 14:15:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
To: Michael Kelley <mhklinux@outlook.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
 <yq5awlu1yfn0.fsf@kernel.org>
 <SN6PR02MB4157484EFDE3315744021D5BD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <SN6PR02MB4157484EFDE3315744021D5BD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 6:00 am, Michael Kelley wrote:
> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org> Sent: Friday, August 7, 2026 11:01 AM
>>
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>
>>> On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
>>>
>>>>> I was under the impression that there is a possibility of using swiotlb
>>>>> instead of restricted-dma-pool with pKVM.
>>>>
>>>> Yes, that patch enables swiotlb as a possibility for protected guests
>>>> but with your patch we avoid shrinking the swiotlb buffer even when
>>>> restricted dma pools are being used and that's a waste of memory.
>>>
>>> I also thought we switched pkvm to use CC-like swiotlb as part of the
>>> alignment in this rework? Mostafa ?
>>>
>>>>> If that is not the case, then we could change:
>>>>>
>>>>> !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>>>>
>>>>> to
>>>>>
>>>>> !is_realm_world() &&
>>>>
>>>> Perhaps, or you could just pass the swiotlb= option if the defaults don't
>>>> work for you. Can you give more details about the slots exhaustion you're
>>>> seeing under CCA?
>>>
>>> We see badness with swiotlb too, it basically doesn't work out of the
>>> box if you have to use it 100% for real devices. It easily runs out
>>> of memory.
>>>
>>> Auto tuning to higher levels makes sense to me, but I'd rather the
>>> core code handled adjusting its size to the estimated need, not arch
>>> code.
>>
>> Agreed
> 
> Nobody has mentioned it on this thread, but arch code under x86 has
> a heuristic for sizing the swiotlb for SEV-SNP and TDX. The heuristic is 6%
> of guest memory, with a max of 1 GiB. See mem_encrypt_setup_arch().
> The heuristic originally went into the 5.11 kernel nearly 6 years ago for
> the original SEV support and hasn't changed since. See commit
> e998879d4fb79, which doesn't give much of an explanation. I don't
> think this is necessarily a good heuristic -- it tends to waste a lot of
> memory, but there are also a few cases where it isn't enough memory.
> After a few years of experience with SEV and TDX, nobody seems to
> have tried to come up with something better, so maybe it's not all that
> bad.
> 
> No doubt the heuristic should move into common code so CCA, SEV,
> and TDX all use the same one.

Indeed that would probably make sense as a future refactoring, as I 
would assume the general expectations of CoCo environments should be 
largely independent from the specific technology of either "Co" :)

However, note that currently the arch checks are effectively serving 
opposite purposes - x86 is specifically *increasing* the default SWIOTLB 
size for SEV/TDX, while the arm64 check (and RISC-V copy), is about 
*reducing* the default size if we think we (mostly) don't need it.

Thanks,
Robin.
