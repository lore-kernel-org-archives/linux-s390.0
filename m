Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280262;
	b=N17dvxFRBWUa80DotlxHStByc/IJNQTyMM/gJOYORx4QT1EnktNpxs3bAAeqz8IaikL7
	 hZto17jQUPwTYmXxzSrE/vnnWaggzITaRB3s0YuVsA5bGvjnbkJx9upcp91PB0cuWfggK
	 bzxbUCGojI54jYtBZTvbLrhO3/+UYaZIBmVb5Z5CforYP1dT0eJKSjytORoZQtTvSqOYO
	 NKR0oRl6epShyUUGcZDGhZsSwEYVBeajspTZMA/wniKU89uuRWi6w8Vdj0ikCOJdTIsCG
	 /0lvut+3oybanlpU6C53OcYT9YIvPw0kYoQXeEJo35SQAY4XFu3WPQrAfe5Pw8/QRTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bnmjJEkieY6A6LCLme12MqEzlKpnAIUYKo+Ua/7lDRE=;
	b=mARk8ZMe5GkqKKnupiVRgrhyU/912kI2CJc8Z0A7HC5Zc8s3IAp5PJQ+liTgaaNDYkpj
	 JjIonYWFy743fy7yT03i1B69QmQ0vaNJ6fjE8/+h+zXEYg3/uPti7gs1WKhwKNRv6aRwe
	 0nvHBo6GlLPmzhV02vmBgjkWhMUVahupipHL4edPJLZnZ6Uv7mipXplR6Lb0tMN/AMkgb
	 ljZDXXETd4Iic4K4/XIwd36CNKb2KwwrRB0UXLB2gq8Q3kUAmUiSC1a++6CZeSfDsxbbK
	 PqiIh9l6bcIgfbmGJvW/A/ojNzAYi18D6oBsvEUeABjBHB0Pab9qeFQEFHLBQd2Tmxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXzUjSXF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61831606A31A;
	Thu, 29 Oct 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXzUjSXF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B8B1F01825;
	Thu, 29 Oct 2026 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793280261;
	bh=bnmjJEkieY6A6LCLme12MqEzlKpnAIUYKo+Ua/7lDRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXzUjSXFcc+U9z+r9vuFUZkE+E7xk9EuDrRhREbzGjNqq8kX2brEyto/t75y6Ae5j
	 pXpdxSYXTygofC43bgGHBj65mjfu0jSKNKQfSNCTjzhPUQaSohVu58CwY1wlmZCsNB
	 GfIVruw5F1S765AznqVo+ahUUit9LUV6i0HXDVyxnzr55J3vmZEjfrlldtBRLwTkLG
	 ohBOIHxtbxmdgRZ2vrzsFWPgaEnoshqt/hoQTbrkUjgbcEJ+LTb+JnsAjUz0OJBH/6
	 hmHJ2mde6FygYrQvTbI2S2Cy2Do6wRnAYc3LRkN4yoVBT8kcKFd7ub3OvTm3xmHkW/
	 txwYAo3cccnTg==
Message-ID: <sashiko-outbox-189372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-2-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:24:20 +0000
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

commit de19569965dfbfabc785467bbb1e64c29e58b5d9
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix UCONTROL inconsistencies

This commit changes the flag encoding used for mapped but unallocated UCONT=
ROL
segment table entries so that they do not set the present bit via fc0.tl =
=3D 1,
and updates the UCAS walk and translation helpers in gmap accordingly.

> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 90389d47ba4e0..4665c1112bb91 100644
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
> @@ -421,6 +423,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, =
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
> +	res.h.fc0.tl =3D _UCAS_ENTRY_LENGTH;
> +	res.h.fc0.tf =3D _UCAS_ENTRY_OFFSET;
> +	return res;
> +}

[Severity: High]
Can _crste_ucas() cause _crste_hole() and dat_entry_walk() to misinterpret =
the
upper 32 bits of PFN_PHYS(pfn) as crste.tok.type and crste.tok.par?

