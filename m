Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE43E44EB;
	Thu, 10 Sep 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032099; cv=none; b=Ib6y/z55sZPBliyJ196o6Qpu6QsIsyErjHYIqEPLCXVy/x5BG4J0e/OC1BEqFn+wfVallPkvlWLY8/YDEUqxQSqf/S5uYdgDRW0X80+Zo9uausErw8EtZZ9+elcvIi+/J2JDFvJ+lmO0it7FLIlI5SfaYNfV4TwZfFuAoSrYh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032099; c=relaxed/simple;
	bh=aCdo8Bbt4RuE2BEnSXUF/igiOBHVMvKWYIliqMf4Hnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZjdq5mYBL4xGQQ5nj8+BEGiyO/0oYHTt/755QpxeerOh4v8uzWFf3VCn7NBQ40gCR5NN1Al7LiLGNjTAPeVq14XOqHkwRlWOUdIFoEB7CHNqh4q5F9/T7VhJ2H6I7H2Uv9ya9SZOqSf3awCa85ReRWSQmtzVlqOBYIusj6iYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWenu4/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWenu4/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2DF1F000FF;
	Thu, 10 Sep 2026 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032097;
	bh=etegQPhHDYYXKpgN5HhrDD3ja2BilOp/q9xebohgcXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SWenu4/bhQp/ebHqQ47mZ8ttape8v/6aPUf2kjB/Ld/j9zBiWoVDmMFM2WXUeFpA4
	 Tz4kQl6h6D02ibEHqRfMCGmzm4F4W385fd4iPw4EV/b0R7FrEPUyPOdgqYghnwGSlg
	 wlCNkIv6fYWAYcTfK4O6DgrRMLRvCHdb42c6Z5fPxcblq5pU74lnZfaSijO4QJtgql
	 XWi5JzunvwkhvBE8/kV9Y4Q9psgLSZ8fOLaxugK+zflWpyfdSLe5ID2gv+8YzALlTs
	 DNEG/urmvrS21JPGf+b18of+CcOKc6HBFiQHYWy3kARa8VmrNDWDGEakhoATI6H2NQ
	 gKLgojcgqTT1g==
Date: Thu, 10 Sep 2026 11:21:34 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
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
	Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, 
	Saravana Kannan <saravanak@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 04/12] arm64/mm: Export set_direct_map_*_noflush() APIs
Message-ID: <aqJjL-kDfl2_wwHG@orome>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-4-79042cfa8de5@nvidia.com>
 <aqJFb3VtsYtnIa1c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nc5ni6zymi4hrk6h"
Content-Disposition: inline
In-Reply-To: <aqJFb3VtsYtnIa1c@infradead.org>


--nc5ni6zymi4hrk6h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 04/12] arm64/mm: Export set_direct_map_*_noflush() APIs
MIME-Version: 1.0

On Wed, Sep 09, 2026 at 10:51:43PM -0700, Christoph Hellwig wrote:
> On Fri, Sep 04, 2026 at 12:44:55PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Drivers that use this may want to be built as a module, so export them.
>=20
> That's one of the worst commit log ever.  No, we don't just export
> core symbols dealing with the kernel direct map because
> "Drivers that use this may want to be built as a module".
>=20
> For one exporting this at all needs a very good justification and
> not just hand waiving.  But more importantly if we can't avoid
> exporting it, it needs to be exported at the tightest sensible
> scope.  E.g. for a given module if it is so special, or a namespace
> if it's not that special.  But in doubt we should have a proper
> core abstraction instead of opening up direct map manipulation to
> random modules.

Fair points. In an earlier set of patches this was abstracted behind a
set of set_memory_*() functions, modelled after set_memory_encrypted()
and set_memory_decrypted(), which I think I'd still prefer, too.

Is that more along the lines of what you had in mind?

Thanks,
Thierry

--nc5ni6zymi4hrk6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqidpsACgkQ3SOs138+
s6GwVg//eIawY/jpVU95C05IvqaJG4LAKMlyvX0vCt0yTbFrsPQhY7RDigfanDMo
ycZhJCp/jyLprOkhxYEUmbLqCr6cn+5taI7LSQYIjkP+XRbG7rM7vYOynCANDeOS
uvUxtRu/8HlB0epcBAco9xhyX6Orb7w61HB8DspHAB/maQpHwCg8ce2/etTREXvK
qXc3uVrtfrsVNKgZgNtSuHcYX5NyIIwuNKc7rwiU+Q3EFcYAF3RpG6XCrncuKajI
GReiAWqBsyzzgM93zbemv3DKjbQkqVBl2fSZzTeguSv5KrJnFFd6n+JnHpHMPQPJ
gg6l3zWb7P8nlPRtlEJh87sNZJ3F8nVYStP5WpaCgjFDW5WrMcTTj/SBKMQqeroe
tgGkEMSMZAew1mtkyy5v0oaaialjMZ7796mpFs9J5GZv1PilvW/3Gn7D91zK4Yii
N923BVwEz9EnkPER42dP9AfLUCDE0lwc4A5t7ezgKbOKLXUIfDN6zlZe3jWQ6LO3
ALOl0JSYvlMX2izpQ4Pyl0/CSFHa5im5+5+o734Ql7U0mBOfpYYziOfPE9NJg5Xm
hINUJ4RiAi1x2e7iP05HqJutCO2hXPdalSnK5rzuosZjqma4SvMo/Ma1P7bcFkJw
2WDAAeRbtHk8qNOioz1Kp3UhdQCwFSP9Wa5RAtfvrmhE1X5Ap8I=
=EeFB
-----END PGP SIGNATURE-----

--nc5ni6zymi4hrk6h--
