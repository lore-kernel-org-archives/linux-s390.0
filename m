Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0536B061;
	Tue, 18 Aug 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050094; cv=none; b=X49TEIDKzjVATQLcJiBz782UFQsVFrsrp4TVsY3LqrUn9SeeLFWsHLbEx/j2OyZ/X6P05/UZm64sY0xRznQ08HQZLP3exGYAJyHAlCJA+c8K6s5TMOktC81k69Jnrcrx0QJ/xBxFYmlgdE0PWL+4BTP2EWJT6x46lspXrnd4bp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050094; c=relaxed/simple;
	bh=b9L2Q+/39LajXyI0hbto1W1KTlMuQqxZ9moms94Cz+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsaugepBHDiBxEdmuekQO97cJUDUjbePMqzXuv3BL23munMZ6X5KOTT3Ps2KDn9AGrHz8vgB8Rsut/1BI7vHPbqeOWyCNDa6+KhINQokbH/XMi7q3lScWHq07Bc9UdoNKDw4NXZH5KZqzYTPEAyv6IdejmA9dMvQNG+u346PVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNaMFjMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNaMFjMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339CC1F00A3A;
	Tue, 18 Aug 2026 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787050091;
	bh=GrBQXav6R2N3UzqUw7GU01knzjenLA9tVxk0EyQNjos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JNaMFjMaPme4OhExTnNEODdf6jGxO1LPjtKYYPG6NK3EtPaSDQwU4IafIO/GMVnGQ
	 hxYVtynOnpQyYHxTaeGB8Z4sNvvC45R96tQFCzLxGl9wlNqXkgYsb+n3KIeqjT50uZ
	 ZrUuKJ7BTITw2OWY51K+V3rBr5DS3kJ9lHjqnX6sfdf+djRrnmPZDqu2143bCHkKyV
	 1Wp5KGBSsVGPOdB9iiCvDg07Kp+371+E8vRmhEmyo7fLFQ7TgpIH2hlFGUAQLm+wmo
	 fxZEI2u2sj4q26sUMC+xdSR5bFDso7FPRt8xTZ4BChUCyAmXevcR0jWK5EenAvB3vI
	 ZvgfvRtNQAWzw==
Date: Tue, 18 Aug 2026 12:48:09 +0200
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
Message-ID: <aoQ1lhZojzsSkWHQ@orome>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
 <an4MEI7lkc2p3nKI@google.com>
 <an8K2gb1pIqbDj6-@orome>
 <aoNDRTKCUkzd2n5G@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hrqt3li6dwgco3w"
Content-Disposition: inline
In-Reply-To: <aoNDRTKCUkzd2n5G@google.com>


--3hrqt3li6dwgco3w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
MIME-Version: 1.0

On Mon, Aug 17, 2026 at 06:22:13PM +0100, Vincent Donnefort wrote:
> On Fri, Aug 14, 2026 at 02:56:05PM +0200, Thierry Reding wrote:
> > On Thu, Aug 13, 2026 at 07:25:20PM +0100, Vincent Donnefort wrote:
> > > On Fri, Aug 07, 2026 at 05:54:27PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > NVIDIA Tegra SoCs commonly define a Video-Protection-Region, which =
is a
> > > > region of memory dedicated to content-protected video decode and
> > > > playback. This memory cannot be accessed by the CPU and only certain
> > > > hardware devices have access to it.
> > > >=20
> > > > Expose the VPR as a DMA heap so that applications and drivers can
> > > > allocate buffers from this region for use-cases that require this k=
ind
> > > > of protected memory.
> > > >=20
> > > > VPR has a few very critical peculiarities. First, it must be a sing=
le
> > > > contiguous region of memory (there is a single pair of registers th=
at
> > > > set the base address and size of the region), which is configured by
> > > > calling back into the secure monitor. The memory region also needs =
to
> > > > quite large for some use-cases because it needs to fit multiple vid=
eo
> > > > frames (8K video should be supported), so VPR sizes of ~2 GiB are
> > > > expected. However, some devices cannot afford to reserve this amount
> > > > of memory for a particular use-case, and therefore the VPR must be
> > > > resizable.
> > > >=20
> > > > Unfortunately, resizing the VPR is slightly tricky because the GPU =
found
> > > > on Tegra SoCs must be in reset during the VPR resize operation. Thi=
s is
> > > > currently implemented by freezing all userspace processes and calli=
ng
> > > > invoking the GPU's freeze() implementation, resizing and the thawin=
g the
> > > > GPU and userspace processes. This is quite heavy-handed, so eventua=
lly
> > > > it might be better to implement thawing/freezing in the GPU driver =
in
> > > > such a way that they block accesses to the GPU so that the VPR resi=
ze
> > > > operation can happen without suspending all userspace.
> > > >=20
> > > > In order to balance the memory usage versus the amount of resizing =
that
> > > > needs to happen, the VPR is divided into multiple chunks. Each chun=
k is
> > > > implemented as a CMA area that is completely allocated on first use=
 to
