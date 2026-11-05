Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863014;
	b=EiJ5PB52qQzHgUAel6ic/QC8jt3FhBt/fN6DOnIxBGWa3Ptemv3Fi1uOFU4tS+k6qdx6
	 SjYvRANepoVy3l1/09b76oSUH54jVadM7+LAkgYbf311LzoROxb4DfCHXAQSw8vw2Iimo
	 mFQRpQjupXPd6zF6tjzTMvd3kYHv5p1igSB/ColfG6DSzpY/uQMey1Gwkvcq21nWigFmt
	 7XC0v0FHwqqOL7CF+m0DG++a2v1v17YX0q2j22KHZSWbbJh8WgwJGyKrDgpdT3wYgE1rb
	 pVDVEmxUvakXA3/HA6+jGzEutt/as4amsaCgpENRVQFpeyZFkhAh2lpczoooo7auCOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ELp7uyQISlekK6wZ3Z38qoZleKazeMHWG5TRxk9j71o=;
	b=yXB16E/ay3VcmX1e6ZURDbOhfMSpP6kI1XSQBoaTZ9hRSL2nsctzkKD5YjCJvUc4sdIg
	 DVdT0Lt3I8lpgGMNINTAUDJVdSvflqGKy5f+55IW3HpclmvK1ysJOjqYQj9Thi/+H5T9w
	 d80zTn42bjQ74Uq6yTr+Dsl920beJnwjYnN7EIkVHFEZGm0NKZOMFbVhUSYS87trqBYqo
	 cU/XIS+L+BrsP7XAU9r17nc20Cb9uE9e89KC1jyrWJdnYLaoiXEfTLsY6uJF4Q1fFrwQK
	 T63uoutC8tg29D1vy9cx1KeFUJqVtnT9HTFz6eUWmSwcqDT45OJL0OiIBbEc9flgcRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCC0tsF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF3606A31B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCC0tsF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302F1F0093A;
	Thu,  5 Nov 2026 07:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863013;
	bh=ELp7uyQISlekK6wZ3Z38qoZleKazeMHWG5TRxk9j71o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCC0tsF4SVs47Ss5VcYXH81cXcbLlx4df6zcxBhEvYz2W1VC2ob7bJv7l2UO7QBAE
	 9vvRBGpj+B6dXffMXrJl/2KBLyJ7JX3qdlDBrV8tpDuIW4g2FZsxALi5P7ZVPdNuu2
	 NGVgzgJuvMproYsmSWrdLc/RokTw1uqPMSmgt/LsqX65NJXO8BPr1qBnQOb1deylDk
	 FlXgGJZR6dIrxB/O7YiXT6gDV8nuuOaMBPtYNN47VYbdZn/6jBPB2oz9H7VXYd6G+4
	 7bQ9GXhjMZZfv2Q16Fihbdc/HC1gjJXSk0EJb/lgIWIf/noMQmSNlZRZv5FC0Tjga0
	 /KXgS99S0AOtg==
Message-ID: <sashiko-outbox-198655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] mm/sparse-vmemmap: drop @pgmap from vmemmap
 population APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>, "David Hildenbrand" <david@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>
Cc: "Lance Yang" <lance.yang@linux.dev>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Ritesh
 Harjani" <ritesh.list@gmail.com>, "Shrikanth Hegde" <sshegde@linux.ibm.com>, "Oscar
 Salvador" <osalvador@suse.de>, "Qi Zheng" <qi.zheng@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Huacai Chen" <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, linux-mm@kvack.org, x86@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105061217.13302-6-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
 <20261105061217.13302-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:16:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: undeclared vmemmap in section_vmemmap_optimization_disable()
--

commit b9ce7eece3f26dd29a5fe079915770aa843f9257
Author: Muchun Song <muchun.song@linux.dev>

mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs

This commit removes the @pgmap parameter from the vmemmap population
helpers and related memory hotplug interfaces, relying instead on
mem_section state and internal architecture-specific checks.

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 71a927d67a9f9..5777f2e296845 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -462,8 +462,7 @@ int __meminit vmemmap_populate_hugepages(unsigned lon=
g start, unsigned long end,
>  }
> =20
>  struct page * __meminit __populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
> -		struct dev_pagemap *pgmap)
> +		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	unsigned long start =3D (unsigned long) pfn_to_page(pfn);
>  	unsigned long end =3D start + nr_pages * sizeof(struct page);

[Severity: Low]
Does section_vmemmap_optimization_disable() (called right below here in
__populate_section_memmap()) cause a build failure on 64-bit LoongArch
when CONFIG_VMEMMAP_OPTIMIZATION is enabled?

In include/linux/vmemmap-optimization.h,
section_vmemmap_optimization_disable() is a static inline function that
calls page_to_pfn():

include/linux/vmemmap-optimization.h:
static inline void section_vmemmap_optimization_disable(unsigned long start,
		unsigned long end)
{
	unsigned long pfn =3D page_to_pfn((struct page *)start);

Under CONFIG_SPARSEMEM_VMEMMAP, page_to_pfn() expands via
include/asm-generic/memory_model.h to ((unsigned long)((page) - vmemmap)).
However, include/linux/vmemmap-optimization.h does not include
linux/pgtable.h or asm/pgtable.h where vmemmap is defined.

On 64-bit LoongArch, arch/loongarch/include/asm/pgtable.h includes
linux/vmemmap-optimization.h before defining the vmemmap macro:

arch/loongarch/include/asm/pgtable.h:
#include <linux/mm_types.h>
#include <linux/mmzone.h>
#include <linux/vmemmap-optimization.h>
...
#define VMEMMAP_ALIGN	max(PMD_SIZE, MAX_FOLIO_VMEMMAP_ALIGN)
#define vmemmap		((struct page *)(ALIGN(VMALLOC_END, VMEMMAP_ALIGN)))

Because section_vmemmap_optimization_disable() is a static inline
function, the preprocessor expands page_to_pfn() inside
linux/vmemmap-optimization.h before vmemmap is defined, leaving vmemmap as
an undeclared identifier when compiling any translation unit that includes
asm/pgtable.h with CONFIG_VMEMMAP_OPTIMIZATION=3Dy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105061217.1330=
2-1-songmuchun@bytedance.com?part=3D5
