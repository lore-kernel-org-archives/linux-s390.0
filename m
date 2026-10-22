Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688019;
	b=CdasAkyZzNuJM630CZ4lDb+2AndjWlVevaFHOJ2xNx10mHrC11g3wemhcfUcW83EEjwu
	 MG0/FSCYf30Cq4sJVg/byLy45uWQbv5ElXbpMXtYk7zL/AkrUk1ZGglQZywpfXFowm1k/
	 En1AgH4kZgHXdPhfNgfD7FiXimO/4NGrLbbGzo+GCayT0h0w6Ew0cOEYtWcJtuVI6XGM5
	 5sTkwPO2ouVInwNsXzMuDFjKwNQIQXyHuUKPUrslSiLq/xmgs2CIDcBDjFDbwM5y8WxWh
	 MgG6qY7mWxVwuGlI6X/K55D3mJBQYRX16Ytij14bXQ7c+/h2FgVnzJVg1Nka4se3DgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l7IXTscY3LKcuQJRmr1is5N8f3yRZJxGSgm9Odb4UY8=;
	b=FUS9PeecNrl4rmTBxfxTZTDtrmMFIlO0BMbN20TS0fmimtlqAkHmJTqLVuUZJMhO+SDQ
	 3WaZxCkyFPvpCKBdX/c3Mk5+SH/++Y7ZFvPYxUvUl73JAcLPste0IorVCRN2B8BQxuhWy
	 Ifg/Uu4sleaRpqMVJjYsM1NEuMOtbQNXL5jtczBP7XUBTr4c5ki5auUnRaJU7/QvQiTqS
	 juQ/W/d2dcOw6MYzjmLfPwUr04f9eiCOp3czALJ9uG+1YQovBGDVeSC6SSl1X32cBXlY9
	 H/Xvkk0eYeEMbZ2z3tN0pzXSwukNCSXv0WyCObPASUFn410RH4IqFTeLBR1GvqdY3Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3zmMSdj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5B606A319;
	Thu, 22 Oct 2026 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3zmMSdj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826AF1F01825;
	Thu, 22 Oct 2026 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792688018;
	bh=l7IXTscY3LKcuQJRmr1is5N8f3yRZJxGSgm9Odb4UY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3zmMSdjxDNkHIG2785zC6d6x7BOlwmPSCCBV2qv2YVNmn02dpOwyW172pZUhwy7G
	 DwfCoYMCveZbyhfSFeDeu9Bw1Jpkwn3uqvPuu7OhyItmS4pITnNGeyvtRHyCuWW1Oq
	 1KNzEFqx782+viznaOUtqJ1b9uB/TmLxHr0e3pje2XRu+EZvpLfn+4maZrBYRpKxJU
	 oJU64GiQ1b1G8Fr/0awE1V5j8xphLYBWzJoxkQGATNMhtjIIAvVTDGFQz0s0lsOyBM
	 FdpRkJqsSp8nMg9Lsx12a7Z+NMGO+K5fktsr4MZ+wEYey1LOH3o7hoe7mDH+IIGMZf
	 Vt+xmnA3md/yw==
Message-ID: <sashiko-outbox-181832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/10] KVM: s390: Improve unmapping of large ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-9-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:53:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: s390: hole PTE clobber and stale pgste.zero in _gmap_unmap_pm=
d_fast()
- [High] KVM: s390: missing compiler barriers around PTE loop in _gmap_unma=
p_pmd_fast()
--

commit 4a297a39db42bf18a8ae260ff7d2a55c3aa686ed
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Improve unmapping of large ranges

This commit adds a fast path for unmapping guest address ranges larger than
one segment by detaching the pmd via idte_crste(), clearing the pte entries
in the detached page table while saving storage keys, and reattaching the
pmd.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index c10681f882c2d..6700a87a420a8 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c

[ ... ]

> @@ -465,6 +456,103 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct=
 kvm_memory_slot *slot, gfn_t
>  	return false;
>  }
> =20
> +static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t n=
ext, struct dat_walk *w)
> +{

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
> +	}

[Severity: High]
Can this loop in _gmap_unmap_pmd_fast() clobber hole ptes and leave stale
pgste.zero bits set?

gmap_unmap_gfn_range_fast() passes DAT_WALK_IGN_HOLES to
_dat_walk_gfn_range(). In standard pte walks, dat_pte_walk_range() skips
entries where pte_hole() is true when DAT_WALK_IGN_HOLES is set without
DAT_WALK_ANY:

arch/s390/kvm/gmap/dat.c:dat_pte_walk_range() {
	for ( ; gfn < end; idx++, gfn++) {
		if (pte_hole(READ_ONCE(table->ptes[idx]))) {
			if (!(w->flags & DAT_WALK_IGN_HOLES))
				return -EFAULT;
			if (!(w->flags & DAT_WALK_ANY))
				continue;
		}
}

When a non-segment-aligned memslot is deleted or moved via
kvm_set_memslot() -> kvm_invalidate_memslot() ->
kvm_prepare_memory_region() -> s390_kvm_mmu_prepare_memory_region(),
dat_delete_slot() -> _dat_slot_pte() marks the ptes in partially covered
boundary segments as _PTE_TOK(_DAT_TOKEN_PIC, PGM_ADDRESSING) and drops
kvm->mmu_lock while invalid_slot is still present in the active hva tree:

arch/s390/kvm/gmap/dat.c:_dat_slot_pte() {
	new_pte =3D walk->priv ? _PTE_EMPTY : _PTE_TOK(_DAT_TOKEN_PIC, PGM_ADDRESS=
ING);
}

If an mmu notifier invalidation larger than _PAGES_PER_SEGMENT runs on that
hva range before invalid_slot is removed, kvm_handle_hva_range() ->
kvm_unmap_gfn_range() -> gmap_unmap_gfn_range_fast() ->
_gmap_unmap_pmd_fast() iterates over [first, last] and unconditionally
writes _PTE_EMPTY, overwriting those PGM_ADDRESSING hole markers. Would
subsequent storage key or cmma operations (such as dat_get_storage_key(),
dat_set_storage_key(), dat_reset_reference_bit(), or dat_perform_essa()) on
those unmapped gfns then succeed instead of returning PGM_ADDRESSING?

Also, the slow path (_gmap_unmap_pte() -> gmap_ptep_xchg() ->
_gmap_ptep_xchg()) clears pgste.zero:

arch/s390/kvm/gmap/gmap.h:_gmap_ptep_xchg() {
	pgste.zero =3D 0;
	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->datt);
}

Since _gmap_unmap_pmd_fast() only clears vsie_notif and vsie_gmem, could
stale pgste.zero bits remain set and be observed by ESSA_GET_STATE or
ESSA_SET_POT_VOLATILE?

> +
> +	/* Reattach the modified page table */
> +	WRITE_ONCE(*crstep, old);

[Severity: High]
What prevents the compiler from reordering the pt->ptes[i] and
pt->pgstes[i] accesses outside the detached pmd window in
_gmap_unmap_pmd_fast()?

In arch/s390/kvm/gmap/dat.h, idte_crste() only clobbers *crstep and "cc",
without a "memory" clobber:

arch/s390/kvm/gmap/dat.h:idte_crste() {
	if (!machine_has_tlb_guest()) {
		/* flush without guest asce */
		asm volatile("idte	%[table_origin],0,%[gaddr]"
			: "+m" (*crstep)
			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr)
			: "cc");
	} else {
		/* flush with guest asce */
		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt]"
			: "+m" (*crstep)
			: [table_origin] "a" (table_origin),
			  [gaddr_opt] "a" (gaddr | IDTE_GUEST_ASCE),
			  [asce] "a" (asce.val)
			: "cc");
	}
}

Neither page_get_storage_key() nor WRITE_ONCE(*crstep, old) includes a
compiler memory barrier either (unlike pgste_set_unlock() in
arch/s390/kvm/gmap/dat.h, which places barrier() before WRITE_ONCE()).

Because pt->ptes[i] and pt->pgstes[i] are plain non-volatile accesses to
types distinct from *crstep (union crste), could the compiler reorder the
pte/pgste updates before idte_crste() or after WRITE_ONCE(*crstep, old),
allowing running vcpus to retain stale tlb entries to unmapped pages or
update hardware storage keys after dat_save_storage_key_into_pgste() has
read them?

> +
> +	return 0;
> +}
> +
> +static bool gmap_unmap_gfn_range_fast(struct gmap *gmap, gfn_t start, gf=
n_t end)
> +{
> +	const struct dat_walk_ops ops =3D {
> +		.pud_entry =3D _gmap_unmap_pud_fast,
> +		.pmd_entry =3D _gmap_unmap_pmd_fast,
> +	};
> +	bool failed;
> +
> +	lockdep_assert_held_write(&gmap->kvm->mmu_lock);
> +
> +	gmap_unmap_prefix(gmap, ALIGN_DOWN(start, _PAGE_ENTRIES), ALIGN(end, _P=
AGE_ENTRIES));
> +
> +	failed =3D _dat_walk_gfn_range(start, end, gmap->datt, &ops, DAT_WALK_I=
GN_HOLES, gmap);
> +	KVM_BUG_ON(failed, gmap->kvm);
> +	return false;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D8