> > > > guarantee the contiguity of the VPR. Once all buffers from a chunk =
have
> > > > been freed, the CMA area is deallocated and the memory returned to =
the
> > > > system.
> > >=20
> > > Hi,
> > >=20
> > > I believe we (the Android team) are trying to solve similar issue to =
yours: Arm
> > > CPUs can still speculatively read memory after it has been transition=
ed to the
> > > Secure state, as long as they retain a cacheable mapping to it.
> > >=20
> > > As modifying the direct mapping is difficult, the workaround ended up=
 in the
> > > hypervisor which unmaps the pages from the host stage-2 on intercepte=
d FF-A Lend
> > > invocations.
> > >=20
> > > If convenient, this is nonetheless the wrong place to do it. Scatteri=
ng the host
> > > stage-2 is really terrible for performance and we would like to move =
it where it
> > > should be, directly into the kernel...
> > >=20
> > > This is what I thought was the attempt in v3, but I am now a bit conf=
used
> > > because I see you are using set_direct_map_invalid_noflush()
> > > set_direct_map_default_noflush(), but I am not sure that works if rod=
ata=3Dfull is
> > > not set? So does the memory for the NVIDIA IP still need to be unmapp=
ed?
> >=20
> > Yeah, this currently relies on the circumstances being such that
> > can_set_direct_map() returns true, and in the case where we want to use
> > the resizable VPR functionality, we're going to have page-granular
> > mappings anyway.
> >=20
> > > If so, how about having an option where the CMA allocation is backed =
by a direct
> > > map with the same page granularity, or at least a smaller and aligned=
 granule?
> > >=20
> > > With that, we know that for whatever CMA allocation we do, we can saf=
ely unmap
> > > from the direct map without risking splitting blocks. On CMA free, we=
 can safely
> > > remap into the direct map as I do not believe we coalesce yet.
> >=20
> > This sounds intriguing. For VPR we could possibly make the size a
> > multiple of the memblock size (or whatever might be appropriate). If we
> > can create a page-granular linear mapping specifically for that region,
> > that'd be ideal. I don't know if the linear mapping can be subdivided in
> > this fashion, though.
>=20
> Actually I don't think modifying the memblock is necessary at all!
>=20
> Here's what I have so far:
>=20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d4de88770ecf..a9f81413b70d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -22,6 +22,7 @@
>  #include <linux/fs.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> +#include <linux/of_fdt.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/kfence.h>
> @@ -1138,6 +1139,27 @@ static inline void arm64_kfence_map_pool(void) { }
> =20
>  #endif /* CONFIG_KFENCE */
> =20
> +#define MAX_FORCE_PTE_REGIONS 64 /* Greater or equal to MAX_RESERVED_REG=
IONS */
> +
> +static struct {
> +       phys_addr_t start;
> +       phys_addr_t end;
> +} force_pte_regions[MAX_FORCE_PTE_REGIONS] __initdata;
> +
> +void __init early_init_dt_force_pte_arch(phys_addr_t start, phys_addr_t =
end)
> +{
> +       static int count;
> +
> +       if (force_pte_mapping())
> +               return;
> +
> +       if (count >=3D MAX_FORCE_PTE_REGIONS)
> +               return;
> +
> +       force_pte_regions[count].start =3D start;
> +       force_pte_regions[count++].end =3D end;
> +}
> +
>  static void __init map_mem(void)
>  {
>         static const u64 direct_map_end =3D _PAGE_END(VA_BITS_MIN);
> @@ -1186,6 +1208,15 @@ static void __init map_mem(void)
>         __map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
>                        flags);
> =20
> +       for (i =3D 0; i < ARRAY_SIZE(force_pte_regions); i++) {
> +               if (!force_pte_regions[i].end)
> +                       break;
> +
> +               __map_memblock(force_pte_regions[i].start, force_pte_regi=
ons[i].end,
> +                              pgprot_tagged(PAGE_KERNEL),
> +                              flags | NO_BLOCK_MAPPINGS | NO_CONT_MAPPIN=
GS);
> +       }

Interesting. I had been thinking more along the lines of adding this
directly into memblock using a new entry in enum memblock_flags. None of
the existing ones seem to do what we need here, though some are closely
related. MEMBLOCK_SECURE or MEMBLOCK_PROTECTED are quite specific and
don't necessarily mean that we need the mapping to be page-granular, so
MEMBLOCK_PAGE_GRANULAR is perhaps clearer.

Adding this to memblock has the advantage of not needing that fixed-size
force_pte_regions side-channel, but obviously it means that we can only
operate at memblock size granularity. With the above proposal, what
happens if the for_each_mem_range() below covers a region that you've
already __map_memblock()'ed above?

