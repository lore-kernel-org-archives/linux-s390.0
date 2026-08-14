Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CB47140E;
	Fri, 14 Aug 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719298; cv=none; b=EkYcaqAxVcAeqnfvN5cfGbqcxzlBCJ8J4Cx/rfk673iRlgp8HXKJRjGJXCfcAklrVa//hA0Ls2n+mxRFjUYxgn4nA2+bWcZoeWM2IH6zDL1FfT5k4wyqWZLdHct1z43i/mWDWkDQQ8sMM1fdjbG93O2pDBs3KM9suJzGvgg3Lac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719298; c=relaxed/simple;
	bh=lZIL3+3JLW42ni7kj6OJqO1NZzS7x7MOPnHS8VH5Yto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRlYehiRqu6RVGy2bp2REf4+nBRxbOEfG0zaUd3mQuv15MGsrfkHB1N1fIAAqxu94IPMB97XlFfNv1jTue7rbRQC5ZeLY5tg2XsoGjAEVidbJ14Xk/esP/Ux3zQP6rZPg/YOADDOvAvLhfi38L4cl3ZaQK5EWSMBXCJpPRBrRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlhynb8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlhynb8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A97B1F000E9;
	Fri, 14 Aug 2026 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719295;
	bh=9gOgR4h4nv5PW2+jH/CkQhhZO28tgTQ/Ktm8Mt2nlik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nlhynb8dVTmid76ii5etMWscbFxDcfFuACRBr24KPmykvAYuWBSPiV/UyYV9eU2Pz
	 x21uzl45cVAr2MWeqxReMA6joxXT3G3pJen5gAYB/EYSl0ftrebct2BCxcP6WOup4q
	 xXHctNTya1IcIsSvuCybTH2PcTpygKDd0zye2QyQonvjOnGuqPHtMuFOlnNATYU15I
	 sw9dbm0qm2S+Ru45AGR4jep8h4yFw9JM9KR3chABnUc2j8VBxSRuo7RXZCU78TRSN1
	 e5MFHSF8qYHUeqftih/XEe9Plkg1Tw89w4lcTKBupf3lQ2gPjbSdfRKG5ofz+JKgtn
	 VbjRnDrNftUXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/6] KVM: s390: Refactor dat_set_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260814144041.169025-4-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
 <20260814144041.169025-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:54:54 +0000
Message-Id: <20260814145455.5A97B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Build failure: dat_delete_slot() is called with too many arguments =
in KVM_MR_MOVE.

Pre-existing issues:
- [High] Spurious failure of memslot deletion and VM crash due to concurren=
t hardware RC bit updates.
--

--- Patch [3]: [PATCH v1 3/6] KVM: s390: Refactor dat_set_slot() ---
commit 15c005eb250e6c4e079b0b85ff6c42d583b09782
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Refactor dat_set_slot()

This commit refactors dat_set_slot() and related functions to only take a
struct kvm_s390_mmu_cache. For dat_delete_slot(), mc is now NULL. This
serves as a prerequisite for moving gmap DAT table setup.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index f2ea013cb33e2..7e5dd5a1eb1ef 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c

[ ... ]

> @@ -873,10 +866,9 @@ static long _dat_slot_crste(union crste *crstep, gfn=
_t gfn, gfn_t next, struct dat_wal
>  static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, =
struct dat_walk *walk)
>  {
>  	union crste new_crste, crste =3D READ_ONCE(*crstep);
> -	struct slot_priv *p =3D walk->priv;
> +	struct kvm_s390_mmu_cache *mc =3D walk->priv;

[Severity: High]
This is a pre-existing issue, but does the atomic exchange in this function
need a retry loop?

If the hardware page table walker asynchronously updates the Reference or
Change (RC) bits on a valid large page CRSTE while KVM is deleting the slot,
it seems dat_crstep_xchg_atomic() can fail because the memory value no long=
er
matches crste:

arch/s390/kvm/dat.c:_dat_slot_crste() {
	...
	/* This table entry needs to be updated. */
	if (walk->start <=3D gfn && walk->end >=3D next) {
		if (!dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->asce))
			return -EINVAL;
	...
}

Would this spurious -EINVAL propagate up to kvm_arch_prepare_memory_region()
and trigger KVM_BUG_ON(rc, kvm), causing the VM to panic?

> -	new_crste.val =3D p->token;
> -	new_crste.h.tt =3D crste.h.tt;
> +	new_crste =3D mc ? _CRSTE_EMPTY(crste.h.tt) : _CRSTE_HOLE(crste.h.tt);
> =20
>  	/* Table entry already in the desired state. */
>  	if (crste.val =3D=3D new_crste.val)

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 91b9758354574..0a08a3c7b023d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5860,7 +5860,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> =20
>  		switch (change) {
>  		case KVM_MR_DELETE:
> -			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);
> +			rc =3D dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npag=
es);
>  			break;
>  		case KVM_MR_MOVE:
>  			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);

[Severity: Low]
Does this code fail to compile?

Since dat_delete_slot() was updated to only take 3 arguments, it looks like
the KVM_MR_MOVE case is still passing 4 arguments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144041.1690=
25-1-imbrenda@linux.ibm.com?part=3D3
