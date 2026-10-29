Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280805;
	b=NLFrAuFcuEoelZuvVbDng18gFgB0wChxWEbkgn3Sxs933sGhNkfj6nGRgJS/Y/F2+M1+
	 q+zZ3YOaO501WO2aijPIQtcVW8OoBH461fHnVE9S1H97Bm9ZAYcIgMY+/gkk7DSEMKp1f
	 v8wL3xeQexnFr1ePkagGIA4t94FradwnU/YwZzrg4O+6cHPSYUTBlL63TIQjnPF/nyVsI
	 /ibhXPgF8bqBX3b0ZYQMRZD+Gn2Lt5GCtwPIirwA7h+UoD6DHg+z0ukygl0mO9gECM5YK
	 8O7OYsaZqiWGfYS//Zs8IRQzVyaKQ0Ez5LuHgQ+8dT7cnCAkh9RcMB8W7mcWPcwQ4/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/IJ1W5MVccMozxZs3LrrDmPvwQFc8uUBGgTBPWCBSxs=;
	b=fToyYc6PDXBvoROYRuoGQ0yGedUAyd6UsG7MaRUu8V+SdJJfjDDs4/nDhkOn8rHH8Gpn
	 8cBhBBtO4HAlGNKt/8hrkqsN6plR8NuhbDAlDB7XFA69wpdSMV2FgJajUSStl46qgVJCW
	 /e8Xye14mSAmJTFLKHyd9G+h+VDmPh2glqPJQ8lehLJ2JznYAomhUZw4PBJzNTsv6PFjm
	 +hjIbi++AutJJzLeHd+d6m74LG25gLM9nuyfFSsevMr+V/1+PqtS3GuPTFbI9zTR6xgvs
	 +rSQCr6W5hOpw6IAu07cXk7KNpkdzYqCTJEWfIB6riVIKmoPOQR4pT6Zt8gMVdYnm8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTmZWdNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106EA606A31A;
	Thu, 29 Oct 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTmZWdNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED011F01828;
	Thu, 29 Oct 2026 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793280804;
	bh=/IJ1W5MVccMozxZs3LrrDmPvwQFc8uUBGgTBPWCBSxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTmZWdNTSzLYfHazvecvp5hZ44BqQeMExj6JrChQ1ezTdxG0drRLGlr75+uQ9Pg96
	 /lempQ1XLRWSGMM5yDqVOUI2cP+9EahEImy3LYvsUHStfHNLYxbqbPchcq72Iqc2hT
	 uOAxwN6g1IwVDYujPBaP6pnYuvehiukuUbwEkoIu+9Qq6rbzTYlnUNacx9U3QvK3Wj
	 xBEiXctETtXw/hPznITqSCzaqwOxd6Q2MUqOE1mCk01fHFGna0yu/I0NRCQX+AM6OD
	 8D7Yq/m8IwxnESTgvdoDsp+16869+cuzJrlVx5wXHbT46hYTLnXpm84Hvzg/zUhDe1
	 RRST1iKdMchPQ==
Message-ID: <sashiko-outbox-189390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] KVM: s390: Introduce gmap_enable_cmm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-7-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:33:24 +0000
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
- [High] KVM: s390: missing srcu lock in gmap_enable_cmm_already_locked()
- [High] KVM: s390: gmap_enable_cmm_already_locked() fails to clear hpage f=
lags
- [Medium] KVM: s390: premature GMAP_FLAG_USES_CMM in gmap_enable_cmm_alrea=
dy_locked()
- [Medium] KVM: s390: stale uses_skeys() cached in gmap_enable_cmm_already_=
locked()
--

commit 4b6cb7d4ca0dbeda9874449b9419ff9b5958ae26
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Introduce gmap_enable_cmm()

