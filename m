Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85B3E9F8D;
	Mon, 27 Jul 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168217; cv=none; b=qxg7bGTTJweLA57nsyfRkozLZkY8ym0ZuIuZ0SsRiKWYHv78ZZqH9LyQvsjopHnqUHPu2ox8n3m67/0oQOHoSlP8BbN0AKsKykLacwdVF0FgwBIyYpaZ0Kdps6Qti7lMsFQ28yiWzvSvb4Oin3A+B7ZcrJ+PbW8gSN7o/DdsXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168217; c=relaxed/simple;
	bh=wqb7dxq+HbnlxwjfeoOhB0TbZ9Wngf1CeoIc+BK5L4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uENRCFCCcNrwhimx2rD2uRdOCIgEVRswj77UuAx/1xa8WKGwtafsoNEyIdq2OUM5sYSLmBT6fNCNb+XTDa/STYEkt3nmwFfuen3BoBrySwdDj2kh/6xr2KRofmP4PYIjcbpEdL1HDGQ2NqqcS+NLcI34eQ2biR+KBV+8Cqii6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2ljp5mW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2ljp5mW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022F81F000E9;
	Mon, 27 Jul 2026 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785168216;
	bh=xV19pqbuvCSTC9yVjfxUsHDgx7ISw5G9PhkpihH2vZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2ljp5mW2Zc23zuvL4qSLf7J5W5L17G3eXCc/SJDP2gwCXQDG9FJk3/O6+UmW/aUI
	 6bgqgVJHj+0cUH7I8+7G7vULLQGEVg/vnEWZwpH/mE05DFIDH7Zfz4mF19HT7Veu7T
	 2VxESnxLmPEcGIcEoDIAfrCS76svWaC5W0jim+VnLRW4q/aFhlG8uipqUkyat8gvQL
	 5HLB9P/aLeE0gzYQZ41fFfwCmbGjfU9Cbx11x7UBU20U2VACNkKcPsvYrRutiTEF29
	 Rc1UhvhYdQ5bJYBIHWeZ6yotzI3Pmabdvy4orfJzB638l/mflKnVjKdG//Yj6FdAgS
	 yVznhCoFoU+7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727150254.236021-5-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:03:35 +0000
Message-Id: <20260727160336.022F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditional NULL pointer dereference of the `old` memslot du=
ring `KVM_MR_CREATE` when migration mode is active.
- [Low] Build failure due to `goto` jumping over a `guard()` declaration, v=
iolating C cleanup attribute semantics.

Pre-existing issues:
- [High] Memory exhaustion and guest memory corruption during `KVM_MR_MOVE`=
 due to shared MMU cache.
--

--- Patch [4]: [PATCH v3 04/10] KVM: s390: cmma: Fix dirty tracking when re=
moving memslot ---
commit bf34c670340b7779837adadb9e6857c53511481a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot

This patch updates CMMA dirty tracking to decrement the counter when a
memslot is removed. It walks the memslot's GFN range during=20
kvm_arch_commit_memory_region to clear the dirty count.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e154a8ad6c735..0a44351722702 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5817,7 +5825,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  		goto out;
>  	}

[Severity: Low]
Will this compile correctly? The goto statement here jumps over the guard()
declaration below, which typically causes a compiler error since C
restricts jumping past the initialization of __attribute__((cleanup))
variables.

> =20
> +	guard(mutex)(&kvm->slots_arch_lock);
> +
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (kvm->arch.migration_mode && kvm->arch.use_cmma) {
> +			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,

[Severity: Critical]
Can this code trigger a NULL pointer dereference when a new memory slot is=
=20
created?=20

If change =3D=3D KVM_MR_CREATE, the old memslot pointer is NULL, but this=20
block unconditionally dereferences old->base_gfn and old->npages before=20
the switch statement checks the change type.

> +					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
> +					    &kvm->arch.cmma_dirty_pages);
> +		}
> +
>  		switch (change) {
>  		case KVM_MR_DELETE:
>  			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);

[Severity: High]
This is a pre-existing issue, but could this lead to memory exhaustion and=
=20
guest memory corruption during KVM_MR_MOVE?=20

Looking at the KVM_MR_MOVE case below this in kvm_arch_commit_memory_region=
():

		case KVM_MR_MOVE:
			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npa=
ges);
			if (rc)
				break;
			fallthrough;
		case KVM_MR_CREATE:
			rc =3D dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->npa=
ges);

The code falls through from dat_delete_slot() to dat_create_slot() and=20
shares the single kvm_s390_mmu_cache (mc). If the cache runs out of space=20
for the second operation, it will fail midway, leaving the DAT tables out=20
of sync with the memslots since this function cannot return an error to=20
userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D4
