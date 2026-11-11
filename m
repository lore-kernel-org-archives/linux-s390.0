Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424463;
	b=OQRD6u+QjcjRX9bBno4SkSgHMsUr68aOHgwRusZv75jDWa29r8O4bNlMXm3zFBG8JDFn
	 cS2xaZrM1IC1fWsEeG5jzYhhwvr24inqRbiCp1k1RLbyFEd0KTs7obGbE2NwOsPUHKYZr
	 SPo3kjy3ElQFoCo5Uku0AeHo2RTHPIpSvZ0KbfxF/PiODyMhmba/MUKDIqJ8xvqE0n/jG
	 owisPKW++QrVEV6nNpiHvtIqroMkzKYj2IBzgRr7C1RW3uF8L8Qx+4ECeHqSoJa79eHqO
	 OABcMS9i2Wd1Q2oMOiuoI6o0EMqp0MZngqzPtHHP+cANdxIbgDgEKcXNtyKZ6KcNdqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424463;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zM+ZFjXOc2pMxiZ/L07NVX2EisJ3IMV33MN37tMxyaI=;
	b=evGOvNn6BHnwEtaulO7onfUvnDGSjk5vG313b6XOqm+eCxm2p4Gy7hc8Hx/uvQkJVOGu
	 SPJNqzYXbTG7wODYCbaLjaeaWY2xkEdXFFSD9u+tp40o/CWWPZvboIr8ufAczdan+Bmzc
	 EeDrnRQ50rX0D/5GNOlhW1iNrbtCf0rLUcvDouG95pSUvgrimN3YXsboAR+p5Qkh+lwuj
	 bk9WPYkjT7VOTeuYxvsGKhuSrFdeVEFuDWPMy/2Y1QlZi7u8TDs4Vgw6myquZCdT+vezo
	 ln9fcn8jkKWmhjzxl/rvPdjyEWNeFpHAUpBpWpwhTxnvHgkDAYBdKyuJWJ/TXyxQBRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFY+nsd5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF050606A326
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFY+nsd5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223F21F00A05;
	Wed, 11 Nov 2026 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424463;
	bh=zM+ZFjXOc2pMxiZ/L07NVX2EisJ3IMV33MN37tMxyaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MFY+nsd570NL6bIdn1pXJU5Vgf23iHD1l/XOdeXqwz/tXvhOiwvC3nfEUqUZDN56o
	 Utylwww6nCy2KSL/2XdxP5FOSbDdL06xxNDBI01Y4Zj3d6lKIcfAL5DTQ+xVXDBFg0
	 Is/QlHki1rO7h2xyvTzGw9WE+gs6APEHt02SEFrEEECroMaN3h2ectzdfZo9Z/C4q9
	 aT+OMdaMfJyVIDUGnToFgk7AS1Qgpui5AcJb0R5/wD/U/G+Gaui9RLGIq2tl7wGmZN
	 Gl3gg6mckaiKpvTO2D8NvOVVZujP4Tnu3l+SW/HmTJtTvkF+8jQV9618EvvwBKR8BH
	 oPINEs4VyDRJQ==
Message-ID: <sashiko-outbox-209541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/mm: Allow hugepage migration for s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
References: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:14:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] s390/mm: guest storage key loss on 1M/2G hugetlbfs page
  migration
- [Medium] s390/mm: loss of soft-dirty bit in __pte_to_rste() and
  __rste_to_pte() on hugetlb migration
--

commit d03e5331e4e0b88aa75246fc7dc6aef18e7c8cdd
Author: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

s390/mm: Allow hugepage migration for s390

This commit selects ARCH_ENABLE_HUGEPAGE_MIGRATION on s390 and defines
arch_hugetlb_migration_supported() for 1M and 2G hugepages so hugetlbfs
pages can be migrated and allocated from ZONE_MOVABLE.

> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index f84aa9265430f..2c6e94888bd06 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *) pmdp;
>  }
> =20
> -bool __init arch_hugetlb_valid_size(unsigned long size)
> +static bool __hugetlb_valid_size(unsigned long size)
>  {
>  	if (cpu_has_edat1() && size =3D=3D PMD_SIZE)
>  		return true;
> @@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
> =20
>  	return 0;
>  }
> +
> +bool __init arch_hugetlb_valid_size(unsigned long size)
> +{
> +	return __hugetlb_valid_size(size);
> +}
> +
> +#if IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION)
> +bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
> +	return __hugetlb_valid_size(huge_page_size(h));
> +}
> +#endif

[Severity: High]
Does migrating a 1M or 2G hugetlbfs folio backing a KVM guest lose the
guest's hardware storage keys?

For 1M and 2G mappings (KVM_CAP_S390_HPAGE_1M / KVM_CAP_S390_HPAGE_2G),
the KVM gmap uses large leaf CRSTEs without PGSTEs, and guest storage keys
live only in the physical page frames.  When unmap_and_move_hugetlb_folio()
unmaps the folio via mmu_notifier_invalidate_range_start(),
_gmap_unmap_crste() clears the large CRSTE to _CRSTE_EMPTY without saving
or splitting the hardware storage keys:

arch/s390/kvm/gmap/gmap.c:_gmap_unmap_crste() {
	...
	if (!old.h.fc)
		return 0;

	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags=
))
		folio =3D phys_to_folio(crste_origin_large(old));
	ok =3D gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h=
.tt), gfn);
	...
}

folio_copy() -> copy_highpage() -> copy_page() then copies only the 4K
page contents via mvcl and does not copy the hardware storage keys to the
destination frames, leaving the guest with stale storage keys and causing
guest protection exceptions or memory corruption.

[Severity: Medium]
Does migrating a hugetlbfs page also drop its soft-dirty bit in
__pte_to_rste() and __rste_to_pte()?

When try_to_migrate_one() installs a hugetlb migration entry, it sets
_PAGE_SOFT_DIRTY via pte_swp_mksoft_dirty() and calls set_huge_pte_at().
However, the swap entry branches in __pte_to_rste() and __rste_to_pte() do
not transfer _PAGE_SOFT_DIRTY to and from _SEGMENT_ENTRY_SOFT_DIRTY:

arch/s390/mm/hugetlbpage.c:__pte_to_rste() {
	...
	} else if (!pte_none(pte)) {
		/* swap pte */
		arch_entry =3D __pte_to_swp_entry(pte);
		rste =3D mk_swap_rste(__swp_type(arch_entry), __swp_offset(arch_entry));
	...
}

arch/s390/mm/hugetlbpage.c:__rste_to_pte() {
	...
	} else if (!none) {
		/* swap rste */
		arch_entry =3D __rste_to_swp_entry(rste);
		pte =3D mk_swap_pte(__swp_type_rste(arch_entry), __swp_offset_rste(arch_e=
ntry));
		pteval =3D pte_val(pte);
	...
}

As a result, remove_migration_pte() reads back old_pte via huge_ptep_get()
with pte_swp_soft_dirty(old_pte) =3D=3D 0 and clears _PAGE_SOFT_DIRTY on the
restored hugepage PTE, breaking soft-dirty tracking via /proc/pid/pagemap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111182944.4154=
805-1-gerald.schaefer@linux.ibm.com?part=3D1
