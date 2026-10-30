Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.90.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357437;
	b=kjji1KTRKRaX+eS2fzoIDIJFSCsGF8yazuqpYEX8W7QIrC79XJ+W4roAmL8NbOeVD/F7
	 zz3bcVsUVZ4LmlHgA1rwvBQgAaIfCKaNtoqSmGY2wjJVH2tUs/YgjVXtig6ahgVJql8D6
	 N4AVLZVFOBDpG7ybKpQXD3SvI22BaZ0fd5hbWZA9/bOzei886MNWidHfZhdkccotHFi2c
	 vX5Q8NHA9sPrwmFhyVdc+0BxznfMJi1o2PvcLqBtL8Y2mJAqJipnIlmgO3ppZv8k5Z029
	 +WecV4LU49x+5T6qEKxDkCfxJvBjP6vdBD8cbU69bRFJCMB7ztjIet7zz7yr40K2SGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357437;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MZqMRfPEVUiuMNxLqgmTIf03oB0BvArhy/TSmIC7oCY=;
	b=mI+5y4lWo+kgJEslYEYsNwoAO1XD0NugJij5vOS9JSDf0rgtHFvf8lGnWGkbpugSQZR/
	 mK1vYqWb2qxu3SrXXu+0JwHx9j1ChSNW7WNkiZ/j6d6iH4uWLMx21Tk4jT71KtgZIn5rq
	 5N+bPa/qAjpqg+2uAUzZg+YCSz7UfD1m4HIEDTLK4XpWg7/aFarU/AH+GGg21Pkfd2+/W
	 izA+icoKhzUH/fh+jlMV+WEHNr835fkm8TL0Jk+5ueNIbs0zgHeHHt4wpyIhxtkhpfxF8
	 PA5aZzxA6Ct972Mk59pnIe/7EaxhP3kwVuIwrKICnCTwa08HPwpf7IQViX5a4TQ7z3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=mQOzLOqZ;
	arc=none smtp.remote-ip=207.54.90.49
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972160A2630;
	Fri, 30 Oct 2026 10:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3972160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=mQOzLOqZ
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793357437; x=1824893437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Bk02kov5eXaN4fQMM0pbL4dj5jWKbTsBzV8w285UiE=;
  b=mQOzLOqZghPqjPfvrqnK/5Y35rROQztIuU4EyC5XFxjQ9N6/ClVLhT6j
   9jXCKGdak9HrbI6ImiktplMzc7Iy6T3bBuxuzdpefRJfTDGXkiWaw91m1
   9OwAnC1TmLx4JKNGm1uXvK9vRZkU9KfAuJvuvqwEZoMoqmYpFP4drssSY
   7dpYM9s0pwwWomcqH595uQGfjUFFtBhZIW3pu4pt5aSwscf2STUwHpms7
   OLrFMy7ZRWaFOsi6t4lFfpBy2PBf5hZAabTqZetEYShS84Xl0ukvB8Qqr
   wSbguWJlR+LC0kXP8r4SBEHezIEO0eA7A7FCWxUZoLHyhO+dECB7V3Fh0
   A==;
X-CSE-ConnectionGUID: PrbQclnpQVq9jN08gysTzQ==
X-CSE-MsgGUID: T7jqwKNdQTWsrTu6cn1pIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="260016297"
X-IronPort-AV: E=Sophos;i="6.27,186,1786978800"; 
   d="scan'208";a="260016297"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:50:30 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id C6A9D404812;
	Fri, 30 Oct 2026 10:50:28 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 79CA71000392;
	Fri, 30 Oct 2026 10:50:28 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.203.66])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id EC18C140769F;
	Fri, 30 Oct 2026 10:50:23 +0000 (UTC)
Date: Fri, 30 Oct 2026 19:50:20 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
 <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq5ao6d48dqr.fsf@kernel.org>

