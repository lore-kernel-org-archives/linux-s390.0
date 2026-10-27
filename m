Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123569;
	b=UkOTt7CTqk30vNr6QUK41ct1idIxJawMqwV/7TzXZoHhxHS7DMvRYnbk0mHqgx8hwT07
	 LT50cI9sFWUu303aJGabLillo6c2P1NTwWqzl/cOwqRNdjNEk9+YVqVMmgLZs5NhFB3Rc
	 R1BGq6902nieajBfeaXcBAztuY8aAALrjAQuDqvIfa5kAKE4/FECSoh3eJn2t6QX+LpaU
	 dWYLL6Q7JC3aaYH3D+f+GfdtAf2i7xHJxzIJJGbSYUxjtENgwrE4Gf4myre3+b5PEbbYp
	 gdiw5sAbH0jlTaz68qF7xjUCKg75C4qTwUy0Hmo/Ynsm3cLUxqdLep9t3+WOE3uQx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gowgVHpsK/w/4c19PBEy00xqngFC5TZeaQ/36+gcSvk=;
	b=fb/tfdMseoGvZyIrp9tbDpSa9ulWKoc8JIwh26iHtrdLyFWb/k1o47Ug2ufC+BTQHgUo
	 pyN/+pDZoPVd27JyqiNHQWUBh77Vn+ZL/etrVB7YE0cbP2+/6tVqd2wzr5vxE6bPfUPll
	 tIii1XcF531f9Z1n62XwEWhgMMtYwZurNK1+pA82jJoTSSQc/FJCpA5iwCpmxecajNQx8
	 AwQB1YGKRhb48iPdp33tmq2qh/02HopPyK26650GPl3CJLVI+0BO5MsdlXr2FszLY+PhX
	 Hrj25ONDAVWCY8ch5HSuRAqcJZbStejW1dC935jAer3Rpz3g31rcd5fendl+cG+5fmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvqaCE35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC2606A31A;
	Tue, 27 Oct 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvqaCE35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BA81F01829;
	Tue, 27 Oct 2026 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123569;
	bh=gowgVHpsK/w/4c19PBEy00xqngFC5TZeaQ/36+gcSvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvqaCE35ouTyvrPHd5xv1Frd/YIRSeP4AZbr6hrAYO9gLivxkVEDfRYX5F1YfNZed
	 YdEgX1DMoHNzPa0msS4uB6xtpRvljPjrlkXzMt/zOVi8rATU2YfJVQC02Mg/XyOi7a
	 uhYFBF7cM6z9XGcP97aKxb3HcWwkV/J6dsNMG8bKqI1marXTV/81EkvdBGW5BPWqI5
	 JaISATNWCBqqW+7SS6EBBZypRUyFbHW2hU8kP+5a5vE0Tq+BD1FayqGVoUf9pGTEAc
	 AGni4A+DBDBFn/xaX2EsPyA0bcAOnkLc6pjJ3IKiqE5iJ9iXOjHNE1achY5r3aQg1f
	 mF/uAUsp3MuNg==
Message-ID: <sashiko-outbox-186994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] KVM: s390: Improve unmapping of large ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027173239.224849-4-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
 <20261027173239.224849-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:52:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] KVM: s390: wrong IDTE option flag IPTE_GUEST_ASCE passed to id=
te_crste()
- [Critical] KVM: s390: missing table-type bits in idte_crste() for PUD inv=
alidation
- [Medium] KVM: s390: _gmap_unmap_pmd_fast() fails to clear pgste prefix_no=
tif bit
--

commit e343f26ffd40139c7f207f60f7208912b2666ca8
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Improve unmapping of large ranges

This commit speeds up gmap_unmap_gfn_range() for guest address ranges larger
than one segment (1M) on standard VMs by invalidating higher-level DAT
entries with idte_crste() and updating detached page tables in bulk rather
than invalidating each leaf PTE individually.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 225fdae3d57ca..7ae0b4a1a6ca0 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c

[ ... ]

> @@ -462,6 +453,117 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct=
 kvm_memory_slot *slot, gfn_t
