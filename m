Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3347B409
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040887; cv=none; b=YbHesJ5+dwtTRiGJ62RvtplSFvPD6kKjHIb9LNZ4LfKxiJRwAvxVA52artKZK5cC/9122+7NCP0CHBddHkJKMl1gyY3F4BSTaClGiRWsU4gksKvi/C7dSPdrsPdwL0H58UxuUHsqEunKAHUGrd+N3cVDvrvtnwBED35FUUrdS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040887; c=relaxed/simple;
	bh=Mw9Q4dZSZywxIhl+yICNHBnTJTAInG4bkpaSeq/J8b4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQvcUa2jFtmNOpUQ2Go18GTnKXn3eLgq0a3erQ0mY5bYCURHIPvkAGvYCJDJmNxCHs1OHcOWAPxVKOt8qpH4rdFhANBGEgQmbTIiQBO1UDdO3L0W4YpMm7wB6fvhenTECKK/BhdLIEGAcnUyc/3MZqf7yw6NBzeFQLW+s4nZmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9G/TrKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9G/TrKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A871F00A3A;
	Tue, 14 Jul 2026 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784040886;
	bh=fEBTMDbPdFH60vwhBD5gseSacUAcwfw39XKLo3Jvsgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9G/TrKJMJoQvE3SIkHfSBLDcadFsRLhK1wqz/kvkKje7sGi8mKb/z+9HGJEmB2cl
	 8zREepFI1kyXo7gJk7FsvXFHibu6iXJrLbGCCqs2hO8GsD6mT/HM6nXs4aNoeauQon
	 aGrK3UV967cbntAZI35R1fWSC0aaHE4JZ05U5QYMMm1f2L4LRwFsDb8mimsE5OV85s
	 C+I2NeTQQFfc5Hv8coTzdCt/fdzr/CS5OJa6sKAmAq7x4Hh71SlqbWQDaxgHNWRhQm
	 W20per52hGkRbsOkm3gl03lXUHQ+dE8IsiU57qMeqvOSUCNQFhSKQqZkT1yCwDsw6o
	 SUw9FIA/bVaUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/22] mm: account page table pages when allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-13-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-13-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:54:45 +0000
Message-Id: <20260714145446.38A871F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] NR_PAGETABLE statistic leak on architectures that do not define =
CONFIG_MMU_GATHER_TABLE_FREE.
- [Medium] Direct calls to pagetable_dtor() followed by generic page freein=
g functions bypass the NR_PAGETABLE decrement, causing stat leaks on ARM64 =
memory hot-remove.
- [Medium] SPARC32 SRMMU page tables completely lose NR_PAGETABLE accountin=
g.
- [Medium] Memory hot-remove and vmemmap teardown on x86 will underflow the=
 NR_PAGETABLE counter.
--

--- Patch [13]: [PATCH 13/22] mm: account page table pages when allocated -=
--
commit 5c303720c0cd77f50e7b180d025a9a9869aab6a2
Author: Kevin Brodsky <kevin.brodsky@arm.com>
mm: account page table pages when allocated

This commit moves memory accounting of pagetable pages from the ctor/dtor
functions to pagetable_alloc() and pagetable_free() in order to improve
accounting where ctor/dtor calls might be missing.

Link: https://lore.kernel.org/r/20251113140448.1814860-3-willy@infradead.org

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b336eb32faa05..361a0d7b74c51 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3681,6 +3681,11 @@ static inline struct ptdesc *pagetable_alloc_nopro=
f(gfp_t gfp, unsigned int orde
>  {
>  	struct page *page =3D alloc_pages_noprof(gfp | __GFP_COMP, order);
> =20
> +	if (!page)
> +		return NULL;
> +
> +	lruvec_stat_add_folio(page_folio(page), NR_PAGETABLE);
> +
>  	return page_ptdesc(page);
>  }

[Severity: Medium]
For architectures or code paths that allocate page tables without using
pagetable_alloc_noprof(), will we now lose the NR_PAGETABLE accounting?

For example, on SPARC32, pte_alloc_one() in arch/sparc/mm/srmmu.c allocates
from a pre-allocated pool via srmmu_get_nocache() and previously relied on
pagetable_pte_ctor() to increment the stat:

arch/sparc/mm/srmmu.c:pte_alloc_one() {
    ...
	if (page_ref_inc_return(page) =3D=3D 2 &&
		!pagetable_pte_ctor(mm, page_ptdesc(page))) {
    ...
}

Similarly, the freeing path mirrors this bypass, using srmmu_free_nocache()
instead of pagetable_free(). Does this change cause SPARC32 to completely
lose user PTE accounting?

> @@ -3689,6 +3694,8 @@ static inline void __pagetable_free(struct ptdesc *=
pt)
>  {
>  	struct page *page =3D ptdesc_page(pt);
> =20
> +	lruvec_stat_sub_folio(page_folio(page), NR_PAGETABLE);
> +
>  	__free_pages(page, compound_order(page));
>  }

[Severity: Medium]
Will this cause an underflow on x86 during memory hot-remove?

In arch/x86/mm/init_64.c, free_pagetable() calls pagetable_free() (which
now decrements the stat) during hot-remove:

arch/x86/mm/init_64.c:free_pagetable() {
    ...
	if (PageReserved(page))
		free_reserved_page(page);
	else
		pagetable_free(page_ptdesc(page));
}

However, these kernel page tables were originally allocated during hot-add
with spp_getpage() or vmemmap_alloc_block_buf(). Both of these use base
allocators and bypass pagetable_alloc_noprof().

Because the stat is never incremented on allocation but is now decremented
on free, does this cause an underflow?

[ ... ]

> @@ -3797,7 +3804,6 @@ static inline void __pagetable_ctor(struct ptdesc *=
ptdesc)
>  	struct folio *folio =3D ptdesc_folio(ptdesc);
> =20
>  	__folio_set_pgtable(folio);
> -	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>  }
> =20
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
> @@ -3806,7 +3812,6 @@ static inline void pagetable_dtor(struct ptdesc *pt=
desc)
> =20
>  	ptlock_free(ptdesc);
>  	__folio_clear_pgtable(folio);
> -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }

[Severity: Medium]
Will this leak the NR_PAGETABLE counter on architectures that bypass
__pagetable_free() and only call pagetable_dtor()?

On architectures lacking CONFIG_MMU_GATHER_TABLE_FREE (like m68k or xtensa),
the fallback tlb_remove_table() implementation explicitly calls
pagetable_dtor() and then enqueues the page for generic batch freeing:

include/asm-generic/tlb.h:tlb_remove_table() {
	struct ptdesc *ptdesc =3D (struct ptdesc *)table;

	pagetable_dtor(ptdesc);
	tlb_remove_page(tlb, ptdesc_page(ptdesc));
}

Since the decrement was moved from pagetable_dtor() to __pagetable_free(),
which is bypassed here, will this leak the counter when userspace unmaps
memory?

A similar bypass appears to occur on ARM64 during memory hot-remove:

arch/arm64/mm/mmu.c:free_hotplug_pgtable_page() {
	pagetable_dtor(page_ptdesc(page));
	free_hotplug_page_range(page, PAGE_SIZE, NULL);
}

Since this directly calls pagetable_dtor() and skips __pagetable_free(),
will this also leave the stat un-decremented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D13
