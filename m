Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794467;
	b=Y80GK5ogW3EOWLN9/jiwASYu/GI8+GfJeaHzT9AjlEcfv6f3t8qPucCBCwLosKncNgYt
	 pduBGkXL5elqFyb+8QF4ZlObHAxkhAHRIem8ifnatSl8EJM9ikMXbXO4NiiOr+gdpNDvz
	 VGoYXBo3lz36GZ2excSxN8fp73TLXGBOokG/xrC9oWJYejqB1U52Aee0dfF11UXg1N9e1
	 jCNo+DZHYj/Waaaugl7S5kL3OQ2zZiDTZfnX9I4BxbbF4ZG2uXXeQUAqgw3Lc0IW3b2dy
	 9fM0zZirIpr6av3lqLzprWbbrTBOwk4VIYHxA8o8WgCtBmySfohu6W7z9Z4q1MJNxiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aSmbULE+03ORV8Jj+AtWFlpiJlKWuzwupMhgFCcFbXg=;
	b=AA21h0qM+V/wMA0sPQLGbmcCBxLibiXYzXMCF4EI0Hrq0eQEsSV2v5WicMMr3umQV7MA
	 ESDLFM0/Xx711ZukPWDSgebdVAh4xCLZiB2lRxdrK8AbcCd01BpjNPbVhj2zQvOVrCmi1
	 f+bDbHtJpxEK6NJG8MeKRhL9XbbyB0laA0VpJurIaa2KA357ywH3l3tw18PxwjbEIxSsm
	 s0+X/7yij7n1QAmQQ5PTnuY1c/RirDA0Supma95mmabr3NxeMgOYG4v4ASxhqkeCVg4uQ
	 cbtLjGQqwKF5ohsZftubtUCHS/oHMTPxkyP3BguZEiZQQKPsZgMCwSRRNGgnE1iUYAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7AE6qah;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3D606A31C;
	Fri, 27 Nov 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7AE6qah
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A521F00897;
	Fri, 27 Nov 2026 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794466;
	bh=aSmbULE+03ORV8Jj+AtWFlpiJlKWuzwupMhgFCcFbXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7AE6qahp2ofq1wOF1fLz3T24VlD+lFPwfl011JR7drUDCU2SWzXsAdLiVMyfNZUq
	 8VMc6nu5aXuoKQ7kJgeW8qdvHbOrxu0ReRywU0S+fOlJArQEODdVHvd3LiDzWzNxfr
	 odUMVERuqnuZ0px7PE3duOPGcFut3Ck3YzxfM4+L57PGHRUsx3gfFvTPf1a6q2KXjC
	 JVwRBVcMd5JU0sBiQ3kRJ6FMvvA2X+Vrn8iEaCft722V9Z2ehzIlk5rEGshbAKk6P1
	 7qR82NYzmHJogEIg/nasLUUlt37Bk43yO1o88w4kDGUYfeMRaoPtxYvAw8qzm6RuNS
	 QswGUEi+toE/A==
Message-ID: <sashiko-outbox-237781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/12] KVM: s390: Introduce gmap_enable_cmm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127150411.221072-4-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
 <20261127150411.221072-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:47:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] KVM: s390: missing vSIE unshadow in
  gmap_enable_cmm_already_locked()
- [Medium] KVM: s390: premature flag set in
  gmap_enable_cmm_already_locked()
- [Medium] KVM: s390: gmap_enable_cmm_already_locked() leaves hugepage
  flags set
--

commit 0b86eaed62523c8498a79fd700936cedd248584a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Introduce gmap_enable_cmm()

This commit introduces gmap_enable_cmm_already_locked() and
gmap_enable_cmm() to mark a gmap as using CMMA, split existing large page
mappings, and pre-allocate 4K page tables across guest memslots on a best
effort basis.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index ef1243ad4e541..c7af1ad9f7c12 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -1527,3 +1527,51 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mm=
u_cache *mc, struct gmap *pare
>  	}
>  	return new;
>  }
> +
> +#if KVM_S390_MANAGES_S390_GUEST
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
> +	lockdep_assert_held(&gmap->kvm->srcu);
> +	lockdep_assert_held(&gmap->kvm->slots_arch_lock);
> +
> +	if (uses_cmm(gmap))
> +		return;
> +
> +	set_bit(GMAP_FLAG_USES_CMM, &gmap->flags);

