Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774067;
	b=5QsNg0n6vyIFPgzwn15a2g85yLy5CDIKiTlhdO6x/rZWZhCfAh7V8dOr2z6ETlpH3gKY
	 6DsoD6VR0B7IysTzA0PZjpKs614YbCb/fse4x12e8U2uinHZtsDhOLSdqA/JV9OJm68Si
	 atAs/rtku6qWeJO6ybcmY5Aa1mwUWPYpGYa8pEbHiywsa8bwonT1LKhKciz9QV6n4WbNh
	 OQA13+XOKnfwO2FzD+pmzT3TJryQa6lgoKPyzlwpFExAD3PzSpPiCADI0HNLzvyNkSbiT
	 kJAAhyjifN9M84ZVDRnpXTgZ0oOAg8wNR4tS61G/4lHgJI+25OHg80NDTwwZXrfvadA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774067;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AUsj+poEnJSrvBmZEDcSvvkiGmzKbJtNxTRyYZvNHUk=;
	b=294sd296aggoSfkPvWvgBSPL1HH2dgFhNJDQDW9ATkyVDuaFFwsumENuZGNloPEq3wA4
	 CEB3WDx4bGLTbbZjv3US79cbsSPEhJR9SCbXwTmGOTzhleVBWv8JbTSbznNDQk/mIbT8d
	 1GwPRp/S/ogd6CRzzHJuZwT5JvlkG/klPxdIMLoQwVMbemaBPKxoaxxPiWPkyU4aaTbbZ
	 9/pJRRY/o+l0qncpiTCGoXwsBnUbcRgan2LyWUEuUeExbV5NIxlbjNUDdAvdPjAuftfAt
	 AcUEUJNTiSI4tHrxbYF2CO/Sdim3j5dm9k2s9GpCZrNfCLblFq1bfU4zmkywx7QVztg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8CWCLcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB62606A324;
	Fri, 23 Oct 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8CWCLcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA5F1F01825;
	Fri, 23 Oct 2026 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792774066;
	bh=AUsj+poEnJSrvBmZEDcSvvkiGmzKbJtNxTRyYZvNHUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8CWCLcF72O1tBHvQxKTq4BO1E/yJkuXLaoSXGHoCzfkC4gsfaanJpv2OYHIJrEjP
	 GHEEsv42lR8N65en5cScL5vj7jjbMZx6siiRqY717Zf5pJCuTFCEN0S/BGdD9bArCJ
	 esGUcnQqQF/J3JPNlgME55HBinK0IU6Uz59C0F5A7D0J0THVJcyKo7Ydnvgf8Fdncg
	 SEgJB2zelwysi5T85hyyWv517syspKUARzkbEoT5eyeqceQOBDq6ZNZtwYMrJwgpR3
	 hxFvCpg/UCpyue8arTB9hCqI0G5MdBJFd712ZpZK+GTHdfqSTMU4fiVPv/LdkOSI8Q
	 5fcvq00K9dZxg==
Message-ID: <sashiko-outbox-182969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-8-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:47:45 +0000
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
- [High] KVM: s390: _crste_ucas() entries misclassified as holes by _crste_=
hole()
--

commit cc87ac32e4a2839d582fdf50d1a8a54f15989cea
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix UCONTROL inconsistencies

This commit changes the encoding of mapped-but-unallocated UCONTROL segment
entries so that the tl field is set to 0 instead of 1, avoiding a collision
with the present bit, and updates the UCONTROL gmap helpers accordingly.

> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 319a8670fb10e..3493f033e2045 100644
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

[Severity: High]
Can entries created by _crste_ucas() be misclassified as memory holes by
_crste_hole() (or as empty entries by _crste_none())?

In union crste, tok.pr and s.fc1.pr both alias bit 63 (the least significant
bit of h.fc0.tl), while tok.type (bits 0..15) and tok.par (bits 16..31) ali=
as
the upper 32 bits of PFN_PHYS(pfn).

Previously, mapped-but-unallocated UCAS segment entries had h.fc0.tl =3D 1,=
 so
tok.pr was 1 and _crste_hole() evaluated to false. With _crste_ucas() setti=
ng
h.fc0.tl =3D _UCAS_ENTRY_LENGTH (0), tok.pr is now 0, while _crste_hole() a=
nd
_crste_none() do not check !crste_is_ucas(crste):

arch/s390/kvm/gmap/dat.h:
static inline bool _crste_hole(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type !=3D _DAT_TOKEN_NONE;
}

#define crste_hole(x) _crste_hole(_CRSTE(x))

static inline bool _crste_none(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type =3D=3D _DAT_TOKEN_NONE;
}

When userspace maps a UCONTROL segment via KVM_S390_UCAS_MAP ->
gmap_ucas_map() -> gmap_ucas_map_one() -> _crste_ucas(p_gfn) with a host
userspace address >=3D (1UL << 48) (so pfn >=3D 1UL << 36, which is standar=
d for
top-down mmap() on 4-level/5-level s390x systems), PFN_PHYS(pfn) has non-ze=
ro
bits in bits 0..15, making crste.tok.type !=3D _DAT_TOKEN_NONE and causing
crste_hole() to return true.

While gmap_ucas_map_one(), gmap_ucas_translate_simple(), and
gmap_ucas_unmap_one() now pass DAT_WALK_IGN_HOLES, other walkers on
vcpu->arch.gmap->datt do not. For example, vcpu_check_access_key_gpa() and
handle_iske() call dat_get_storage_key(), and handle_rrbe() calls
dat_reset_reference_bit():

arch/s390/kvm/gmap/dat.c:dat_get_storage_key() {
    ...
	rc =3D dat_entry_walk(NULL, gfn, datt, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE=
, &crstep, &ptep);
	if (rc)
		return rc;

	if (!ptep) {
		union crste crste =3D READ_ONCE(*crstep);

		if (!crste_leaf(crste) && !crste.h.i)
			goto again;
		if (!crste.s.fc1.pr)
			return 0;
    ...
}

In dat_entry_walk(), at the segment level:

	if (crste_hole(entry) && !ign_holes)
		return entry.tok.type =3D=3D _DAT_TOKEN_PIC ? entry.tok.par : -EFAULT;

Before dat_get_storage_key() or dat_reset_reference_bit() can reach the
!crste.s.fc1.pr check and return 0 for the unallocated segment, wouldn't
dat_entry_walk() abort with -EFAULT (or return bits 16..31 of the host
userspace address as a bogus guest program interruption code if bits 0..15
happen to match _DAT_TOKEN_PIC)?

Should _crste_hole() and _crste_none() also check !crste_is_ucas(crste)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D7
