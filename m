Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895626;
	b=QernInpXIGxphRTldCAvxWfhWVwyLK6O2YYBocgE/3BaRgvUWDcBll+DifLwfsji1aiG
	 tuS+U7dxf+p6ofSbG3geT57G0APV1GItk5jjCRIyl/XcM1m0bMorJwDI4EfGLh2MOrm/R
	 /DARAy24Dw3Wm9xbi+KXuGq/aOtBMw40rzLPtyG2adbjYPO/8w08ig4lStHzjbWlW9zhC
	 T87T/B//jVKNdDrQE8pqLygYi3B3Xo/CHgKak9jXVW+oEgbsjmou7hz8ou66DlSpHbKoJ
	 6iQwKLLkaEvhtgV+yCb/VjHdd0Ps//s+x9GeC92tVhT9TsnE9qLcuHouPsAMeBfVi2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZQQBnn/48mc4O/706Aywbc0VwtDEdzyDvNG5j+PDrpo=;
	b=y0Euk6MK4W+u1IDkczfbXsdFGLi+nL8cILSEIje4F9sQogM3EmIS5AaeTyOG4TWydARt
	 Siix57vcp25tb8/qhgzI0qByFeZO4DCn7X6T9cNum3dcL3RXePbzN+nyKbwIwWkdR6uBX
	 9ZOrIS29ubup9Qs28JhJWFtT1qCweLKhzbNBdHfjgQHJuScWMmDwQFihy0a6Lr5GP+0Vm
	 lBQydzYDU/JtTgTRTEgYflfDujQz0XQBL1HyCHryiHo7Tk+JzIMiIWMubn1CU2GgwpJV0
	 pxDWa+sJ+uFpwdCrLZ7yo9lAj7uAmiveRo0wgGKELUlLj+Kg6IRPExiIw+zPYfGGSEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elOMPbCl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE1606A33F;
	Thu,  5 Nov 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elOMPbCl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5641F00A02;
	Thu,  5 Nov 2026 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895626;
	bh=ZQQBnn/48mc4O/706Aywbc0VwtDEdzyDvNG5j+PDrpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elOMPbClkuNnEJ6NeqrWR76OWX0I5arBY1h06JRuVRXqUl4FE5QdI4r580Atpzukn
	 RzlMc6uDf1qhq20ic0tdygnuQXW5g+GWlPgDXugdEPrvkzq2QDRT4QW85fakR+o62/
	 h9yGWSl387dDWPQfCB3/wP9rGggs4GltSYA3YdoX/OweCtys/eQxxTotT+cBPQuY5N
	 VTigdvvAdKW/L58lqqdTeOEP8uLlO7cLkbRL3xD0l+bVuVLgw+BULn/yuCRALoOOf5
	 ejrycZsc3qnbC/HP/Xndi+GafuuAY1GP/UWRwX0XIYV4QEHobogSmaj8jEfziKcKJY
	 qzaOSma+eXrqQ==
Message-ID: <sashiko-outbox-199468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105153705.208516-2-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:20:25 +0000
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
- [High] KVM: s390: _crste_ucas() collides with crste.tok in _crste_hole()
--

commit a4c739d060e46a8362a876fd2edc730f00fb6503
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix UCONTROL inconsistencies

This commit updates how mapped-but-unallocated UCONTROL segment entries
are encoded in union crste so they do not set the tl field to 1 and
collide with the present bit, and adjusts UCAS walks to ignore holes.

> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 90389d47ba4e0..e6215c0b571f9 100644
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -109,6 +109,8 @@ union pte {
>  #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
>  #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
>  #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
> +#define _UCAS_ENTRY_LENGTH	0
> +#define _UCAS_ENTRY_OFFSET	3
> =20
>  /* Soft dirty, needed as macro for atomic operations on ptes */
>  #define _PAGE_SD 0x002
> @@ -421,6 +423,23 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, =
int tt)
>  	return res;
>  }
> =20
> +static inline union crste _crste_ucas(kvm_pfn_t pfn)
> +{
> +	union crste res =3D { .val =3D PFN_PHYS(pfn) };
> +
> +	res.h.i =3D 1;
> +	res.h.tt =3D TABLE_TYPE_SEGMENT;
> +	/*
> +	 * Segment entries do not have a TF or TL field; reuse those bits to
> +	 * indicate that this is a special mappped-but-not-allocated UCAS
> +	 * entry. Setting TL to 0 ensures that the entry will always be
> +	 * considered not present.
> +	 */
> +	res.h.fc0.tl =3D _UCAS_ENTRY_LENGTH;
> +	res.h.fc0.tf =3D _UCAS_ENTRY_OFFSET;
> +	return res;
> +}

