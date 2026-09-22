Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD663CFF61;
	Tue, 22 Sep 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060667; cv=none; b=joEGeF6luY6p9rDdFTmI1r7wjR1TtbtfCz4+BUv3YUU9/505RdAwLBaNcrIIpj/XbZWJfPmD03nbMDzzD8HAOuysZ7ycuZSc9IFWCpbXs2NZxkmLa1ux7Vf9BtFCf3/saJNE483KyY89Xf3jLqGWgQA8vYOrdgIEtBCO98NUgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060667; c=relaxed/simple;
	bh=orVpRqlG2qqdYdCvlLGxX9McHpv80hQfjyQ0kGaVyRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0cGRoyoheqjDyEwDY6m7FZx2bKMYKlHfpVE3EhMZsi8qCtL3p3MF3KzXFvOvgAix6Sd5OnmSUNn/1NafqF1ckdUH4m1ylw697J+X+W+LGrNulGaOZd31f+lf00nFOMcmM50lvvzYnriFoGTOIMNC3YNjvPIrwg+kmUXP69fXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In8g8kd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In8g8kd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816F21F000FF;
	Tue, 22 Sep 2026 07:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060665;
	bh=7N/4ujtXH7gFivd8e09aq0btebh8aKhYlRQRMV/fpT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=In8g8kd8nHAw/ptWkhQ5+3DST6Z39rEGlTsKhD7o42vgGBI5A0QLOqSm/s6gWEy6b
	 DPsIS+A+L96TE7N3jQTZI8/kcbyYrQu8ENrma5TKuK6FXIEtGMIGftTEBgG+IWyFew
	 FGLP7nDxga8tzh1Ra2P8oJ/PX+bgShpmA9Bgzqgn1ByUG2qjPD5/x8Ej/D8r4ocs6l
	 FXxsBZFQrqR6fl+XjfIDjGF9LfRnVjTPz/HiQ2may2J4dpO6oGUyyNEh46vwxR2jNW
	 oShqw+MbKT5NZ2FVyZOXU+N8CuTVM2wGggThPkCoup8eKTf4bnCkgP8KhYBsMLZk26
	 ySMNFfE5Vp9pw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 5/6] dma: swiotlb: Add an overridable architecture
 pool opt-out
In-Reply-To: <20260921065154.9DA361F00893@smtp.kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-6-aneesh.kumar@kernel.org>
 <20260921065154.9DA361F00893@smtp.kernel.org>
Date: Tue, 22 Sep 2026 12:34:20 +0530
Message-ID: <yq5ajyod3gy3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dma: swiotlb: default opt-out incorrectly overrides iommu=soft
> --
>
> commit 8a081ec4054b9ec450c0c293130d0ceb6b8d20fa
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> dma: swiotlb: Add an overridable architecture pool opt-out
>
> This commit introduces SWIOTLB_INIT_DEFAULT_OFF to allow an architecture
> to opt out of SWIOTLB pool initialization without losing placement
> constraints.
>
>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> index 0cff255827baf..ce257b20ea9cf 100644
>> --- a/arch/x86/kernel/pci-dma.c
>> +++ b/arch/x86/kernel/pci-dma.c
>> @@ -44,9 +44,13 @@ static unsigned int x86_swiotlb_flags;
>>  static void __init pci_swiotlb_detect(void)
>>  {
>>  	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
>> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
>> -		x86_swiotlb_enable = true;
>> +	if (no_iommu)
>> +		x86_swiotlb_flags |= SWIOTLB_INIT_DEFAULT_OFF;
>
> [Severity: High]
> When this is combined with iommu=soft (which sets
> SWIOTLB_INIT_ADDRESSING_LIMIT), doesn't this flag overwrite the user's
> explicit fallback request?
>
> [ ... ]
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index c19675846fc1d..46b789eb08063 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -563,10 +563,16 @@ swiotlb_select_pool_policy(unsigned int flags)
>>  	if (flags & SWIOTLB_INIT_REMAP)
>>  		return SWIOTLB_POOL_DEFAULT;
>>  
>> -	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>> +	if (swiotlb_force_bounce)
>>  		return SWIOTLB_POOL_DEFAULT;
>>  
>> -	if (swiotlb_force_bounce)
>> +	/*
>> +	 * Explicit requirements above override an architecture's default opt-out.
>> +	 */
>> +	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
>> +		return SWIOTLB_POOL_NONE;
>> +
>> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>>  		return SWIOTLB_POOL_DEFAULT;
>>  
>>  	if (swiotlb_kmalloc_needs_bounce())
>
> [Severity: High]
> By evaluating SWIOTLB_INIT_DEFAULT_OFF before SWIOTLB_INIT_ADDRESSING_LIMIT
> and swiotlb_kmalloc_needs_bounce(), does the default opt-out incorrectly
> override explicit requests for a software bounce pool and unaligned kmalloc
> bouncing?
>
> For instance, if a user boots an x86 system with iommu=off iommu=soft,
> pci_swiotlb_detect() sets SWIOTLB_INIT_DEFAULT_OFF because of no_iommu=1.
> The iommu=soft parameter also sets SWIOTLB_INIT_ADDRESSING_LIMIT.
>

I don't think combining iommu=off with iommu=soft is valid.

>
> Because the opt-out is checked first here in swiotlb_select_pool_policy(),
> it returns SWIOTLB_POOL_NONE and prevents the pool from being allocated.
> Could this lead to DMA mapping failures for devices that cannot address all
> system memory, contradicting the commit message which states that iommu=soft
> retains the addressing limit?
>

-aneesh
