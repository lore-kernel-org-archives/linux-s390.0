Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C52FFF8B;
	Mon, 22 Jun 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145632; cv=none; b=Vdn3hHv9qxdhlPMKfXEtt2/QGQomNd8x7e4w9L5YyxVlsldSPE8wu2H0aVxpx5VjPehLEMrxH1JolWSdgndi2/jHsa2ldmHRIKvzLuUlUnXtpKYXyqvoH1LO5qBoQ0oAuyrsb7ycM5omGE54SwR59YoPkn/a7UKGHEs8ZZp5+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145632; c=relaxed/simple;
	bh=YpusvmujpauQpFVEbDQvsCv1BRGEdTNpfNuz1GxX6ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIxSCibqKUmu4yWRbnh53P2oLU+SumAaFLyJb9upjuvFgnGQ6vk8g7XDjCKEj9JDDlA67q50t+U2fZKzkhPgzkryXvIxgYR3TgIsXL68ehuzBBIDtpghpBmedvQFbbixr3fKfC2Rbi+TRrmRTUH6SrbuLib3nPQiJB3RYFi0Mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuCBE8ox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuCBE8ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E891F000E9;
	Mon, 22 Jun 2026 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145631;
	bh=ScyTZSeEe5yJ2jo9j8zAwSRgr53dEtUt9K1MFynbnEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CuCBE8oxXfzkKoVOTiKe1JUhFj69PLM5a1odFSqBB+5x50FlOssu5TpHOL1fz2k1j
	 +vK2C8W9Ls4vbsrCygKdwRhYmmbqb5qe1XUo+N8XkT2fFcErt2vkToDoeVnJUNVA6A
	 3j7gLAH+szg8kfYm7SedOfRet1ihdNE0QXB0BoAGjVCxy6SYMIelVGZqShj3IHL295
	 jSKQRsHA+nR9eBfp20Ux56BVxFhkQF+dblzCgmQvF4rZHVzCwHT6Zc8zrA5M3RS3Ch
	 wWJ7cyDTzO2DmdYUHuRmRn2yd5C4RCmw/5c21wKWHgEUSY6tcIqNdYTGGDLjNBOpIx
	 T6NOemLAa6jfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] KVM: s390: Do not set special large pages dirty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260622160739.202044-4-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:27:09 +0000
Message-Id: <20260622162710.C4E891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing special page checks (`.s` flag) in `gmap_unmap` and `d=
estroy_pages` paths lead to a host kernel panic when mapping I/O memory int=
o Secure Execution VMs.
- [Critical] Missing special page checks in storage key and reference bit h=
andlers allow an unprivileged guest to crash the host via addressing except=
ions.
- [Critical] In `_kvm_s390_pv_make_secure()`, KVM unconditionally calls `pf=
n_folio()` on the faulting PFN and attempts to lock it without verifying if=
 the PFN is backed by a valid `struct page`.
--

commit 9b9c8471e051ee12971f206fa564520a1f1fea5b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: KVM: s390: Do not set special large pages dirty

This commit updates gmap_clear_young_crste() to avoid setting special large
pages dirty. It adds a check for the special bit before calling
folio_set_dirty().

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 52d55ddea8d4f..3192f610f6962 100644
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

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at the special=
 bit
check added here, I noticed similar missing checks in other paths.

In arch/s390/kvm/gmap.c:_gmap_unmap_crste():

    if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->fl=
ags))
        folio =3D phys_to_folio(crste_origin_large(old));

And _gmap_unmap_pte():

    if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flag=
s))
        folio =3D pfn_folio(ptep->h.pfra);

Are we missing a check for the special bit here before converting the physi=
cal
address to a folio? If a Secure Execution VM uses device memory (like
VM_PFNMAP) without a backing struct page, could extracting the PFN and
calling phys_to_folio() / pfn_folio() return a garbage pointer and cause a
host panic when accessed?

Similarly, in _destroy_pages_crste():

    if (!crstep->h.fc || !crstep->s.fc1.pr)
        return 0;
    origin =3D crste_origin_large(*crstep);

And _destroy_pages_pte():

    if (!ptep->s.pr)
        return 0;
    __kvm_s390_pv_destroy_page(phys_to_page(pte_origin(*ptep)));

Could these paths also trigger a host panic by unconditionally calling
phys_to_page() on special pages?

[Severity: Critical]
This is a pre-existing issue, but I see a similar pattern in dat.c.

In arch/s390/kvm/dat.c:dat_reset_skeys_crste():

    if (!crstep->h.fc || !crstep->s.fc1.pr)
        return 0;
    // ...
        addr =3D sske_frame(addr, PAGE_DEFAULT_KEY);

In dat_reset_reference_bit():

    if (!crste.h.fc || !crste.s.fc1.pr)
        return 0;
    return page_reset_referenced(large_crste_to_phys(*crstep, gfn));

In dat_get_storage_key():

    if (!crste.h.fc || !crste.s.fc1.pr)
        return 0;
    skey->skey =3D page_get_storage_key(large_crste_to_phys(crste, gfn));

Does this code fail to check the special bit before executing inline
assemblies (sske, rrbe, iske) on the origin physical address?

If a guest maps I/O memory and executes these instructions, would KVM execu=
te
them on the host side using the I/O physical address, potentially causing an
addressing exception and host panic since I/O memory does not support stora=
ge
keys?

[Severity: Critical]
This is also a pre-existing issue, but I noticed another unprotected
pfn_folio() call in pv.c.

In arch/s390/kvm/pv.c:_kvm_s390_pv_make_secure():

    folio =3D pfn_folio(f->pfn);
    priv->rc =3D -EAGAIN;
    // ...
    if (folio_trylock(folio)) {
        priv->rc =3D __kvm_s390_pv_make_secure(f, folio);

Is it possible for f->pfn to be a raw device PFN (where f->page is NULL) if
the fault resolves to a special device mapping like VM_PFNMAP?

If so, would calling pfn_folio() and folio_trylock() on an invalid folio
pointer lead to a host kernel panic?

>  		new.s.fc1.d =3D 0;
>  		new.h.p =3D 1;
>  	} while (!dat_crstep_xchg_atomic(crstep, crste, new, gfn, walk->asce));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D3
