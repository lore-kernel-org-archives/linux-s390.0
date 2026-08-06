Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918193AA4E2;
	Thu,  6 Aug 2026 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032552; cv=none; b=dl2yEACu4yXb/PNidDl3ZfSz+Q9kkKorr2vGPgNWfmbrPopVgKoZfU/N3IzEqwcaaUkSmlyA12dADUsq6widAtjXlc6x1s47uq2d4HzRHeWoSXoI4pv1czxLYNqSII3VSw+IdddIDBq9/SFiDPNklGW99oALiRVg2gaDvPcyj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032552; c=relaxed/simple;
	bh=J1mmhRLKDxaELj7616F3jLYF/axUtWF1l/JEzzjmppo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZc0h6Ey93RKvXjo7szZouQSPCVLcsOx5DJesSSHhTCcYv4BcIvB7hJOWxaGmurYV1wSrzLD2EzrEj/zEyZRYh3UbGH218x7CczU2r9/jBy8BYIdzoFZjqSQaUIEMBPWXCRurlJUgGd+WNa9gWZRN3/goyvgVasf5G3tu2VE5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKNEIVai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKNEIVai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4651F00A3E;
	Thu,  6 Aug 2026 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032551;
	bh=J1mmhRLKDxaELj7616F3jLYF/axUtWF1l/JEzzjmppo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kKNEIVaiVH4wrn5oHK5ajPxUnFHB9+4/A/1LvM/uKTkDc0Tv9t57ZG0ITr9wXU8Xp
	 dM7Cy6hGgHbZ/yeYTfWQ71Y57HgqRdmv1eKN2HCcuSEE4ilC3CtyGNaMO6veI78U67
	 YcMqItiqFW5t/eUfTLQayfOrEOELuT08s9jUqHMsWIlKuGRS7h4T2GXPWrf4X6w2Zv
	 tNNgofe3iP7rxX22Z7nlivDoSEEfrD+/jWedR6As/aEKkVkXWpqV8mSDDYNCbarkZ1
	 SVWiBIPcCxOreaWD7DyyAbxr2eCgQZMraKPZN7mkuyWcqW1KUCi9T1+4s4zx6S89Zo
	 2vOjrgZWIe6og==
Date: Thu, 6 Aug 2026 18:09:08 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
Message-ID: <anSuYvj1JU5K8xUO@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <CGME20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c@eucas1p1.samsung.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
 <3f47aeab-33b1-4966-a5ce-5d6d5261e0e2@samsung.com>
 <e212caac-6c30-448a-9e10-32fff8b842f6@kernel.org>
 <83e5e74d-7106-4e14-9d10-56438372f6a3@samsung.com>
 <ak_E4UxfnFJywJa7@orome>
 <1eec88e6-1ea8-4525-bb17-e41444d715dc@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awe2ln3pvo2iqnm5"
Content-Disposition: inline
In-Reply-To: <1eec88e6-1ea8-4525-bb17-e41444d715dc@samsung.com>


--awe2ln3pvo2iqnm5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
MIME-Version: 1.0

On Thu, Jul 16, 2026 at 12:43:56PM +0200, Marek Szyprowski wrote:
> On 09.07.2026 17:59, Thierry Reding wrote:
> > On Thu, Jul 09, 2026 at 07:56:45AM +0200, Marek Szyprowski wrote:
> >> On 08.07.2026 10:35, David Hildenbrand (Arm) wrote:
> >>> On 7/7/26 12:02, Marek Szyprowski wrote:
> >>>> On 01.07.2026 18:08, Thierry Reding wrote:
> >>>>> From: Thierry Reding <treding@nvidia.com>
> >>>>>
> >>>>> There is no technical reason why there should be a limited number o=
f CMA
> >>>>> regions, so extract some code into helpers and use them to create e=
xtra
> >>>>> functions (cma_create() and cma_free()) that allow creating and fre=
eing,
> >>>>> respectively, CMA regions dynamically at runtime.
> >>>> Well, the technical reason for not creating cma regions dynamically =
at
> >>>> runtime is that on some architectures (like 32bit ARM) the early fix=
up
> >>>> for the region is needed to make it functional for DMA.
> >>> Can you point me at the code that does that? Thanks!
> >> Check dma_contiguous_early_fixup() and dma_contiguous_remap() in=C2=A0
> >> arch/arm/mm/dma-mapping.c. Those functions ensures that the CPU mappin=
gs for
> >> the CMA reserved region in linear map are remapped with 4k pages inste=
ad
> >> of the 1M sections, so later, it will be=C2=A0possible to alter the ma=
ppings and
> >> change them to coherent when needed (altering 1M sections is not possi=
ble,
> >> because each process has it's own level-1 array even for the kernel li=
near
> >> mapping).
> >>
> >>
> >>
> >> However, in the use case in this patchset the reserved region is only =
shared
> >> with buddy allocator by using the CMA infrastructure, not registered t=
o the
> >> regular DMA-mapping API, so it would work fine. I'm not convinced that=
 this