This commit introduces gmap_enable_cmm_already_locked() and its locking
wrapper gmap_enable_cmm() to allocate all 4k page tables of a running guest
and split existing large page mappings on a best-effort basis when enabling
CMMA.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index b9d92bef5459d..e0c584ec69069 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -1524,3 +1524,40 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mm=
u_cache *mc, struct gmap *pare
>  	}
>  	return new;
>  }
> +
> +/* Bail out for any allocation failure. This is only a best effort to al=
locate all page tables. */
> +void gmap_enable_cmm_already_locked(struct kvm_s390_mmu_cache *mc, struc=
t gmap *gmap)
> +{
> +	struct kvm_memory_slot *ms;
> +	struct kvm_memslots *slots;
> +	gfn_t gfn, start, end;
> +	union crste *crstep;
> +	union pte *ptep;
> +	int flags, bkt;
> +
> +	if (uses_cmm(gmap))
> +		return;
> +
> +	set_bit(GMAP_FLAG_USES_CMM, &gmap->flags);

[Severity: Medium]
Should GMAP_FLAG_USES_CMM be set only after the memslot walk finishes?

gmap_enable_cmm() in arch/s390/kvm/gmap/gmap.h checks uses_cmm(gmap) before
acquiring gmap->kvm->slots_arch_lock:

arch/s390/kvm/gmap/gmap.h:gmap_enable_cmm() {
	if (uses_cmm(gmap))
		return;

	guard(mutex)(&gmap->kvm->slots_arch_lock);

	gmap_enable_cmm_already_locked(mc, gmap);
}

Because gmap_enable_cmm_already_locked() sets GMAP_FLAG_USES_CMM before
walking the memslots, and then drops gmap->kvm->mmu_lock and calls
kvm_s390_mmu_cache_topup() on every _PAGE_ENTRIES iteration, a concurrent
caller of gmap_enable_cmm() (such as another vCPU in handle_essa()) or a
reader of uses_cmm(gmap) (such as the KVM_REQ_STOP_MIGRATION handler) can
observe uses_cmm(gmap) as true and proceed while the first caller is still
allocating 4k page tables and splitting large pages.

In addition, if slots are empty or kvm_s390_mmu_cache_topup(mc) fails early,
GMAP_FLAG_USES_CMM remains permanently set, preventing any later call to
gmap_enable_cmm() or gmap_enable_cmm_already_locked() from retrying.

[Severity: High]
Also, what prevents gmap_link() from continuing to request 1M or 2G mappings
after GMAP_FLAG_USES_CMM is set if GMAP_FLAG_ALLOW_HPAGE_1M or
GMAP_FLAG_ALLOW_HPAGE_2G was enabled on gmap->flags?

Unlike kvm_s390_pv_init_vm(), gmap_enable_cmm_already_locked() does not cle=
ar
GMAP_FLAG_ALLOW_HPAGE_1M or GMAP_FLAG_ALLOW_HPAGE_2G on gmap->flags, and
gmap_1m_allowed() / gmap_2g_allowed() do not check !uses_cmm(gmap):

arch/s390/kvm/gmap/gmap.c:gmap_link() {
	if (f->page) {
		order =3D folio_order(page_folio(f->page));
		if (order >=3D get_order(_REGION3_SIZE) && gmap_2g_allowed(gmap, f, slot))
			level =3D TABLE_TYPE_REGION3;
		else if (order >=3D get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f, =
slot))
			level =3D TABLE_TYPE_SEGMENT;
	}
	return _gmap_link(mc, gmap, level, f);
}

If GMAP_FLAG_ALLOW_HPAGE_2G is set on gmap->flags and
gmap_enable_cmm_already_locked() splits a 2G region3 entry into a segment
table on the first _PAGE_ENTRIES step, but then bails out on a subsequent
step in the same 2G range when kvm_s390_mmu_cache_topup(mc) fails (or races
with a fault while mmu_lock is dropped between iterations), the remaining
segment entries in that 2G range are still empty (i =3D 1) or 1M mappings
(fc =3D 1).

When a fault subsequently runs gmap_link() -> _gmap_link() ->
dat_entry_walk() with walk_level =3D=3D TABLE_TYPE_REGION3 and
DAT_WALK_ALLOC_CONTINUE, dat_entry_walk() sees the split region3 table entry
and clears allocate:

arch/s390/kvm/gmap/dat.c:dat_entry_walk() {
		if (walk_level =3D=3D TABLE_TYPE_REGION3 &&
		    continue_anyway && !entry.pud.h.fc && !entry.h.i) {
			walk_level =3D TABLE_TYPE_PAGE_TABLE;
			allocate =3D false;
		}
}

