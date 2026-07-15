Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11F3A901F;
	Wed, 15 Jul 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131302; cv=none; b=MHHFvaLuzPg8Qs9XuYLwb98A9IhgVfBFn+gB+3SWtJeB+iwJdpwj6ga4VT4VRK6KFu83IPo/znIrcHIBmMg0B7AzfTT6JzSvE57Ns5f1RConxiOlUfjAzAP1juSkBfskushGQ6rB8xhQgLX730mp3b/FtOsmw7E9/ipvNfcBSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131302; c=relaxed/simple;
	bh=xwAMLt7rpcE8P63yyzqTVOXxB1AEal3a0nfL4+SyquM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JircpOw5cI/c05KFpH699vJ1yRIKzkgy1jYBgdGtPWDf283g+IDCzol64+t98nHlzL6QsEHkNWBXXkO8K5lnbC9oGsspAqjkoDeKuLioZp/MCqd+nynfVJLWCdcrH9MAQ24+6UHQJSxSnZeNb/YdQ/l64YhNMsWGUDSTS/4bLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh+VI423; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh+VI423"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6F11F000E9;
	Wed, 15 Jul 2026 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131294;
	bh=xwAMLt7rpcE8P63yyzqTVOXxB1AEal3a0nfL4+SyquM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jh+VI423rvA4pEB662vSG9nIdPacb3Hf4rr+qxFjQlFT2516JBKgnOQrQOb3QVvXb
	 ev2S5PMWLjQVETNU6ShzBjGduyOwtIokDYSYfY/6kvAxhyGuFyNwMZQdafK1argN6E
	 pU5azVYJ3QAVTUMUyakUa+abCdngPasAiLzco9AoNouJykJ8c/RJvW9GzGIe02Vzwa
	 hsUl54ctY/2tHS9kX9NTvUA5G82kBc0EbGH6wC17zifB2gfx9q/vXgh2zm5ICUGi+v
	 UPbrHHg5ciLkRC5pQ2KC9SK+xkZtNNBC6J6Hm6pTzs/VVQ/rcKICPZVcgzXg5qsPeA
	 M8JKoPlwQm5IQ==
Date: Wed, 15 Jul 2026 18:01:31 +0200
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
Message-ID: <alesre0ZfNV7vgco@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck>
 <akZkuwktaXFTrASP@orome>
 <akaSJ5D98w2cHqb6@orome>
 <akftuw9NyRy36fXA@willie-the-truck>
 <akuvyu1Pq0ZVMZV0@orome>
 <akzikTrmhMsvkNVY@willie-the-truck>
 <ak_8Po3NxgAU7k0T@orome>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbqkpw722zqmsvzm"
Content-Disposition: inline
In-Reply-To: <ak_8Po3NxgAU7k0T@orome>


--nbqkpw722zqmsvzm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
MIME-Version: 1.0

On Thu, Jul 09, 2026 at 09:58:01PM +0200, Thierry Reding wrote:
> On Tue, Jul 07, 2026 at 12:27:13PM +0100, Will Deacon wrote:
> > On Mon, Jul 06, 2026 at 03:49:24PM +0200, Thierry Reding wrote:
> > > On Fri, Jul 03, 2026 at 06:13:31PM +0100, Will Deacon wrote:
> > > > On Thu, Jul 02, 2026 at 06:41:23PM +0200, Thierry Reding wrote:
> > > > > On Thu, Jul 02, 2026 at 03:46:44PM +0200, Thierry Reding wrote:
> > > > > > On Thu, Jul 02, 2026 at 10:18:47AM +0100, Will Deacon wrote:
> > > > > > > On Wed, Jul 01, 2026 at 06:08:15PM +0200, Thierry Reding wrot=
e:
> > > > > > > > From: Chun Ng <chunn@nvidia.com>
> > > > > > > >=20
> > > > > > > > Add helpers to swap PROT_NORMAL and PROT_DEVICE_nGnRnE prot=
ection bits
> > > > > > > > on a kernel-linear-map range.
> > > > > > >=20
> > > > > > > That sounds like a really terrible idea. Why is this necessar=
y and how
> > > > > > > does it interact with things like load_unaligned_zeropad()?
> > > > > >=20
> > > > > > This is necessary because once the memory controller has walled=
 off the
> > > > > > new memory region the CPU must not access it under any circumst=
ances or
> > > > > > it'll cause the CPU to lock up (I think technically it'll hit a=
n SError
> > > > > > but in practice that just means it'll freeze, as far as I can t=
ell).
> > > > > >=20
> > > > > > Probably doesn't interact well at all with load_unaligned_zerop=
ad().
> > > > > >=20
> > > > > > > I think you should unmap the memory from the linear map and m=
emremap()
> > > > > > > it instead.
> > > > > >=20
> > > > > > Given that the memory can never be accessed by the CPU after th=
e memory
> > > > > > controller locks it down, I don't think we'll even need memrema=
p(). The
> > > > > > only thing we really need is the sg_table we hand out via the D=
MA BUFs
> > > > > > so that they can be used by device drivers to program their DMA=
 engines
> > > > > > internally.
> > > > > >=20
> > > > > > Looking through some of the architecture code around this, shou=
ldn't we
> > > > > > simply be using set_memory_encrypted() and set_memory_decrypted=
() for
> > > > > > this? While they might've been created for slightly other use-c=
ases,
> > > > > > they seem to be doing exactly what we want (i.e. remove the pag=
e range
> > > > > > from the linear mapping and flushing it, or restoring the valid=
 bit and
> > > > > > standard permissions, respectively).
> > > > >=20
> > > > > Ah... I guess we can't do it because we're not in a realm world a=
nd so
> > > > > the early checks in __set_memory_enc_dec() would return early and=
 turn
