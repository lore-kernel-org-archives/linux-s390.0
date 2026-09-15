Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA147DD64;
	Tue, 15 Sep 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461985; cv=none; b=E8LlzPV5r0Py112EDsCCAWe/ldsP5xWaGYtikISqhud8t6buqKpLkq378KimKeTdFNf7sNJZlTO/SPQvb/kJjDOLGX13v/ChsZTR1LPHSyu7atFZMIpTo3I2lmBkNOdgK3KGq3U5mIBW01G1KxRGlGi0d+MuIguicRu1xzx+JCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461985; c=relaxed/simple;
	bh=YCxiQSKBXmQEendNiWA9kB2M8JZlC5H1RaHx+sNcs4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BxymESkt9Y3eXYw0yPAa+4h67ughHmIh/eYtx/UtOSfr8ICSagDwdcM3XIpSuiPKlaG7pcPouFaTps5yptkjgVw1Caf2DQfqpoaqSVIPoekRIx1ltqZopLIfH/iUcEbRW6kigpGdEpqkQce3uWroxzcB5HZDfABwTmob11hUZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2iUDY0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2iUDY0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560741F000FF;
	Tue, 15 Sep 2026 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461983;
	bh=SjOn26JeY4vz3qa8rqCCM8qIZp+nYUBpvjstkrIOnjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M2iUDY0vLh60R2S9cmi4WMn43kEpkH0c+dr9xTZGcISRkE4bCMFkH/WMw34VYnDpl
	 V79CW0/2zpB/yDqVLgE/w0hoET3ejNrQcuIG8RMe320LRO5WwQFE8zqWWSmOodaiF0
	 w0s6iC2SGsyTug37WelqrEGzItBAvKm901b6pUpfe5jIe4wc1GvBsdoARDoBwx3TVv
	 yNe57zbmsBhbeK8CpeEzjgRG+OQfAsX765cJE0bZStLOGWCk6jjr8LipFVsD7zcTXM
	 GnLvHaZsbukOSsXsYaQkRnw2eU9hdBXFoh8lcDC6jIwuagXMm3WWdF99ilwrawxIIo
	 iueTuLipCmfnw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 5/5] dma: swiotlb: Remove SWIOTLB_ANY
In-Reply-To: <20260914075959.AA0751F000FF@smtp.kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-6-aneesh.kumar@kernel.org>
 <20260914075959.AA0751F000FF@smtp.kernel.org>
Date: Tue, 15 Sep 2026 14:16:17 +0530
Message-ID: <yq5atsnq297q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Subsystem guideline violation: Use of globally uninitialized high_memory in __init code
> --
>
> commit 61bbab3b84e605312f21e75e603675cd29154afc
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> dma: swiotlb: Remove SWIOTLB_ANY
>
> This patch replaces SWIOTLB_ANY with SWIOTLB_INIT_ADDRESSING_LIMIT to
> explicitly identify callers that need pools reachable by devices with
> limited DMA addressing. It changes the default behavior to allow static
> and dynamic pools anywhere in directly mapped memory when the limit flag
> is omitted.
>
> [ ... ]
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 6695da682f961..f8a77926b8b09 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
> [ ... ]
>> @@ -604,10 +599,10 @@ void __init swiotlb_init_remap(unsigned int flags,
>>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>>  	if (!remap)
>>  		io_tlb_default_mem.can_grow = true;
>> -	if (flags & SWIOTLB_ANY)
>> -		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
>> -	else
>> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>>  		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
>> +	else
>> +		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
>
> [Severity: High]
> This is a pre-existing issue, but does this evaluation of high_memory in an
> __init function risk calculating an incorrect physical limit?
>
> The swiotlb_init_remap function in kernel/dma/swiotlb.c evaluates
> virt_to_phys(high_memory - 1) during early kernel boot. However, the
> high_memory global is uninitialized and evaluates to zero until
> free_area_init() runs. Calculating a physical limit using high_memory here
> can result in a bogus DMA boundary (such as zero or an underflowed limit),
> which could lead to memory allocation failures or data corruption during
> DMA mapping.
>
> Could this code use memblock_end_of_DRAM() instead of high_memory during
> early boot allocations?
>


But swiotlb_init() is called after set_high_memory()

start_kernel()
  |
  +--> mm_core_init_early()
  |      |
  |      +--> free_area_init()
  |             |
  |             +--> set_high_memory()
  |
  +--> mm_core_init()
         |
         +--> arch_mm_preinit()
                |
                +--> swiotlb_init()

-aneesh
