Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B146AA8F;
	Fri, 14 Aug 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712169; cv=none; b=uGb1CzDn/WrlLQj5brPJ6VtHaByYLxId6ciAz5JPaCy2TB6V2aUh8UfPoGk1c/HXWiWOLScPn3gUXp7bKeWS8XARUrU3lsiMfmJotA21A+zRf8GTMFjz/DaIPS+BI0E9mE+IloaJGj9np4vS1aPrjzklUTnC1jeQ9dxMwdAK1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712169; c=relaxed/simple;
	bh=cX+72s9o2pIYhrhjJqMobcQWIikVZ9nl0Ljsw77hPx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaaLsRtaGSMTqF+1YNDVEv/1AQKA+X6kmPYRcQH5+aZGXh6IT4+HGffeW5G/lBW4DJhkHJ5xJu6hAj40qN+yqr9JZYtPn65WH2J96riTtgrWimENzgWhawnHWJ9mPNzYZLRtO2uc/XpiEAvxOo9j5eHUYaWmH3N+HZwFuzMxH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e977F/nZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e977F/nZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BE81F000E9;
	Fri, 14 Aug 2026 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712168;
	bh=cX+72s9o2pIYhrhjJqMobcQWIikVZ9nl0Ljsw77hPx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e977F/nZkZ3+kWqrRqgIfVJd/aBqAfJBoJ0g2Jj+dswl1Yg8oI6tRpw4WyEGE1+X5
	 ugqpy7w+0PGPzYIzyhQ49UE79ycBGLH814wt5t6VCwpq/fsYz5+oV6IV4OYn2PPgAn
	 fv3+Ey1E7u2WkT/SQL0uxiu065pQDQk0viXx9tFYyrgo8quEfA5xgasEuIKFLpRfW4
	 9LtheyIuV7FSxZqP0wPnWpQNgWraqQlCpz1CQlD8dVJ3450cieekXQzAVhaDRThuU6
	 /K81KqNxEY9a5Z6oTmwsp7EawXpN2CYk+7qgYfB/RCh2d6ibc/4AAJKcUkji02OGAJ
	 P+ZrWGMhbtoHQ==
Date: Fri, 14 Aug 2026 14:56:05 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
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
	Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <an8K2gb1pIqbDj6-@orome>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
 <an4MEI7lkc2p3nKI@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wsqkte2vdducxgiq"
Content-Disposition: inline
In-Reply-To: <an4MEI7lkc2p3nKI@google.com>


--wsqkte2vdducxgiq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
MIME-Version: 1.0

On Thu, Aug 13, 2026 at 07:25:20PM +0100, Vincent Donnefort wrote:
> On Fri, Aug 07, 2026 at 05:54:27PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > NVIDIA Tegra SoCs commonly define a Video-Protection-Region, which is a
> > region of memory dedicated to content-protected video decode and
> > playback. This memory cannot be accessed by the CPU and only certain
> > hardware devices have access to it.
> >=20
> > Expose the VPR as a DMA heap so that applications and drivers can
> > allocate buffers from this region for use-cases that require this kind
> > of protected memory.
> >=20
> > VPR has a few very critical peculiarities. First, it must be a single
> > contiguous region of memory (there is a single pair of registers that
> > set the base address and size of the region), which is configured by
> > calling back into the secure monitor. The memory region also needs to
> > quite large for some use-cases because it needs to fit multiple video
> > frames (8K video should be supported), so VPR sizes of ~2 GiB are
> > expected. However, some devices cannot afford to reserve this amount
> > of memory for a particular use-case, and therefore the VPR must be
> > resizable.
> >=20
> > Unfortunately, resizing the VPR is slightly tricky because the GPU found
> > on Tegra SoCs must be in reset during the VPR resize operation. This is
> > currently implemented by freezing all userspace processes and calling
> > invoking the GPU's freeze() implementation, resizing and the thawing the
> > GPU and userspace processes. This is quite heavy-handed, so eventually
> > it might be better to implement thawing/freezing in the GPU driver in
> > such a way that they block accesses to the GPU so that the VPR resize
> > operation can happen without suspending all userspace.
> >=20
> > In order to balance the memory usage versus the amount of resizing that
> > needs to happen, the VPR is divided into multiple chunks. Each chunk is
> > implemented as a CMA area that is completely allocated on first use to
> > guarantee the contiguity of the VPR. Once all buffers from a chunk have
> > been freed, the CMA area is deallocated and the memory returned to the
> > system.
>=20
> Hi,
>=20
> I believe we (the Android team) are trying to solve similar issue to your=
s: Arm
> CPUs can still speculatively read memory after it has been transitioned t=
o the
> Secure state, as long as they retain a cacheable mapping to it.
>=20
> As modifying the direct mapping is difficult, the workaround ended up in =
the
> hypervisor which unmaps the pages from the host stage-2 on intercepted FF=
-A Lend
> invocations.
>=20
> If convenient, this is nonetheless the wrong place to do it. Scattering t=
he host
> stage-2 is really terrible for performance and we would like to move it w=
here it
> should be, directly into the kernel...
>=20
> This is what I thought was the attempt in v3, but I am now a bit confused
> because I see you are using set_direct_map_invalid_noflush()
> set_direct_map_default_noflush(), but I am not sure that works if rodata=
=3Dfull is
> not set? So does the memory for the NVIDIA IP still need to be unmapped?

