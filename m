Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775854;
	b=GUsI85YJomjCLsWDQ6nKFSq1zTc5meVS2pwgx5H5GOGt89fR4nvW61ySCfZFv5Lmepbg
	 oAXT61dIGApCMutAzlqYAmUejMkCcWk/aSXr4imW0xS1moP6IigL05wM6CbHRR6AYZLwf
	 1iv85filpCVwaQ7TGTN2n/ZGsmTbAy7zn2olg0HQAlvtSVf9jX6L9QeTwsunoacVsHTMf
	 oVQC9hGAbIXTVdCbQf49XFYmoOYa1e+5+WLkVFyj51ohib8sFvYPKpHKB2T2Sl1hUNf34
	 A53qvBz/YHLJ3B1xJk9IHw3psUVuisYkqu+UwBDFQcvoCtBm2FLHznCMn1k7rYm5IBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HfBaRCSj53nWpDLHO1eD+/W9hko9c9addAFkAxeqTCw=;
	b=v1WaHBmajnF0JaDtiOkvYXknBavUwWuCjBErbv1D2YwTuO7gEG1FGG6PiVSn7duUSnpK
	 jcpuBbbn+CCI45/+qGlbsQIOkynTP58JwLHNP5x2fv0WYOoKPSuUiR1hKGhKb/c2v6ORz
	 cUOvhK1dCxUSXv3nU5pi0rGo8dEF/Guy0ffxc0JdtDAqhNdB9EyFhrtQoTnNBudVLGcSY
	 JaVs/X1YCeoKZjH17UVEYMzTKDmiREivMMQQWwtphwqwW/ljcBNhMYqVyM30BS07gIeuV
	 0r55ryJchm0lwbYXFod1PEoaPwAgTWZyZJ5W5dJG7DQQ/Z0zxnxT/za4jkz4JvsMQ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StpvNeSr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EC606A31A;
	Fri, 23 Oct 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StpvNeSr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB291F01825;
	Fri, 23 Oct 2026 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792775853;
	bh=HfBaRCSj53nWpDLHO1eD+/W9hko9c9addAFkAxeqTCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=StpvNeSr/W3hr7n/Ox6+F0NCah82ZKsPqsMdKNiw0fHVLsv0kMYGYWpW7l675LLwA
	 Nz8I8OE2JwoorV8ZKhXG8Lpf1bDLatCsuGWHYrKqOAvhOFSY+FM+QKHiLslKB2MXtL
	 PjWBGluepKbZCjwjEnaSAb31VeVvTlggRbPE9EeuzGsH0ixfbpvQNSlT+TIRo+JEer
	 ZmmE7brQMtDFRQp2grweAexqMOYn5fhfrLvSx2FvvNP0oD4I2FE7f3zs4ZMXoaF6We
	 NWR7rV6hmLlIB+3d9UDoPEqWSOHh28jlOqowuqhj9so21PSzgCqdhlR5fQVKzVJt15
	 Jk8Yum4ojqYAQ==
Message-ID: <sashiko-outbox-182996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] KVM: s390: Improve unmapping of large ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-9-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:17:32 +0000
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
- [High] KVM: s390: _gmap_unmap_pmd_fast() overwrites pte_hole() entries wi=
th _PTE_EMPTY
--

commit e24d7490ad24c4b12cfd0f6fe018550a836e83db
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Improve unmapping of large ranges

This patch optimizes unmapping of guest ranges larger than 1M by
detaching the PMD, overwriting PTEs in bulk, and reattaching the PMD
rather than invalidating leaf DAT entries individually.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index c10681f882c2d..01d25aa1f605f 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -465,6 +456,105 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct=
 kvm_memory_slot *slot, gfn_t

[ ... ]

