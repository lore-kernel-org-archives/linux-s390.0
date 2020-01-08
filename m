Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726087AbgAHMkB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 07:40:01 -0500
Subject: Re: [PATCH v2 7/8] mm/memory_hotplug: Add pgprot_t to mhp_modifiers
References: <20200107205959.7575-1-logang@deltatee.com>
 <20200107205959.7575-8-logang@deltatee.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f4c11a37-91dd-a366-7683-4e4cd4bd7e99@redhat.com>
Date: Wed, 8 Jan 2020 13:39:48 +0100
MIME-Version: 1.0
In-Reply-To: <20200107205959.7575-8-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>, Michal Hocko <mhocko@suse.com>

On 07.01.20 21:59, Logan Gunthorpe wrote:
> devm_memremap_pages() is currently used by the PCI P2PDMA code to creat=
e
> struct page mappings for IO memory. At present, these mappings are crea=
ted
> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, =
on
> x86, an mtrr register will typically override this and force the cache
> type to be UC-. In the case firmware doesn't set this register it is
> effectively WB and will typically result in a machine check exception
> when it's accessed.
>=20
> Other arches are not currently likely to function correctly seeing they
> don't have any MTRR registers to fall back on.
>=20
> To solve this, add an argument to arch_add_memory() to explicitly
> set the pgprot value to a specific value.

You're adding a parameter indirectly by adding it to the structure.
Maybe "provide a way to specify the pgprot value explicitly to
arch_add_memory()"

>=20
> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a

s/is/need/

> simple change to pass the pgprot_t down to their respective functions
> which set up the page tables. For x86_32, set the page tables explicitl=
y

"page table protection" ?

> using _set_memory_prot() (seeing they are already mapped). For sh, reje=
ct
> anything but PAGE_KERNEL settings -- this should be fine, for now, seei=
ng
> sh doesn't support ZONE_DEVICE anyway.
>=20
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  arch/arm64/mm/mmu.c            | 3 ++-
>  arch/ia64/mm/init.c            | 4 ++++
>  arch/powerpc/mm/mem.c          | 3 ++-
>  arch/s390/mm/init.c            | 2 +-
>  arch/sh/mm/init.c              | 3 +++
>  arch/x86/mm/init_32.c          | 5 +++++
>  arch/x86/mm/init_64.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 ++
>  mm/memory_hotplug.c            | 2 +-
>  mm/memremap.c                  | 6 +++---
>  10 files changed, 24 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3320406579c3..9b214b0d268f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1058,7 +1058,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  		flags =3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> =20
>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
> +			     size, modifiers->pgprot, __pgd_pgtable_alloc,
> +			     flags);
> =20
>  	memblock_clear_nomap(start, size);
> =20
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index daf438e08b96..5fd6ae4929c9 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -677,6 +677,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	int ret;
> =20
>  	ret =3D __add_pages(nid, start_pfn, nr_pages, modifiers);
> +	if (modifiers->pgprot !=3D PAGE_KERNEL)
> +		return -EINVAL;

... maybe better "if (WARN_ON_ONCE(...))"
[...]

> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -56,9 +56,11 @@ enum {
>  /*
>   * Restrictions for the memory hotplug:
>   * altmap: alternative allocator for memmap array
> + * pgprot: page protection flags to apply to newly added page tables
>   */
>  struct mhp_modifiers {
>  	struct vmem_altmap *altmap;
> +	pgprot_t pgprot;
>  };
> =20
>  /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1bb3f92e087d..0888f821af06 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1027,7 +1027,7 @@ static int online_memory_block(struct memory_bloc=
k *mem, void *arg)
>   */
>  int __ref add_memory_resource(int nid, struct resource *res)
>  {
> -	struct mhp_modifiers modifiers =3D {};
> +	struct mhp_modifiers modifiers =3D {.pgprot =3D PAGE_KERNEL};

I think we usually use spaces like

=3D { .pgprot =3D PAGE_KERNEL };

t480s: ~/git/linux virtio-mem-v1 $ git grep "=3D {\." | wc -l
978
t480s: ~/git/linux virtio-mem-v1 $ git grep "=3D { " | wc -l
35447

>  	u64 start, size;
>  	bool new_node =3D false;
>  	int ret;
> diff --git a/mm/memremap.c b/mm/memremap.c
> index e30be8ba706b..45ab4ef0643d 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -163,8 +163,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int=
 nid)
>  		 * We do not want any optional features only our own memmap
>  		 */
>  		.altmap =3D pgmap_altmap(pgmap),
> +		.pgprot =3D PAGE_KERNEL,
>  	};
> -	pgprot_t pgprot =3D PAGE_KERNEL;
>  	int error, is_ram;
>  	bool need_devmap_managed =3D true;
> =20
> @@ -252,8 +252,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int=
 nid)
>  	if (nid < 0)
>  		nid =3D numa_mem_id();
> =20
> -	error =3D track_pfn_remap(NULL, &pgprot, PHYS_PFN(res->start), 0,
> -			resource_size(res));
> +	error =3D track_pfn_remap(NULL, &modifiers.pgprot, PHYS_PFN(res->star=
t),
> +				0, resource_size(res));
>  	if (error)
>  		goto err_pfn_remap;
> =20
>=20

The !arch code looks good to me (besides I would prefer "params" instead
of "modifiers").

Acked-by: David Hildenbrand <david@redhat.com>


--=20
Thanks,

David / dhildenb
