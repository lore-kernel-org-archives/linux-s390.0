Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123646;
	b=FvXi7yIr9AUU3FpZaB/UHisLkrTy+l+PGUtr4vstwUl6YyPlac2fxizNL0x7TFQCEV7W
	 hL3yUBsiBZFk/wJ7nxZe6UY95SgSHyJVJQXXJmFssLQKpuFYcleLbUATdIJWq9TPyVsUs
	 PI9i09z3qVW9VBUEPz9g0h+vJvHegYf3WiUZQM62J+UF4xVchsEirqWFWwq6aqK1zV9iL
	 VBsJUCSKCP65yhr7y8noWCiErNMHhuI/RZXz1cw0UJkPoSI1uNk/qJLyDhYMtBcixFAm+
	 soci3CCBtJ2hh6xYvYz4Cve3tygRNI2r7k+dd8YyDemmfGq4PLKUQOTPMTGcnQD0SKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123646;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hkthE3LGg4pUwXVNxWMZwWIDTaHK3HN3fIb+gMEWqs0=;
	b=D05c2y8g6sSaGXNOOBpuPXcvJsVSZiho4UKvpIhPBhnXTZKuUsMwSTrEUSzB8pCB+xpK
	 7CozhlcrnTRFZuAhEGc/DwOFh0FdeIxFj1c7sVTLfZJuIUyhNie/drOLq1bq6CZMxqVeA
	 lE0tBMEGLOZvTKzuXNFr/DeP0AvNyyqAjl0M/WY8yTc31IakkU5KHKwMGlfdFDAVWRi2Z
	 KdEZlr+mimpXjyDlk6klDdV4SOYwIdtjpFhTLDBsIO5WcG5y62lVEAk0xA3/ptz0KCqpn
	 ueXuewTyMs5tT+2hUxQnRJJqGrlLSkNl3u4Tci9TZPOvjoCD/vi4u+CxZtS6CYLbCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/3Get4N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAF606A31A;
	Tue, 27 Oct 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/3Get4N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE711F01825;
	Tue, 27 Oct 2026 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123645;
	bh=hkthE3LGg4pUwXVNxWMZwWIDTaHK3HN3fIb+gMEWqs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k/3Get4NpMBbzsTD/kNm2UTGXj7bFuFMTbpSY72TuVkaluGq66tCLFkmY/d/8ZDnX
	 fFJnS6yF9HxQlElrFXZk5B5dyxXXy/wKzlJXPT8gdZS0+trFfMsAa/cbKQ49xHu1ca
	 0LvixkKgnvvUdct28gVrmRrfz1YWa902XVbZ1gvbtseXC16jl1V14vBf1U4/h8zclC
	 avesGqLNurzfJHrhuTFzG7UFOM8Uj5kERcXuA6S/Kkkyxm3KVPi7+o87gxcdA0d4sX
	 ahEnpXl/Z4WYMBTx/C6kxYrQdIjk4mHOyeHn2aza+iqJtsvdbvQsRv/QCaDFv+cMph
	 Td55owyWHffsw==
Message-ID: <sashiko-outbox-186996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027173239.224849-2-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
 <20261027173239.224849-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:54:04 +0000
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
- [High] KVM: s390: _crste_ucas() collides with _crste_hole() and _crste_no=
ne()
--

commit 8288fc810dc049ff30a9d687a1ca6d691bb508c2
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix UCONTROL inconsistencies

This commit changes the flag encoding used for mapped but unallocated
UCONTROL vCPU segment entries so that they do not set the present bit,
and updates the UCAS gmap helpers accordingly.

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
With _UCAS_ENTRY_LENGTH set to 0, _crste_ucas() leaves bit 63 (res.tok.pr)
cleared while setting res.h.i =3D 1 and placing PFN_PHYS(pfn) across bits
0..51, which overlaps res.tok.type (bits 0..15) and res.tok.par (bits
16..31).

In arch/s390/kvm/gmap/dat.h, _crste_hole() and _crste_none() check:

static inline bool _crste_hole(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type !=3D _DAT_TOKEN_NONE;
}

#define crste_hole(x) _crste_hole(_CRSTE(x))

static inline bool _crste_none(union crste crste)
{
	return crste.h.i && !crste.tok.pr && crste.tok.type =3D=3D _DAT_TOKEN_NONE;
}

When a UCONTROL segment is mapped via KVM_S390_UCAS_MAP to a host address
with non-zero bits in 63:48 (i.e. PFN_PHYS(pfn) >=3D (1UL << 48), which is
normal for 5-level s390x mmap addresses), crste_hole() evaluates to true
for the UCAS entry.

While this patch passes DAT_WALK_IGN_HOLES in the gmap_ucas_*() helpers,
other callers walk vcpu->arch.gmap->asce without DAT_WALK_IGN_HOLES, such
as:

- vcpu_check_access_key_gpa() (via KVM_S390_MEM_OP) and handle_iske() ->
  dat_get_storage_key() -> dat_entry_walk(..., DAT_WALK_ANY, ...)
- handle_rrbe() -> dat_reset_reference_bit() ->
  dat_entry_walk(..., DAT_WALK_ANY, ...)

In dat_entry_walk(), hitting the segment entry triggers:

	if (crste_hole(entry) && !ign_holes)
		return entry.tok.type =3D=3D _DAT_TOKEN_PIC ? entry.tok.par : -EFAULT;

Instead of returning 0 at the !crste.s.fc1.pr check in
dat_get_storage_key() or dat_reset_reference_bit(), won't this fail with
-EFAULT (or return the upper address bits as a bogus program interruption
code if entry.tok.type happens to equal _DAT_TOKEN_PIC)?

Should _crste_hole() and _crste_none() exclude crste_is_ucas(crste) (or
check !crste.h.fc0.tf)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027173239.2248=
49-1-imbrenda@linux.ibm.com?part=3D1
