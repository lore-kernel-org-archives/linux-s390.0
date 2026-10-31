Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408076;
	b=UU2a/OStUSYhr38TWIM9bF1pAagC9kZyb+Zxt3ndGE2wBBx30wFf7IjwiXlw+VZtGqfW
	 ZXOs7qyHXuTk/gTbih04MsgRSoamO+CRLfkrWMmUb9KCJdJI5Ry/QzrMkREoWBA6F4r7J
	 PV47gil2vJaEd3DmPqMQUGUw2dJv+AIU+HfZrdO7InmpUIsGS5xNWxh6B7SrAX7eqiNMk
	 HdPEj5YRKIWnmLHrHDPITIyI26rjGn3OodoT3PRq3dGHJanTlaXEHgFS8sTfNffNAWrzk
	 dyJoTQXsCWWlroU8pKsvIgeLwtZewiPeT9y5Hoe0cNblJlAeOrAUd2KFl6lTAJN6afQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408076;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4V3DWQ3hn0Q46L4O/zEHmAdFwXpEQVhEqdNgIlo3Qm8=;
	b=oQMo6allZGwAossCX6HNOlljb8NwzCEbArAnq8BPLuyDWruaByO2sw2JsAtCSUu1Dwcm
	 BH2ZEyaJIEPwzHvVckQsrFFl5M54v6fUPa14Bm1XhhNE/yok2iXlrjvyFsF1ZPedrY1bB
	 0LLnH8hr5hkulsZeLa8CtYhWyagbsdKiVsO6A1eUjrOKmRuTbV37y3cInvzxnA4MOlwoG
	 cpvTZhT9btozm7kq5G3nhe7dv3SLuddmi3PizKlPtGSnT49sy6bAXWX7wpzUMHC3rGJOF
	 gjRo6sjfgEJQ1acYzmlsvmrDqCgZeWk7c6xJrAPrf3S2vlE5g4SqZNCxqFISixIg4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdDEp1hg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B87606A31A
	for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdDEp1hg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065BB1F00A02;
	Sat, 31 Oct 2026 00:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793408075;
	bh=4V3DWQ3hn0Q46L4O/zEHmAdFwXpEQVhEqdNgIlo3Qm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdDEp1hgM5e6drAfESkvdZ5t1YJD6Pri82SC5R+jw4HbTRvxlmBXmCsEFJM/GuDuP
	 n8IDvfXBxlfxOkJKvdEeJ8kBRIqLoSCGcHND9S4hnZJiB0Ih7RokoISXstn0NTFcYs
	 eCOipphgG9GTuwe7lSaD5RuwK89VSF3Si4YA5tT7pfhYcGeCflQCRsmtfeKmFF9oGI
	 EXdcYDrepGQvcjhGSFCTOBn3c5MvO1aApESh/UE7bUyHe6q/8eLFfVuo6O2zXx1qJ7
	 Ye5G+ZHMQFY1M5L389TI8ieJ3ViUA5kY04VIrwqkrVXHr9ff3rnhhTwCapGw1JtGhH
	 gnoCYPDIH9i2w==
Message-ID: <sashiko-outbox-191688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] mm/sparse-vmemmap: drop @pgmap from vmemmap
 population APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>, "David Hildenbrand" <david@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>
Cc: "Lance Yang" <lance.yang@linux.dev>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Ritesh
 Harjani" <ritesh.list@gmail.com>, "Shrikanth Hegde" <sshegde@linux.ibm.com>, "Oscar
 Salvador" <osalvador@suse.de>, "Qi Zheng" <qi.zheng@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, linux-mm@kvack.org, x86@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261030140720.1256062-5-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
 <20261030140720.1256062-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:54:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm/sparse-vmemmap: section_activate() ignores ARCH_WANT_OPTIMIZE_D=
AX_VMEMMAP
- [Medium] mm/sparse-vmemmap: section_activate() stores non-optimizable com=
pound order
- [Low] powerpc/mm: missing vmemmap-optimization.h include in init_64.c
--

commit 48cc74f276edacd74ae0108659b8fbbf37ab5193
Author: Muchun Song <muchun.song@linux.dev>

mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs

This commit removes the @pgmap parameter from the vmemmap population helpers
and related memory hotplug interfaces, relying on mem_section state and
architecture-specific population code to determine whether vmemmap mappings
can be optimized.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4fb48fbe712d2..b4b63f89d1884 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5345,8 +5345,7 @@ static inline void print_vma_addr(char *prefix, uns=
igned long rip)
>  #endif
> =20
>  struct page * __populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
> -		struct dev_pagemap *pgmap);
> +		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);

[Severity: Low]
Does building arch/powerpc/mm/init_64.c with CONFIG_SPARSEMEM_VMEMMAP=3Dy f=
ail
due to an implicit declaration of section_set_compound_order() after the
earlier changes in this series?

In commit 84948c20ec18 ("powerpc/mm: drop powerpc vmemmap_can_optimize()"),
vmemmap_populate() in arch/powerpc/mm/init_64.c was updated to call
section_set_compound_order():

arch/powerpc/mm/init_64.c:vmemmap_populate() {
	...
	section_set_compound_order(__pfn_to_section(page_to_pfn((struct page *)sta=
rt)), 0);
	return __vmemmap_populate(start, end, node, altmap);
}

