Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA13C769B;
	Mon, 10 Aug 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362421; cv=none; b=oVucKmTTnkxxlQVuztF8uJJVaCZpkARpxkBbJ5ORykNpU+GjBumGC/vZSDd0kBxGKCvQic7ydMqWGlIgVmLawaAlcfiq2YbEOvtnKg/WdKZ2fopAZ/Cr7AyspSP7SOPxWHIP9w6UWYlxfcU+WagQCmD1hARoWJ1/9ehyBrsAIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362421; c=relaxed/simple;
	bh=BQbJ5bc2a0t3ZQzMw4ZBOXIyFfTFHGJfHhVg4sJJmjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZKjUNnqgTYmiuv/bKA7qFyBYeb4did9gLfIjG1QJUIKIKmiZHMXwlf908M10GO7yzdpbudz+aMHVZkAgfnIbeA9fub3KwyZjYWVuzR8q+yL5gQQIu3duQIatUqNbJa+cOncA8nNahbpUxcUO0z2zKlVH7gzwV+4/xZA9EZvUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdqOARlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdqOARlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455F1F000E9;
	Mon, 10 Aug 2026 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362419;
	bh=fCRqoeWNWtgyOE15SAxF1YS8N0xnzH3d7d2rFiQqAvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZdqOARlqNVXG2WPdY64KIFiiHy7+iL34WY5SFGKkpbDKTPzoxcrf8GlztQOTzotYK
	 Kg5HPHwLV+5NhAnFpPy2M0d3tpks7urO5LVdtaYhr6+MuPr6zb4pRlRwSp3hiSM9Aj
	 vCAxgQFWgzY6cDHelMHj4C/jXVkJj7f+QtrE7Yt3Gg22QfoyAeZM99oD0he866L/DY
	 F2KZG03kM1xVZJQxLaqFMXnxi4i4KMM/sYLsNWaGEVRErraJAxad6KiDUUDo+NPuEt
	 O2mzWp+GVkyfqSfgZBJpiQWioD1g/jvLk6/XCtjYgdXIs9llPpIPtA7fDAT8VOn/Ix
	 ydjL4LdODFn+Q==
Date: Mon, 10 Aug 2026 12:46:51 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
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
Message-ID: <anm6K2umtx4iKnyZ@willie-the-truck>
References: <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>

On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> On 10.08.2026 12:20, Will Deacon wrote:
> > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> >>
> >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> >>>>> But the whole thing is best effort anyway, the kernel picks
> >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> >>>>> how many devices or how much DMA they do.
> >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> >>>>> that as it would be the other way around and users would have to
> >>>>> decrease it manually.
> >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> >>>> it should be done in common code and, yes, we are probably going to
> >>>> have to do something alot smarter to have the common code better
> >>>> auto-tune this for the CC case..
> >>> What about the $subject patch? I assume that it is still needed to
> >>>
> >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> >>>
> >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> >>>
> >>> paths?" patchset?
> >>>
> >> I would request that we pick this patch to fix the regression described
> >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > I really don't think we need it. CCA hardware isn't exactly widespread
> > and the KVM host side patches don't appear close to being merged.
> 
> Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?

Argh, no, I'm definitely planning to send that!

I'm just saying that this specific fixup patch (which is a PATCH sent
in reply to another patch in the middle of a series...):

https://lore.kernel.org/all/20260807092612.2202005-1-aneesh.kumar@kernel.org/

isn't something we should take for the upcoming merge window. There are
better, alternative ways to tackle the issue (as discussed in the thread)
and it's really not as urgent as Aneesh is trying to make it sound.

Will