> >> is the right API to use for this though.
> > Are you saying you're not convinced that CMA is the right API to use for
> > this? Or something else?
> I read this again and indeed CMA seems to be right solution. I only wonder
> why do You want to create the CMA areas dynamically? Imho it would work=
=C2=A0if
> You just create large enough CMA area on boot, what would automatically
> share the memory with buddy allocator and then allocate dynamic VPR regio=
ns
> with cma_alloc(), potentially unmapping or marking the allocated region as
> reserved in linear kernel mapping to avoid any potential speculative acce=
ss
> to the protected memory.

Hi Marek,

sorry for missing your reply earlier.

The reason why we want to create the CMA areas dynamically is because we
want to split the secure memory into multiple areas. And the size and
number of these areas may need to vary, so I didn't want to have to rely
on rebuilding kernels with different numbers of maximum CMA areas
depending on the chunk size that we choose.

The reason why we need to split up the protected memory into multiple
CMA areas is that allocation patterns can create holes within a CMA
area. For the VPR memory, however, we must ensure that there aren't any
holes within the protected region because it is specified using a single
base address and a size. So there is one contiguous region that can be
marked protected.

If we were to use a single CMA area, we could get holes within an area
that is marked protected and once the pages are returned to the buddy
allocator with cma_release(), something else could be attempting to
access it and cause an error because it is still protected.

The only way to make sure we get a single, resizable and contiguous
region is by using multiple CMA areas and allocating the entire area
once our allocations need to expand into that new area. So we're not in
fact using much of the CMA infrastructure and actually need to duplicate
some of it. We primarily need it for the page migration and reclaim
functionality.

> In both cases You will probably won't need the DMA-mapping API on top of
> it, although it might be even possible to partially use with by
> registering custom dma_ops for the devices using the protected region
> (assuming that it would support only DMA_ATTR_NO_KERNEL_MAPPING
> allocations).

Yeah, I don't think we want the DMA API on top at all. The allocator has
special needs, like clustered allocations to minimize fragmentation and
keeping as few chunks activated as possible. We also want to avoid
resize operations because they can be quite heavy depending on system
load.

Thierry

--awe2ln3pvo2iqnm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmp0saEACgkQ3SOs138+
s6HmUQ//RyPTgx2QiCZkziDzWhQ8YjQ9J8KlwiQnyLspOz+Na5x6bslbOl/AuuBd
DCTC8+y/ax94aG30aB0SctUZLtHriGHwevA3J9hm/CfR1K72DsjLSDnkqujE5h7B
QxLJyl9wyqStgOfJEl6PwA8H9VbDkdJNHJlmpFzeki7a5QHQR28b+FyoWOZGGutC
YKiDlqpqQk1rs9d8WQ4M5w6JiRmImAI9YcoFP36b36oPf6/DziGOYjqCO6k9o1GI
pKj8EV6as2MTKoCdsuwHiQo/f2gQfyquJF+yK6m62NZy6wyr1ceed6jmCoIcuuh6
NKDs1AUWYdLhOVod22LHwn8GCjaDRkYHuUNgRtVrz5BgUuVUW/EmVieF/7BeRpna
HZ+uWPa09LwQq0ma8cRTNEQykq4zhVKxshPlVGeFuRJqIQ7C3ba/4UCWEDtT4Dlj
udGkgC059nR72DiCjPnQ40LV5naHw+dIkTt7uS2rh/xRih0ZW5bTc1ex3KvVq2H+
wtjVSehARwHbIzU3ijuk3iNDaGRYZS99YYB5NjULlXGFeldz0M4qj8L/Gu684Kt0
c0DFGObvF6isiTZgfuIwCNEEURIKdOut/DpqvFXcAmaAYvwvko7EPo4xwigfSapd
63yY0m3zfV1lefYdShI86wkQ8t4KSbU6Vhoh/A0AUNc1mcNqir8=
=PD/g
-----END PGP SIGNATURE-----

--awe2ln3pvo2iqnm5--
