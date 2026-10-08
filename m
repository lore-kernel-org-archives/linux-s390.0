Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F449E5DE;
	Thu,  8 Oct 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463911; cv=none; b=l1rw3vT9aBKEIiRf1lZMz5msfImZPrkfFf5mZ92gqwfVuMbdpqaK23H3LInmhPzPDHDLYyj33Z3s89OdSmVj6djL1GaKWd344Trn7PTxNULkwIwm0bM/ep1fQo7DavIhkE0fWpK3mu+El9BwWGLKWhIpaaes+1DVRuLYhM7Zxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463911; c=relaxed/simple;
	bh=yybsjxVTbzd8fZs72yNrXHsa7ZAel783Veu0/ZplOjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTrtNbkNd0y/0Hz0z1s91vLENHjfhuBN4BqsEccCqoDq8/e2IuNhFKtvk2FHJJB24eCx2ZZpVavWeRYnJZgH/i2vvkiGstcXFKB0/XGw0XADfzkbUwPjbEEhvHU4t6LJknPXlQQWz1BOkgH+KuKFUZI8oTikFm3um6hs7nAb+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jHcYeO7P; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jHcYeO7P"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD321516;
	Thu,  8 Oct 2026 05:51:43 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385483F66F;
	Thu,  8 Oct 2026 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791463907; bh=yybsjxVTbzd8fZs72yNrXHsa7ZAel783Veu0/ZplOjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHcYeO7PQ4uywop/cdz4Sp+A+aFbl0MgQD1Ls+p5EdipEXi6WD0t37Ph73w/vv0DU
	 zaE58iHLndSo+/C52KBqYxok8UD7CtjGoRjaBmsWgfa74P8A2xQIUgYTR13WaYMyPN
	 MJYzbhW+p/gSjdnlF9y+DSqgMqvawjjqEWGiXB4w=
Date: Thu, 8 Oct 2026 13:51:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <aseRzPshcoys7AJS@arm.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5av77c92oo.fsf@kernel.org>

On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> > Will Deacon <will@kernel.org> writes:
> >> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
> >>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
> >>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
> >>> > >  	if (swiotlb_force_disable)
> >>> > >  		return SWIOTLB_POOL_NONE;
> >>> > >  
> >>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> >>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >>> > > +	    !restricted_dma_pool_present)
> >>> > >  		return SWIOTLB_POOL_CC_GUEST;
> >>> > 
> >>> > I think this check on the restricted DMA pool is too general -- the pool
> >>> > could be tied to a specific DMA-capable peripheral and so treating its
> >>> > presence as a global property isn't right.
> >>> 
> >>> I agree it's a hack but that was the simplest way to avoid the pVMs
> >>> getting a bounce buffer after this patch. More than happy to leave it
> >>> out and reduce the buffer on cmdline or we come up with some better
> >>> heuristics.
> >>
> >> Hrm, that does mean that reverting just this part will regress pVMs
> >> because they'll suddenly be allocating a tonne more memory for an
> >> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
> >> series until this has been worked out properly.
> >>
> >>> Another option could be the arch code passing another flag that it
> >>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
> >>> don't particularly this either. The arch code doesn't know whether
> >>> there's an alternative pool.
> >>
> >> At that point, the default size may as well be driven by the
> >> drivers/virt/coco driver.
> >>
> >>> That said, such heuristics should have been a separate patch to make it
> >>> easier to review/drop.
> >>
> >> I think the only right way to get a semi-accurate heuristic is to take
> >> into account the set of dma-capable devices that will use the swiotlb
> >> pool, but that's fiddly and should probably be tackled as a separate
> >> series. Maybe a simpler hack in that direction would be to take the
> >> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
> >> run into the usual problem of not being able to tell if a device is
> >> DMA-capable or not, but you could probably look for a global restricted
> >> DMA pool and, if that doesn't exist, check for per-device restricted pools
> >> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
> >> a reasonable approximation.
> >
> > So, something like this?
> >
> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > 	    swiotlb_cc_guest_needs_default_pool())
> > 		return SWIOTLB_POOL_CC_GUEST;
> >
> 
> Detecting a DMA-capable device is not straightforward, and if we get it
> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
> code below be a reasonable approximation of what you suggested?
> 
> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
> weak function that architectures can override. arm64 pKVM could then use
> a different scheme (for this patch series default to false). Would that
> be preferable?

Even the rmem check for each device is still a hack that may bite us in
the future (private devices for example would not need swiotlb). I'm
thinking more and more of leaving the sizing an arch-specific decision,
don't bother generalising it at all.

On pKVM vs CCA guests, there's really nothing specific here to pKVM
guests. The only difference is that confidential guests that so far have
run without a swiotlb buffer will regress if their memory is tight. For
confidential guests without dedicated rmem (either CCA or pKVM), I think
our options are either command line swiotlb sizing or dynamic swiotlb.

Could you respin your series while leaving out the generic sizing? IOW,
no x86 code generalisation. We can discuss the best strategy on sizing
later (I haven't checked how much of this series still makes sense
without the generic sizing).

-- 
Catalin