[Severity: High]
As reported by Sashiko on v5 [1], does _crste_ucas() collide with
crste.tok.type and crste.tok.par when checked by _crste_hole(),
_crste_none(), and dat_entry_walk()?

In union crste, tok.type occupies the top 16 bits (val >> 48) and tok.par
occupies the next 16 bits ((val >> 32) & 0xffff), while h.fc0.tf sits in
the unnamed 26-bit padding of struct tok and setting h.fc0.tl =3D 0 sets
tok.pr =3D 0:

arch/s390/kvm/gmap/dat.h:
	union {
		struct {
			unsigned long type :16; /* Token type */
			unsigned long par  :16; /* Token parameter */
			unsigned long      :26;
			unsigned long i    : 1; /* Must be 1 */
			unsigned long      : 1;
			unsigned long tt   : 2;
			unsigned long      : 1;
			unsigned long pr   : 1; /* Must be 0 */
		};

Because _crste_ucas(pfn) stores PFN_PHYS(pfn) in val, crste.tok.type is
(PFN_PHYS(pfn) >> 48) & 0xffff and crste.tok.par is
(PFN_PHYS(pfn) >> 32) & 0xffff.

However, _crste_hole() and _crste_none() do not check crste_is_ucas():

arch/s390/kvm/gmap/dat.h:
static inline bool _crste_hole(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type !=3D _DAT_TOKEN_NONE;
}

and dat_entry_walk() checks:

arch/s390/kvm/gmap/dat.c:dat_entry_walk() {
	...
	if (crste_hole(entry) && !ign_holes)
		return entry.tok.type =3D=3D _DAT_TOKEN_PIC ? entry.tok.par : -EFAULT;
	...
	if (entry.pmd.h.i && !entry.pmd.h.fc) {
		if (!allocate)
			return any ? 0 : -ENOENT;
		rc =3D dat_split_ste(mc, &(*last)->pmd, gfn, asce, uses_skeys);
}

When a segment is mapped via KVM_S390_UCAS_MAP (kvm_vm_ioctl_ucas_map() ->
gmap_ucas_map() -> gmap_ucas_map_one()) before the parent segment is
allocated, gmap_ucas_map_one() installs _crste_ucas(p_gfn) into the child
vcpu->arch.gmap->asce. If another gmap function then walks
vcpu->arch.gmap->asce without DAT_WALK_IGN_HOLES:

1. When PFN_PHYS(p_gfn) < (1UL << 48) (i.e. host user address < 256 TiB),
entry.tok.type is 0 (_DAT_TOKEN_NONE), so crste_hole(entry) returns false
instead of failing with -EFAULT. If DAT_WALK_ALLOC is set (for example via
handle_sske() or handle_pfmf() -> dat_cond_set_storage_key(), or via
dat_set_storage_key() or dat_set_cmma_bits()), dat_entry_walk() calls
dat_split_ste() on the UCAS entry in vcpu->arch.gmap->asce. That allocates
a page table in the child gmap (which is leaked on gmap_dispose() because
GMAP_FLAG_OWNS_PAGETABLES is cleared on UCONTROL child gmaps) with zeroed
PGSTEs (PTVAL_VMADDR =3D=3D 0), causing subsequent gmap_ucas_translate() ca=
lls
to translate the segment to GPA 0 in gmap->parent instead of the mapped
user_addr.

2. When (PFN_PHYS(p_gfn) >> 48) =3D=3D _DAT_TOKEN_PIC (1) (i.e. 256 TiB <=3D
user_addr < 512 TiB), crste_hole(entry) is true and dat_entry_walk()
returns entry.tok.par ((PFN_PHYS(p_gfn) >> 32) & 0xffff) instead of
-EFAULT. If entry.tok.par is 0, dat_entry_walk() returns 0 with
*ptepp =3D=3D NULL and *last pointing to the non-leaf UCAS entry, causing
dat_cond_set_storage_key() and dat_set_storage_key() to spin endlessly at
if (!crste_leaf(crste)) goto again; while holding
read_lock(&vcpu->kvm->mmu_lock). If entry.tok.par is non-zero, callers
such as handle_iske(), handle_rrbe(), handle_pfmf(), and
vcpu_check_access_key_gpa() treat those address bits as a guest Program
Interruption Code.

Should _crste_hole(), _crste_none(), and dat_entry_walk() explicitly
handle crste_is_ucas() so unallocated UCAS entries are always treated as
non-PIC holes?

[1] https://lore.kernel.org/r/20261029130044.125032-2-imbrenda@linux.ibm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153705.2085=
16-1-imbrenda@linux.ibm.com?part=3D1
