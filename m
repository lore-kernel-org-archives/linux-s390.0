Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269E3F077C;
	Mon, 10 Aug 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371262; cv=none; b=dg5ZBKT0zxQbXqW/ZpLaASHrv7GuWoewBmf/p8ofuVp4ZZ4/30wZIGl51ies6TsQ79aw+m0MSh38PRrRjHuTa/bSJQYG9TKDf+0x0yp5vLbqyAQ3QSnTe2JW8sTTaN33e1I9dGkd/Ejigh7eG0ZY2AxqztDxeVPAgrhX1YQLnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371262; c=relaxed/simple;
	bh=2VRexDWzd/FwjKhqx0ta8n+OzYjSyu4UQt7QBvUx/nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwcKmugqFRJISoJRratrdXlbxip10Io+cksb5r8oYzTgDUJ3fHor9ca5CTCK4zErzwL+85R6unLC3el11r9gj3DwphUFqQWB92duhgoD3z1m2DrA7j/JhKGmNIQMkqyE5jY7Ais1A2nyy7TS++7O4yIvzxy6YpAtLhdo9D95VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX+kc7VL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX+kc7VL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8787D1F000E9;
	Mon, 10 Aug 2026 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786371257;
	bh=iehNUi3egKfQHvYDNGbbdbgLVRR5Q5cJOqpp5C8Holw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mX+kc7VLJtEYOvp9eGzSbishYvLpCPkZLR4wXwvjM+wgYETFgrk9xkyfZ1a24vtri
	 65ciAVNY1eJFvAX2bAMV2BZRvoU1yHEY3Y5nwK/h/z/S1K9fmc0HFeLTnzJNwxwnvh
	 MXmQ+Y4/Bgx5CaRyf2mpgo3ANRET883pr2yUAom2B3bjyyNBj49w7EFFmeZL3mS8BP
	 m4IThuwjn0FbSzKS4XQf+8c0tVREC4KvHbtmEs74Xg4d0IuRzNhYY1qCKMiEZe4k3A
	 jB3YgCtck/dVYN0wDiM5ADDw6SKS0cdM8N9+keC869RIEF1LTOnz8KBopzUo7OUunB
	 bdNexLqovZBcQ==
Date: Mon, 10 Aug 2026 16:14:14 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
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
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v4 05/10] mm/cma: Allow dynamically creating CMA areas
Message-ID: <annbzvLojXK33Sav@orome>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-5-5510d16af89e@nvidia.com>
 <3b458c02-e836-4b24-a712-57fa8dd59e45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7x3s4iklpcr3dcx"
Content-Disposition: inline
In-Reply-To: <3b458c02-e836-4b24-a712-57fa8dd59e45@kernel.org>


--i7x3s4iklpcr3dcx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 05/10] mm/cma: Allow dynamically creating CMA areas
MIME-Version: 1.0

On Fri, Aug 07, 2026 at 06:16:06PM +0200, David Hildenbrand (Arm) wrote:
> On 8/7/26 17:54, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > There is no technical reason why there should be a limited number of CMA
> > regions, so extract some code into helpers and use them to create extra
> > functions (cma_create() and cma_free()) that allow creating and freeing,
> > respectively, CMA regions dynamically at runtime.
> >=20
> > The static array of CMA areas cannot be replaced by dynamically created
> > areas because for many of them, allocation must not fail and some cases
> > may need to initialize them before the slab allocator is even available.
> > To account for this, keep these "early" areas in a separate list and
> > track the dynamic areas in a separate list.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
>=20
> Sorry that I didn't get to reply earlier to
>=20
> 	https://lore.kernel.org/all/anS0nxAwCXGWZRl9@orome/
>=20
> But I am still not convinced why we shouldn't just have a single array th=
at
> grows dynamically.
>=20
> "
> After replying to T.J. I think this static array is actually a nice
> feature in a way. It allows us to more easily make a distinction between
> the regular CMA regions created from reserved-memory regions that
> represent classic carveouts, and the more versatile CMA areas that could
> be used for any purpose.
>=20
> Telling the two types apart could obviously also be solved using some
> kind of flag stored with the CMA area, but at this point I don't really
> see a reason why the two lists would need to be unified.
> "
>=20
> Really, cma_for_each_early_area() + cma_for_each_area() is just nasty.
>=20
> I'd strongly vote to unify unless there is a very good reason to do it
> separately.

Marek had an interesting suggestion to extend CMA with fixed address or
range allocations, in which case we would only need a single CMA area.
If that works and is acceptable, there's not much need any longer for
cma_create()/cma_free().

Thierry

--i7x3s4iklpcr3dcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmp53LYACgkQ3SOs138+
s6F2pA//agw5g+ad2JaahbYD22vSCRqW3CiqP6DioCJAxsagk9tg5EhZHpBTyXgx
NeLeY+2kE3x6TL2VgqHJ4y8hoBb9s8kMQ/Y1mzKbX42KBaSncC7KOHxHC4oAYZ/Y
GIzavTlTlWZlGrD9qC/3YmmWdG7aHRr/UXALcH8VhYqn65ABqGIkmVmAcFBkZCC6
QAsB0WWbU1GVW7adArp/XjeywXwzYbuDjrhYMccXmfBexX5iA7dqyEBLybPiAhiw
/dN0PzpxaKReMS62gTC8Vl7nRW9mMC5NJpnDfMXzQtz5LBxYQkgUM07SFF4Z1cpH
ndEI0GkQyLkesWA8HJWysBbKHuO053/jjcE1+3JW61POx8TSmHPIW0Y52kE5O7h+
639yzEAlbLtPXsq9zQz6xpstENU5reyLz+IBhH3XC+f0RawuNb2YOnP29ayByUkS
o5Eg0kYjFGZP82xhBRlmveTPfBrTe/Un1wfJjnPMNttHrJaK7n3nlOrI6O7YAFau
Ou3/c15vyAOs1JrqdxCnPk4GOQFfYCwiK9cogcw/k2q6tgoSTjxuZsxqmmzOTAZx
Xj0mKBiV6RR5VCygyH+6tbdoPERl3Y8LHEP/cc642K9ldPi2Xjdqiylwt/4v7hkV
VM2qHuSnW8bwLF8N3ee2tCKpCmsx+rjwPK2tyQgPc8ts1VvqSyI=
=OEKA
-----END PGP SIGNATURE-----

--i7x3s4iklpcr3dcx--
