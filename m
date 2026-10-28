Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214613;
	b=CaML6Htm7shlLcVpK6psnVzOMFp+HbMa91rNx6PMAN5oURqY+1p4VkfNh5etGbOV6A28
	 EK04GjRrFJh0QVRJIYJ4UdwzW11lBAaSfJE9rOD35NNOmCYO+VNbu8SXVOvo/UHvOfJWh
	 kRBAbv5JS+fbWX9I8gZ/sSnwlBKVP4LVbN0Us9wsnIvhffxm+MYbRtDTrSkpeK4qK0z5s
	 Zudl2uGeNtsg5URZ9zH3H3KGDOO9sBGloWCTYhX3HtwTWuRGlC26A9QIjf1GEmcJgdrtw
	 z7HtwarGHdXRrdpOl+5gZlC12CVDOjKDhOPDiHlwW2zaA/kF1zOns3lb3GgZRY6ZkUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214613;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zCgcXqHEvEyVgEpxAVIyx0DoRb/hM4ZRmy30a1vhzBs=;
	b=whIsywRjDt7XzKst0AsXsgt6prV+M5akHOoBXCikGxIAmpGnq0d7/cLdm2Uyb+kIy28e
	 zbhWRdofWBKBUvBWM+4cVkFVI6NNE9dgAWEQRGM1QzoU1osNRqAVWnFP7o37Hz+lHZvfm
	 wFPTO6yY6S6VAFkdD3kSi4jEXLlw5uyWlffcv4pazL9YUfAwsjBVn+8tmRRu6OHKBJNyG
	 sTIxlvshA1mTcWrGyl1JjLr3ZtuCt8cvAz9HBf049jbK0ujkU0MRvb2yu08QDbHbsfilc
	 n54b8IGGNpTs5ayLVMwVYUnvI3WCy3+aWe/6Clesp26eBwG2pNZ7u0jER/TPttmbr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezgR5MKD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E36606AB1E;
	Wed, 28 Oct 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezgR5MKD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A725B1F01828;
	Wed, 28 Oct 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214613;
	bh=zCgcXqHEvEyVgEpxAVIyx0DoRb/hM4ZRmy30a1vhzBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezgR5MKDcshm56Myp7y8HBQjk+2Uoc5dQjYq4WlMCX96kmjDLZbeP07FYgZmQFw7w
	 2GrtfonGkL4SfbXE5KeiGcsgfj4J5b8ETclXNpF48ubZ07fvw7xa6BGhJl32InCXFO
	 fDKoSSc+HehjGEBQyRuV3hmDXzM8iF/ApqguER1yhgZfuoy0J7jSXmLPonEIJINlHl
	 8or5uTREQzOsZzI3WNKW+pQV70rD7ddf4DxtRl0VYcbjeapid4xm+lh05eX54J2VQP
	 4rpLnG4cXC5tCcI5e51EF7bMJVW7cqfE6ZS3trqCWTdZmFgh5xPZHg4AWQ/ILCp3Rz
	 lvtCo4N/Y7ksA==
Message-ID: <sashiko-outbox-188342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] KVM: s390: Introduce
 gmap_allocate_all_page_tables_best_effort()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-7-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 19:10:12 +0000
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
- [High] kvm: s390: pass DAT_WALK_USES_SKEYS to dat_entry_walk() on split
- [Low] kvm: s390: use return on kvm_s390_mmu_cache_topup() failure
--

commit 9e76b2f0d91bb75ee34f562ce5400b323e47a284
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Introduce gmap_allocate_all_page_tables_best_effort()

This commit introduces gmap_allocate_all_page_tables_best_effort() to
walk all memslots of a running guest and allocate 4K page tables while
splitting existing large page mappings on a best-effort basis.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 04f3ab03a041a..3ff08232cbb36 100644
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
> +void gmap_allocate_all_page_tables_best_effort(struct gmap *gmap)
> +{
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) =3D NULL;
> +	struct kvm_memory_slot *ms;
> +	struct kvm_memslots *slots;
> +	gfn_t gfn, start, end;
> +	union crste *crstep;
> +	union pte *ptep;
> +	int bkt;
> +
> +	mc =3D kvm_s390_new_mmu_cache();
> +	if (!mc)
> +		return;
> +
> +	guard(srcu)(&gmap->kvm->srcu);
> +
> +	slots =3D kvm_memslots(gmap->kvm);
> +	if (!slots || kvm_memslots_empty(slots))
> +		return;
> +
> +	kvm_for_each_memslot(ms, bkt, slots) {
> +		start =3D ALIGN(ms->base_gfn, _PAGE_ENTRIES);
> +		end =3D ALIGN_DOWN(ms->base_gfn + ms->npages, _PAGE_ENTRIES);
> +
> +		for (gfn =3D start; gfn < end; gfn +=3D _PAGE_ENTRIES) {
> +			if (kvm_s390_mmu_cache_topup(mc))
> +				break;

[Severity: Low]
Should this be a return instead of break?

Using break here only exits the inner GFN loop for the current memslot,
so kvm_for_each_memslot() will continue iterating over any remaining
memslots and retrying allocations after kvm_s390_mmu_cache_topup(mc) has
failed.

> +
> +			guard(write_lock)(&gmap->kvm->mmu_lock);
> +
> +			dat_entry_walk(mc, gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_SPLIT,
> +				       TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);

[Severity: High]
Can splitting an aged large page here lose guest storage keys when
uses_skeys(gmap) is true?

When a 1M or 2G large page is aged via gmap_age_gfn() ->
gmap_clear_young_crste(), the entry is marked invalid (h.i =3D 1) while
the guest storage keys for its 4K frames remain in hardware storage keys.

When dat_entry_walk() splits that invalid large PMD via dat_split_ste(),
saving the hardware storage keys into the newly allocated 4K PGSTEs is
gated on uses_skeys (from DAT_WALK_USES_SKEYS):

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

Because DAT_WALK_USES_SKEYS is not passed to dat_entry_walk(),
pgste_init.pcl is false and the new PGSTEs are left zeroed while the new
PTEs have h.i =3D 1. When a subsequent minor fault validates the PTE via
_gmap_handle_minor_pte_fault() -> gmap_ptep_xchg() -> __dat_ptep_xchg(),
uses_skeys(gmap) is true, so __dat_ptep_xchg() restores the zeroed PGSTE
over the hardware storage key:

arch/s390/kvm/gmap/dat.c:__dat_ptep_xchg() {
    ...
	if (uses_skeys) {
		if (old.h.i && !new.h.i)
			/* Invalid to valid: restore storage keys from PGSTE. */
			dat_set_storage_key_from_pgste(new, pgste);
    ...
}

Should this pass (uses_skeys(gmap) ? DAT_WALK_USES_SKEYS : 0) in the
dat_entry_walk() flags, similar to gmap_protect_rmap()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D6