At the segment level, dat_entry_walk() then returns -ENOENT (for empty
segment entries because allocate is false) or -EFBIG (for 1M segment entries
because split is false), which _gmap_link() translates into -EAGAIN, causing
kvm_s390_faultin_gfn() to retry in an unbounded loop.

Similarly, if kvm_s390_mmu_cache_topup(mc) fails before a region is split, =
or
if a memslot is later created or moved via
s390_kvm_mmu_prepare_memory_region() -> dat_create_slot(), subsequent faults
will still see GMAP_FLAG_ALLOW_HPAGE_1M or GMAP_FLAG_ALLOW_HPAGE_2G set and
install 1M or 2G large mappings without PGSTEs.

> +
> +	slots =3D kvm_memslots(gmap->kvm);
> +	if (!slots || kvm_memslots_empty(slots))
> +		return;
> +
> +	flags =3D DAT_WALK_ALLOC | DAT_WALK_SPLIT | (uses_skeys(gmap) ? DAT_WAL=
K_USES_SKEYS : 0);
> +
> +	kvm_for_each_memslot(ms, bkt, slots) {

[Severity: High]
Can kvm_memslots(gmap->kvm) and kvm_for_each_memslot() be called here witho=
ut
holding gmap->kvm->srcu or gmap->kvm->slots_lock?

kvm_memslots() calls __kvm_memslots(), which checks that either kvm->srcu or
kvm->slots_lock is held:

include/linux/kvm_host.h:__kvm_memslots() {
	as_id =3D array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
			lockdep_is_held(&kvm->slots_lock) ||
			!refcount_read(&kvm->users_count));
}

gmap_enable_cmm() only acquires gmap->kvm->slots_arch_lock, and callers such
as KVM_S390_SET_CMMA_BITS -> kvm_s390_set_cmma_bits() also hold only
kvm->slots_arch_lock without acquiring kvm->srcu.

Holding slots_arch_lock alone does not satisfy srcu_dereference_check() or
protect kvm->memslots against concurrent memslot updates (unlike
kvm_s390_vm_set_migration(), which acquires both guard(srcu)(&kvm->srcu) and
guard(mutex)(&kvm->slots_arch_lock)). Should gmap_enable_cmm_already_locked=
()
acquire guard(srcu)(&gmap->kvm->srcu)?

> +		start =3D ALIGN(ms->base_gfn, _PAGE_ENTRIES);
> +		end =3D ALIGN_DOWN(ms->base_gfn + ms->npages, _PAGE_ENTRIES);
> +
> +		for (gfn =3D start; gfn < end; gfn +=3D _PAGE_ENTRIES) {
> +			if (kvm_s390_mmu_cache_topup(mc))
> +				return;
> +
> +			guard(write_lock)(&gmap->kvm->mmu_lock);
> +
> +			dat_entry_walk(mc, gfn, gmap->asce, flags, TABLE_TYPE_PAGE_TABLE,
> +				       &crstep, &ptep);

[Severity: Medium]
Could evaluating uses_skeys(gmap) only once before the memslot loop leave
flags with a stale value across mmu_lock drops?

gmap_enable_skeys() -> _gmap_enable_skeys() sets GMAP_FLAG_USES_SKEYS under
mmap_write_lock(gmap->kvm->mm) and gmap->kvm->mmu_lock without acquiring
gmap->kvm->slots_arch_lock.

If a concurrent vCPU executing a storage-key instruction or a
KVM_S390_SET_SKEYS ioctl enables GMAP_FLAG_USES_SKEYS while
gmap_enable_cmm_already_locked() has dropped gmap->kvm->mmu_lock between
iterations, subsequent dat_entry_walk() calls in this loop will still pass
flags without DAT_WALK_USES_SKEYS.

When dat_split_ste() splits an invalidated large PMD (old.h.fc =3D=3D 1 and
old.h.i =3D=3D 1) with uses_skeys =3D=3D false:

arch/s390/kvm/gmap/dat.c:dat_split_ste() {
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
			return 0;
		}
}

pgste_init.pcl will be false and dat_save_storage_key_into_pgste() will be
skipped, leaving the new PGSTEs zeroed so that subsequent storage key reads
or minor faults lose the guest storage keys on those pages.

Should uses_skeys(gmap) be checked inside the write_lock(&gmap->kvm->mmu_lo=
ck)
critical section on each iteration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D6
