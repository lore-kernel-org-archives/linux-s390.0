Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215694;
	b=fN+csMLz+mgczGQ7wX7a+gb/5vsmjM0cH+3j1ZU1y6pfuFzxgOKCiSI2/k1lo9SxB/jI
	 KW2WFaU13DCyaZKVmbiKAobM6SjS6lN51eeLnUguBtOKiQeUBXWN8ikpip6xxGsKkFk/u
	 GGaOPRSJveWbwo90bozSa3XrgSS9T7TF2odp1IcpgqCg779cMpc37VV3x4DxDu4QM+Q7h
	 AqhjIb0Yjvy8u58IzAjdKLjqyOImY+A+uahwomlJ4LC0/J7QBRZwQB02RYYmmzzezvgFJ
	 C4iq8WhuB+LqEZtGy5sMvNfgInGXuwWZnjYEK1oO1y8TSiwvp2ZHMbatNhkeffGFPhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OttymoT+Gj7B3Pr54kafvxx7oIh2IVc8g1Kog35whCo=;
	b=gyAr42Tz6qnBADlof1zvJBW8hbGPL9tsLSFm2vTegSnb6u4ilikQBH3aHLkbeHiE4ulB
	 UkKvlaFUUL3xnkdtTKeTNrs5YgoHlZVfgeQQdvz0uzmptI7CkBAnrZgesKaMuBFEg6H2N
	 6l9AbAbQmsz/nf1k+SI4faBvIVk99jY4t5Gddou2cAtixK7qKIgZKX0hnv2NV4xXU61Mc
	 WgtRJ/6LE8BE5y3OXOp7G4Nw44mMc8w3OUWb2nNS8tyArgMhyBrFLc33zweyKyFwTatw9
	 lsIfi2CaYGDNXp/wt/5zdYYxTZx3Y72aYc4aaRVCoeKQ1YwItWGI5CIfRsytIi64XNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHs9QdF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7E606A31F;
	Wed, 28 Oct 2026 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHs9QdF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14A1F01825;
	Wed, 28 Oct 2026 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793215693;
	bh=OttymoT+Gj7B3Pr54kafvxx7oIh2IVc8g1Kog35whCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CHs9QdF88lJ9yx5KdbMUMjNXFUJMKhRgejE6Th5YBrOYZdEFphAuoedmcREOGiCH9
	 5k8Otl7ufJxkW+FCAtKKZab3GW3+bxwxnRh6KRmVrO+kQOLEX04SqQ4LsrEU3z9Db9
	 0Tg/c9WJl8I9+Sg+OcmOqSTmwnF2DejkW/lr7nbpq6vXJagdJdxjd49SRGY5sXS1oa
	 aUyyW0ZZL+kx4UjRcCIKRO/HlB+0v4EMSpt3v8nfNCk4yNyw+xUW+DO2xcg6BM0H44
	 a+YyMVmIkgZ3UfxOZIE3vrr136uUsdRZb7+DvmnD0l4TxJZXTx78fYjQjrJWWM/eOv
	 /KcFDNz0kulwA==
Message-ID: <sashiko-outbox-188352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] KVM: s390: Allocate page tables when CMMA is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-8-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 19:28:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] KVM: s390: gmap_allocate_all_page_tables_best_effort() drops s=
keys on split
- [High] KVM: s390: hugepage flags left enabled when enabling CMMA in handl=
e_essa()
- [Medium] KVM: s390: race in handle_essa() setting GMAP_FLAG_USES_CMM befo=
re allocation
- [Medium] KVM: s390: page tables allocated after dat_set_cmma_bits() in kv=
m_s390_set_cmma_bits()
--

commit 2d680e1a8c09302f7abfa247b43bee558b17d8ec
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Allocate page tables when CMMA is used

This commit calls gmap_allocate_all_page_tables_best_effort() in
handle_essa() and kvm_s390_set_cmma_bits() when GMAP_FLAG_USES_CMM is first
set on the gmap, so that page tables are pre-allocated and existing large
page mappings are split when CMMA is used.

> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index 856939acf012f..4f0dd3173ab91 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
> @@ -1248,7 +1248,10 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  		 * value really needs to be written to; if the value is
>  		 * already correct, we do nothing and avoid the lock.
>  		 */
> -		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> +		if (!uses_cmm(vcpu->arch.gmap)) {
> +			set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> +			gmap_allocate_all_page_tables_best_effort(vcpu->arch.gmap);
> +		}

