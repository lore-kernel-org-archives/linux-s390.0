Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140534908AF;
	Sun, 26 Jul 2026 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053881; cv=none; b=tNddoPadMCG0Znq5rY9FFk+pP08kmRELKjnn5hOCHwGfDpf24fzoT3T+mb1Aq+p000lF+rA8sXtxVGycU76p9pHiBhQmknPzgRDMshwBznxUmkJynBjh3mfMyDnKiMwyesphFrxQtk2euLMD5y5qHCOtQoksDE4a/feeUJ1VuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053881; c=relaxed/simple;
	bh=Bq7TX5r/SEKAEn6WaogmmDe5TBWyV2LVNfH02ZXTnXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwSgbSWnFCdBhv2jJuPZope5M339uxeUw7Dm/3l9KTiNF9+yk4+rfRplz2TwXmkL1N3GbXStvpIi+AGhPNzHvDoN/1tRL8vKroGzE2kdrW40Kadwpdb8yO4YCz4W48fYGn1jUt6t+ylmxe/MKcsHvnkkFoXQYQs5WjBMrBkeB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSh6v7Ln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSh6v7Ln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CAF1F000E9;
	Sun, 26 Jul 2026 08:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785053879;
	bh=rV3KV7vBjyfzuXzvKP70K3FcZTJiIsGPcCYGDQB6sAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSh6v7LnboLYO6xF16A2+7oGN8HoXODtGw5S8YO/FkrMU2s6CN6sTfDR1dR/lfKoz
	 2qUJFoixbeZXmsG6d/uilEjj2PxxfrzsGPE5BQ6jhQ7HBFfdBcaRGpQouUb6azeUgi
	 n34cs0woLHoRxqtxV+r8p4J5+gDE7MQ2o8/RgCRL+DPKTM2UP/nwvcwVwn7QnpLOsV
	 UEkEXGiiy6JDqh7Ys0iN1ikcBqAGMSkjH68/0zQ4NQTKpbdrGGQ02iEM4JloZieZQY
	 oOKoUoPlmPX5blblYslJfGJhkNgUevihiOHrfRA+gi9U3BaHvOnD+uI6bcD17dyw+v
	 MOsVc9tnoXHPw==
Date: Sun, 26 Jul 2026 11:17:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
Message-ID: <20260726081753.GD12003@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
 <amTJY_CdE-uDgoGG@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amTJY_CdE-uDgoGG@ziepe.ca>

On Sat, Jul 25, 2026 at 11:34:11AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2026 at 10:57:04AM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
> > > 
> > > > Something like, but probably void* needs to be phys_addr_t:
> > > > 
> > > > static inline struct page *dma_phys_to_page(void *addr)
> > > > {
> > > > #ifdef CONFIG_DMA_DIRECT_REMAP
> > > > 	return vmalloc_to_page(addr);
> > > > #else
> > > > 	return virt_to_page(addr);
> > > > #endif
> > > > }
> > > 
> > > I don't like this, we don't know for sure the addr will be in a vmap
> > > and this will fail if it isn't.
> > 
> > Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
> > relevant for addresses acquired from pool.
> 
> Yeah, but I still don't like it :) It is hard to follow if you make
> those kinds of leaps, someone will call this new helper on something
> they shouldn't

This issue is straightforward to address today. Limit the scope, use
an appropriate function name, and add a comment indicating that the
function is local to and specific to the pool. The latter helps
AI-based review tools flag incorrect usage outside the intended scope.

> 
> > dma_phys_to_page() is a bad name for some low-level conversion function.
> > It needs to be internal to DMA logic, in the level when we convert from
> > phys to page.
> 
> I think we should not convert from phys to page, that's also easy to
> do wrong

Perhaps I'll reiterate my complaint. DMA internals are already hard to
understand. Part of that complexity is necessary to support every
possible use case, but another part comes from a maze of types that is
entirely self-inflicted. I think this code only makes the latter worse.

Currently, the phys type universally describes memory and can be
reliably translated into any required representation. It is the most
fundamental type we have.

Thanks

> 
> Jason
> 
