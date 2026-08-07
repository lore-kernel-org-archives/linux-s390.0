Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D2466B5E;
	Fri,  7 Aug 2026 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107827; cv=none; b=hOoSVEDLz95tIq4fX48f+CuXJVus6mbkH5i6Xrg6gupK3JZRaiVUwa0ypR5Ajd9MkHkdFkVMF4WaYusypSdyisuc9P2suh4ZqEkgcnb/qkawlk9cucbR2ewXEgDFuV7XbTpHyIwvB/QvQdoqeWeTkl3vX3sXzwCxWQthvYpB+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107827; c=relaxed/simple;
	bh=SFOODg6qJhhqz/d8SgHxakbTZXTQ0q6LGAHn5/aRuTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mVZRUsvZSQuxttEhaUBBufSa3dnmhJ2VcP80XXndHAzdKLICXU7p5LArCQbob49oLQMWwUDrxCGYUV/PrEgLRqlMCcFHybEY912X5QtlHWdtklatS5Nb2ufKThB7kjvwGn6/JSbXm/bIs0aeZFzSP3vtg49C3LBGkkZLxroV410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZgVfkuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZgVfkuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9CF1F000E9;
	Fri,  7 Aug 2026 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107807;
	bh=9QqKKM/ejR76i/TkpRfggSdbNj1yOKb4P01vNyYkRUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jZgVfkuoWf2/siK+rKc90sJnAQt9IS3OPxAuRh6EIc5QTd91l788Rnt8tZqkY0eX1
	 4V1fwC8Xke07dOEvJH4kYYZt+gvugXiKXdGz5s3Jt1/2YTv8XFf+3pPwa5TgRIy87h
	 tOTUigHIwOO/5rABTOwSnFvBDxhesq9IwfDUw/PwoaE1G3A47ELaIB7XeCacIsSDyy
	 PyFbqxUIFxAGM/63Xlcz8epDPjAFNlriiXizH5Y2/GDhHud+FPUDHlQJ3ZIrkb6HGm
	 sOiy7Vzx6vgAVgxctx2iJ5Rbh6hpYJoJ/vzRtPUfqSEI2nVg/CcZrAxJwm0CjWUY4i
	 tcfKhcQgz+Ztw==
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
In-Reply-To: <anXIZSh9lq99VG9X@willie-the-truck>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
Date: Fri, 07 Aug 2026 18:33:14 +0530
Message-ID: <yq5acxvu2ict.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Will Deacon <will@kernel.org> writes:

> On Fri, Aug 07, 2026 at 02:56:12PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Realm guests and protected KVM guests may require swiotlb for device DMA
>> even when all system RAM is addressable by the DMA zones.
>> 
>> Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
>> guests, as the reduced number of slots can be exhausted during CCA guest
>> operation.
>> 
>> Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/mm/init.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index e308a7cabd12..24caaf10e755 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
>>  {
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>>  
>> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> +	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>
> Protected guests under pKVM rely on restricted DMA, so won't this just
> waste memory for them?
>

commit 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"),
which this patch fixes, has

--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -339,9 +339,7 @@ void __init arch_mm_preinit(void)
 {
        unsigned int flags = SWIOTLB_VERBOSE;
 
-       if (is_realm_world() || is_protected_kvm_guest()) {
-               flags |= SWIOTLB_FORCE;
-       } else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
+       if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
                /*
                 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
                 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.

The is_protected_kvm_guest() part was added by the 
commit e62decaf98e7 ("arm64/coco: Add pKVM as a CC platform")

@@ -337,7 +339,7 @@ void __init arch_mm_preinit(void)
 {
        unsigned int flags = SWIOTLB_VERBOSE;
 
-       if (is_realm_world()) {
+       if (is_realm_world() || is_protected_kvm_guest()) {
                flags |= SWIOTLB_FORCE;
        } else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
                /*
@@ -412,6 +414,17 @@ void dump_mem_limit(void)
        }
 }

I was under the impression that there is a possibility of using swiotlb
instead of restricted-dma-pool with pKVM. If that is not the case, then
we could change:

!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&

to

!is_realm_world() &&

-aneesh
