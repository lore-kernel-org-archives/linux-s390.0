Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB1423A80;
	Wed, 12 Aug 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532898; cv=none; b=WtlbFoMWUy7PVKyiQdGVGqf86lrYmlgYD7/GtHw5K2xNWblL3GLZu44hMPapOIN9OYxBMeFmybJxcEopd6XlXO77K6UCVKyWJQsT3wsYKUZo7XmCJUWL7mkyI5U2a3c9I8AxlPIEtyv4NgArqNbBCLt0MkV57c+8lmg9i+pLxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532898; c=relaxed/simple;
	bh=lzP/JY3aeuocCdWL/0uXP7CnjLsvHNNNeXnnQoQI6GQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgiiXTPVYMMuFyaQrXFtuZIeL+qZYNHVtAHwcn1ZQEYqJnSdrRn9G78ySH6j24FHS4dXenulrUXm+t0UtjO2IdIryVXv88qD0pwXA6oRA7zWLh3khyJbu2iHR4+EbMQnPUFP1l8N3tbVmIaWDVoNF/UqJKUHXsm6UW7hGfXEHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkPSCeLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkPSCeLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332981F000E9;
	Wed, 12 Aug 2026 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532896;
	bh=wrG8DuqyrTgTLnhCEF0YR7wirnsbC3EpRyGJXVbGCIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EkPSCeLDP67zu3BNdozJVWmVgN/lwbl/w5cX6yfGYw9yVFjo6oPLCa0KuCgxJq/bJ
	 KCRPGDosYj4GfgaVr2nyBLrLMQzyq56jcmCurtz+u98h44jUMGlYs5abspQ7HI6rsh
	 QfoHCmaUDsxiRzdFLpT+tVjAjEYbE4nO23QHgxFCh00LDfMeQi+Ph7C2SSyb7vjFYB
	 hmnKnnLtrOxIfLT7V/pLXlLtaxUOl4T+7oG8LNW7m3pliZ+JhFVaHDpU+gCrQUFKvh
	 ITPhU3LDVqetWIWSsynW6Wc8ICVklFrAdPPAB/k0svEdGHBfo3zvurKffjxX4mpEdJ
	 bjOpTJ9BJHYPw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <anxEc8EHmJQywVI5@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
Date: Wed, 12 Aug 2026 16:38:03 +0530
Message-ID: <yq5ajypvioks.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Systems with memory encryption use swiotlb to provide shared or
>> unencrypted buffers for device DMA. Confidential guests may route all
>> DMA through these buffers, while SME hosts use them for devices that
>> cannot address encrypted memory. The default swiotlb pool can therefore
>> be exhausted under I/O-intensive workloads.
>> 
>> Let architectures mark the default swiotlb pool as shared before
>> swiotlb_init().
>
> I thought we wanted even this decision to be moved out of the arch code.
>

Architectures may want to use an unencrypted swiotlb pool for different
reasons, one of them being CC_ATTR_GUEST_MEM_ENCRYPT. x86 hosts also
require unencrypted pool to support SME. We can cover both cases using
CC_ATTR_MEM_ENCRYPT. However, pKVM does not want an unencrypted SWIOTLB
pool. So I was thinking it would be much cleaner to let the architecture
code drive that decision.

>
>> Move the existing x86 sizing policy into generic swiotlb
>> code and add early pool marking for arm64 Realm guests, powerpc secure
>> guests, s390 protected-virtualization guests, and x86 memory-encryption
>> platforms. Use CC_ATTR_MEM_ENCRYPT on x86 to include host SME, whose
>> swiotlb pool must also be decrypted for devices that cannot address
>> encrypted memory.
>
> That's a functional change for x86. For now, I'd keep it to
> CC_ATTR_GUEST_MEM_ENCRYPT.
>
> BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> option in realms?
>
>> Move the powerpc secure-guest swiotlb enablement before initialization
>> so that the shared pool is allocated with the required flags. pKVM
>> guests continue to use a restricted DMA pool instead of the default
>> swiotlb pool.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/mm/init.c                 |  6 ++-
>>  arch/powerpc/mm/mem.c                |  7 +++
>>  arch/powerpc/platforms/pseries/svm.c | 10 ----
>>  arch/s390/mm/init.c                  |  2 +
>>  arch/x86/mm/mem_encrypt.c            | 27 ++--------
>>  include/linux/swiotlb.h              |  7 ++-
>>  kernel/dma/swiotlb.c                 | 73 ++++++++++++++++++++++------
>>  7 files changed, 82 insertions(+), 50 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index e308a7cabd12..4c022e8aed43 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -338,8 +338,12 @@ void __init arch_setup_zero_pages(void)
>>  void __init arch_mm_preinit(void)
>>  {
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>> +	/* pKVM uses restricted-dma-pool */
>> +	bool cc_guest = is_realm_world();
>>  
>> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>> +	if (cc_guest) {
>> +		swiotlb_mark_default_cc_shared();
>> +	} else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>>  		/*
>>  		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>>  		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
>
> With your other reworking, doesn't the core code know the swiotlb will
> be shared? Can it not make the decision to resize at that point based
> solely on CC_ATTR_GUEST_MEM_ENCRYPT?
>
> I also wonder whether we could address Will's pKVM request not to
> allocate a bounce buffer once pKVM guests will start reporting
> CC_ATTR_GUEST_MEM_ENCRYPT. Some simple heuristic: if a
> restricted-dma-pool is advertised in DT (it will end up in
> rmem_swiotlb_setup()), skip resizing the default swiotlb. It's not
> perfect but the bounce buffer can be overridden on the command line.
>

For the same reason I mentioned above, architectures may have different
reasons for setting cc_shared = true. IMHO, it is cleaner to let the
architecture code make that decision before swiotlb_init().

-aneesh
