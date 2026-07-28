Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073542A792;
	Tue, 28 Jul 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241922; cv=none; b=pR0kVDRKUjtCLbApI//44et+i37DRbbSlFxeeB0aIZqOd7dadOeDj1qKCs7hvmimxXvJb8BXtgj1vZHPJH8mjSY++BTIPwT68QmSASSWMZLnjaOjDWU/QY9tcfzd85wdYPShjnn0VAR7FmmxGoKjfWa9/ssO2Dm9zKO7pWxyjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241922; c=relaxed/simple;
	bh=DwDX6DQL7cMvuolyolXtePjrRKyhuxkkJnirH8faXg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKLEcrpHLH8vtEzg7N5CprhJfWC2rFLMmW5wXnRDd8INJ4y8hfRbvaNjHbMBJO89kP3Sx5SLSC1Rcc1lqzLMKOqGnJ6cdUf4dc9otmkMM2jpchEJVDBlAGLoPc2LxXwKdJqTU2UucbA52Xv7r7/5WiSjH5XdmS+tLfKMVA9K69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEM01trD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEM01trD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E771F000E9;
	Tue, 28 Jul 2026 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241920;
	bh=lSkwhKAcEsyJqT/0xqVJXtxYxIXWD0v9uCPSjTmMF2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WEM01trD462HpzukrLQzJYedOMo/krm72PvzqlsPIr95pA22pK97BItUkKTq0RiE1
	 BafhKgnPLjt9aVTzvU1dFa7RMbB40i5ZGyvy+Uq+GD3nlFNKGJAlh6v5YCczVVs88W
	 XLgMqJmGuxCudWp7Pe+Yi+kgsFNJVH9ZJXfZCAW/9lfgbs+iqFLXWZDleq9blMw7mP
	 +MH5pd841sVe9ss5f/WYkSBvsx7eS76Efavuj5k30SQrM2EWKd6eLiQqbz9Kr4x/nz
	 YGdV+Rm3lqSrOuShxDdIBjk4LGOrgQZRl5vevgtv94weDxSm1UhqL4Mz6Y3mDajtlK
	 HdSaygY48BoeQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
In-Reply-To: <20260726081753.GD12003@unreal> (Leon Romanovsky's message of
	"Sun, 26 Jul 2026 11:17:53 +0300")
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
	<20260717180442.110954-2-aneesh.kumar@kernel.org>
	<20260721115456.GI110966@unreal> <yq5atsps77c5.fsf@kernel.org>
	<20260721142921.GN110966@unreal> <yq5ao6g0750v.fsf@kernel.org>
	<20260721153321.GO110966@unreal> <amEhEKQW0_HJ9cLN@ziepe.ca>
	<20260723075704.GC110966@unreal> <amTJY_CdE-uDgoGG@ziepe.ca>
	<20260726081753.GD12003@unreal>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 28 Jul 2026 18:01:45 +0530
Message-ID: <yq5ah5ljjnwu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Romanovsky <leon@kernel.org> writes:

> On Sat, Jul 25, 2026 at 11:34:11AM -0300, Jason Gunthorpe wrote:
>> On Thu, Jul 23, 2026 at 10:57:04AM +0300, Leon Romanovsky wrote:
>> > On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
>> > > On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
>> > > 
>> > > > Something like, but probably void* needs to be phys_addr_t:
>> > > > 
>> > > > static inline struct page *dma_phys_to_page(void *addr)
>> > > > {
>> > > > #ifdef CONFIG_DMA_DIRECT_REMAP
>> > > > 	return vmalloc_to_page(addr);
>> > > > #else
>> > > > 	return virt_to_page(addr);
>> > > > #endif
>> > > > }
>> > > 
>> > > I don't like this, we don't know for sure the addr will be in a vmap
>> > > and this will fail if it isn't.
>> > 
>> > Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
>> > relevant for addresses acquired from pool.
>> 
>> Yeah, but I still don't like it :) It is hard to follow if you make
>> those kinds of leaps, someone will call this new helper on something
>> they shouldn't
>
> This issue is straightforward to address today. Limit the scope, use
> an appropriate function name, and add a comment indicating that the
> function is local to and specific to the pool. The latter helps
> AI-based review tools flag incorrect usage outside the intended scope.
>
>> 
>> > dma_phys_to_page() is a bad name for some low-level conversion function.
>> > It needs to be internal to DMA logic, in the level when we convert from
>> > phys to page.
>> 
>> I think we should not convert from phys to page, that's also easy to
>> do wrong
>
> Perhaps I'll reiterate my complaint. DMA internals are already hard to
> understand. Part of that complexity is necessary to support every
> possible use case, but another part comes from a maze of types that is
> entirely self-inflicted. I think this code only makes the latter worse.
>
> Currently, the phys type universally describes memory and can be
> reliably translated into any required representation. It is the most
> fundamental type we have.
>

I think we can address the suggested changes as a follow-up patch series
on top of this.

How about we get this picked up for the next merge window first, so that
we can get the CC_SHARED related changes in? The follow-up changes
should be easier once we have agreement on the overall design, and can
then be done as incremental cleanups.

-aneesh
