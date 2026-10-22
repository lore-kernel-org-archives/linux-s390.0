Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688439;
	b=UpMDOHIHxfbIY5g8vn/kCOPCKtrmmcb86TtcomjzqxpcHZ5LTpnU6yU/bYIeMH31bhfZ
	 LoajjQ+npA/qXWYcWDSuMoZheUA81CZE5tF8e6kMiNYpPyJGrtAJSjUb8xH0Uyvzs28so
	 ida+ZAZbRbtN8HHSQIAZnXFCtjzSsm7e6fj1RTszkbKtxuvgQpdiddXx21i8rg9Pf15Pu
	 5Cplg8ArU0vUMGXjdD0QOLbF57Mbgwe34ctVvxifogD82F/9NXbVoN4MxMI2Asex4+5mW
	 u42X0JBClO+wKBkf0wz6ViotPp4i9TBl20qfv9tfdsjX1YbO+t1EOYuTkNWkqNQui+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qas/TyFcocz2SYZiEWnqlKVUWE7yAp9qxahDKtRodPs=;
	b=Q3VfSJNzdvcfagfJHkkL1g6frKvAbTOcxaTvWn8O662Ug5cvzEK4C2npT4016QGKjh5W
	 bU2O95BgxEJNIKjTm+xyR2WC8O1iNGYVpInn25s5swgTYWiPKdZI2WWr8gwgq3z44dNFl
	 8cMfPPr0owXcMLw0im7i30HsglL+ay+iTfQxvcWghLITJmM76rGRXcJsk1au+eY9r3i9Y
	 JDN5AAW1Fmb1CPFHvuTES9LnpBJzVBCIuu6vbHWyjz1VjffNEUHGyYfZnrxxCoMgf6/Os
	 PcSdzTBVlmU7gGoG0keK0Q2PnKFFuJmg5dEZe+n3/v84rNJ91EPvLalnrRcHZzZo7tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRT2VMP9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA7606A319;
	Thu, 22 Oct 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRT2VMP9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1298A1F01825;
	Thu, 22 Oct 2026 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792688438;
	bh=Qas/TyFcocz2SYZiEWnqlKVUWE7yAp9qxahDKtRodPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRT2VMP94MK2PH5Jr/9ujJFPfIHGPnIieVjuAXknI5LHsPPWkjZIlzxAwzXVboB3/
	 HB5P18Tpc7sNlGlyzU7X6g9qBJVcLztukmZSvlza7Sqffn/YQ8RQ7ndPGw2yaxN0fa
	 ymbQXLqMGcaD0xXWnM8OF2Cawi1VXXlK9PeqyZmwUYYGP/j7MxL/CuOddmocMJlU+p
	 eKZjzsbIFVg3jvmwBPmfZuJNF9RDPikMiExSPrf7k4EFBrXaf3pWzf+rsWZBEmImie
	 nOkUgtgU/P4GX4RYe+mVGzoHZx5+Rz3pbqmizDSC03hBqePU0XysxKEjYnqDrIr8Fk
	 rDKP+wWaQ9nnA==
Message-ID: <sashiko-outbox-181838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/10] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-8-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:00:37 +0000
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
- [Medium] KVM: s390: _crste_ucas() collides with token encoding in _crste_=
hole()
--

commit 709d72ff37a22ce1d8ae00a0f230ee566c74c804
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix UCONTROL inconsistencies

This commit changes the flags used in union crste to represent mapped but
unallocated UCONTROL segment entries so that they do not collide with the
present bit. It introduces _crste_ucas() and updates crste_is_ucas() and
the UCONTROL gmap helpers accordingly.

> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 5dceb397fc1b8..5b03a21c180da 100644
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -105,6 +105,8 @@ union pte {
>  #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
>  #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
>  #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
> +#define _UCAS_ENTRY_LENGTH	0
> +#define _UCAS_ENTRY_OFFSET	3
> =20
>  #define CRDTE_NODAT		IPTE_NODAT
>  #define CRDTE_GUEST_ASCE	IPTE_GUEST_ASCE
> @@ -429,6 +431,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, =
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

[Severity: Medium]
Does _crste_ucas() collide with the token encoding checked by _crste_hole()
and _crste_none()?

In _crste_ucas(), res.h.i is 1 and res.h.fc0.tl is 0, which means bit 63
(res.tok.pr and res.s.fc1.pr) is 0 while bits 0..43 of res.val hold the
segment-aligned host address PFN_PHYS(pfn).

In arch/s390/kvm/gmap/dat.h, _crste_hole() and _crste_none() do not check
crste_is_ucas() or crste.h.fc0.tf:

static inline bool _crste_hole(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type !=3D _DAT_TOKEN_NONE;
}

static inline bool _crste_none(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type =3D=3D _DAT_TOKEN_NONE;
}

When a UCONTROL segment is mapped via KVM_S390_UCAS_MAP with a host
userspace address at or above 0x0001000000000000UL (so bits 0..15,
crste.tok.type, are non-zero) before the parent segment is faulted in,
_crste_hole() returns true for the _crste_ucas() entry.

While this patch passes DAT_WALK_IGN_HOLES in gmap_ucas_map_one(),
gmap_ucas_translate_simple(), and gmap_ucas_unmap_one(), other walkers of
vcpu->arch.gmap->datt do not. For example:

kvm_arch_vcpu_ioctl()
  -> kvm_s390_vcpu_memsida_op()
    -> kvm_s390_vcpu_mem_op()
      -> check_gva_range()
        -> guest_range_to_gpas()
          -> vcpu_check_access_key_gpa()
            -> dat_get_storage_key()

In arch/s390/kvm/gmap/dat.c:dat_get_storage_key():

	rc =3D dat_entry_walk(NULL, gfn, datt, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE=
, &crstep, &ptep);
	if (rc)
		return rc;

And in arch/s390/kvm/gmap/dat.c:dat_entry_walk():

	if (crste_hole(entry) && !ign_holes)
		return entry.tok.type =3D=3D _DAT_TOKEN_PIC ? entry.tok.par : -EFAULT;

Instead of returning storage key 0 for the unallocated segment,
dat_get_storage_key() will fail with -EFAULT (or return bits 16..31 of the
host address in entry.tok.par if entry.tok.type happens to equal
_DAT_TOKEN_PIC). Should _crste_hole() and _crste_none() exclude
crste_is_ucas(crste)?

[ ... ]

> @@ -1027,7 +1040,8 @@ static inline int dat_create_slot(struct kvm_s390_m=
mu_cache *mc, struct dat_tabl
> =20
>  static inline bool crste_is_ucas(union crste crste)
>  {
> -	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl =3D=3D 1 && crste.h=
.fc =3D=3D 0;
> +	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
> +	       crste.h.fc0.tl =3D=3D _UCAS_ENTRY_LENGTH && crste.h.fc0.tf =3D=
=3D _UCAS_ENTRY_OFFSET;
>  }
> =20
>  static inline void dat_set_storage_key_from_pgste(union pte pte, union p=
gste pgste)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D7