> +
>         /* map all the memory banks */
>         for_each_mem_range(i, &start, &end) {
>                 /*
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 42e3e2d8a2b8..445f204f01e4 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -136,6 +136,8 @@ static int __init early_init_dt_reserve_memory(phys_a=
ddr_t base,
>         return memblock_reserve(base, size);
>  }
> =20
> +void __weak early_init_dt_force_pte_arch(phys_addr_t start, phys_addr_t =
end) { }
> +
>  /*
>   * __reserved_mem_reserve_reg() - reserve memory described in the
>   * first entry in 'reg' property
> @@ -168,6 +170,9 @@ static int __init __reserved_mem_reserve_reg(unsigned=
 long node,
>         size =3D s;
> =20
>         if (size && early_init_dt_reserve_memory(base, size, nomap) =3D=
=3D 0) {
> +               if (of_get_flat_dt_prop(node, "force-pte", NULL))
> +                       early_init_dt_force_pte_arch(base, base + size);
> +
>                 fdt_fixup_reserved_mem_node(node, base, size);
>                 pr_debug("Reserved memory: reserved region for node '%s':=
 base %pa, size %lu MiB\n",
>                          uname, &base, (unsigned long)(size / SZ_1M));
> @@ -517,6 +522,9 @@ static int __init __reserved_mem_alloc_size(unsigned =
long node, const char *unam
>                 return -ENOMEM;
>         }
> =20
> +       if (of_get_flat_dt_prop(node, "force-pte", NULL))
> +               early_init_dt_force_pte_arch(base, base + size);
> +
>         fdt_fixup_reserved_mem_node(node, base, size);
>         fdt_init_reserved_mem_node(node, uname, base, size);
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 51dadbaa3d63..6c73c76dee1b 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -74,6 +74,7 @@ extern void early_init_dt_check_for_usable_mem_range(vo=
id);
>  extern int early_init_dt_scan_chosen_stdout(void);
>  extern void early_init_fdt_scan_reserved_mem(void);
>  extern void early_init_fdt_reserve_self(void);
> +extern void early_init_dt_force_pte_arch(phys_addr_t start, phys_addr_t =
end);
>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
>  extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
> =20
> >=20
> > > (This alignment is not necessary for upcoming systems with BBML3)
> > >=20
> > > However, to implement this, we'd need to split memblocks and I believ=
e the only
> > > way at the moment is temporarily mark it as "nomap" which didn't seem=
 very
> > > popular in the comments on v3.
> >=20
> > Could this be simplified if this type of allocation is always memblock
> > aligned?
> >=20
> > Looking at map_mem(), it seems like we could add some sort of special-
> > casing in the for_each_mem_range() block to check if the memory is VPR
> > (or generic, page-granular carveout, or whatever we want to call it) and
> > set NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS in that case.
> >=20
> > If that works, set_direct_map_*() could be enhanced to detect such cases
> > and always work. Or perhaps a more specific API could be introduced.
> >=20
> > Thierry
>=20
> for set_direct_map() I think we could extend it to check if it is mapped =
at the
> PTE-level and if it is we can proceed?
>=20
> I am currently looking at extending CMA with an option "unmap-on-alloc;" =
that
> would only be available if CONFIG_ARCH_HAS_SET_DIRECT_MAP, or
> cma_set_unmap_on_alloc, or if "force-pte;" is set.=20

I suppose we could add something like this into the new cma_alloc_at()
function that I proposed in v5. The use-case for that is already quite
specific (i.e. it essentially means the CMA is externally managed) and
that might be what similar drivers may want to do. I don't know if it
would be more generally applicable to regular cma_alloc() users, too.

Thierry

--3hrqt3li6dwgco3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqEOGYACgkQ3SOs138+
s6EigRAArj1eO1c267NHDHdo/8MR1SRlx3hdgYU/jHbt/ggms70x+OpRbdIk3NAm
rPLA8Unuwq39pAECQrhWANa4M9WQoDNqPgV6s1/l/2Yrs+kyj4ns3kE8umrHmCm0
M3CQqR3yZMdVshcNq0zB4jrTXHcjcyVcevYsjhXbQIMoZib3LvB/LKxum/qytZYR
2UJpGXu6Zoo6VeSp7xeqACPfj1yYRHhNYc9Y2YnnlV1LDoKgZBPve+t2zvfmsGn/
NqoQmyhMMsdCQLmyHH3lX/sT2LUmIyqUx5sBt89W7WgN7Au2OUP1Mpv3LyLAv2Cb
s08NrRUmYgpxB33BRo/wwwymlUcX/f3Udkg6iQYgqZhyTtgZjzN2dEki1otsNdcP
Fuvwa6v65ImK0gtapZNxwUUSV4NPGoic1ZyPm4ujMUGLt0F2sMTl/LrYBYyoaazJ
GoYKFmosVmOLOEZOM5qDNkUDsnMzsazzZPR80scJZyCBUU1vh6OaQUzIX6wdMfhc
Cmo/+YkPWoquiaVLIFf8jiNV5E0nwhyjPghb4fVW9DIJJc92u5UQwhqYi9hmAb+j
uBuMcesiN0ijSl+udd2sQDsY0aiepDhr/JJPLG+L+k+s7x25/LPpzzJw/HP+eHc5
GNjtrSj+FizP+UgvY7jR67WwZg6+OPF+7NMU+UKEJIRwDm1LiMA=
=Sxz0
-----END PGP SIGNATURE-----

--3hrqt3li6dwgco3w--