> > > > > it into a no-op.
> > > > >=20
> > > > > How about if I extract a common helper and provide set_memory_p()=
 and
> > > > > set_memory_np() in terms of those. Those are available on x86 and
> > > > > PowerPC as well, so fairly standard. I suppose at that point we're
> > > > > closer to set_memory_valid().
> > > >=20
> > > > Why not just call set_direct_map_invalid_noflush() +
> > > > flush_tlb_kernel_range() for each page? We already have APIs for th=
is.
> > >=20
> > > Having a "standard" helper with a fixed and documented purposed seemed
> > > like a preferable approach for this particular case. We also may want=
 to
> > > make the driver that uses this buildable as a module, in which case w=
e'd
> > > need to export these rather low-level APIs. And then there's also the
> > > fact that we typically call this on a rather large region of memory
> > > (usually something like 512 MiB), so doing it page-by-page is rather
> > > suboptimal.
> > >=20
> > > > The big challenge I see with any linear map manipulation, however, =
is
> > > > that it will rely on can_set_direct_map() which likely means you ne=
ed to
> > > > give up some performance and/or security to make this work. Does me=
mory
> > > > become inaccesible dynamically at runtime? If not, the best bet wou=
ld
> > > > be to describe it as a carveout in the DT and mark it as "no-map" so
> > > > we avoid mapping it in the first place.
> > >=20
> > > VPR exists in two modes: static and resizable. For static VPR we do
> > > exactly that: describe it as carveout in DT with no-map and deal with=
 it
> > > accordingly in the driver. Resizable VPR is for device that have small
> > > amounts of RAM. Content-protected video playback will in the worst ca=
se
> > > consume around 1.8 GiB of RAM, so we want to be able to reuse for oth=
er
> > > purposes when VPR is unused on those devices. In that case, the memory
> > > is also described as a reserved-memory region in DT, but it is marked=
 as
> > > reusable so that it can be managed by CMA.
> > >=20
> > > The resize operation is fairly slow to begin with because we need to
> > > stall the GPU and put it into reset before the operation, then take it
> > > out of reset and resume it afterwards.
> > >=20
> > > What kind of performance impact do you expect?
> >=20
> > You'll need to measure it, but we've seen reports of double-digit
> > percentage regressions in performance and power. As I said, the problem
> > is that you need to split the linear map to 4k page at runtime to unmap
> > the dynamic carveout, but that isn't something that can be done on most
> > CPUs. Therefore you end up having to use page-granular mappings for the
> > entire thing, similarly to how 'rodata_full' drives can_set_direct_map()
> > and the perf/power hit affects everything.
>=20
> The VPR has fairly large alignment restrictions (1 MiB) and we do unmap
> in fairly large chunks (512 MiB currently, but we can change that if it
> is helpful) because we really want to avoid resizing operations, so the
> tradeoff is between frequency of resize vs. potential memory wasted.
>=20
> Does that change anything with regards to performance?

Turns out that the system we need this for is very likely going to end
up using 4 KiB pages anyway because it doesn't have a whole lot of RAM
(which is the whole reason we want the VPR to be resizable in the first
place). So it sounds like set_direct_map_*() is a good way forward.

Still, wouldn't it potentially be much faster to unmap entire 2 MiB
blocks at a time if we know the driver guarantees the alignment? Maybe
the changes to add num_pages as an argument to set_direct_map_*() that
Mike mentioned would already be an improvement because it avoids those
gratuitous calls to can_set_direct_map().

Thierry

--nbqkpw722zqmsvzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpXrtgACgkQ3SOs138+
s6GDnRAAnq3U1zVlgJ4c+zt8KmTjZpRAfBuPML2LU9g5YIqK3pDsrt+qXaG6SRGG
svsBD63S7cpqMvuQsnlWdZ7jiTXeY72XEv12xXNALGKWXwlUkodB4zvNDPgwqmki
hh+Fg4/TmFGkLNEI1ot2FgQFbS61E+T4RPZtN+3pJID5m8vdpBIj++eDDvSoYPS4
ctd+RBvk9cSTXkEFLQ6QGJ0v91ZO82pEtkXwqpAtzO01vkSaTehQIxIaBa+T3pvj
eRM3YV5qc8L0MnKg2Exd+Q1IcnDCpYyJsnWp7UVlgxVTXm2kSDqxnd7Q+cRsgBN3
CqF7Q2DpeCMb+FCwtXICttjt2uGn10K6359IFPZUQ+tgC3Dlur+TUBKSdhEqVu78
mgq83v6eU4Z2NhAsM9j3FeOe7vm8ccCWNZsOr3+jxD8zS+xnuKojA37A4ZSykw0x
KWhCpLnOUt/SF7BoanBSvPz0kGR2M0M57haMXp7bbwwYOVdtE8y6LDfHHmZy8NgX
h06Kiu7I9kB4yAw1uzVlKQOI5fF+5AQJlg7OYGijHG3XCC4kW4WV9XI3Eiq04vYr
imNiSb1018jeBaGTtLCPtgGEYNcwO4N/6IQBCDhAAs9sqY//cKD0WArBqb+dgIDo
wQnLmnG3Y4YfZt3XuuKCr+/aTbO/rKspuVXslgkCOS81J4nhNdQ=
=/smH
-----END PGP SIGNATURE-----

--nbqkpw722zqmsvzm--