Then commit 4171e4b9fc2a ("mm/sparse-vmemmap: drop vmemmap_can_optimize()")
removed the linux/vmemmap-optimization.h include from include/linux/mm.h:

include/linux/mm.h:
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>

Because neither arch/powerpc/mm/init_64.c nor any header it includes pulls =
in
linux/vmemmap-optimization.h, should arch/powerpc/mm/init_64.c include
linux/vmemmap-optimization.h directly?

[ ... ]

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 43559593107c9..df71125a6ee23 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c

[ ... ]

> @@ -739,9 +736,9 @@ static struct page * __meminit section_activate(int n=
id, unsigned long pfn,
>  		return pfn_to_page(pfn);
> =20
>  	section_set_compound_order_range(pfn, nr_pages, order);

[Severity: Medium]
What happens in section_activate() when pgmap->vmemmap_shift is non-zero, b=
ut
smaller than VMEMMAP_OPTIMIZATION_MIN_ORDER (or sizeof(struct page) is not a
power of two)?

Previously, section_activate() gated order on vmemmap_can_optimize(altmap,
pgmap), leaving ms->compound_page_order as 0 whenever the order was not
eligible for vmemmap optimization. With commit 4171e4b9fc2a ("mm/sparse-vme=
mmap:
drop vmemmap_can_optimize()") and this commit, section_activate() sets:

mm/sparse-vmemmap.c:section_activate() {
	...
	unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
	int rc;

	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
		return ERR_PTR(-EOPNOTSUPP);
	...
	section_set_compound_order_range(pfn, nr_pages, order);
	memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap);
}

And __populate_section_memmap() only clears compound_page_order when both
altmap and section_vmemmap_optimizable(ms) are true:

mm/sparse-vmemmap.c:__populate_section_memmap() {
	...
	if (altmap && section_vmemmap_optimizable(ms))
		section_set_compound_order(ms, 0);
}

If 0 < pgmap->vmemmap_shift < VMEMMAP_OPTIMIZATION_MIN_ORDER (for instance,=
 a
2MB PMD-aligned devdax range with vmemmap_shift =3D 5 on 64KB-page PowerPC
where VMEMMAP_OPTIMIZATION_MIN_ORDER is 11), section_vmemmap_optimizable(ms)
returns false. However, ms->compound_page_order remains set to that non-zero
order even though the section's vmemmap is not optimized.

If a subsection of that section is later deactivated (leaving the section
non-empty) and re-added with nr_pages < PAGES_PER_SECTION, won't the
section_compound_order(ms) check in section_activate() falsely reject the
subsection activation with -EOPNOTSUPP?

> -	memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> +	memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap);

[Severity: High]
Could dropping vmemmap_can_optimize() and @pgmap unintentionally enable DAX
vmemmap optimization on architectures that select
ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP but not ARCH_WANT_OPTIMIZE_DAX_VMEMMAP,
such as 64-bit LoongArch?

Previously, __vmemmap_can_optimize() was guarded by
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP, so section_activate() kept order =3D=
 0
for dev_pagemap mappings when that option was disabled. After commit
4171e4b9fc2a ("mm/sparse-vmemmap: drop vmemmap_can_optimize()") and this
commit, CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP is no longer checked. Instead,
section_activate() unconditionally records pgmap->vmemmap_shift via
section_set_compound_order_range(), and section_vmemmap_optimizable() ->
vmemmap_optimizable_order() only checks IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZAT=
ION).

On 64-bit LoongArch, ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP is selected (enabli=
ng
CONFIG_VMEMMAP_OPTIMIZATION when CONFIG_HUGETLB_PAGE=3Dy), but
ARCH_WANT_OPTIMIZE_DAX_VMEMMAP is not selected, and vmemmap_free() is an
empty stub:

arch/loongarch/mm/init.c:
void vmemmap_free(unsigned long start, unsigned long end, struct vmem_altma=
p *altmap)
{
}

When memremap_pages() maps a dev_pagemap with vmemmap_shift >=3D
VMEMMAP_OPTIMIZATION_MIN_ORDER on LoongArch:

memremap_pages()
  pagemap_range()
    arch_add_memory() / add_pages()
      __add_pages()
        sparse_add_section()
          section_activate()
            populate_section_memmap()
              __populate_section_memmap()
                vmemmap_populate()
                  vmemmap_populate_hugepages()
                    vmemmap_populate_basepages()
                      vmemmap_pte_populate()
                        vmemmap_alloc_pte()

vmemmap_pte_populate() now installs read-only shared tail PTEs and takes
page references on the shared tail page. When memunmap_pages() later runs,
LoongArch's no-op vmemmap_free() leaves those PTEs mapped and leaks the
vmemmap pages while section_deactivate() resets compound_page_order to 0,
causing subsequent hot-add or memremap_pages() calls on that PFN range to
trigger WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)) in vmemmap_pte_populate()
or fault when writing to read-only vmemmap pages.

Should section_activate() still gate pgmap->vmemmap_shift on
IS_ENABLED(CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP) (as well as
!altmap && vmemmap_optimizable_order(pgmap->vmemmap_shift))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030140720.1256=
062-1-songmuchun@bytedance.com?part=3D4
