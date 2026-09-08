Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DB3B42CC;
	Tue,  8 Sep 2026 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856765; cv=none; b=e8mSOJuou3519BpfD6wgfXVxz+b6Mn3LHJslpTDXSS4oTTXMrQLxLCTQ0ioZ9karwwf9YGFqd+D+mcGst9alG2av93N8YDzRj/L/WF+KmfI/CjlKNkfPsiuUBhtWLVefFud/ZMW8HVkPN2ybrRLpz4Xz+wv3CsUqydJUFUEfmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856765; c=relaxed/simple;
	bh=slUWdnwq0XGj7f4s3OzgJoorkVnZmUKvVcYJXpe/QEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQCNQFFwgMRxEOnGdDJ2xljv0a4UDsNamXzWK1f1/GoPRUVh0uEXw4xnsKYvMqi0DJxk1Y0u0wxeNF15D8ugkY2d/xE9oI7eFticlItkRWTFcJ852Pc1VFHogavWSEfQYczL1XROMpGPb4zsbEhmp6vgZlUSXDOubmzSk+3pBdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f31djqHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f31djqHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23A1F00A3A;
	Tue,  8 Sep 2026 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856760;
	bh=slUWdnwq0XGj7f4s3OzgJoorkVnZmUKvVcYJXpe/QEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f31djqHMq1zm0NH10E6jABNFN/XEtBtVUywkW/jJEx2y3vkNmMXh/1kd/Sjj72P04
	 T6L92RsSr9CQrX66jc0wrPwHh6ZjVD5aSMaTpkb+Cxjgp9ZU6YrbkkYXhDrOYryDaO
	 ZTgU5gp6BdSkoU54QhSCWPpRXJjEqeQ7gFPhqonFR9QaQp7K9wC3t0y6YPinAZxwQV
	 h+w9nS9hTC4LwZO/38s9ryPJzCgNR+G1JO/Mul0cHse249ia1+soSZnoBYdeQ4kY0m
	 HeH3O938M7uXInW4K+dnzPNL73PzwIIfEEPV3T8JCftA19ij/TKmEUEYsg1ScglZFI
	 YJglKg/Ofvcpw==
Date: Tue, 8 Sep 2026 10:39:17 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, 
	Saravana Kannan <saravanak@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, vdonnefort@google.com
Subject: Re: [PATCH v6 00/12] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <ap_HzwVp-6aOKEbJ@orome>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <apquUWgrD9C2jWQ0@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5apqptzjdcu2eq7"
Content-Disposition: inline
In-Reply-To: <apquUWgrD9C2jWQ0@willie-the-truck>


--a5apqptzjdcu2eq7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 00/12] dma-buf: heaps: Add support for Tegra VPR
MIME-Version: 1.0

On Fri, Sep 04, 2026 at 12:41:05PM +0100, Will Deacon wrote:
> Hi Thierry,
>=20
> On Fri, Sep 04, 2026 at 12:44:51PM +0200, Thierry Reding wrote:
> > This series adds support for the video protection region (VPR) used on
> > Tegra SoC devices. It's a special region of memory that is protected
> > from accesses by the CPU and used to store DRM protected content (both
> > decrypted stream data as well as decoded video frames).
> >=20
> > Patches 1 through 3 add DT binding documentation for the VPR and add the
> > VPR to the list of memory-region items for display, host1x and NVDEC.
> >=20
> > The set_direct_map_*_noflush() functions that will be used later in this
> > series are exported in patch 4 so that the drivers that use them can be
> > built as a module.
> >=20
> > Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
> > but works on sizes that are not a power of two.
> >=20
> > The of_node_to_nid() function is exported in patch 6 because it is used
> > in a later patch adding a driver that can be built as a module.
> >=20
> > Patch 7 introduces new APIs needed by the Tegra VPR implementation that
> > allow memory to be allocated at a fixed offset within a CMA area. Tegra
> > VPR needs this in order to implement its own allocator on top of CMA to
> > meet the strict hardware requirements. This replaces the dynamic CMA
> > area creation patch from earlier versions.
>=20
> Did you get a chance to see how this could work with Vincent's series:
>=20
> https://lore.kernel.org/r/20260902104712.2399797-1-vdonnefort@google.com
>=20
> ? I think that should remove your reliance on can_set_direct_map() and
> mean that you can retain block mappings for most of the linear mapping.

I'm not sure if it would help all that much. Yes, if we mark the VPR
region as LLMAP (or PTE_MAP, whichever it ends up being), it should make
the checks for can_set_direct_map() redundant. However, from what I can
tell, Vincent's series still forces page-granularity on these regions,
so it won't retain block mappings at all for them.

The block mappings can be retained for the non-VPR memory, so that's
nice. It also reduces the amount of external prerequisites, but I had
kind of hoped that we could go one step further and keep block mappings
even for the VPR memory if the region happened to be a multiple of the
block size.

The recent addition of page count to the set_direct_map_*() functions
helps reduce the amount of checks that need to be run, so maybe there's
not too much to be gained from removing whole block mappings at once
=66rom the linear map.

Thierry

--a5apqptzjdcu2eq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqfybIACgkQ3SOs138+
s6HeMBAAuLF8s85+tHae/nBOh6j4pUVcjE5KyexYHpAnHyj8HIuDuERbHercMMPe
CyLnvqYhkNgu1LmEjo9O0OVzGEe65BJoHkdgmXMTyFLQ/9NGtdvaaTCabe99iBCm
1BGL8d0KtegUlzTJLntnV+ubRKhLjZthpMxxjuThV2TJaFTQXtS4kcaldKUTw73o
k9bbvnuX2PsQCVZTL+aAKsRtvXHT011GzCwlfufuRnkX1kJ7vXidndwdsMOFoIJm
lThSDnPii6F/bJc74o9ztJlObQ8gjs/6hzMjrFu9FVFoMa0sucCfM6d+q6wOw/QF
nS7Gtk7mV9RgQ2PkT6o+Umw0l1Nnwd5R5XGKo+vuVb8hCy6hmTe1jPkIy0PyFyan
k54nErXH09l91YA06FpSI4HmeoCYUk4cUU/hKlKYVbE+7DrP7GLNBgEl//Xm5zfB
do1TCokmrQMoFu3UniXLhSmKJMZOuvW23cj5FVP81q3t3cJxvONGp7hvXMyAz5Yy
tx3HYQn+1z1GuPrmlI/PQ7bCz2ZHhepUHPcP6fx3qQoEcECZr23Ud1xVA1xrxNKS
AfvLgsWqAZnG0bTq0hOp2xW38FlPOEB/Gn0A3ux9viOHbMyVuOHqET3wahXk3XgN
OkCpZ+OS8PyANuhW2WySDdpC1HnKIgfn0ghFX2BlmOZ86qZ1LTg=
=5HqX
-----END PGP SIGNATURE-----

--a5apqptzjdcu2eq7--
