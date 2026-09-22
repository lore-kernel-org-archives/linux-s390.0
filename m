Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909E4DDB5D;
	Tue, 22 Sep 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060232; cv=none; b=nlkAgTvMt0ZA/wCgKtkASITULlUcYUt7MLinWgG87fMF48RJkY3WUb41lzgyspJebz+wNb07nvddZdYa6sP/ij+4RGD218MxEKcu/HnSxrAdpwTTLHSc/Cc1tU1P3SrOQE36Jd06Cisi0UUE/p+py1bpI4LAflQOgq+gEQeY19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060232; c=relaxed/simple;
	bh=FcTCXKGeTtFpcrVBbNfvj7cPYW3qv1hqdB+74dNhimk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4R3j0C9beNNBa7K2P3aVbc9p4Mgd8XQYXSib4fY8CJEKrml8aScp0do6EJQYFI5xP9vX5Y4ZDYwdBf5He1IBGniSl6zp7Ngj7HpgkD9VmmAWFg6iqQ6hBEtHN4dm35Co5D9aXDnYxMcyRO6k8gsk6863vDhmnqYl3ju5uPtL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNB44/zw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNB44/zw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602FD1F000FF;
	Tue, 22 Sep 2026 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060224;
	bh=VVgL/uzz137uMRzSkpFduyYcDsPNmDrSlT5+2SBHXpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BNB44/zwKoNMc0NnM2KjlJD0Vr/OZo7eRyriJNlJby7xV70V9sHGh4ZUo3N6FgJ5t
	 AjPqJib9IFHuoqfPh8SyGVJoAHqxb/F0KmSrGipZ3+Sm+r/lDNT/XUTs7nFCcT2DhH
	 g5WR1jq4muLh7CxgYUjUANWn3iQ3FgYkWa6NZWbaJ6BOFWumg9ZQKJ956iEpeA81PA
	 hzTJ4cfSvz4m1vsEf2dZ4qKH6nXJpbMvl69nqyp+3sqrQFniFXCfQhmD8wTBwEdZc/
	 /Yq6Bnpzrc3VVAujAQyozn9bvn0jHEZpnABRRKd4QSAfltWAjXL8kiHAK+SmBrRSWB
	 c5nlXGg/IquUw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 3/6] dma: swiotlb: Centralize minimal pool sizing
In-Reply-To: <21180ec6-b9ad-43fd-9e52-51df644e1b93@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-4-aneesh.kumar@kernel.org>
 <21180ec6-b9ad-43fd-9e52-51df644e1b93@arm.com>
Date: Tue, 22 Sep 2026 12:26:47 +0530
Message-ID: <yq5apky53hao.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
>> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be

 [ ... 54 lines skipped ... ] 

>>   
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 8f86deb25be2..f368a73f4ed0 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -483,9 +483,18 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
>>   static void __init
>>   swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
>>   {
>> +	if (swiotlb_default_size_changed())
>> +		return;
>> +
>
> This appears to be entirely redundant, as ultimately the point of this 
> function is to call swiotlb_adjust_size() (if it does anything at all), 
> and the first thing that does is this same exact check. We hardly need 
> to micro-optimise short-circuiting a handful of arithmetic in a one-off 
> setup path, and it's convoluted enough as it is, so please try to avoid 
> redundancy that makes it even more confusing to follow.
>

OK, I'll drop this.

>
>>   	switch (policy) {
>> -	case SWIOTLB_POOL_MINIMAL:
>> +	case SWIOTLB_POOL_MINIMAL: {
>> +		unsigned long size;
>> +
>> +		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
>> +		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
>> +		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
>>   		break;
>
> Similarly I think it would be clearer if we had a common 
> swiotlb_adjust_size() call at the end of the function, and then either 
> calculate a size or return early in each switch case as appropriate.
>
> Furthermore, swiotlb_size_or_default() is awful IMO - and in fact after 
> this series we could perhaps clean it up entirely by making the size 
> implicit in swiotlb_init_late() - not to mention misleadingly redundant. 
> I'd say just open-code "default_nslabs << IO_TLB_SHIFT" like elsewhere 
> in the file, but in fact it may as well just be IO_TLB_DEFAULT_SIZE 
> (think about it...)
>

How about we rename swiotlb_size_or_default to

unsigned long swiotlb_default_pool_size(void)
{
	return default_nslabs << IO_TLB_SHIFT;
}

We still need a helper because arch/arm/xen/mm.c also uses it. I also
updated swiotlb_adjust_pool_size() as suggested.

static void __init
swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
{
	unsigned long size;

	switch (policy) {
	case SWIOTLB_POOL_MINIMAL:
		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
		size = min(swiotlb_size_or_default(), size);
		break;
	case SWIOTLB_POOL_CC_GUEST:
		size = swiotlb_adjusted_size();
		break;
	case SWIOTLB_POOL_NONE:
		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
		return;
	case SWIOTLB_POOL_DEFAULT:
	default:
		return;
	}

	swiotlb_adjust_size(size);
}


-aneesh
