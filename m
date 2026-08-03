Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F740F75D;
	Mon,  3 Aug 2026 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762526; cv=none; b=acd3zD9dJ1pyUAbkQAAhNqj0mHUMYZr4jGpCxP0sMzNJs3I8uQbTzTuJtkAxZHFI4vPMog+TBhRvh0u5DsQXh8sDx+FQMZKEHZ01IyHaRUbHTq+qKxRHB31oYCgwKwr3+8nbH74/o75dCVrdyKHag9f6qiX9nffP7IkK4Ym9xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762526; c=relaxed/simple;
	bh=n5tu+xInQvNO3LrbvXSVAwzgQWyJIIzVR0oeEiloz1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZAUl723B/bSkkp6wL/LMbc6hudLRNUc8LWA2DoOJmvfqZwIgyP+HohqqplcYkZ1bp3+DgC3mPBX74rwJBeOCQe7fktL3ePdWwZ37CQsvZvMuKgQENNIAURFqbTjX2RPqinMOe1+dMsg/9Z0zTnqcSrZqc2ZWoddyMc92/Wv6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DySaHdrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DySaHdrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0640B1F000E9;
	Mon,  3 Aug 2026 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762524;
	bh=ZRIiGFzjZ3FJXXWS3EoeUVh2aIwH/oTIs0H/DdYCVNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DySaHdrNJG4d5ctYDxnnmvCy4Dy4l5c3Plh+FD736cZpzlpOUfduRYekrpofD/Xpt
	 KxeFtzNe/7GBIZgapjoybYHsgpS1hwuvWbGGzFAb0TgyeGRrnvdCIMq9zMhY/gAZ8D
	 IU/LiDQ1+jirV1KyXip2LshPfiraNqvY2rwxTx5uWkZXNHIe9iTwPLP/brKmyTgqBM
	 HUX979n4nTPvwJvfCixWgWS3oBKnjR+ysuUMwk9nOOqHhcglx9cK+Hmm5LtVp45Uot
	 4zX3Qtx477arD2LOhVjh5ulvlyPCrUdBTzbkRb1uhcKTNEcOWaN+p7ZHw0f1cC7gir
	 UXtmZflVSk6sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/13] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803124040.126471-9-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:08:42 +0000
Message-Id: <20260803130844.0640B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The CMMA dirty pages counter leaks when unmapped pages (holes) wit=
h `cmma_d =3D=3D 1` are deleted.
--

--- Patch [8]: [PATCH v8 08/13] KVM: s390: cmma: Fix dirty tracking when re=
moving memslot ---
commit 914169226ab516b51f60cbd45659598a2b39525d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot

This commit decrements the cmma-dirty counter when a memslot is removed
to ensure accurate dirty tracking during migration mode. It also
opportunistically adopts scope-based resource management for the
kvm_s390_mmu_cache.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e5c5e9f61cb24..ba811f0673d10 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5830,6 +5846,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	}
> =20
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
> +			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
> +					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
> +					    &kvm->arch.cmma_dirty_pages);
> +		}
> +

[Severity: High]
Does this code leak the cmma_dirty_pages counter when unmapped pages (holes)
have cmma_d =3D=3D 1?

Because this pre-walk uses DAT_WALK_IGN_HOLES without DAT_WALK_ANY,
dat_pte_walk_range() will skip calling cmma_d_count_pte() for holes:

arch/s390/kvm/dat.c:dat_pte_walk_range() {
	if (pte_hole(READ_ONCE(table->ptes[idx]))) {
		if (!(w->flags & DAT_WALK_IGN_HOLES))
			return -EFAULT;
		if (!(w->flags & DAT_WALK_ANY))
			continue;
	}
	...
}

If a guest page was dirtied (setting cmma_d =3D 1 and incrementing the
counter), and then the host unmaps the page (e.g., via page reclaim
or MADV_DONTNEED), the PTE becomes a hole but the PGSTE retains
cmma_d =3D=3D 1.

When the memslot is removed, this pre-walk skips the hole, failing
to decrement cmma_dirty_pages. Then dat_delete_slot() walks the range
with DAT_WALK_ANY and clears cmma_d, causing the counter to permanently
leak.

If this counter never reaches 0, could it stall live migration by causing
userspace to infinite loop waiting for remaining dirty pages to drop to 0?

>  		switch (change) {
>  		case KVM_MR_DELETE:
>  			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D8
