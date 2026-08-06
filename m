Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9F72630;
	Thu,  6 Aug 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033866; cv=none; b=AjCKAlq4aZJntvS1sNbCRbcGCQPF1PJnb/Y6RepXUUHTa+tzQ0/EH6TU/rjIteHrFBFSzkqFRheRYs9WSjRTnueCAbMaeNlL0MfmxcuKpf5ajUrWyvHFmjyv149ltKn+awOu72N4YPCyT2tqx3xFFdHaxreGRL1dbM7YE+5B+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033866; c=relaxed/simple;
	bh=mVTwW0b2WURKlJNz5W6ur6Q9trw1irf346v/mtsQRWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sfzxo/5nLvf58zdgIvA+0hAUTSMhw1iXt+BcOvx12R8YHKsatvXo6xPn6DgD4bvXtxVai+4QJPHz7LL8s3/b4U0mo72MDnl4Vm3uLCimUR1nAqPygSOXum9a0NA1/jgAE9EPo5PHSHJ0sbdkLl5sv6ytgBlLTGv8g2wtbkaPK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1kXRt+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1kXRt+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135FF1F000E9;
	Thu,  6 Aug 2026 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033864;
	bh=mVTwW0b2WURKlJNz5W6ur6Q9trw1irf346v/mtsQRWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P1kXRt+yoIsWD7ulhfbS3urOuVuE0SbPvMDxieMb81wACWsaIkq5JOoANzW7S8NWx
	 J4fqscMVF4IvMA4A+ZyRcGi0cMYWRm03UyH3hRQu7dJiZRCTeFLT3MM1bCRaAr1/dQ
	 Wzyv+1ZLBNqWJj5KtPgT6L6qt2ViX4mrbhABS0c2K59hQ/rk5vF3QtJfGoYwVTs7Pm
	 8qo2h9eKBwfZAv5ivqMMODftIZf+/eIV2YydgQxJmFW66KSbq2aFP8It6DXFMsSP7E
	 SJIUOL5KNIfVP1j2jZc4I9RAWvtZYm1iUOuYSejOF40J37fdh5bmrCbSSKxhHw9NgD
	 YOSMfYvvnXfgg==
Date: Thu, 6 Aug 2026 18:31:02 +0200
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
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
Message-ID: <anS0nxAwCXGWZRl9@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
 <b1c1693d-02b4-4c5c-bb0a-1c2d87258d30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rscp6jw7dv2pn33g"
Content-Disposition: inline
In-Reply-To: <b1c1693d-02b4-4c5c-bb0a-1c2d87258d30@kernel.org>


--rscp6jw7dv2pn33g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
MIME-Version: 1.0

On Wed, Jul 08, 2026 at 10:59:46AM +0200, David Hildenbrand (Arm) wrote:
> On 7/1/26 18:08, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > There is no technical reason why there should be a limited number of CMA
> > regions, so extract some code into helpers and use them to create extra
> > functions (cma_create() and cma_free()) that allow creating and freeing,
> > respectively, CMA regions dynamically at runtime.
>=20
> I'm confused. We still allow cma_create() only during __init, right?
>=20
> Would we expect callers of cma_free() after __init? Or at which point?

The idea is to allow cma_create() at any point. I forgot to properly
remove the various __init annotations to make that clear. I've done that
for the next revision.

Technically cma_free() could happen any time a user no longer needs it.
While we currently only do this on error-unwind, the Tegra VPR driver
could technically be turned into a module and the entire region be torn
down at that point, including calling cma_free() on all the chunks. I
don't think we ever want to do that and it'd require a bit of tweaking
to the OF reserved-memory code, but generally speaking I don't see why
we wouldn't want to allow cma_create() and cma_free() at any time after
__init.

> > The static array of CMA areas cannot be replaced by dynamically created
> > areas because for many of them, allocation must not fail and some cases
> > may need to initialize them before the slab allocator is even available.
>=20
> We can start with a memblock array of an initial size (like we do today).
>=20
> Then, when you need more space, we can double the size (copying content a=
nd
> exchanging the pointer). Either allocate from memblock or from slab, if
> available (slab_is_available).
>=20
> memblock does something similar, see memblock_double_array().

After replying to T.J. I think this static array is actually a nice
feature in a way. It allows us to more easily make a distinction between
the regular CMA regions created from reserved-memory regions that
represent classic carveouts, and the more versatile CMA areas that could
be used for any purpose.

Telling the two types apart could obviously also be solved using some
kind of flag stored with the CMA area, but at this point I don't really
see a reason why the two lists would need to be unified.

Thierry

--rscp6jw7dv2pn33g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmp0tsYACgkQ3SOs138+
s6EDqQ//VPlX14ZCCWQFTzMM+CH1U7z90n2OI2r6sVAf3mIXAqF56hCOe1TSTHch
SLJpzBAU/F15bA6jirr2jOS8SHr7N0C+ox5M2yoEGywgGsbTEOjWSvejWrHWkJ9m
7fdcdEl/hB7yzbpBvDMxGiATg+0SwQrhy4Sp7105QzaPpE3/9dS5UXbQuhsbCcAy
4fU7Xd3wOOLcxg5u7Fl0ggfWHiAX68o32alTzPijPaVubxFJ1RnLQLeNhTdwJv03
nvh3RVR8dpDTY7hZbsTr/4r5+4L3ktGvufT5m3K0lImfKVb5hklsKVbNTnQMtJ+i
nAC+BTofn33vMautsZwPhhAQeesfMSJkuNASPD9kqZ0U+b+W7XtmmkmwbigS2r9u
1lajCmiV77/KeZazBydPFJzqt+0lEkLAwWtBAk+M/Fw0Lsx3/ycfApXqEtCv/Jfw
G1oTIraXEv0tXgSbl0Q0zAY/TKTgTmtNqVNbLJh2VxhQiicJGiEYZ9w7i971TlUs
obsrwFtpOrWdkBI8VFGUm59sNK7yjrl2XWpejZ+xmhY4GanpuNYf/Ki6nBhTn39r
qUNyB63c492tlL7PYUHVx1tMFCMwDBPw9wg5Dn57++j5s3gmoAmgqaAykpl/tuhB
lRoRWYWo4mgQ/C62svXRtyqVx5TMhQpRLrpQOAGdx4y6SF4GmGk=
=TjKb
-----END PGP SIGNATURE-----

--rscp6jw7dv2pn33g--
