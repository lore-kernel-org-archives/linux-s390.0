Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022430C171;
	Fri,  3 Jul 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098825; cv=none; b=AET21w20uutvhVyNk+eUvB+XPJeqjxYJWuSZqRh6g9TaWFjWR2n/X2O4nCQTNdf7kdimAM8NZuhmASjsi+mR8EZknKUjCQ5JHKolGXK2v4Q4l1XTGaIRCVzcie5HVhB2M+N5mBzyewrnPe7iansOpzG2qF7kxIuOJO0cjRlImKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098825; c=relaxed/simple;
	bh=Vvmk2HuSS/Wvh1QlILkzQj7MRAp2VsFVroeY2nSJGsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZderAe55q8FkaEXKYJDpMrI+oSwMkyX+GENwcSUQtR590iNqbrsNjXT6BWmLufFL64uDOywrIYD0wUi+wLhvbOocc12/pnwEvjpTfjKydNQX8ReM6y5IpN5sO7PFm1r4+Csb/fA/AvNO724Tj3jZ6k6lg/hl6sJ1FbUTaNXJcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4enwm4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4enwm4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB2F1F000E9;
	Fri,  3 Jul 2026 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783098824;
	bh=q23BIidiZ017iKhXJsbogBQ9PJP1zUIVfxmZpJ2jL8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4enwm4svtwtT15ZA13jyA9qwc9lTppZoLAqvOXFJBuu8Kf5+n3us4YU1h9YquIQ5
	 ZJzaMwvXvLV4y1YTzZTccXJTXIqFY7kVs1R7t1Xlwnq201NEMIOKid+EEmnkxiSMSi
	 GNi/uX7pe9g5oOTx6OwStKk2v/qCkvdBHEwH1xGl+ZPu9h6p/ywnZRCLOOmca4YyDa
	 svZYQ2arPoNcRi94A2S6PIqz9+mr1jy1vobmXh+nOQmN5VkPCJckI573GfqHv+OilP
	 Bm5MnNHsTToXJBO1LQvI4FYubASQDDOLIaRxh4CJS3U0VT2ZmBr02kU8SnnEr3qzmp
	 fkqPwnkZrA6Ww==
Date: Fri, 3 Jul 2026 18:13:31 +0100
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, Chun Ng <chunn@nvidia.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Message-ID: <akftuw9NyRy36fXA@willie-the-truck>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck>
 <akZkuwktaXFTrASP@orome>
 <akaSJ5D98w2cHqb6@orome>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akaSJ5D98w2cHqb6@orome>

On Thu, Jul 02, 2026 at 06:41:23PM +0200, Thierry Reding wrote:
> On Thu, Jul 02, 2026 at 03:46:44PM +0200, Thierry Reding wrote:
> > On Thu, Jul 02, 2026 at 10:18:47AM +0100, Will Deacon wrote:
> > > On Wed, Jul 01, 2026 at 06:08:15PM +0200, Thierry Reding wrote:
> > > > From: Chun Ng <chunn@nvidia.com>
> > > > 
> > > > Add helpers to swap PROT_NORMAL and PROT_DEVICE_nGnRnE protection bits
> > > > on a kernel-linear-map range.
> > > 
> > > That sounds like a really terrible idea. Why is this necessary and how
> > > does it interact with things like load_unaligned_zeropad()?
> > 
> > This is necessary because once the memory controller has walled off the
> > new memory region the CPU must not access it under any circumstances or
> > it'll cause the CPU to lock up (I think technically it'll hit an SError
> > but in practice that just means it'll freeze, as far as I can tell).
> > 
> > Probably doesn't interact well at all with load_unaligned_zeropad().
> > 
> > > I think you should unmap the memory from the linear map and memremap()
> > > it instead.
> > 
> > Given that the memory can never be accessed by the CPU after the memory
> > controller locks it down, I don't think we'll even need memremap(). The
> > only thing we really need is the sg_table we hand out via the DMA BUFs
> > so that they can be used by device drivers to program their DMA engines
> > internally.
> > 
> > Looking through some of the architecture code around this, shouldn't we
> > simply be using set_memory_encrypted() and set_memory_decrypted() for
> > this? While they might've been created for slightly other use-cases,
> > they seem to be doing exactly what we want (i.e. remove the page range
> > from the linear mapping and flushing it, or restoring the valid bit and
> > standard permissions, respectively).
> 
> Ah... I guess we can't do it because we're not in a realm world and so
> the early checks in __set_memory_enc_dec() would return early and turn
> it into a no-op.
> 
> How about if I extract a common helper and provide set_memory_p() and
> set_memory_np() in terms of those. Those are available on x86 and
> PowerPC as well, so fairly standard. I suppose at that point we're
> closer to set_memory_valid().

Why not just call set_direct_map_invalid_noflush() +
flush_tlb_kernel_range() for each page? We already have APIs for this.

The big challenge I see with any linear map manipulation, however, is
that it will rely on can_set_direct_map() which likely means you need to
give up some performance and/or security to make this work. Does memory
become inaccesible dynamically at runtime? If not, the best bet would
be to describe it as a carveout in the DT and mark it as "no-map" so
we avoid mapping it in the first place.

Will
