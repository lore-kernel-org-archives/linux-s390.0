Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D818DB35;
	Thu, 10 Sep 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037527; cv=none; b=TGfNgZ4T0c6cVhcapzVtlDfE1tDyQ7osukiyrrJJa//7T9yL4zF5AqSUvWGpPkDlGjqHkR4NyBQTDi/BPFdKlaSZwyCHQ9TVfAwgos55H2TKKBt6TaK3vS6zorP9XuEHO2Z+Vy+AVk+55cymIfA9UhmLfJZNf5dvfDEXk4w9dyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037527; c=relaxed/simple;
	bh=N7tjoMh0VJ0JjF10mqJOPD7b1ih9SO6rgWyfI3+RTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhWIJOJaaV4obJosx6iNVAsGP28PPfDgNMAZVwvQ/bJHSKZ8qrpJ///IMXPJ4UTWNhE83tuVX5zmNtRW0AmozAywd1O/ra8AIfYwok1szrE6Zy7JUbw918KZqVxzFXrp2Y3IbqWeU1mCPaJ+b2pjunpwRdjbXbsj6xdfZvh5T9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkBWkbqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkBWkbqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB61D1F000FF;
	Thu, 10 Sep 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037526;
	bh=N7tjoMh0VJ0JjF10mqJOPD7b1ih9SO6rgWyfI3+RTmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jkBWkbqsUtrXGjvzs9ejgfK4XpAo0fpqaDkZEwyYUh3nsky2zY+18Vn27mS7241TL
	 MvCu5S/EUOKRuRIWcemqgqVR0X7r6k4w/oYOXZqhYTVtmn5cDR0ZWuVJ+EoGIOf31K
	 si2Vs3AQL0JW0JfVnduAaNtpDg+K6Gjxl/jEwtzpEcPUiZ4rezgSm0nh5PAkQQUFO1
	 GwPIbbmKXcJaxgmpF9ohj/yHw0Jk801NrDXApGybMo/hVriULWRHefHhXwmI/BEyuR
	 x75hp2NlH3/kPyBXNr+tNycCgJ1d5N0BstAe2eFHBEpUaMX8cbJ1kv4UK65a/OEoEn
	 o+nS3JzDYdGyw==
Date: Thu, 10 Sep 2026 12:52:03 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>, 
	Mark Rutland <mark.rutland@arm.com>, Saravana Kannan <saravanak@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 06/12] of: Export of_node_to_nid()
Message-ID: <aqKLkeg0iRBqa3bo@orome>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
 <20260908145929.GB3123582-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pochtu3uujjsdg7m"
Content-Disposition: inline
In-Reply-To: <20260908145929.GB3123582-robh@kernel.org>


--pochtu3uujjsdg7m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 06/12] of: Export of_node_to_nid()
MIME-Version: 1.0

On Tue, Sep 08, 2026 at 09:59:29AM -0500, Rob Herring wrote:
> On Fri, Sep 04, 2026 at 12:44:57PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Drivers buildable as a module may want to use this, so export it.
>=20
> We need a specific reason/driver. Otherwise, that's every API function.=
=20
>=20
> It doesn't look to me like the VPR driver ever actually uses the NID.

You're right, we currently don't need this. The plan is to use this to
differentiate between VPR instances on NUMA systems, but we don't have
any such system yet. I'll drop this patch for now.

Thierry

--pochtu3uujjsdg7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqii9MACgkQ3SOs138+
s6G+LA/7BGayHietSWcjHsnMEamaB/I04lj2qpSvcwlZK/2E94CCzDouik55LAg2
7yFNbMU0VYi2oxec0RMMlAfo/OEN8iG+3X3tcTwQ6Hv7fPxlsffyKDIAb0SxAalQ
3gXrYnaeeUS8oWlfyapzTnArDHz1wkolZluRr9R3cj73ED8jdi0XuHkTjlbGKVko
KaZTIYUo9uB5G1wLUs0TOP3pAfJJa97LpAtMPIdytlgwy8wLXa5ti4A79opsZzIa
5kTsTXx5D9Xg+/kJuuvpr/5lanW+hYPWVbL8w37xwjKV5EoQW5kSdUnXXuZiE5p6
zM5tKM16OssvhPhZkYaYwdR4QwrJz2wpGE1R8NV9W0IMpW4HtsIRJPbTQhQOqn0L
DdKwKKwPYYEAshOJ/vel7xA5/rnfbFAtxOI8CvPpjM6mv0y8AFM8fApzzcfjlJvW
D+mJVr7IHD3+E4MZeA44MUvJpuK9a6tZg80Z0ixPnnbtl7th8/3nrj6vpW2ANmjk
aeh2Rud7YKP1TJThucNGvzzl9zmePpUiapF47cWCkR13ooM8opgzSHkeGBkU4Oaa
HsXVrm8Ie+po6BAMLKsduZrB2KFkFyJ68bMGbHwuwqmVSux9BnT+Mc65Yc7fWEF7
9+pu4BoTZZ32aJXzpyx8RcxV9jADGugXNEA88fHQpAxDbtyg5lc=
=XC4p
-----END PGP SIGNATURE-----

--pochtu3uujjsdg7m--