>  	return false;
>  }
> =20
> +static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t n=
ext, struct dat_walk *w)
> +{
> +	union crste old =3D *crstep;
> +
> +	/* We only care about large puds */
> +	if (!old.h.fc)
> +		return 0;
> +	if (!gfn)
> +		gmap_unmap_prefix(w->priv, 0, next);
> +	if (old.s.fc1.vsie_notif)
> +		gmap_handle_vsie_unshadow_event(w->priv, gfn);
> +
> +	if (machine_has_tlb_guest())
> +		idte_crste(crstep, gfn, IPTE_GUEST_ASCE, w->asce, 0);
> +	else
> +		idte_crste(crstep, gfn, 0, w->asce, 0);
> +	*crstep =3D _CRSTE_EMPTY(old.h.tt);

[Severity: Critical]
Does idte_crste() set the required table-type bits in the R1 operand when
invalidating a Region-3 entry here in _gmap_unmap_pud_fast()?

Looking at arch/s390/kvm/gmap/dat.h:idte_crste():

	unsigned long table_origin =3D __pa(crste_table_start(crstep));
	unsigned long gaddr =3D gfn_to_gpa(gfn) & HPAGE_MASK;

table_origin does not OR in the Designation-Type bits (crstep->h.tt << 2),
unlike __pudp_idte() in arch/s390/include/asm/pgtable.h which sets
_ASCE_TYPE_REGION3 (0x04), or crdte_crste() in arch/s390/kvm/gmap/dat.h
which sets new.h.tt << 2.

Because crste_table_start(crstep) is 16K-aligned, bits 60-61 of table_origin
are always 00 (Segment Table). When gmap_unmap_gfn_range_fast() walks a 2G
large PUD (old.h.tt =3D=3D TABLE_TYPE_REGION3), won't IDTE interpret the
Region-3 table as a Segment Table and index entry 0 using the Segment Index
bits of gaddr instead of the Region-3 Index, causing a translation
specification exception or corrupting entry 0 while leaving *crstep and its
2G TLB entries un-invalidated before *crstep is overwritten?

> +
> +	return 0;
> +}
> +
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
> +		if (machine_has_tlb_guest())
> +			idte_crste(crstep, gfn, IPTE_GUEST_ASCE, w->asce, 0);
> +		else
> +			idte_crste(crstep, gfn, 0, w->asce, 0);
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
> +	if (machine_has_tlb_guest())
> +		idte_crste(crstep, gfn, IPTE_GUEST_ASCE, w->asce, 0);
> +	else
> +		idte_crste(crstep, gfn, 0, w->asce, 0);

[Severity: Critical]
Should the three idte_crste() calls in _gmap_unmap_pud_fast() and
_gmap_unmap_pmd_fast() pass IDTE_GUEST_ASCE instead of IPTE_GUEST_ASCE?

In arch/s390/include/asm/pgtable.h, the constants are defined as:

	#define IPTE_GUEST_ASCE	0x800
	...
	#define IDTE_PTOA	0x0800
	#define IDTE_NODAT	0x1000
	#define IDTE_GUEST_ASCE	0x2000

In idte_crste(), opt is ORed into the R2 operand (gaddr | opt). Passing
IPTE_GUEST_ASCE (0x800) sets IDTE_PTOA (bit 52, Clearing-by-ASCE) instead of
IDTE_GUEST_ASCE (0x2000, bit 50).

When machine_has_tlb_guest() is true, won't this execute IDTE in
Clearing-by-ASCE mode with non-zero R1 and gaddr operands (risking a
specification exception), fail to flush guest-ASCE TLB entries, and leave
*crstep valid in memory while pt->ptes[i] and pt->pgstes[i] are modified
below?

> +
> +	for (i =3D first; i <=3D last; i++) {
> +		if (pte_hole(pt->ptes[i]))
> +			continue;
> +		if (!pt->ptes[i].h.i && uses_skeys(w->priv))
> +			pt->pgstes[i] =3D dat_save_storage_key_into_pgste(pt->ptes[i], pt->pg=
stes[i]);
> +		pt->ptes[i] =3D _PTE_EMPTY;
> +		pt->pgstes[i].vsie_notif =3D 0;
> +		pt->pgstes[i].vsie_gmem =3D 0;
> +		pt->pgstes[i].zero =3D 0;
> +	}

[Severity: Medium]
Should this loop in _gmap_unmap_pmd_fast() also clear
pt->pgstes[i].prefix_notif?

In the slow path, _gmap_unmap_pte() -> gmap_ptep_xchg() -> _gmap_ptep_xchg()
clears pgste.prefix_notif when installing _PTE_EMPTY (newpte.h.i =3D=3D 1):

	if (pgste.prefix_notif && (newpte.h.p || newpte.h.i)) {
		pgste.prefix_notif =3D 0;
		gmap_unmap_prefix(gmap, gfn, gfn + 1);
	}

Although gmap_unmap_gfn_range_fast() already calls gmap_unmap_prefix() on
the aligned range, leaving pt->pgstes[i].prefix_notif set on _PTE_EMPTY
entries means that when the page is later faulted back in via _gmap_link()
-> gmap_ptep_xchg(), a read fault (newpte.h.p =3D=3D 1) will trigger an
unnecessary gmap_unmap_prefix(), while a write fault (newpte.h.p =3D=3D 0 &&
newpte.h.i =3D=3D 0) will keep the stale prefix_notif bit set on the new PT=
E.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027173239.2248=
49-1-imbrenda@linux.ibm.com?part=3D3