Yeah, this currently relies on the circumstances being such that
can_set_direct_map() returns true, and in the case where we want to use
the resizable VPR functionality, we're going to have page-granular
mappings anyway.

> If so, how about having an option where the CMA allocation is backed by a=
 direct
> map with the same page granularity, or at least a smaller and aligned gra=
nule?
>=20
> With that, we know that for whatever CMA allocation we do, we can safely =
unmap
> from the direct map without risking splitting blocks. On CMA free, we can=
 safely
> remap into the direct map as I do not believe we coalesce yet.

This sounds intriguing. For VPR we could possibly make the size a
multiple of the memblock size (or whatever might be appropriate). If we
can create a page-granular linear mapping specifically for that region,
that'd be ideal. I don't know if the linear mapping can be subdivided in
this fashion, though.

> (This alignment is not necessary for upcoming systems with BBML3)
>=20
> However, to implement this, we'd need to split memblocks and I believe th=
e only
> way at the moment is temporarily mark it as "nomap" which didn't seem very
> popular in the comments on v3.

Could this be simplified if this type of allocation is always memblock
aligned?

Looking at map_mem(), it seems like we could add some sort of special-
casing in the for_each_mem_range() block to check if the memory is VPR
(or generic, page-granular carveout, or whatever we want to call it) and
set NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS in that case.

If that works, set_direct_map_*() could be enhanced to detect such cases
and always work. Or perhaps a more specific API could be introduced.

Thierry

--wsqkte2vdducxgiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmp/EGIACgkQ3SOs138+
s6FIfA/7BDMg2roMkVSyRLt06etjxYFBWHpNzxj/SvOzYROjoeOaUOJR15Xodk18
HI650LP1luxhtmIKPHRjGxZK30ROvHB6QTsl0lYM0cQZ4tVrv5WTMcL9uCui0WzA
LkF9SVH4YiJdbE4tCnWc9eJSxxedpCsS8d5cHLfDyI2cKvjAxgTxll8INqCMafAU
wehMyhd65emp5OYmvSuftsNzYf/uM0Oke8Rf64zZjOyZzpBi7AZG2CdROlrN/v1V
xODXrjdPaZvdq6HkzFVW0GYsouBaWb2rqzw/IsgO5RbT6vg/oOwo+4z50ZDefimA
x2mLXvg+gzqjY20hfJ82Bar0sCQ8nNlO6rLPpxwXMn9ICDpFV5aaiGvbaZ9ibDxR
yScvx4k0i/k6NPFoyuKJFSqNn9s4WGqU6p0j+un2K97HMEPtJ3onKs3Pjj63E38i
EkVAJZkrbt+PNYGiILRWWnU7dTqd5/CreBR7F0zFvVz0+JYjgfmlWcTdLKPAazag
PpRU7SZKUfHRd+LnsS54706H2dOP1rq5NXx+AGSdRJcwgw30XbIhZ3CmqYBVjbdN
Nh/5Y19dBDV5UhRx4o3Cqcb1BV/cuu2w0TpGyxoyIUUTFxgDp59uBi2Qi6nY/8kY
KdeMys4RVWucUUwpbtpKJamulwDRGtlLjyLEIqVeYZY/FOBiaKU=
=ERUC
-----END PGP SIGNATURE-----

--wsqkte2vdducxgiq--
