Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE253EC82C;
	Mon, 10 Aug 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371298; cv=none; b=EQs/CE3U0IIw5hfUHVSzV083TvEfRFhWeJqWmKXK/RNyGi/iRRsncOjryI7E6GMm4NOhtOK7zWcPVvLXvX9EIzsJcvJmldWC48CNfzjprCH/3/8a/fsRHiyYvxBNZfQz/eyEdrOtJ3sAktOVkCCdDbmDALEyRxcCeh+LvSR0fp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371298; c=relaxed/simple;
	bh=f0KjkiUVLIfdRbBzyOjBy2QoB9diSFrEw4kN60BEQLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6O1sHQSQ1y3AXKFyFTHnYSgAjjrp0m05rLMP+t1rR3/15ztRW5PHwy9JQWRZzh/jPqa2KL8Wz5tvYiiOouyrd2WI10a8zWg9brhsa0YSIvR+VBJqM/+wnrXy7MWGEH6sYsoDEoAOdPI6jJOdGJz247TCkywphSRIVqhDhqBq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBkTu6+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBkTu6+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E94C1F000E9;
	Mon, 10 Aug 2026 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786371296;
	bh=Cqbq7ocjp5qLqhn6ub1Jz2ULUPz57xxAkQlmliZcS0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FBkTu6+85usDU52Dha/5DQXVxWOENVS7yKDU9Ofdw3/oCPIg8ZLLUDSMcKrnVSP9L
	 f3c2cikYrYuD545fo9Hujadnw/NDojGZoRhVIg9Jw3Posb1ONG7re4pg3rkKq4FDSi
	 +veUdAwky9ShQkN2t7ZmYRCR2su1bedXoyHeAfhfydhcQAYdnKuNH0K4+OncmDgbXR
	 c0VrUqERtZN0kZ8GV6c/ch6F0MNItNaGkFJrLo0roy86L4K6/lG4uLnvSgbdwglunP
	 MNHEtAN3z1+wuwpt11fYQGr3o9Sd77LRs1gJTjf1yjJVk7tzduLbddd70pQP+LLyoY
	 mmQse+6xWKhIg==
Date: Mon, 10 Aug 2026 15:14:47 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Message-ID: <annc1ynWUsWQc4JM@willie-the-truck>
References: <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
 <20260810130818.GN200537@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810130818.GN200537@ziepe.ca>

On Mon, Aug 10, 2026 at 10:08:18AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
> > On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> > > On 10.08.2026 12:20, Will Deacon wrote:
> > > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> > > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> > > >>
> > > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> > > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> > > >>>>> But the whole thing is best effort anyway, the kernel picks
> > > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> > > >>>>> how many devices or how much DMA they do.
> > > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> > > >>>>> that as it would be the other way around and users would have to
> > > >>>>> decrease it manually.
> > > >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> > > >>>> it should be done in common code and, yes, we are probably going to
> > > >>>> have to do something alot smarter to have the common code better
> > > >>>> auto-tune this for the CC case..
> > > >>> What about the $subject patch? I assume that it is still needed to
> > > >>>
> > > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> > > >>>
> > > >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> > > >>>
> > > >>> paths?" patchset?
> > > >>>
> > > >> I would request that we pick this patch to fix the regression described
> > > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > > > I really don't think we need it. CCA hardware isn't exactly widespread
> > > > and the KVM host side patches don't appear close to being merged.
> > > 
> > > Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?
> 
> Let's not make progress on guest support contingent on KVM CCA host
> side patches please. I expect the CSPs will have VM instance types
> available based on CCA within quarters, and Linux as a Guest should
> work in those environments regardless of what KVM is doing. I don't
> really expect full KVM support for years, frankly, the patchset is
> massive. Even Intel and AMD don't have full KVM support yet.

To be clear: the only part I'm pushing back on is the realm-specific hack
to size the SWIOTLB area in arch/arm64/. Even with that hack applied, I
don't believe a one-size-fits-all value is going to work for everybody,
so it was really great to see that special-case removed in:

https://lore.kernel.org/all/20260717180442.110954-18-aneesh.kumar@kernel.org/

but now, because it regresses some test configuration, the proposal was
to penalise protected VMs too (bearing in mind that the patch above
hasn't yet landed upstream):

https://lore.kernel.org/all/20260807092612.2202005-1-aneesh.kumar@kernel.org/

with the alternative being to reintroduce the original hack that we
just removed!

https://lore.kernel.org/all/yq5acxvu2ict.fsf@kernel.org/

I'm saying: merge the patches as they are, without reintroducing this
horrible bodge in the architecture code to drive a heuristic that most
people seem to agree should be handled more robustly elsewhere.

> People already have CCA capable HW, are already testing this stuff and
> the closer upstream can get to being workable as a guest without a
> mountain of OOT patches the better.

This specific part is about a single line of code, to control something
which is already configurable in Kconfig and on the cmdline. It's not
a mountain of out-of-tree patches.

> I agree the thing is not ideal, but it was merged to ARM like this a
> long time ago, this patch is just fixing a small oopsie (was it a
> merge conflict?) to put it back. I don't the objection.

My main objection is that I have very little confidence in people trying
to fix this properly if we take the realm-specific bodge in the arch
code. With all the CCA patches floating about already, why would they?

Will
