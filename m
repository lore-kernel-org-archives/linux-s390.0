Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D036E466;
	Fri,  7 Aug 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125610; cv=none; b=U1SmjIMSZTq5usqLsCrYSejH0TFoopvDKcXLZZs/OeEVvGqySTrN8uBefnlz0KTrWMiSZr1MFnaGJizPcN2Qh7NFuBzW+k5v3pPyUXS4pvdRR8lQlC81s0QlwsnhARVH4K+m3bT8iMEUDOSsNr9NbtUstlJfEv5do4BUJns08Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125610; c=relaxed/simple;
	bh=1Oe182UghJB6zmvPQ4B5TKJJr3BW4MdOLnWvw8BiJ34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DrhC1bBpbDOiWYt4kY08YUgWwh3BBqORl7xT+bK6lci+e4fpFfiGwlUj+g5ttcdp9bkG6echjIUmoTcQKMivTyO9ZSyN817PLb9Eg1+OOvi2n5rXzMk2lOVu4U/oqX6U6X1dJ1ffLhtnlSkl7abRdtrG79Kc8Yd7i1R1wammPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJD5BuIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJD5BuIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113191F000E9;
	Fri,  7 Aug 2026 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125608;
	bh=anTn3vLV1JrxTHR3F12/3ps8riKNqYfPGpQ3iHTztQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kJD5BuIFAjMSJG3vrvonufIfl5PkjhSvEyRTNa2e+eKbjs9hpZsRN0aT/dRE5qzcG
	 m6/ZymFBQPJ706AeGlXg1d3uSKhWNEQ8Nd+p6g8bsUaPTzKKir703XUcBeaBpbnFz3
	 ETtX8Dnv//CnXs9fpJnkLku6o7/ODBsyNAcymBNp3I5y80zrxdyKqT6853qwRujknu
	 HRL18GIFAsZdNua7nARtRPQiPHaXK/Z/II2I+NYz1FA1zWaAZuF1rjRtv1jobLfPjx
	 uIPYUsqxGbPbvMEtrQVG/F9Bc9PezRuuDpKSUMgO48Cgtht+onxBHLmcFYSYAY/Y1n
	 YTHkk6DfBUFXA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected guests
In-Reply-To: <anXbJ2O4DWgPxCeg@willie-the-truck>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
Date: Fri, 07 Aug 2026 23:29:54 +0530
Message-ID: <yq5azeyxyfol.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Will Deacon <will@kernel.org> writes:

> On Fri, Aug 07, 2026 at 06:33:14PM +0530, Aneesh Kumar K.V wrote:
>> Will Deacon <will@kernel.org> writes:
>> 
>> > On Fri, Aug 07, 2026 at 02:56:12PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> Realm guests and protected KVM guests may require swiotlb for device DMA
>> >> even when all system RAM is addressable by the DMA zones.
>> >> 
>> >> Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
>> >> guests, as the reduced number of slots can be exhausted during CCA guest
>> >> operation.
>> >> 
>> >> Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
>> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> >> ---
>> >>  arch/arm64/mm/init.c | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> >> index e308a7cabd12..24caaf10e755 100644
>> >> --- a/arch/arm64/mm/init.c
>> >> +++ b/arch/arm64/mm/init.c
>> >> @@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
>> >>  {
>> >>  	unsigned int flags = SWIOTLB_VERBOSE;
>> >>  
>> >> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>> >> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> +	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>> >
>> > Protected guests under pKVM rely on restricted DMA, so won't this just
>> > waste memory for them?
>> >
>> 
>> commit 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"),
>> which this patch fixes, has
>> 
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -339,9 +339,7 @@ void __init arch_mm_preinit(void)
>>  {
>>         unsigned int flags = SWIOTLB_VERBOSE;
>>  
>> -       if (is_realm_world() || is_protected_kvm_guest()) {
>> -               flags |= SWIOTLB_FORCE;
>> -       } else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>> +       if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>>                 /*
>>                  * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>>                  * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
>> 
>> The is_protected_kvm_guest() part was added by the 
>> commit e62decaf98e7 ("arm64/coco: Add pKVM as a CC platform")
>> 
>> @@ -337,7 +339,7 @@ void __init arch_mm_preinit(void)
>>  {
>>         unsigned int flags = SWIOTLB_VERBOSE;
>>  
>> -       if (is_realm_world()) {
>> +       if (is_realm_world() || is_protected_kvm_guest()) {
>>                 flags |= SWIOTLB_FORCE;
>>         } else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>>                 /*
>> @@ -412,6 +414,17 @@ void dump_mem_limit(void)
>>         }
>>  }
>> 
>> I was under the impression that there is a possibility of using swiotlb
>> instead of restricted-dma-pool with pKVM.
>
> Yes, that patch enables swiotlb as a possibility for protected guests
> but with your patch we avoid shrinking the swiotlb buffer even when
> restricted dma pools are being used and that's a waste of memory.
>

The patch restores the behavior to what it was before that commit. That
is, for both CCA and pKVM, we don't do the max_pfn check, and hence the
swiotlb is never resized.

>
>> If that is not the case, then we could change:
>> 
>> !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> 
>> to
>> 
>> !is_realm_world() &&
>
> Perhaps, or you could just pass the swiotlb= option if the defaults don't
> work for you. Can you give more details about the slots exhaustion you're
> seeing under CCA?

That is definitely possible. However, on arm64, the current code further
reduces the default swiotlb size when max_pfn < arm64_dma_phys_limit.
That reduction is only correct when swiotlb is being used as a bounce
buffer because of arm64_dma_phys_limit.

With CCA, that is not the case. We use swiotlb to bounce DMA for
untrusted devices. Therefore, reducing the default swiotlb size based on
max_pfn is not correct for CCA configurations.

This change in behavior is also a regression for CCA. CCA configurations
that booted successfully before now gives the error below.


[   39.848004] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 256 (slots), used 159 (slots)
[   40.002654] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 256 (slots), used 159 (slots)
[   40.165933] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 256 (slots), used 159 (slots)
[   40.325465] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 512 (slots), used 415 (slots)
[   40.485932] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 204800 bytes), total 768 (slots), used 671 (slots)
[   42.485337] EXT4-fs (vda): re-mounted 6870157e-2795-475e-aad6-3a05725fb7cf.
[   43.799800] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 1280 (slots), used 1153 (slots)
[   44.016682] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 1280 (slots), used 1153 (slots)
[   44.226566] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 1536 (slots), used 1409 (slots)
[   44.437194] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 262144 bytes), total 1792 (slots), used 1665 (slots)

-aneesh
