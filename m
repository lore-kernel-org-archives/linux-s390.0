Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931F1A6810;
	Wed, 24 Jun 2026 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301038; cv=none; b=r7pD9tlTiALN6+Q/aQzTmmN/dz3JylYcTXmzn1H5zfgaVSkeRFDxCILYS2NpzXtt/WiMqSwfrigt4LuBVAUoS4RRiwZ7Qw9+yejW/WrqRpJ/N9q/+UD0Edh4GNQt0Lpk/Kw4fkXbda9pro6MxY2f+F2dEqi71EC7J4SKHd+jIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301038; c=relaxed/simple;
	bh=BXttZtIjYhmZniM9h6DEz+dCCFljyrUJR1AUoon+7t4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5sp7umeUrvr7UOdSj3MiqJGpr7PSojUSdxEoGqds9lYl+pMEJSpTamM/ZZh0+5lDgMa5TOYahsbvuu0hc0YrR6XNwQq9OBF0AsNGOF4U1SvG7kIn5xJOCpiA65P8Q120P9C2qJ/qhFmY3Q80d4bXLRwEXqPEqK1EQDHf0OmYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CToDUxtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CToDUxtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC951F00A3A;
	Wed, 24 Jun 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301037;
	bh=dbsdz1Se4yBvj37WN7WCUGl/KxY/Tc8U7Ys4raJWlj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CToDUxtGv6ZShizRxteLUUfkDzeZPWAB0Hu3NgXy9E0Abn4ZKuJl4rLDaj3wTR7sl
	 EzF3UuJcp3E52AC5fGorOG3CWshPJw6UInPFuAEIxDGp7L4BDA+PrE2UpbV/NW/YMc
	 REkK+wfv/OeibfaaQgxIpE9ZrZq1T9+NIo/agLCn4L1fuxJjrrnNI7/VWMpqbHvVZA
	 sKYyZgMhu4ddLNdj8dsopz74YoKTNdFls7Ij5M8JskbSlTwyZmVq5IEn3JyOyUFfe+
	 8eDqu2n+0m+ootjO7wNb2qy6scoZOYxaJpw2qRlyWYCrtIWDLUarU9EexnA11k/iIw
	 SdOlHUZOA89MQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 06/12] KVM: s390: Do not set special large pages
 dirty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260624111928.144283-7-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
 <20260624111928.144283-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:37:16 +0000
Message-Id: <20260624113717.3CC951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing validation for special pages in KVM GMAP unmap and des=
troy paths leads to host kernel crash on invalid folio pointer dereference.
- [Critical] Missing check for a valid `struct page` before folio conversio=
n during PV guest secure page creation causes host crash.
--

commit 5f6958e6ac1a501221bda61b5fd8d27af20f157d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Do not set special large pages dirty

Special pages / folios should not be set dirty. This also applies to
large pages.

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
>  		new.s.fc1.d =3D 0;
>  		new.h.p =3D 1;

[Severity: Critical]
This isn't a bug introduced by this patch, but since you are fixing the
special page check here, do we need similar checks in other places?

For instance, in _gmap_unmap_pte(), does this code safely handle special=20
pages when calling pfn_folio() on the PTE's PFN?

arch/s390/kvm/gmap.c:_gmap_unmap_pte() {
    ...
	if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
		folio =3D pfn_folio(ptep->h.pfra);
    ...
}

Similarly, in _gmap_unmap_crste(), does this code need a check for=20
!old.s.fc1.s before calling phys_to_folio() on a large page origin?

arch/s390/kvm/gmap.c:_gmap_unmap_crste() {
    ...
	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags=
))
		folio =3D phys_to_folio(crste_origin_large(old));
    ...
}

And in _destroy_pages_pte(), does it need a check for !ptep->s.s to avoid=20
an invalid struct page dereference?

arch/s390/kvm/gmap.c:_destroy_pages_pte() {
    ...
	__kvm_s390_pv_destroy_page(phys_to_page(pte_origin(*ptep)));
    ...
}

Also in _destroy_pages_crste(), should there be a check for !crstep->s.fc1.s
before calling phys_to_page()?

arch/s390/kvm/gmap.c:_destroy_pages_crste() {
    ...
	for ( ; cur < end; cur +=3D PAGE_SIZE)
		__kvm_s390_pv_destroy_page(phys_to_page(cur));
    ...
}

Can unprivileged userspace trigger a host kernel crash by mapping a memory
region backed by special PFNs without struct pages, converting it to a
protected VM, and then tearing it down or unmapping it?

[Severity: Critical]
This is also a pre-existing issue, but does _kvm_s390_pv_make_secure()=20
need a check for a valid struct page before converting the folio and=20
attempting to acquire its lock?

arch/s390/kvm/pv.c:_kvm_s390_pv_make_secure() {
    ...
	folio =3D pfn_folio(f->pfn);
    ...
	if (folio_trylock(folio)) {
    ...
}

Could unprivileged userspace map PFNMAP memory without a backing struct=20
page into a PV guest and cause a host crash when this path is triggered
during guest memory fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624111928.1442=
83-1-imbrenda@linux.ibm.com?part=3D6
