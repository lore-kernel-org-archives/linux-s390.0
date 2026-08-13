Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348B3E2747;
	Thu, 13 Aug 2026 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661020; cv=none; b=qjn7g34PdYVICCObHbe+QHEbl5T6H1fyyVI3FmudrgKxCwysrtboZNpUOQ59myMYvmgJP+zKeOwP0dE/UN0WPCFHzY8kHOq4boyMpexg87JlpwvGamSQ1JSl105NnDrpLqnRRrdJVntW7DMDBWScZevgkuTdAoMKYV4zKOEHYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661020; c=relaxed/simple;
	bh=yidAZR2+rMRX6azVrH41SRcmLaNdRDTCNeG6uDz4Pqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kn+4+T8knmOlpr9pn9LIUPH/Qk4ZvfX59QceeTaMEE2lIR48VajUImSMO6RIoEKnOPUF3V5+Z2tznxJMkJQKyfXtKjL65ERL/H1E6dnG3sGbSz0yFo3SUo3zeyv3y4qXxXlF0kMmPx0mDBe5FzjcYiecGjpoQ/rVfY7YgZ4oyCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy9O2UZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy9O2UZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC941F000E9;
	Thu, 13 Aug 2026 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786661019;
	bh=y78v3zzdZT2rnCHJEoF/HWrCMA7r+5oL2fUwZN/EiT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fy9O2UZ7SxydGngVXUptJNAI2XspKsfttxcsSzEi0OInHsDEaCxmkz/Vo6hJewQD5
	 T12xm0DzfL09EziXZaXel5D46vyh/D0nOwSujD+F6WVHF2Q+t52/gd0b1ekYoVED73
	 vD5wM/MvLGDF0AVGrY5jGXycAdFkG68rFCwoo/Z6/PX2uLxu9/q5VDHFQh1c5FdHod
	 /IC0P19RZXsnlw5135LueyN4vYHHogSJs7/uiYe9dNQIx8VDeIwEc14NwkFMnk/hr8
	 6q+tIO/rj82WOYGJvZvFlnEZ6PkGjae0nO+dQgfuROm1I0tUkv3nj8JWfPWA9yNuDK
	 xI92/lc28uo0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] KVM: s390: vsie: Fix unshadowing while shadowing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260324174301.232921-8-imbrenda@linux.ibm.com>
References: <20260324174301.232921-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:43:34 +0000
Message-Id: <20260813224338.9EC941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing unshadowing check in `_do_shadow_pte` and `_do_shadow_=
crste` leads to orphaned shadow mappings and use-after-free of host memory.
--

--- Patch [7]: [PATCH v3 7/9] KVM: s390: vsie: Fix unshadowing while shadow=
ing ---
commit d5030d28123280edd38c0f9ad86e8a0833ab9f12
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix unshadowing while shadowing

If shadowing causes the shadow gmap to get unshadowed, exit early to
prevent an attempt to dereference the parent pointer, which at this
point is NULL.

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 70703bf866dbe..0ac2d775d4c05 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1472,6 +1472,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t =
raddr, union crste *host, uni
>  		return rc;
> =20
>  	do {
> +		/* _gmap_crstep_xchg_atomic() could have unshadowed this shadow gmap */
> +		if (!sg->parent)
> +			return -EAGAIN;
>  		oldcrste =3D READ_ONCE(*host);
>  		newcrste =3D _crste_fc1(f->pfn, oldcrste.h.tt, f->writable, !p);

[Severity: Critical]
This is a pre-existing issue, but since we are checking for unshadowing her=
e,
could _gmap_crstep_xchg_atomic() unshadow the shadow gmap on the exact=20
iteration where it succeeds?

If _gmap_crstep_xchg_atomic() succeeds but unshadows sg, the loop exits and
bypasses this check on the next iteration. It would then unconditionally in=
stall
the shadow entry just below the loop:

_do_shadow_crste() {
    ...
	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f=
->gfn, false));

	newcrste =3D _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
	gfn =3D gpa_to_gfn(raddr);
	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn, sg=
->asce))
		;
    ...
}

Could this leave the guest with orphaned shadow mappings? If the host later
unmaps the page, it iterates over parent->children to invalidate shadow page
tables. Since sg was removed during unshadowing, it would fail to find and=
=20
invalidate it, which seems like it might allow a use-after-free of host mem=
ory.

Would we need a similar check after the loop exits here, and similarly in
_do_shadow_pte() after _gmap_ptep_xchg() returns?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324174301.2329=
21-1-imbrenda@linux.ibm.com?part=3D7