[Severity: Medium]
What happens if two vCPUs in a multi-vCPU guest intercept on ESSA
concurrently in handle_essa() when !READ_ONCE(vcpu->kvm->arch.migration_mod=
e)?

In this path only vcpu->mutex and the kvm->srcu read lock are held. When the
first vCPU sees !uses_cmm(vcpu->arch.gmap), it immediately sets
GMAP_FLAG_USES_CMM via set_bit() and then enters
gmap_allocate_all_page_tables_best_effort(), which iterates over all memslo=
ts
while repeatedly dropping gmap->kvm->mmu_lock and sleeping in
kvm_s390_mmu_cache_topup():

arch/s390/kvm/gmap/gmap.c:gmap_allocate_all_page_tables_best_effort() {
    ...
		for (gfn =3D start; gfn < end; gfn +=3D _PAGE_ENTRIES) {
			if (kvm_s390_mmu_cache_topup(mc))
				break;

			guard(write_lock)(&gmap->kvm->mmu_lock);

			dat_entry_walk(mc, gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_SPLIT,
				       TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
		}
}

If a second vCPU enters handle_essa() while the first vCPU is still running
gmap_allocate_all_page_tables_best_effort(), the second vCPU will observe
uses_cmm(vcpu->arch.gmap) =3D=3D true, skip the allocation, set
vcpu->arch.sie_block->ecb2 |=3D ECB2_CMMA, and retry ESSA in SIE before all
page tables have been allocated and all large pages have been split.
Conversely, because !uses_cmm() and set_bit() are not atomic or serialized =
by
a VM-wide lock such as kvm->slots_arch_lock, two vCPUs can both pass
!uses_cmm() and run duplicate allocation walks across all memslots.

Should the check, flag update, and page table allocation be serialized under
a VM-wide lock so other vCPUs wait until allocation finishes before re-ente=
ring
SIE with ECB2_CMMA enabled?

[Severity: Critical]
Can calling gmap_allocate_all_page_tables_best_effort() here (and in
kvm_s390_set_cmma_bits()) corrupt guest storage keys when splitting aged
1M or 2G large pages?

If storage keys are already enabled (GMAP_FLAG_USES_SKEYS) and a 1M large
page has been aged via gmap_age_gfn() -> gmap_clear_young_crste() so that
crste.h.i is set while the storage keys remain in the physical pages,
gmap_allocate_all_page_tables_best_effort() calls dat_entry_walk() without
DAT_WALK_USES_SKEYS:

arch/s390/kvm/gmap/gmap.c:gmap_allocate_all_page_tables_best_effort()
  -> dat_entry_walk(mc, gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_SPLIT, .=
..)
     -> dat_split_ste()

Inside dat_split_ste() in arch/s390/kvm/gmap/dat.c, saving the physical
storage keys into the newly allocated PGSTEs for an invalid segment entry is
gated on uses_skeys from the walk flags:

arch/s390/kvm/gmap/dat.c:dat_split_ste() {
    ...
			pgste_init.pcl =3D uses_skeys && init.h.i;
			dat_init_pgstes(pt, pgste_init.val);
		} else {
			dat_init_page_table(pt, init.val, 0);
		}

		if (dat_pmdp_xchg_atomic(pmdp, old, new, gfn, asce)) {
			if (!pgste_init.pcl)
				return 0;
			for (i =3D 0; i < _PAGE_ENTRIES; i++) {
				union pgste pgste =3D pt->pgstes[i];

				pgste =3D dat_save_storage_key_into_pgste(pt->ptes[i], pgste);
				pgste_set_unlock(pt->ptes + i, pgste);
			}
    ...
}

Because DAT_WALK_USES_SKEYS is not passed, pgste_init.pcl is false and the =
new
PGSTEs are left with zeroed storage keys while pt->ptes[i].h.i =3D=3D 1. Wh=
en
those 4K pages are later faulted back in via _gmap_handle_minor_pte_fault()=
 ->
__dat_ptep_xchg() (which does pass uses_skeys(gmap)), old.h.i && !new.h.i
triggers dat_set_storage_key_from_pgste() and overwrites the guest's hardwa=
re
storage keys with zero.

Should gmap_allocate_all_page_tables_best_effort() include
(uses_skeys(gmap) ? DAT_WALK_USES_SKEYS : 0) in the flags passed to
dat_entry_walk()?

[Severity: High]
Could leaving GMAP_FLAG_ALLOW_HPAGE_1M and GMAP_FLAG_ALLOW_HPAGE_2G set on
gmap->flags when enabling CMMA lead to a guest vCPU infinite fault loop?

When userspace enables KVM_CAP_S390_HPAGE_1M or KVM_CAP_S390_HPAGE_2G and
also enables KVM_S390_VM_MEM_ENABLE_CMMA, neither handle_essa(),
kvm_s390_set_cmma_bits(), nor gmap_allocate_all_page_tables_best_effort()
clears GMAP_FLAG_ALLOW_HPAGE_1M or GMAP_FLAG_ALLOW_HPAGE_2G, and
gmap_1m_allowed() / gmap_2g_allowed() in arch/s390/kvm/gmap/gmap.c do not
check !uses_cmm(gmap):

arch/s390/kvm/gmap/gmap.c:gmap_1m_allowed() {
	return test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &gmap->flags) &&
	       !((f->gfn ^ f->pfn) & ~_SEGMENT_FR_MASK) &&
	       slot->base_gfn <=3D ALIGN_DOWN(f->gfn, _PAGES_PER_SEGMENT) &&
	       slot->base_gfn + slot->npages >=3D ALIGN(f->gfn + 1, _PAGES_PER_SEG=
MENT);
}

