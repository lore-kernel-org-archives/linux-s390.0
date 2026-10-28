Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214943;
	b=epXwM6XRac6mS69MvvO/K7tXkkx5NYGtAcFHiSFr8fFLrtrmuTUPP6rCv8E+4iCUNnWT
	 lBduiiC7T2PD5/DloMkYnti5dCOZ7GlDBedpvDNM473Gn1z956ouilBw+RHieRA7dKuI9
	 V6oomNUF4urwGprjoe18w6+YuQ46dtAU5iuxMEY/EXSvbGuIDUqb8/3leZaraVlK/1Syo
	 OHfPuwEmLccYldr3T0m/8VEDc69aEiazvnXcy3mxg5pBQUgu/qfr7Wipzre/4qLsWBnNs
	 QMFg3Y2M/rM+/t8Pn7YjXiFXghUkB4HNim2LzgElx1hQ9sPG80ts0wQ7MlMQJm5+XtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/sdlVL7e521paInlVGPXeRSGyEf8ci6lJZqdL6F8Kw=;
	b=o0GdAPVaTeTt/dM/Jc2FCws6kVpIc9LYnggJR7EBMqo3eKzEGATeieGf3liBQQi4Jrny
	 vCT4ZmGmSB//fBNrxCoBHRkew5X5+WOxc72fcwLtr0LPiutc0Nfb3W/gsvOZGnLn1pibk
	 9GT+j0ZxtA4FlS31DzN80rUVtyb/qKNVR34LZhlSu31rbWHgOcIDQVYyfzukgQ4pn6miL
	 vXFaNeds9oc71WfmEA5YTpxZtVqfnHIlhw+nA7yPXs+9wKhAgYF3cWPEaC6jR98Ha6Hlh
	 43h0PMs7J1n7iDRWIKzN0yVqe3rgJHTVolIpmkunQb1hHxer8CZguEBlcaZglK/zyOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWuK+tPW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F9606A31D;
	Wed, 28 Oct 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWuK+tPW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC0D1F01825;
	Wed, 28 Oct 2026 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214942;
	bh=w/sdlVL7e521paInlVGPXeRSGyEf8ci6lJZqdL6F8Kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWuK+tPWzqKOV20bQnyK064xRtRsP+dElRESjfGlFawPeOlaX+T5jMWAHAjvIurrG
	 YhK4OfMM08f0sN1pZHdMRssL7kZiqbyvxYCJQ26hV8afBfrVwPoj4nvkyiLI+fSrxz
	 6bD1/TLgL5IXBfPnG/M/bmBKN9H9J0pVE3PxasCvqdtAKKS+msArXMTdpWDU5gcbmn
	 DDKbJ1Lo6LPRKniaK8EebtESJdBfXlSE7dvnXCb9E9ShFX0IFkDHP6jeKfPRlZ0ksN
	 1yrcVDnnAQ5PcCXuDXedyUcxk+QIo2Q8DkrdF5NG9UijMjnMHJYuwamkxzpfzk1Joz
	 3mClGKwg0JRZg==
Message-ID: <sashiko-outbox-188344@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-2-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 19:15:41 +0000
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
- [High] KVM: s390: _crste_ucas() entries are misclassified by _crste_hole()
--

commit ae2a9cbd52d9a1b0705430e97b065c3fd62e60bc
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix UCONTROL inconsistencies

This patch updates mapped-but-unallocated UCONTROL segment entries to use a
new combination of flags (_UCAS_ENTRY_LENGTH and _UCAS_ENTRY_OFFSET) so they
no longer collide with the present bit, and adds DAT_WALK_IGN_HOLES to the
UCAS walk paths.

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
Can _crste_ucas() entries be misclassified by _crste_hole() and
dat_entry_walk() when walking a UCONTROL gmap without DAT_WALK_IGN_HOLES?

In _crste_ucas(), PFN_PHYS(pfn) is stored in bits 0..51 of res.val while
res.h.fc0.tl =3D 0 (clearing tok.pr) and res.h.fc0.tf =3D 3 (in bits 56..57=
).
However, _crste_hole() and _crste_none() only inspect crste.tok.type (bits
0..15 of res.val) and do not check crste_is_ucas():

arch/s390/kvm/gmap/dat.h:
static inline bool _crste_hole(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type !=3D _DAT_TOKEN_NONE;
}

static inline bool _crste_none(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type =3D=3D _DAT_TOKEN_NONE;
}

And in dat_entry_walk():

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

Because crste.tok.type overlaps (PFN_PHYS(pfn) >> 48) & 0xffff and
crste.tok.par overlaps (PFN_PHYS(pfn) >> 32) & 0xffff, two problems can
occur when a caller walks vcpu->arch.gmap->asce without DAT_WALK_IGN_HOLES
(for example via KVM_S390_MEM_OP -> vcpu_check_access_key_gpa() ->
dat_get_storage_key(), or storage-key and CMMA handlers such as
handle_sske(), handle_pfmf(), or dat_perform_essa()):

1. When PFN_PHYS(pfn) < (1UL << 48) (256 TiB, which is true for all 3-level
   s390x user address spaces), crste.tok.type is 0 (_DAT_TOKEN_NONE).
   _crste_hole() returns false instead of treating the UCAS entry as a hole.
   If dat_entry_walk() was called with DAT_WALK_ALLOC (for instance via
   dat_set_storage_key(), dat_cond_set_storage_key(), or
   dat_set_cmma_bits()), it falls through to dat_split_ste(), overwriting
   the UCAS segment entry with a newly allocated page table that has
   PTVAL_VMADDR =3D=3D 0, wasn't allocated in gmap->parent->asce, and is le=
aked
   when the child gmap is destroyed because GMAP_FLAG_OWNS_PAGETABLES is not
   set on vcpu->arch.gmap.

2. When (PFN_PHYS(pfn) >> 48) =3D=3D _DAT_TOKEN_PIC (1, i.e. 256 TiB <=3D
   user_addr < 512 TiB under 5-level page tables), _crste_hole() returns
   true, but dat_entry_walk() sees entry.tok.type =3D=3D _DAT_TOKEN_PIC and
   returns entry.tok.par (bits 16..31 of the user address) instead of
   -EFAULT. Callers interpret positive return values as a guest Program
   Interruption Code, or if bits 16..31 happen to be 0, dat_entry_walk()
   returns 0 with *ptepp =3D=3D NULL, causing callers like dat_perform_essa=
()
   to dereference a NULL ptep.

Should _crste_hole() (and _crste_none()) account for crste_is_ucas(crste),
or should dat_entry_walk() explicitly check for crste_is_ucas(entry) before
inspecting entry.tok.type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D1
