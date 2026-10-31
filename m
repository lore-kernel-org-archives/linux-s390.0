Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414605;
	b=RKYi8CQkCrsstEKWJyB5iba6v++/aUYyTFx9bSvD/G2so/doW93VdGiy0MilYByiwIHf
	 QkeSIW6JZEDkiYDb4YALQ17d8reIQ2AkDO6vWcZyPw66/oiQ6uqUBE01bNXZHQgsv9gGh
	 ouYI1/WvKX7cgxJ8RGQ8PwALuJl+JBzk/oOEsjLM8wgjVrmgq/jHqDglRHM4njkZ36HQf
	 kfsd7c1ZSB8KobkVAFgc432W0ahsUSpJheGUDmfwa/9lQ4uiqZGywRBqqs9si1jnJ7Il1
	 mmQNlHBT/MoKxFxKXQ6mLLaiDCyhs5MwFQXoEwy2eRXt40c136ql25YUp1OKO+RA+RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414605;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=2ekXJ0a8Q3aeP50m9J5zFbJe2TWONi3l/1vhiVAvAmk=;
	b=CUZNzOSAIAmuYGEj7UNk8osrW/PxQu/OLqyQKe2logHkZsxV0yg2ZIvNtzfztHraN09S
	 KXQihZbAm/HmO9Q1b3PpvOAxfWMnqsiYahWNsWa0TNkIEMuywVI48h/dfFN+ut/SNu6cU
	 YSsQsmVTLqXm8OmsunpW8Co8dJuQb2GYr6q1uN6o7MuwbUY0EV1w1WR/PrLapsoSEFTPn
	 1P4ihyn/A9UZhvwVjxk2k6SCnQpPltcPoNW1G2+QxxszL/H6HCzyuzBY3DrnG2yYhGmKr
	 0E3BEYb8nxtn+rdScE2fjWEXohj7+oRUgDuhIvtH/ozc16PXGQXTolboxzOjv3uN6JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TnVG+t3V;
	arc=none smtp.remote-ip=95.215.58.196
Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27F606A31D
	for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2026 02:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F27F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TnVG+t3V
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WsjTDowD69vaAV5c8r7Aevhgcpf9hq/Quk1PYoegTg0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793414600; v=1; x=1794019400;
 b=TnVG+t3VjS9fZ1tMp5GpjwAe+LVdBvZPHiltUW4cB4RrFWTGiqTMOIH/ctF97EJmz87H0ehE
 dsmGxXmOi/bko1nnb0o0vwMJHmmSLTtxBx0A91vbjeXkJ9bnHYsWZxPqfh7CchVuduqe4rFw/hd
 YwQ8Qh3h470eIxU/jjEjL/H4=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id dc0478d27c2ffce3;
	Sat, 31 Oct 2026 02:43:19 +0000
X-Mizu-Trace-ID: dc0478d27c2ffce3
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 3/4] mm/sparse-vmemmap: drop vmemmap_can_optimize()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <sashiko-outbox-191687@kernel.org>
Date: Sat, 31 Oct 2026 10:42:56 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lance Yang <lance.yang@linux.dev>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Oscar Salvador <osalvador@suse.de>,
 Qi Zheng <qi.zheng@linux.dev>,
 linux-mm@kvack.org,
 x86@kernel.org,
 linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5841D61D-50CB-4AA9-AC72-BD6AE8033589@linux.dev>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
 <20261030140720.1256062-4-songmuchun@bytedance.com>
 <sashiko-outbox-191687@kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 31, 2026, at 08:54, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [High] mm/sparse-vmemmap: dropping vmemmap_can_optimize() bypasses =
DAX arch config
> - [Medium] mm/sparse-vmemmap: section_activate() stores =
non-optimizable compound order
> - [Low] mm/sparse-vmemmap: missing header include breaks powerpc =
init_64.c build
> --
>=20
> commit 4171e4b9fc2abb84bf0e245a60563f33f94a263d
> Author: Muchun Song <muchun.song@linux.dev>
>=20
> mm/sparse-vmemmap: drop vmemmap_can_optimize()
>=20
> This commit removes the DAX-specific vmemmap_can_optimize() helper =
from
> include/linux/mm.h and relies on section_vmemmap_optimizable() to =
determine
> whether a section uses vmemmap optimization.
>=20
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index e875f73b0c6ff..4fb48fbe712d2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -38,7 +38,6 @@
>> #include <linux/bitops.h>
>> #include <linux/iommu-debug-pagealloc.h>
>> #include <linux/kcsan-checks.h>
>> -#include <linux/vmemmap-optimization.h>
>=20
> [Severity: Low]
> Does removing this include break the 64-bit PowerPC build when
> CONFIG_SPARSEMEM_VMEMMAP=3Dy is enabled?
>=20
> In arch/powerpc/mm/init_64.c, vmemmap_populate() calls
> section_set_compound_order():
>=20
>    section_set_compound_order(__pfn_to_section(page_to_pfn((struct =
page *)start)), 0);
>=20
> Previously, arch/powerpc/mm/init_64.c got the declaration of
> section_set_compound_order() transitively via include/linux/mm.h. =
Without
> including linux/vmemmap-optimization.h in arch/powerpc/mm/init_64.c,
> compiling it will fail with an implicit function declaration error.

I should include this header in the patch 2 to fix this, because I don't =
like
this implicit way of header file inclusion.

