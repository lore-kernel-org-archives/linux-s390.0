Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC22C3261;
	Thu,  6 Aug 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033307; cv=none; b=rjwpZ8GyRGAxyRgz/nEBmJ2rRfh1kp0h79spXzh3yKfLTpYN/ubaFobsHiJ+QGW7frtVPDlStmOdxD9x429xtpsJ5LNBkBhWh9njyOMQGtk7baOPo2ht+yVYRAY/3fTMDkEY7d82yDqTGE1ZhqJSM7QY605qRsSQnRX0mVjNnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033307; c=relaxed/simple;
	bh=9OQRYxnEbL1vlfwxgT977i1AfPRqWf0vi68WNMX/Mqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jChrveXNMxV/hMpr3En8w+WuF1MAw9PO1jZORwpLKLhVy3Pj2BoI20kvB2SY8rlnTNFvAiVFlraTvVhSccf4z19frr4qsO+z8usy+LAZSFN8VodTDUAlwBF2Mz+zyzU8Oi7Z6L5qZVDsahSLvr+8OL3aiYw1UEbzSlHZl/tLEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aalAEn7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aalAEn7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3844E1F00A3A;
	Thu,  6 Aug 2026 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033305;
	bh=9OQRYxnEbL1vlfwxgT977i1AfPRqWf0vi68WNMX/Mqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aalAEn7rNUlyRJPV20BjL3yI3iPPN+js6kl4wiCICluf+ZHpYklDJI/OsH7/3ARg6
	 6B8o11hfV2IPUN3Qq6QJmnNjXQC+59EpEP5WYdtoDSed9abq3u+doW4SPm6/oDr3T7
	 WWaEaKql5HntTfMkY72NHSwnnY6fX/u97XSO3ci0teM4TfzFOTv5O8ebSGlHprBcY8
	 llw1LEhloYGFMqTMz6BQvN3SKr+VR2DwYRLKw1W8OM9fFn1tKTbaycRrBHNmPXt+oU
	 fLBXBy6hbmtPaffVx6Jj94F/NzDmzVT6Qs46zlC7UEKdcgz0I0lIyGDW38wbRt4aCm
	 UPYrrB9vJfAAQ==
Date: Thu, 6 Aug 2026 18:21:43 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
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
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
Message-ID: <anSyU_-zArFch-an@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
 <CABdmKX2i_vxs3EgJgydEbXoTxqWe9g9pj=hqPKuwf0ge0SjZuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gmnekg7ar3gl7m6"
Content-Disposition: inline
In-Reply-To: <CABdmKX2i_vxs3EgJgydEbXoTxqWe9g9pj=hqPKuwf0ge0SjZuQ@mail.gmail.com>


--4gmnekg7ar3gl7m6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
MIME-Version: 1.0

On Wed, Jul 08, 2026 at 04:49:31PM -0700, T.J. Mercier wrote:
> On Wed, Jul 1, 2026 at 9:09=E2=80=AFAM Thierry Reding <thierry.reding@ker=
nel.org> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > There is no technical reason why there should be a limited number of CMA
> > regions, so extract some code into helpers and use them to create extra
> > functions (cma_create() and cma_free()) that allow creating and freeing,
> > respectively, CMA regions dynamically at runtime.
> >
> > The static array of CMA areas cannot be replaced by dynamically created
> > areas because for many of them, allocation must not fail and some cases
> > may need to initialize them before the slab allocator is even available.
> > To account for this, keep these "early" areas in a separate list and
> > track the dynamic areas in a separate list.

Huh... going over this thread again I could've sworn that I had replied
to this before, but I can't find any evidence of any reply.

> Hi, It looks like you'll also need to update the CMA dma-buf heap's
> add_cma_heaps init function so that it adds all the CMA areas, not
> just the early ones.

I would actually rather not do that. The case that we need this for is
creating a special purpose dma-buf heap that's composed of multiple CMA
areas. These areas must not be used by anyone else. Exposing these to
the CMA dma-buf heap would allow anyone to allocate from individual
chunks and throw off the accounting that we need to do in order to keep
the protected memory from working correctly.

Besides, given the dynamic nature of this means that the CMA dma-buf
heap might already have probed when these dynamic CMA areas are added.
So we would either need to have some way of notifying the CMA dma-buf
heap of newly created areas or we might end up with an incomplete set
of registered heaps.

If you really insist, I could look into this, but I think it's actually
a nice feature that the CMA dma-buf heap only registers these "early"
areas and exposes them.

Thierry

--4gmnekg7ar3gl7m6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmp0tJQACgkQ3SOs138+
s6Hx2A/+LyXBkYE0i4vOlsqA/Ydjj8c8/300xmhsRpFbwbpF3gTAquepUhv4ccLk
pn6s3oOPckjHUjgqi17LCjM+dbGIQRiXZ5sHHuq69DOmSq6K43pvPWC9DQE3kICK
i05UEwUTy2GyHSp229X6bMmMKYyl4WW9pde+bHXFO3IBdszOFd76qxdMqtl3agOv
kfgnaTJezzmgsC1qP4etPKCdwHkxCcCO+r/IUp5vm8tuot9r3ZmBeyeLcSaboN0D
RP21XS13WS+QLN/rZAXyBAVhrpNrTBOcQcI5CYrTXnDFkJYeQJEkd5ugPi/q2wr4
KM8oHddCYYYHQyIEOG7pFcNGhonqPopbSVLN/BwII0fbmJXppQrdPyR4B3ZzsZzI
51eP67NZSMCtnEqOeaqKYc629FRTyBsrMWfEhmHu19hAJb/p9PvkqxCIR+TlebSt
HbuYY8JUEbz4Ck0Cb9FHGHsuYwsYkSKVpy0CpXnqkYEayTLU7dEHHpoKyTtS5Wvz
w8fNZPuvXMWffnb1L+4nblBj2VNkJCSUvr3ZcgU0H6PlqcES02A5W6ectwCN/2R2
STUcZd3vK2dFxCKRPHOx5+YyienQ9dBUapH7HwK01V0SFwh9m58TpMKmacD+y7vU
Ns4RBrD6r3h3Ua+YybzB1+b9dqB8U4mzDp9x92jAksifc9ZHH5Y=
=/fYh
-----END PGP SIGNATURE-----

--4gmnekg7ar3gl7m6--