If gmap_allocate_all_page_tables_best_effort() bails out early on an
allocation failure, if another vCPU faults on a segment not yet visited whi=
le
mmu_lock is dropped between segments, or if a memslot is added or moved aft=
er
GMAP_FLAG_USES_CMM is set (where s390_kvm_mmu_prepare_memory_region() ->
dat_create_slot() installs _CRSTE_EMPTY entries without page tables),
gmap_link() will install a valid 1M or 2G large CRSTE.

When a vCPU with ECB2_CMMA set subsequently faults on that valid large page,
kvm_s390_faultin_gfn() -> gmap_try_fixup_minor() ->
gmap_handle_minor_crste_fault() sees:

arch/s390/kvm/gmap/gmap.c:gmap_handle_minor_crste_fault() {
    ...
	/* Appropriate permissions already (race with another handler), nothing to=
 do. */
	if (!oldcrste.h.i && !(f->write_attempt && oldcrste.h.p))
		return 0;
    ...
}

and returns 0 without splitting the large page, causing the vCPU to fault
indefinitely. Should GMAP_FLAG_ALLOW_HPAGE_1M and GMAP_FLAG_ALLOW_HPAGE_2G =
be
cleared (or checked against uses_cmm(gmap)) before splitting existing large
pages?

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 18fb200f854a8..739e8c23c3ae0 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -2359,7 +2359,10 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>  		}
>  	} while (r =3D=3D -ENOMEM);
> =20
> -	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> +	if (!uses_cmm(kvm->arch.gmap)) {
> +		set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> +		gmap_allocate_all_page_tables_best_effort(kvm->arch.gmap);
> +	}

[Severity: Medium]
In kvm_s390_set_cmma_bits(), is it intentional that
gmap_allocate_all_page_tables_best_effort() is called after
dat_set_cmma_bits() rather than before it?

Inside dat_set_cmma_bits() in arch/s390/kvm/gmap/dat.c, dat_entry_walk() is
called under read_lock(&kvm->mmu_lock) with DAT_WALK_ALLOC and without
DAT_WALK_SPLIT:

arch/s390/kvm/gmap/dat.c:dat_set_cmma_bits() {
    ...
	for (cur =3D ALIGN_DOWN(gfn, _PAGE_ENTRIES); cur < gfn + count; cur +=3D _=
PAGE_ENTRIES) {
		rc =3D dat_entry_walk(mc, cur, asce, DAT_WALK_ALLOC, TABLE_TYPE_PAGE_TABL=
E,
				    &crstep, &ptep);
		if (rc)
			return rc;
	}
    ...
}

If any 1M or 2G large page mappings already exist in the target GFN range
when KVM_S390_SET_CMMA_BITS is first invoked, dat_set_cmma_bits() will hit
the unsplit large page entry in dat_entry_walk() and fail with -EFBIG before
gmap_allocate_all_page_tables_best_effort() has had a chance to split it.

In addition, because the !uses_cmm(kvm->arch.gmap) block runs unconditional=
ly
after the loop even when r !=3D 0, any error from dat_set_cmma_bits() (such=
 as
-EFBIG or PGM_ADDRESSING on an invalid GFN range) will still set
GMAP_FLAG_USES_CMM and allocate page tables across all memslots before
returning the error.

Should the !uses_cmm(kvm->arch.gmap) check and
gmap_allocate_all_page_tables_best_effort() happen before the
dat_set_cmma_bits() loop (or be gated on success if placed after)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D7