>=20
>> struct mempolicy;
>> struct anon_vma;
>> @@ -5395,42 +5394,6 @@ static inline void vmem_altmap_free(struct =
vmem_altmap *altmap,
>> }
>> #endif
>>=20
>> -#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
>> -static inline bool __vmemmap_can_optimize(struct vmem_altmap =
*altmap,
>> -					  struct dev_pagemap *pgmap)
>> -{
>> -	unsigned long nr_pages;
>> -	unsigned long nr_vmemmap_pages;
>> -
>> -	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
>> -		return false;
>> -
>> -	if (!pgmap || !is_power_of_2(sizeof(struct page)))
>> -		return false;
>> -
>> -	nr_pages =3D pgmap_vmemmap_nr(pgmap);
>> -	nr_vmemmap_pages =3D ((nr_pages * sizeof(struct page)) >> =
PAGE_SHIFT);
>> -	/*
>> -	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
>> -	 * pages. See layout diagram in =
Documentation/mm/vmemmap_dedup.rst
>> -	 */
>> -	return !altmap && (nr_vmemmap_pages > =
VMEMMAP_OPTIMIZATION_PAGES);
>> -}
>> -/*
>> - * If we don't have an architecture override, use the generic rule
>> - */
>> -#ifndef vmemmap_can_optimize
>> -#define vmemmap_can_optimize __vmemmap_can_optimize
>> -#endif
>> -
>> -#else
>> -static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
>> -					   struct dev_pagemap *pgmap)
>> -{
>> -	return false;
>> -}
>> -#endif
>=20
> [Severity: High]
> With vmemmap_can_optimize() removed, nothing in C code checks
> CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP anymore. Could this unintendedly
> enable DAX vmemmap optimization on architectures that only select
> ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP, such as 64-bit LoongArch?

You are right. This patch will enable vmemmap-optimization for device =
DAX
on LoongArch.

Because I plan to remove ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP completely =
in
the future, so I'll add a new commit before this one to disable HVO for
device DAX on LoongArch. It'll be easy to do this, just like patch 2 =
does
for PowerPC.

On LoongArch, HugeTLB HVO is supported without gigantic HugeTLB pages. =
So
there is no users of section-based vmemmap optimization. So just =
disabling
vmemmap optimization in architectural vmemmap_populate() is enough.

>=20
> When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy and CONFIG_ZONE_DEVICE=3Dy=
 are
> both enabled on 64-bit LoongArch, CONFIG_VMEMMAP_OPTIMIZATION is =
selected.
> In section_activate(), order is now set from pgmap->vmemmap_shift, and
> section_vmemmap_optimizable() -> vmemmap_optimizable_order() only =
checks
> IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION).
>=20
> As a result, activating a DAX section with pgmap->vmemmap_shift >=3D
> VMEMMAP_OPTIMIZATION_MIN_ORDER on LoongArch will map read-only shared =
tail
> PTEs and grab references to vmemmap_shared_tail_page via =
vmemmap_alloc_pte().
> However, LoongArch's vmemmap_free() in arch/loongarch/mm/init.c is an =
empty
> no-op stub:
>=20
>    void vmemmap_free(unsigned long start, unsigned long end, struct =
vmem_altmap *altmap)
>    {
>    }
>=20
> On section_deactivate(), those shared tail page references are leaked =
and
> the read-only PTEs remain mapped, causing subsequent section =
activations to
> either trigger WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)) and fail =
with
> -ENOMEM in vmemmap_pte_populate(), or fault in kernel mode when =
writing to
> struct pages through the stale read-only PTEs.
>=20
> [ ... ]
>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 3e9d6617c4bb2..43559593107c9 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>=20
> [ ... ]
>=20
>> @@ -699,10 +707,9 @@ static struct page * __meminit =
section_activate(int nid, unsigned long pfn,
>> 	struct mem_section *ms =3D __pfn_to_section(pfn);
>> 	struct mem_section_usage *usage =3D NULL;
>> 	struct page *memmap;
>> -	unsigned int order;
>> +	unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>> 	int rc;
>>=20
>> -	order =3D vmemmap_can_optimize(altmap, pgmap) ? =
pgmap->vmemmap_shift : 0;
>> 	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
>> 		return ERR_PTR(-EOPNOTSUPP);
>=20
> [Severity: Medium]
> What happens in section_activate() when pgmap->vmemmap_shift is =
non-zero,
> but is not actually optimizable (for example, when 0 < =
pgmap->vmemmap_shift
> < VMEMMAP_OPTIMIZATION_MIN_ORDER, or when !is_power_of_2(sizeof(struct =
page)))?

Even though this issue is unreachable, I'm still going to fix it since =
it is easy.
Something like:

diff --git a/include/linux/vmemmap-optimization.h =
b/include/linux/vmemmap-optimization.h
index fa9e9abd6656..104f7275a49f 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -42,7 +42,9 @@ static inline void section_set_compound_order(struct =
mem_section *section,
 {
        VM_WARN_ON(section_compound_order(section) && order &&
                   section_compound_order(section) !=3D order);
-       section->compound_page_order =3D order;
+
+       if (vmemmap_optimizable_order(order))
+               section->compound_page_order =3D order;
 }


Thanks.

>=20
> Previously, order was forced to 0 when vmemmap_can_optimize() returned
> false. Now, section_activate() passes the raw pgmap->vmemmap_shift to
> section_set_compound_order_range(pfn, nr_pages, order).
>=20
> Because __populate_section_memmap() only resets the order when both =
altmap
> and section_vmemmap_optimizable(ms) are true:
>=20
>    if (altmap && section_vmemmap_optimizable(ms))
>            section_set_compound_order(ms, 0);
>=20
> ms->compound_page_order remains non-zero for unoptimizable non-zero =
orders.
> Since section_activate() checks section_compound_order(ms) rather than
> section_vmemmap_optimizable(ms), wouldn't a subsequent partial-section
> activation (nr_pages < PAGES_PER_SECTION) in that section be =
erroneously
> rejected with -EOPNOTSUPP even though vmemmap optimization was never =
used?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20261030140720.1256062-1-songmuchun@bytedan=
ce.com?part=3D3