> +static long _gmap_unmap_pmd_fast(union crste *crstep, gfn_t gfn, gfn_t n=
ext, struct dat_walk *w)
> +{
> +	union crste old =3D *crstep;
> +	struct page_table *pt;
> +	gfn_t first, last;
> +	unsigned int i;
> +
> +	if (old.h.fc) {
> +		if (old.s.fc1.vsie_notif)
> +			gmap_handle_vsie_unshadow_event(w->priv, gfn);
> +
> +		idte_crste(crstep, gfn, w->datt.asce);
> +		WRITE_ONCE(*crstep, _CRSTE_EMPTY(old.h.tt));
> +
> +		return 0;
> +	}
> +
> +	if (old.h.i)
> +		return 0;
> +
> +	pt =3D dereference_pmd(old.pmd);
> +	first =3D max(gfn, w->start) & (PTRS_PER_PTE - 1);
> +	last =3D (min(next, w->end) - 1) & (PTRS_PER_PTE - 1);
> +
> +	for (i =3D first; i <=3D last; i++)
> +		if (pte_needs_unshadow(pt->ptes[i], _PTE_EMPTY, pt->pgstes[i]))
> +			gmap_handle_vsie_unshadow_event(w->priv, gfn + i);
> +
> +	/* Detach the page table */
> +	idte_crste(crstep, gfn, w->datt.asce);
> +
> +	for (i =3D first; i <=3D last; i++) {
> +		if (!pt->ptes[i].h.i && w->datt.uses_skeys)
> +			pt->pgstes[i] =3D dat_save_storage_key_into_pgste(pt->ptes[i], pt->pg=
stes[i]);
> +		pt->ptes[i] =3D _PTE_EMPTY;
> +		pt->pgstes[i].vsie_notif =3D 0;
> +		pt->pgstes[i].vsie_gmem =3D 0;
> +		pt->pgstes[i].zero =3D 0;
> +	}

[Severity: High]
Can _gmap_unmap_pmd_fast() overwrite pte_hole() entries with _PTE_EMPTY?

In gmap_unmap_gfn_range_fast(), _dat_walk_gfn_range() is called with
DAT_WALK_IGN_HOLES, which causes dat_crste_walk_range() to skip CRSTE holes.
However, _gmap_unmap_pmd_fast() open-codes the PTE loop over
pt->ptes[first..last] instead of going through dat_pte_walk_range(), which
would normally skip PTE holes when DAT_WALK_IGN_HOLES is set:

arch/s390/kvm/gmap/dat.c:dat_pte_walk_range() {
	for ( ; gfn < end; idx++, gfn++) {
		if (pte_hole(READ_ONCE(table->ptes[idx]))) {
			if (!(w->flags & DAT_WALK_IGN_HOLES))
				return -EFAULT;
			if (!(w->flags & DAT_WALK_ANY))
				continue;
		}
}

When a memslot larger than 1M whose start or end GFN is not 1M-aligned
(_PAGES_PER_SEGMENT) is deleted or moved via kvm_set_memslot(),
kvm_invalidate_memslot() installs invalid_slot into the active
slots->hva_tree before kvm_prepare_memory_region() ->
s390_kvm_mmu_prepare_memory_region() calls dat_delete_slot() under
kvm->mmu_lock:

arch/s390/kvm/gmap/kvm_mmu.c:s390_kvm_mmu_prepare_memory_region() {
	scoped_guard(write_lock, &kvm->mmu_lock) {
		kvm_s390_update_cmma_dirty(kvm, old);
		if (change =3D=3D KVM_MR_DELETE || change =3D=3D KVM_MR_MOVE)
			rc =3D dat_delete_slot(kvm->arch.gmap->datt, old->base_gfn, old->npages);
		if (!rc && (change =3D=3D KVM_MR_MOVE || change =3D=3D KVM_MR_CREATE))
			rc =3D dat_create_slot(mc, kvm->arch.gmap->datt, new->base_gfn, new->npa=
ges);
	}
}

For any boundary 1M segment not completely covered by the deleted memslot,
_dat_slot_crste() leaves the existing page table attached (!crste.h.fc &&
!crste.h.i) and _dat_slot_pte() marks the deleted GFNs' PTEs as pte_hole()
(_PTE_TOK(_DAT_TOKEN_PIC, PGM_ADDRESSING)).

After s390_kvm_mmu_prepare_memory_region() drops kvm->mmu_lock and before
kvm_delete_memslot() or kvm_move_memslot() removes invalid_slot from
slots->hva_tree, a concurrent mmu_notifier invalidation
(kvm_mmu_notifier_invalidate_range_start() -> kvm_mmu_unmap_gfn_range() ->
gmap_unmap_gfn_range()) covering more than _PAGES_PER_SEGMENT pages will run
_gmap_unmap_pmd_fast() on that boundary segment and overwrite the pte_hole()
entries with _PTE_EMPTY.

Since dat_entry_walk() checks pte_hole() to return PGM_ADDRESSING for
unmapped GFNs inside a split segment, wouldn't overwriting those hole tokens
with _PTE_EMPTY cause subsequent storage key (ISKE/SSKE/RRBE), ESSA, and CM=
MA
operations on those unmapped GFNs to treat them as valid guest pages instead
of raising PGM_ADDRESSING or returning -EFAULT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D8
