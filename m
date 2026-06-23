Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BC308F3E;
	Tue, 23 Jun 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230131; cv=none; b=p7IBca1temvuAFP8D3ugUVyrTM0W2C3naETNG+VcnP9IIq2fTYxCKe7AFUfqmEiAPLvg1MipSlQuWcGj96h0Y1rRF5DWE8ahz8HvZlhSqWjSxiuZqOV0j6Ekx+WXDxfaX/NGQobru8HUEfYaStlnsF4uEnfT8pXmy0wCgLyykYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230131; c=relaxed/simple;
	bh=t6NBHPyd0ygF25qKkd8/crVuMHDeNgTskwxoBGPVOlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nc1M3cVa+m9vm134v8IFLGjzly8/BJy+ffXSMGR1TMjUl5uq2ZNNvoKSh+T+yfy1UJHrJx1YFLfgn+bd2ylVAGEcuF3Oj5m838bMnn2oAj00EaMZhw4PiUm5qlqRGGg0eNRQK9/Pb6JtTPY1M1ysm+A3Klg1UzvrpR+mOmE8JZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjXmlNfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjXmlNfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E111F000E9;
	Tue, 23 Jun 2026 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230126;
	bh=YRMsIzbioVpZSfV67VhFtiCAkRqpboYk/iWhz8tIk+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjXmlNfmYDTZ5D56zppHccEbc32gj1+2z76xIMgCXsrPnIsnodnXpxQ2/NUgf9OQs
	 5EVeXQyeYcim0nu43/DpPKKP6iaNGYNNpBmyrstTod232a6qP2iQGYjX2z5YFeeSvr
	 V19L8kgaKnb3QH90PBJ6K/C/2iegZ1Lpdm9c+jEflt5+YGD89oextMHbt5ZY1mNAYv
	 oWwxu3D7rpAcHpr6jRmhxId6UawnQjcc4Z1HXVY5VJk5vbae+kOLpHGG9NFbsLuX7m
	 ryQS4VUsV/eZG2CJNlikRLEMEsOXfvlDg/MTK7jnU/OJ57GR31GJxpy6tpeyrzCbf5
	 uo1gYtn537xsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] KVM: s390: Do not set special large pages
 dirty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260623153331.233784-4-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
 <20260623153331.233784-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:55:25 +0000
Message-Id: <20260623155525.E2E111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing check for special pages (`!s.s` / `!old.s.fc1.s`) in K=
VM gmap unmap and destroy paths causes operations on garbage folio/page poi=
nters.
- [Critical] The UVC handler `_kvm_s390_pv_make_secure()` unconditionally c=
onverts the faulting PFN to a folio, enabling a malicious PV guest to crash=
 the host by attempting to secure an MMIO region.
- [High] The `s` (Special) bit is lost when a large page (PMD) is split int=
o PTEs, leading to illegal `folio_set_dirty()` calls on special pages.
--

commit c8813ca7d60b80b32bbd7cf3d235de6086bea6b4
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Do not set special large pages dirty

Special pages / folios should not be set dirty. This also applies to
large pages. Add a missing check in gmap_clear_young_crste() to prevent
setting the large page dirty if it is a special page.

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -327,7 +327,7 @@ static long gmap_clear_young_crste(union crste *crste=
p, gfn_t gfn, gfn_t end, st
>  		new.h.i =3D 1;
>  		new.s.fc1.y =3D 0;
>  		new.s.fc1.prefix_notif =3D 0;
> -		if (new.s.fc1.d || !new.h.p)
> +		if ((new.s.fc1.d || !new.h.p) && !new.s.fc1.s)
>  			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
>  		new.s.fc1.d =3D 0;
>  		new.h.p =3D 1;

[Severity: Critical]
This isn't a bug introduced by this patch, but since you are fixing the
special bit check here, I noticed other unmap and destroy paths might be
missing similar checks.

In _gmap_unmap_pte() and _gmap_unmap_crste(), the folio is extracted and
converted without verifying if the special bit is clear:

arch/s390/kvm/gmap.c:_gmap_unmap_pte() {
    ...
    if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flag=
s))
        folio =3D pfn_folio(ptep->h.pfra);
    ...
}

Similarly, _destroy_pages_pte() and _destroy_pages_crste() check for presen=
ce
but seem to skip checking the special bit before calling phys_to_page().

Can this lead to host kernel panics? If a protected VM has MMIO regions
mapped, could unmapping or destroying the VM cause these functions to extra=
ct
a garbage pointer from the special PFN and crash the host upon dereference?

[Severity: Critical]
This is a pre-existing issue, but while looking at PFN conversions, does
the UVC handler correctly validate the faulting PFN before converting it?

arch/s390/kvm/pv.c:_kvm_s390_pv_make_secure() {
    ...
    folio =3D pfn_folio(f->pfn);
    priv->rc =3D -EAGAIN;
    ...
    if (folio_trylock(folio)) {
    ...
}

Could a malicious PV guest issue a secure storage conversion request on a
guest physical address corresponding to an MMIO region? If KVM's fault-in
logic resolves the PFN without a backing struct page, would the uncondition=
al
pfn_folio() conversion and subsequent trylock result in a host panic?

[Severity: High]
This is a pre-existing issue, but I noticed the special bit might be getting
lost during page table splitting.

When dat_split_ste() copies properties from the old PMD to the new PTEs,
it appears to omit the special bit:

arch/s390/kvm/dat.c:dat_split_ste() {
    ...
    init.val =3D pmd_origin_large(old);
    init.h.p =3D old.h.p;
    init.h.i =3D old.h.i;
    init.s.d =3D old.s.fc1.d;
    init.s.w =3D old.s.fc1.w;
    init.s.y =3D old.s.fc1.y;
    init.s.sd =3D old.s.fc1.sd;
    init.s.pr =3D old.s.fc1.pr;
    ...
}

If a special large page is split, will the resulting PTEs permanently lose
their special designation? Could this cause aging paths to mistakenly skip
the special check and attempt to call folio_set_dirty() on an invalid
pointer later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623153331.2337=
84-1-imbrenda@linux.ibm.com?part=3D3