In union crste, setting res.h.fc0.tl =3D 0 leaves bit 63 (res.tok.pr) as 0 =
while
res.h.i is 1, and res.h.fc0.tf sits in the unnamed padding of struct tok.
Meanwhile, PFN_PHYS(pfn) occupies bits 0..51, overlapping res.tok.type (bits
0..15) and res.tok.par (bits 16..31).

Because _crste_hole() and _crste_none() do not check crste_is_ucas():

arch/s390/kvm/gmap/dat.h:_crste_hole() {
	return crste.h.i && !crste.tok.pr && crste.tok.type !=3D _DAT_TOKEN_NONE;
}

arch/s390/kvm/gmap/dat.c:dat_entry_walk() {
	...
	if (crste_hole(entry) && !ign_holes)
		return entry.tok.type =3D=3D _DAT_TOKEN_PIC ? entry.tok.par : -EFAULT;
	...
	if (entry.pmd.h.i && !entry.pmd.h.fc) {
		if (!allocate)
			return any ? 0 : -ENOENT;
		rc =3D dat_split_ste(mc, &(*last)->pmd, gfn, asce, uses_skeys);
	...
}

Waiters or walks on vcpu->arch.gmap->asce without DAT_WALK_IGN_HOLES will
behave differently depending on the upper bits of the mapped userspace addr=
ess
PFN_PHYS(p_gfn):

1. When PFN_PHYS(p_gfn) < (1UL << 48) (any standard 3-level or 4-level
userspace address below 256 TiB), entry.tok.type is 0 (_DAT_TOKEN_NONE), so
crste_hole(entry) is false instead of returning -EFAULT. If a walk with
DAT_WALK_ALLOC is triggered (such as handle_sske() or handle_pfmf() ->
dat_cond_set_storage_key() -> dat_entry_walk()), dat_entry_walk() calls
dat_split_ste() on the UCAS entry. That allocates a struct page_table in the
child gmap (which leaks on unmap/dispose because GMAP_FLAG_OWNS_PAGETABLES =
is
not set on UCONTROL vCPU gmaps) and zeroes its PGSTEs, leaving PTVAL_VMADDR=
 as
0 and causing subsequent gmap_ucas_translate() calls to translate the guest
segment to host address 0.

2. When 0x0001000000000000UL <=3D PFN_PHYS(p_gfn) < 0x0002000000000000UL (on
5-level page tables), entry.tok.type is 1 (_DAT_TOKEN_PIC). When entry.tok.=
par
is non-zero, dat_entry_walk() returns those address bits as a positive prog=
ram
interruption code instead of -EFAULT.

3. When entry.tok.type is _DAT_TOKEN_PIC and entry.tok.par is 0 (for exampl=
e,
PFN_PHYS(p_gfn) =3D=3D 0x0001000000000000UL), dat_entry_walk() returns 0 wh=
ile
leaving *ptepp as NULL. In handle_essa() -> __do_essa() -> dat_perform_essa=
(),
this leads to a NULL pointer dereference in pgste_get_lock(ptep):

arch/s390/kvm/gmap/dat.c:dat_perform_essa() {
	...
	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &pt=
ep)) {
		*state =3D (union essa_state) { .exception =3D 1 };
		return -1;
	}

	pgste =3D pgste_get_lock(ptep);
}

And in dat_cond_set_storage_key(), returning 0 with ptep =3D=3D NULL on a n=
on-leaf
UCAS crste causes an infinite loop at goto again under read_lock(&kvm->mmu_=
lock).

Should _crste_hole() and _crste_none() (or dat_entry_walk()) explicitly acc=
ount
for crste_is_ucas() so that unallocated UCAS entries are consistently treat=
ed
as non-PIC holes when DAT_WALK_IGN_HOLES is not set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D1
