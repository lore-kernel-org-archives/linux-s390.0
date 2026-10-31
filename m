Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408075;
	b=xGy7Qdk3QiT1sltQTsKPsNh6Dls1XF3vN4STSVdcj+a3Gja5epbUxtrmebrTzVK50gTH
	 iO4O5iWs5TqTnq6shvHVv9m6YphwOleW8m+K6PyBFajbzdeNAuMDRmpDfN9GBg9yXkozv
	 EMW9uXfuc5reIVh6SlbVJuH+0eNy01eUs9dDsmvVAnVI7n8FxT3fxTDY+R2zZ5oAo4KQV
	 C7ZRSXuTFPvz+xqWpwH0MGfw1B1vej6kuFpSh+HxFugaqpvI/Mwab8vbLEMOmjZ7A/sGY
	 S2wq4dlUnMQZYa1ooXoUp8YLM9Arc0paXBCdWj9cSpw35djNvTy68Ddds6OIqvN48fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408075;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UeX+wdDShRmhPelNetjZ+aWPVWfNItPj8vq7heLDX1Q=;
	b=mm1Sf65p2NEGGi6QtCU3G7GXqFFv7j8nzj9guUKtGiroPwIK7RxavnUDYM8l7t2yrcwE
	 aNqxqsdJKwSwklGI1scnbpFhwz33ZGRHrixykLE2B/QB2s7efngjQwACUN9+lsvfDUGiT
	 oMh9M1/aHmP95ZBLZrJoR4ACL/Tqa6tAA1UVqprt9hqbnyNEFrlCklV+9j3qgWE9j66Da
	 K6Yt+MFAyl+aEOeclcKdd0CdBy4sTxIonkgq9uy8YwOCbXi/pYHz2ZZcZL4eFV3LVXW7C
	 RpkS0xxtY/WkyJ9EmKKS+Ndyk6MSSnRx14RNDEwVffvdkAkn5IUvpGSz1Ku/EPl78YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h17If4ym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5070606A31C
	for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2026 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h17If4ym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A687B1F000C1;
	Sat, 31 Oct 2026 00:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793408074;
	bh=UeX+wdDShRmhPelNetjZ+aWPVWfNItPj8vq7heLDX1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h17If4ymRuQeHDvE6GWjSOg6n8BQB36Rr7jWpMqe2IbSBhAFzZapSK/FPlVBkp1jw
	 WBaEkb/oJG89kFx6e34XvY5t149Cw8YqOyeLsq4EhvTkqlPku0Egnhml2lCNAVM8lh
	 mRXtNQYnOafN0TNbAhJtBUQ7axwloxhSFZEHaiHlk55Dz6kv6huTZBPvk785aHP/fE
	 tmpLrgJbF1TCyo6hoAlUtP7P+L95btmcIhJ8rrUgEB+n2ywIVFtVz+YqRddTiqqH5L
	 w/dac6Jnxlh7pqjvyM5kKsoDblbvBDSBp14fmUuMdIh4lGiugSwyCeKGNmkmPwj8dg
	 BFTAY+SHwBZEw==
Message-ID: <sashiko-outbox-191687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/sparse-vmemmap: drop vmemmap_can_optimize()
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
In-Reply-To: <20261030140720.1256062-4-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
 <20261030140720.1256062-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:54:33 +0000
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
- [High] mm/sparse-vmemmap: dropping vmemmap_can_optimize() bypasses DAX ar=
ch config
- [Medium] mm/sparse-vmemmap: section_activate() stores non-optimizable com=
pound order
- [Low] mm/sparse-vmemmap: missing header include breaks powerpc init_64.c =
build
--

commit 4171e4b9fc2abb84bf0e245a60563f33f94a263d
Author: Muchun Song <muchun.song@linux.dev>

mm/sparse-vmemmap: drop vmemmap_can_optimize()

This commit removes the DAX-specific vmemmap_can_optimize() helper from
include/linux/mm.h and relies on section_vmemmap_optimizable() to determine
whether a section uses vmemmap optimization.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e875f73b0c6ff..4fb48fbe712d2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -38,7 +38,6 @@
>  #include <linux/bitops.h>
>  #include <linux/iommu-debug-pagealloc.h>
>  #include <linux/kcsan-checks.h>
> -#include <linux/vmemmap-optimization.h>

[Severity: Low]
Does removing this include break the 64-bit PowerPC build when
CONFIG_SPARSEMEM_VMEMMAP=3Dy is enabled?

In arch/powerpc/mm/init_64.c, vmemmap_populate() calls
section_set_compound_order():

    section_set_compound_order(__pfn_to_section(page_to_pfn((struct page *)=
start)), 0);

