Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614D47CA8C;
	Fri,  7 Aug 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108723; cv=none; b=lgJRstuprIdTZCq5yDdtrTKmEPD7lmwgzNE8PFf93g/qsYtbTmIjq8Mx38zjLQXGKeLpSquVSPlYktTcVMGn2MN07oQ+JS4TT37SITsFDs8/T2frC5YI0pf2IftHBZksHtGuchmAuSyB70pTFc5QKG3JZUqdHAWY/C78V0nsxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108723; c=relaxed/simple;
	bh=gDwhkk/t71TRO5fpIF77dkVtXvZNkvZ27+O5qiP/9A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA5LxlQecF/5IL3Ulpic1ts8dYP44squoqFACgRdhPq9hYED1auY18wClzTkCoQyRMjmVozV4B5CNlw5ixZbusDeZ66NrB5MQTdB5caIPe3OK1VzpkJLCxMfsUF3GlNL+6l3eJhwJ+69JpAasQg2TXIUrMWOwdnqRmbGnbaJOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCNbiOkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCNbiOkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338611F000E9;
	Fri,  7 Aug 2026 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108720;
	bh=wsfDDPcsG5MUSLOHvWCFv40tfsXBmUj7P+V3Bqk82YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cCNbiOkjKWAUqmhRd4f35UKCjy7UEhkqpWWFeU9w7Kfiy5DgWT3dZw1OQFG8VAzwR
	 XZNBYUU8FhCvDz09mx7t85bJh2lGZS5wWKXfdEHcjdTmqrCKuvbXD4PHj259GvbZZY
	 At6gmah61p+afUyBaMnPfpe+im9eRwJlcM1uOVFcvRENntNyyd8OspaulZRPI21O0+
	 RQ+DtFZQKiusnOPhpgTJWrPlMW7ENlDI/iDnaojBH384ZJnryZxsxnSTIXfU3vj3ks
	 R4W0nC24in4QB64L5eYdsvT8dTMBFtjRhb+mL0yI6d/AOEHHOKCqEgpBrbJoOp2NCH
	 LWSkcbZumcQJg==
Date: Fri, 7 Aug 2026 14:18:31 +0100
From: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <anXbJ2O4DWgPxCeg@willie-the-truck>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxvu2ict.fsf@kernel.org>

On Fri, Aug 07, 2026 at 06:33:14PM +0530, Aneesh Kumar K.V wrote:
> Will Deacon <will@kernel.org> writes:
> 
> > On Fri, Aug 07, 2026 at 02:56:12PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Realm guests and protected KVM guests may require swiotlb for device DMA
> >> even when all system RAM is addressable by the DMA zones.
> >> 
> >> Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
> >> guests, as the reduced number of slots can be exhausted during CCA guest
> >> operation.
> >> 
> >> Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  arch/arm64/mm/init.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index e308a7cabd12..24caaf10e755 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
> >>  {
> >>  	unsigned int flags = SWIOTLB_VERBOSE;
> >>  
> >> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> >> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> +	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> >
> > Protected guests under pKVM rely on restricted DMA, so won't this just
> > waste memory for them?
> >
> 
> commit 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"),
> which this patch fixes, has
> 
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -339,9 +339,7 @@ void __init arch_mm_preinit(void)
>  {
>         unsigned int flags = SWIOTLB_VERBOSE;
>  
> -       if (is_realm_world() || is_protected_kvm_guest()) {
> -               flags |= SWIOTLB_FORCE;
> -       } else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> +       if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>                 /*
>                  * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>                  * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
> 
> The is_protected_kvm_guest() part was added by the 
> commit e62decaf98e7 ("arm64/coco: Add pKVM as a CC platform")
> 
> @@ -337,7 +339,7 @@ void __init arch_mm_preinit(void)
>  {
>         unsigned int flags = SWIOTLB_VERBOSE;
>  
> -       if (is_realm_world()) {
> +       if (is_realm_world() || is_protected_kvm_guest()) {
>                 flags |= SWIOTLB_FORCE;
>         } else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>                 /*
> @@ -412,6 +414,17 @@ void dump_mem_limit(void)
>         }
>  }
> 
> I was under the impression that there is a possibility of using swiotlb
> instead of restricted-dma-pool with pKVM.

Yes, that patch enables swiotlb as a possibility for protected guests
but with your patch we avoid shrinking the swiotlb buffer even when
restricted dma pools are being used and that's a waste of memory.

> If that is not the case, then we could change:
> 
> !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> 
> to
> 
> !is_realm_world() &&

Perhaps, or you could just pass the swiotlb= option if the defaults don't
work for you. Can you give more details about the slots exhaustion you're
seeing under CCA?

Will