[Severity: Medium]
Should gmap_enable_cmm_already_locked() also clear
GMAP_FLAG_ALLOW_HPAGE_1M and GMAP_FLAG_ALLOW_HPAGE_2G on gmap->flags?

Because those flags remain set, any segment that does not keep a
pre-allocated 4K page table (for instance, when a memslot is created or
moved after CMMA is enabled, or when kvm_s390_mmu_cache_topup() fails
mid-loop) will still satisfy gmap_1m_allowed() or gmap_2g_allowed() in
gmap_link() and be mapped with 1M or 2G large pages, causing subsequent
CMMA operations such as dat_set_cmma_bits() to fail with -EFBIG.

> +
> +	slots =3D kvm_memslots(gmap->kvm);
> +	if (!slots || kvm_memslots_empty(slots))
> +		return;
> +
> +	if (WARN_ON_ONCE(is_ucontrol(gmap)))
> +		return;

[Severity: Medium]
Does setting GMAP_FLAG_USES_CMM before the memslot walk allow concurrent
callers of gmap_enable_cmm() to return early before page tables are
allocated and large pages are split?

CPU0                                    CPU1
gmap_enable_cmm()
  mutex_lock(&kvm->slots_arch_lock)
  gmap_enable_cmm_already_locked()
    set_bit(GMAP_FLAG_USES_CMM, ...)
                                        gmap_enable_cmm()
                                          if (uses_cmm(gmap))
                                            return;  <-- skips lock
    for (gfn =3D start; gfn < end; ...)
      kvm_s390_mmu_cache_topup(mc)
      dat_entry_walk(...)

Because gmap_enable_cmm() checks uses_cmm(gmap) without holding
slots_arch_lock, CPU1 observes GMAP_FLAG_USES_CMM while CPU0 is still
splitting large pages and sleeping in kvm_s390_mmu_cache_topup().
Setting the flag before the is_ucontrol(gmap) check also leaves
GMAP_FLAG_USES_CMM set if is_ucontrol(gmap) triggers.

> +
> +	flags =3D DAT_WALK_ALLOC | DAT_WALK_SPLIT;
> +
> +	kvm_for_each_memslot(ms, bkt, slots) {
> +		start =3D ALIGN(ms->base_gfn, _PAGE_ENTRIES);
> +		end =3D ALIGN_DOWN(ms->base_gfn + ms->npages, _PAGE_ENTRIES);
> +
> +		for (gfn =3D start; gfn < end; gfn +=3D _PAGE_ENTRIES) {
> +			if (kvm_s390_mmu_cache_topup(mc))
> +				return;
> +
> +			guard(write_lock)(&gmap->kvm->mmu_lock);
> +
> +			if (uses_skeys(gmap))
> +				flags |=3D DAT_WALK_USES_SKEYS;
> +
> +			dat_entry_walk(mc, gfn, gmap->asce, flags, TABLE_TYPE_PAGE_TABLE,
> +				       &crstep, &ptep);
> +		}
> +	}
> +}
> +#endif /* KVM_S390_MANAGES_S390_GUEST */

[Severity: High]
Can splitting large pages via dat_entry_walk() with DAT_WALK_SPLIT leave
stale 1M or 2G mappings in vSIE shadow gmaps?

When _do_shadow_crste() shadows a 1M or 2G large page, it records the
rmap entry in sg->host_to_rmap only at the 1M-aligned or 2G-aligned base
GFN (f->gfn & mask) and sets s.fc1.vsie_notif on the large CRSTE.
Unlike gmap_split_huge_pages() -> _gmap_split_crste(), which calls
gmap_handle_vsie_unshadow_event() before splitting, dat_entry_walk()
with DAT_WALK_SPLIT calls dat_split_crste() and dat_split_ste()
directly, copying vsie_notif into all 4K PGSTEs without unshadowing sg:

arch/s390/kvm/gmap/dat.c:dat_split_ste() {
    ...
			pgste_init.prefix_notif =3D old.s.fc1.prefix_notif;
			pgste_init.vsie_notif =3D old.s.fc1.vsie_notif;
			pgste_init.vsie_gmem =3D old.s.fc1.vsie_notif;
    ...
}

If a 4K subpage at a non-zero offset within that former large page is
later unmapped or write-protected, _gmap_handle_vsie_unshadow_event()
looks up that exact 4K GFN in sg->host_to_rmap, misses the rmap entry at
the aligned base GFN, and leaves the stale large mapping active in
sg->asce.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127150411.2210=
72-1-imbrenda@linux.ibm.com?part=3D3
