Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793506634;
	b=YqiKp+h3dWFCZ6TG9e5sizqHPKQb0XJ3SQqobV1lb4e2S2KLP29zKQAL+j//9OTRW0HO
	 vRzS4znXXoRqpENfRdKWGYalpuq+LcP3u901oExt1sk47wr68foiQb4GfzaL706ivLl8P
	 YNywpM5C+SpIqMBKpmf9T5GPxfQxLQXQ4AX5CxdqljmIJimKWlN5miRtJ3D8TfrTPrt7w
	 rzDDKfzq1dUzTJVpINWbu9mNYTSrivmkSIejPKWZg/g/Yz5Uz0SkpH7BypWPklWYcAINO
	 n+hsaTmCM6z+Be4e+Si0TFlDImmFYGiRoLhyT9bkr/DjVku11zhfavR3ys1ZscuJM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793506634;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=mUqu+6HsBuPxnZ0xvfhrdFnRGtvir4qjhgMAVr4T9Ko=;
	b=TZsF4WtDpQtIBUQco5CYMqf7pyMAN2hcLnT70ccOgCAWICdFxn5dxyCiDWPciakeScyr
	 R7r98aQtjDyr/1iC5ooNac1yADZB+JPfPbckmeRbUSrspkE8F/8YkYnjaNCLiKAI/Atmm
	 fj8qJ6rYAG/xhW6c1Jo3X6/ChZL5/FAdwpTN19i9xXFtexMQ2f3AfW8Iw2+VIqQGIIpGF
	 ixK8p/f/0ExwhB1SNCP42xNAL32Wm1CXiPcFHfyg9lkZbEpBb/p3afdt1iwmkVPrkqo93
	 dXml2ExgRnbVik1lkmKbWKsZxCz2mkfAb1X7GirwLhPZBp7N1NlUi0mHkPCma8gABKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szc8bvtd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0C606A324;
	Sun,  1 Nov 2026 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szc8bvtd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3681F000C1;
	Sun,  1 Nov 2026 04:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793506633;
	bh=mUqu+6HsBuPxnZ0xvfhrdFnRGtvir4qjhgMAVr4T9Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Szc8bvtdgyfePD3Lcy+welmLY8PIM/MtSN+SWIMLPjyxSAUjFYbtzX/kg/Gk5W6ob
	 AYPG16F5BppYWK28ekq6B4oHkbVsa+lhdlIX9kk2K7luf1zP8bvyIiQlN7cxKLefnz
	 AoI6Ac242CTEeqI3aifav4i4kabOUAzpWrpQTkliA8ZqivaSs5YfaonNvidpfoWMJa
	 6jPJ8xnrDXxGgY7hl5m0qHxKAk5XJempL3eDIBY50vaX+CFknAYUnPM1R+RrTcypkl
	 ukEcKPlOK+p0kKrGynfvdOLrmP1tOsJWpENln+kYeylBrjzAxWzp/+bUv9vsW/XkIc
	 9w+/Glq+JuypQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org> <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org> <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
Date: Sun, 01 Nov 2026 09:47:05 +0530
Message-ID: <yq5a8q3d9oe6.fsf@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kohei Enju <enju.kohei@fujitsu.com> writes:

