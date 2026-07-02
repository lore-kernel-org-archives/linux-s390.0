Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABE397339;
	Thu,  2 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010492; cv=none; b=iwVHd7/428O8morhrGOiyKcPacxnsuDag9pUkkgumUoh7tj6RZFf8BW4VnmXDQEqfPrCXovw9krSZEq+fIdZBSjtbTh3YmR4gBs3av/tH1yW+AiphXj7v/OwDjelw8ZS1v5tcMKX5tcWuXQeWNKPseKBHUSKo+XWvPLfrboej08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010492; c=relaxed/simple;
	bh=4TcPpM0BZaoJj/LKE0Ry2kWPQZbK+NaW1FTfGXp6Qn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/PpFtrJlDx8CL2DHWhX7TlufHi1XY4BEm2gvt7KmyKwWUmDD9wP23vIAY1rIDRLRCWxbW5zYy1cEK/ugO1Cn6C2iNQU+PI9+ud/60aXExymRq+PHPGe8iRfUYKqEFnOgJTKY9eO4LIGO2ZOonIz36Q4PtB/X1nH7Szgnur8GNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbIxVhIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbIxVhIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3321D1F00ACF;
	Thu,  2 Jul 2026 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010485;
	bh=4TcPpM0BZaoJj/LKE0Ry2kWPQZbK+NaW1FTfGXp6Qn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UbIxVhIT3k+L2Rvex870aYp4emZYvycrMzgT/l80VxrbTxWvxI9JRKpnaUNMEjG3G
	 ZoVLWczTG/g9HyZAgZ70twW/ylV0EE7XLdG/sgXmKLnHisy8AsEYlfbd5niKzqz1lY
	 ws98cZTWJqeFnp3vSJLG17/qF3Ge/moCJxFQuACsKCwbcRvPFAWF7LSujuvl0ZguAd
	 0Ey5CbVzfmKHTGGtoQsv7zUESob5GM+jQi/nn4i0YwCIBp/b1yxTiqFNMy4jhvtD5D
	 q7w26HLWMKTd+xN5EbSr27iexWuWelP+dlG+S+pGinCthmp6iUYPrtV/RBEn+6x6na
	 +pBQI4mIXDTaw==
Date: Thu, 2 Jul 2026 18:41:23 +0200
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
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Chun Ng <chunn@nvidia.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Message-ID: <akaSJ5D98w2cHqb6@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck>
 <akZkuwktaXFTrASP@orome>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a4brqgkdrivfh2ns"
Content-Disposition: inline
In-Reply-To: <akZkuwktaXFTrASP@orome>


--a4brqgkdrivfh2ns
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
MIME-Version: 1.0

On Thu, Jul 02, 2026 at 03:46:44PM +0200, Thierry Reding wrote:
> On Thu, Jul 02, 2026 at 10:18:47AM +0100, Will Deacon wrote:
> > On Wed, Jul 01, 2026 at 06:08:15PM +0200, Thierry Reding wrote:
> > > From: Chun Ng <chunn@nvidia.com>
> > >=20
> > > Add helpers to swap PROT_NORMAL and PROT_DEVICE_nGnRnE protection bits
> > > on a kernel-linear-map range.
> >=20
> > That sounds like a really terrible idea. Why is this necessary and how
> > does it interact with things like load_unaligned_zeropad()?
>=20
> This is necessary because once the memory controller has walled off the
> new memory region the CPU must not access it under any circumstances or
> it'll cause the CPU to lock up (I think technically it'll hit an SError
> but in practice that just means it'll freeze, as far as I can tell).
>=20
> Probably doesn't interact well at all with load_unaligned_zeropad().
>=20
> > I think you should unmap the memory from the linear map and memremap()
> > it instead.
>=20
> Given that the memory can never be accessed by the CPU after the memory
> controller locks it down, I don't think we'll even need memremap(). The
> only thing we really need is the sg_table we hand out via the DMA BUFs
> so that they can be used by device drivers to program their DMA engines
> internally.
>=20
> Looking through some of the architecture code around this, shouldn't we
> simply be using set_memory_encrypted() and set_memory_decrypted() for
> this? While they might've been created for slightly other use-cases,
> they seem to be doing exactly what we want (i.e. remove the page range
> from the linear mapping and flushing it, or restoring the valid bit and
> standard permissions, respectively).

Ah... I guess we can't do it because we're not in a realm world and so
the early checks in __set_memory_enc_dec() would return early and turn
it into a no-op.

How about if I extract a common helper and provide set_memory_p() and
set_memory_np() in terms of those. Those are available on x86 and
PowerPC as well, so fairly standard. I suppose at that point we're
closer to set_memory_valid().

Thierry

--a4brqgkdrivfh2ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpGlK8ACgkQ3SOs138+
s6HETA//VE10mlKmDkMPw7oOS2GPLTn9mVHksFDOn28PMBlC2qgyv4CyznGj3Rfw
WHIYoNb0rxntAbxQkh6SV5FCCi76fm/uTR3z2an8FI8W7KwiVfDiaIv3cmlG6TVd
XcCj42QUsUHU7iFHzfSVkW33626MSfyeD+w00yxmT14U2Utl4X/+V+EQF6tRStJZ
eLJUAyxrArCx98MI79QW13QB5MilfaFjtY6IxwXr+0hW2qnXGbNWJ5x1Z5kbC6wD
6yOAfi8QY0nqau5GKgo/+dkYUq1zAc65a7QdRu5KW383NDcLhRbtrwBoA6TYFriL
c2GJiV1ch4N8Dsr694Lmn4jNHUUqPLcPY8it6qMkUNVrc5XjK24C0intns2AFR4i
7ca82YvaTCuql87GjgBkz9NptVtmqVdZxnrtVYAH9mbvfczVpAEEsacYrMwtqBPM
crTqcMLjkLxVZdnsvwT3Je73FolwTnxNsBlTaA24I64kQCW9QUIRy6WltcFdimPM
2K40ULhVg3dNDSaGsQaIvDv8kpgBJiX4sf3kIjK71Dgo9/HKS4IBZx3kfKUxxURj
RD51dxPOiDXPwIzDZxbERJ2rZx4NxSTj2FjLET7Vs6nbKwvC+K/XiLOtEIXbfwdD
w9Hih0fRPiPrhG+uab8J6u+Jsaj9KI/DnuqDrIZL+ciFm4MVaNc=
=9S6h
-----END PGP SIGNATURE-----

--a4brqgkdrivfh2ns--