Previously, arch/powerpc/mm/init_64.c got the declaration of
section_set_compound_order() transitively via include/linux/mm.h. Without
including linux/vmemmap-optimization.h in arch/powerpc/mm/init_64.c,
compiling it will fail with an implicit function declaration error.

>  struct mempolicy;
>  struct anon_vma;
> @@ -5395,42 +5394,6 @@ static inline void vmem_altmap_free(struct vmem_al=
tmap *altmap,
>  }
>  #endif
> =20
> -#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
> -static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
> -					  struct dev_pagemap *pgmap)
> -{
> -	unsigned long nr_pages;
> -	unsigned long nr_vmemmap_pages;
> -
> -	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
> -		return false;
> -
> -	if (!pgmap || !is_power_of_2(sizeof(struct page)))
> -		return false;
> -
> -	nr_pages =3D pgmap_vmemmap_nr(pgmap);
> -	nr_vmemmap_pages =3D ((nr_pages * sizeof(struct page)) >> PAGE_SHIFT);
> -	/*
> -	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
> -	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
> -	 */
> -	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
> -}
> -/*
> - * If we don't have an architecture override, use the generic rule
> - */
> -#ifndef vmemmap_can_optimize
> -#define vmemmap_can_optimize __vmemmap_can_optimize
> -#endif
> -
> -#else
> -static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
> -					   struct dev_pagemap *pgmap)
> -{
> -	return false;
> -}
> -#endif

[Severity: High]
With vmemmap_can_optimize() removed, nothing in C code checks
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP anymore. Could this unintendedly
enable DAX vmemmap optimization on architectures that only select
ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP, such as 64-bit LoongArch?

When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy and CONFIG_ZONE_DEVICE=3Dy are
both enabled on 64-bit LoongArch, CONFIG_VMEMMAP_OPTIMIZATION is selected.
In section_activate(), order is now set from pgmap->vmemmap_shift, and
section_vmemmap_optimizable() -> vmemmap_optimizable_order() only checks
IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION).

As a result, activating a DAX section with pgmap->vmemmap_shift >=3D
VMEMMAP_OPTIMIZATION_MIN_ORDER on LoongArch will map read-only shared tail
PTEs and grab references to vmemmap_shared_tail_page via vmemmap_alloc_pte(=
).
However, LoongArch's vmemmap_free() in arch/loongarch/mm/init.c is an empty
no-op stub:

    void vmemmap_free(unsigned long start, unsigned long end, struct vmem_a=
ltmap *altmap)
    {
    }

On section_deactivate(), those shared tail page references are leaked and
the read-only PTEs remain mapped, causing subsequent section activations to
either trigger WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)) and fail with
-ENOMEM in vmemmap_pte_populate(), or fault in kernel mode when writing to
struct pages through the stale read-only PTEs.

[ ... ]

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 3e9d6617c4bb2..43559593107c9 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c

[ ... ]

> @@ -699,10 +707,9 @@ static struct page * __meminit section_activate(int =
nid, unsigned long pfn,
>  	struct mem_section *ms =3D __pfn_to_section(pfn);
>  	struct mem_section_usage *usage =3D NULL;
>  	struct page *memmap;
> -	unsigned int order;
> +	unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>  	int rc;
> =20
> -	order =3D vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : =
0;
>  	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
>  		return ERR_PTR(-EOPNOTSUPP);

[Severity: Medium]
What happens in section_activate() when pgmap->vmemmap_shift is non-zero,
but is not actually optimizable (for example, when 0 < pgmap->vmemmap_shift
< VMEMMAP_OPTIMIZATION_MIN_ORDER, or when !is_power_of_2(sizeof(struct page=
)))?

Previously, order was forced to 0 when vmemmap_can_optimize() returned
false. Now, section_activate() passes the raw pgmap->vmemmap_shift to
section_set_compound_order_range(pfn, nr_pages, order).

Because __populate_section_memmap() only resets the order when both altmap
and section_vmemmap_optimizable(ms) are true:

    if (altmap && section_vmemmap_optimizable(ms))
            section_set_compound_order(ms, 0);

ms->compound_page_order remains non-zero for unoptimizable non-zero orders.
Since section_activate() checks section_compound_order(ms) rather than
section_vmemmap_optimizable(ms), wouldn't a subsequent partial-section
activation (nr_pages < PAGES_PER_SECTION) in that section be erroneously
rejected with -EOPNOTSUPP even though vmemmap optimization was never used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030140720.1256=
062-1-songmuchun@bytedance.com?part=3D3