> On 10/08 20:02, Aneesh Kumar K.V wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> 
>> > On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
>> >> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>> >> > Will Deacon <will@kernel.org> writes:
>> >> >> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>> >> >>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>> >> >>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> >>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>> >> >>> > >  	if (swiotlb_force_disable)
>> >> >>> > >  		return SWIOTLB_POOL_NONE;
>> >> >>> > >  
>> >> >>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> >> >>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> >>> > > +	    !restricted_dma_pool_present)
>> >> >>> > >  		return SWIOTLB_POOL_CC_GUEST;
>> >> >>> > 
>> >> >>> > I think this check on the restricted DMA pool is too general -- the pool
>> >> >>> > could be tied to a specific DMA-capable peripheral and so treating its
>> >> >>> > presence as a global property isn't right.
>> >> >>> 
>> >> >>> I agree it's a hack but that was the simplest way to avoid the pVMs
>> >> >>> getting a bounce buffer after this patch. More than happy to leave it
>> >> >>> out and reduce the buffer on cmdline or we come up with some better
>> >> >>> heuristics.
>> >> >>
>> >> >> Hrm, that does mean that reverting just this part will regress pVMs
>> >> >> because they'll suddenly be allocating a tonne more memory for an
>> >> >> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>> >> >> series until this has been worked out properly.
>> >> >>
>> >> >>> Another option could be the arch code passing another flag that it
>> >> >>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>> >> >>> don't particularly this either. The arch code doesn't know whether
>> >> >>> there's an alternative pool.
>> >> >>
>> >> >> At that point, the default size may as well be driven by the
>> >> >> drivers/virt/coco driver.
>> >> >>
>> >> >>> That said, such heuristics should have been a separate patch to make it
>> >> >>> easier to review/drop.
>> >> >>
>> >> >> I think the only right way to get a semi-accurate heuristic is to take
>> >> >> into account the set of dma-capable devices that will use the swiotlb
>> >> >> pool, but that's fiddly and should probably be tackled as a separate
>> >> >> series. Maybe a simpler hack in that direction would be to take the
>> >> >> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
>> >> >> run into the usual problem of not being able to tell if a device is
>> >> >> DMA-capable or not, but you could probably look for a global restricted
>> >> >> DMA pool and, if that doesn't exist, check for per-device restricted pools
>> >> >> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
>> >> >> a reasonable approximation.
>> >> >
>> >> > So, something like this?
>> >> >
>> >> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> > 	    swiotlb_cc_guest_needs_default_pool())
>> >> > 		return SWIOTLB_POOL_CC_GUEST;
>> >> >
>> >> 
>> >> Detecting a DMA-capable device is not straightforward, and if we get it
>> >> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
>> >> code below be a reasonable approximation of what you suggested?
>> >> 
>> >> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
>> >> weak function that architectures can override. arm64 pKVM could then use
>> >> a different scheme (for this patch series default to false). Would that
>> >> be preferable?
>> >
>> > Even the rmem check for each device is still a hack that may bite us in
>> > the future (private devices for example would not need swiotlb). I'm
>> > thinking more and more of leaving the sizing an arch-specific decision,
>> > don't bother generalising it at all.
>> >
>> > On pKVM vs CCA guests, there's really nothing specific here to pKVM
>> > guests. The only difference is that confidential guests that so far have
>> > run without a swiotlb buffer will regress if their memory is tight. For
>> > confidential guests without dedicated rmem (either CCA or pKVM), I think
>> > our options are either command line swiotlb sizing or dynamic swiotlb.
>> >
>> > Could you respin your series while leaving out the generic sizing? IOW,
>> > no x86 code generalisation. We can discuss the best strategy on sizing
>> > later (I haven't checked how much of this series still makes sense
>> > without the generic sizing).
>> >
>> 
>> It would mostly consist of the first three cleanup patches, followed by
>> three patches that replace the addressing_limit argument with flags.
>> 
>> #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
>> /* Initialize a pool for devices with limited DMA addressing. */
>> #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
>> /* Initialize a pool that requires architecture remapping. */
>> #define SWIOTLB_INIT_REMAP		(1 << 2)
>> /* Initialize a pool for DMA to memory-encrypted host or guest memory. */
>> #define SWIOTLB_INIT_MEM_ENCRYPT		(1 << 3)
>> /* Initialize a pool for unaligned kmalloc bouncing. */
>> #define SWIOTLB_INIT_KMALLOC		(1 << 4)
>> /* Do not initialize a pool unless SWIOTLB is explicitly required. */
>> #define SWIOTLB_INIT_DEFAULT_OFF		(1 << 5)
>> 
>> This results in the large change below. I'm not sure we want to do this
>> for no real benefit other than making swiotlb_should_init() slightly
>> easier to follow.
>> 
>> static bool __init swiotlb_should_init(unsigned int flags)
>> {
>> 	if (swiotlb_force_disable)
>> 		return false;
>> 
>> 	if (swiotlb_force_bounce)
>> 		return true;
>> 
>> 	if (flags & (SWIOTLB_INIT_REMAP | SWIOTLB_INIT_MEM_ENCRYPT)))
>> 		return true;
>> 
>> 	/* Explicit requirements override an architecture's default opt-out. */
>> 	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
>> 		return false;
>> 
>> 	return flags & (SWIOTLB_INIT_ADDRESSING_LIMIT | SWIOTLB_INIT_KMALLOC);
>> }
>>  [...]
>
> Hi Aneesh,
>
> I can reproduce the CCA regression discussed in this thread:
>   https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/#t
>
> The guest runs out of SWIOTLB slots, causing disk I/O to fail and
> preventing the guest from booting.
>
> I would like to test the fix on real CCA hardware. Could you please Cc
> me when you respin the series? I follow LKML, but I may still miss the
> posting by chance.
>

The conclusion was to either use CONFIG_SWIOTLB_DYNAMIC or swiotlb kernel command line
option

-aneesh