On 10/08 20:02, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
> >> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> >> > Will Deacon <will@kernel.org> writes:
> >> >> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
> >> >>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
> >> >>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> >>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
> >> >>> > >  	if (swiotlb_force_disable)
> >> >>> > >  		return SWIOTLB_POOL_NONE;
> >> >>> > >  
> >> >>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> >> >>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> >>> > > +	    !restricted_dma_pool_present)
> >> >>> > >  		return SWIOTLB_POOL_CC_GUEST;
> >> >>> > 
> >> >>> > I think this check on the restricted DMA pool is too general -- the pool
> >> >>> > could be tied to a specific DMA-capable peripheral and so treating its
> >> >>> > presence as a global property isn't right.
> >> >>> 
> >> >>> I agree it's a hack but that was the simplest way to avoid the pVMs
> >> >>> getting a bounce buffer after this patch. More than happy to leave it
> >> >>> out and reduce the buffer on cmdline or we come up with some better
> >> >>> heuristics.
> >> >>
> >> >> Hrm, that does mean that reverting just this part will regress pVMs
> >> >> because they'll suddenly be allocating a tonne more memory for an
> >> >> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
> >> >> series until this has been worked out properly.
> >> >>
> >> >>> Another option could be the arch code passing another flag that it
> >> >>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
> >> >>> don't particularly this either. The arch code doesn't know whether
> >> >>> there's an alternative pool.
> >> >>
> >> >> At that point, the default size may as well be driven by the
> >> >> drivers/virt/coco driver.
> >> >>
> >> >>> That said, such heuristics should have been a separate patch to make it
> >> >>> easier to review/drop.
> >> >>
> >> >> I think the only right way to get a semi-accurate heuristic is to take
> >> >> into account the set of dma-capable devices that will use the swiotlb
> >> >> pool, but that's fiddly and should probably be tackled as a separate
> >> >> series. Maybe a simpler hack in that direction would be to take the
> >> >> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
> >> >> run into the usual problem of not being able to tell if a device is
> >> >> DMA-capable or not, but you could probably look for a global restricted
> >> >> DMA pool and, if that doesn't exist, check for per-device restricted pools
> >> >> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
> >> >> a reasonable approximation.
> >> >
> >> > So, something like this?
> >> >
> >> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> > 	    swiotlb_cc_guest_needs_default_pool())
> >> > 		return SWIOTLB_POOL_CC_GUEST;
> >> >
> >> 
> >> Detecting a DMA-capable device is not straightforward, and if we get it
> >> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
> >> code below be a reasonable approximation of what you suggested?
> >> 
> >> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
> >> weak function that architectures can override. arm64 pKVM could then use
> >> a different scheme (for this patch series default to false). Would that
> >> be preferable?
> >
> > Even the rmem check for each device is still a hack that may bite us in
> > the future (private devices for example would not need swiotlb). I'm
> > thinking more and more of leaving the sizing an arch-specific decision,
> > don't bother generalising it at all.
> >
> > On pKVM vs CCA guests, there's really nothing specific here to pKVM
> > guests. The only difference is that confidential guests that so far have
> > run without a swiotlb buffer will regress if their memory is tight. For
> > confidential guests without dedicated rmem (either CCA or pKVM), I think
> > our options are either command line swiotlb sizing or dynamic swiotlb.
> >
> > Could you respin your series while leaving out the generic sizing? IOW,
> > no x86 code generalisation. We can discuss the best strategy on sizing
> > later (I haven't checked how much of this series still makes sense
> > without the generic sizing).
> >
> 
> It would mostly consist of the first three cleanup patches, followed by
> three patches that replace the addressing_limit argument with flags.
> 
> #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
> /* Initialize a pool for devices with limited DMA addressing. */
> #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
> /* Initialize a pool that requires architecture remapping. */
> #define SWIOTLB_INIT_REMAP		(1 << 2)
> /* Initialize a pool for DMA to memory-encrypted host or guest memory. */
> #define SWIOTLB_INIT_MEM_ENCRYPT		(1 << 3)
> /* Initialize a pool for unaligned kmalloc bouncing. */
> #define SWIOTLB_INIT_KMALLOC		(1 << 4)
> /* Do not initialize a pool unless SWIOTLB is explicitly required. */
> #define SWIOTLB_INIT_DEFAULT_OFF		(1 << 5)
> 
> This results in the large change below. I'm not sure we want to do this
> for no real benefit other than making swiotlb_should_init() slightly
> easier to follow.
> 
> static bool __init swiotlb_should_init(unsigned int flags)
> {
> 	if (swiotlb_force_disable)
> 		return false;
> 
> 	if (swiotlb_force_bounce)
> 		return true;
> 
> 	if (flags & (SWIOTLB_INIT_REMAP | SWIOTLB_INIT_MEM_ENCRYPT)))
> 		return true;
> 
> 	/* Explicit requirements override an architecture's default opt-out. */
> 	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
> 		return false;
> 
> 	return flags & (SWIOTLB_INIT_ADDRESSING_LIMIT | SWIOTLB_INIT_KMALLOC);
> }
>  [...]

Hi Aneesh,

I can reproduce the CCA regression discussed in this thread:
  https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/#t

The guest runs out of SWIOTLB slots, causing disk I/O to fail and
preventing the guest from booting.

I would like to test the fix on real CCA hardware. Could you please Cc
me when you respin the series? I follow LKML, but I may still miss the
posting by chance.

Thanks,
Kohei
