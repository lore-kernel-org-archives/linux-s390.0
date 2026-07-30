Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5C38C40C;
	Thu, 30 Jul 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430912; cv=none; b=Pw924u985q6rLOCxhnqI6G7irJsiHRIWV7EEfi34oMkEUxbkqmpQUWZk7+xA11WjhJL9SebVqLkdsCaG5+uAwPGKJHhFLeKYzGxvvtEg1sbgnL+k0Ulotiniwfmt9S1MuzREIaXmPkQrXNBswhAahZ1gj/jQ4JAPBgZPR5K5oZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430912; c=relaxed/simple;
	bh=8CRhcx9voQYYtda8jyWqwuSWUU3ywtuKa9cgJ2a9Jcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ug4MYe15Tt3fxWWQ9Vdb2jNviR/S4At4JlBdE+uGUzvPfnHE8FXlskV9ALdDHxkJUkV3EBEKdCa7EtWsMs72qSV6JsUaohP5MuGjrnMh9A+KEqhAYuS6/6nbhU5DggVqeFZwvxi7p/yFoNGRuzslDfXgHxXgMvIMNVCe6D+EUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRfwPZD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRfwPZD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029321F000E9;
	Thu, 30 Jul 2026 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430911;
	bh=dAHjHgV5aV1GafsZU89rJwZLGeF53exC2EC7B6XX8rY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRfwPZD+yxNIZGkRSr5f4u9pI7h0rwo1gV3v8gRm8czUZWAxNBZOmHKK1gsn4jL0L
	 eOnV5B9eJylsr8EonQJCe27fmEDnEGKAD0RoHOSXlW+rZlUpBeyVm5avAn/tRkV07w
	 b88lPRKoobIt2Bg3gSN6g5l6ks1gGL/znuzuIv60OKqfa8nkQizs9uBAg3dRBEazIW
	 gBR3Ilryj7QkIfRtscGzUErhZG9oEeGsGrjn3B78YM+vtW0wEodo/KtLzMZa/k6Puk
	 j0ZUkZ3hHds0+QQ/zXxwfv0TyaTRX9ssDCpeTJ8PslIIX3SpLEYspo3LuuBNUFbH67
	 ihQMPlHooKI5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/14] KVM: s390: Move DAT table updates to
 kvm_arch_prepare_memory_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730162714.133327-15-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-15-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 17:01:50 +0000
Message-Id: <20260730170151.029321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Moving DAT page table modifications and migration state update=
s to `kvm_arch_prepare_memory_region()` without rollback logic permanently =
corrupts guest state and causes an infinite loop (host DoS) on error paths.
--

--- Patch [14]: [PATCH v6 14/14] KVM: s390: Move DAT table updates to kvm_a=
rch_prepare_memory_region() ---
commit 99c3a9b6f800205c1388216366b06b3eef1e58f0
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Move DAT table updates to kvm_arch_prepare_memory_region()

This commit moves the whole page table update logic from
kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().
This allows the memory allocation failures during DAT table updates to be
propagated to userspace as errors rather than leaving the system in an
inconsistent state.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 035476ec7fbc3..668272dffa18b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5788,55 +5807,27 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
[ ... ]
> +retry:
> +	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
> +			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
> +					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
> +					    &kvm->arch.cmma_dirty_pages);
> +		}
> +
> +		switch (change) {
> +		case KVM_MR_DELETE:
> +			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);
> +			break;
> +		case KVM_MR_MOVE:
> +			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);
> +			if (rc)
> +				break;
> +			fallthrough;
> +		case KVM_MR_CREATE:
> +			rc =3D dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->=
npages);
> +			break;
> +		case KVM_MR_FLAGS_ONLY:
> +			break;
> +		default:
> +			rc =3D 0;
> +			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
> +		}
> +	}
> +	if (rc =3D=3D -ENOMEM) {
> +		rc =3D kvm_s390_mmu_cache_topup(mc);
> +		if (!rc)
> +			goto retry;
> +	}
> +	return rc;

[Severity: Critical]
If kvm_s390_mmu_cache_topup() fails here and returns -ENOMEM, does this lea=
ve
the DAT modifications intact without any rollback?

If this returns an error, the KVM core will catch it and restore the active
memslot metadata:

virt/kvm/kvm_main.c:kvm_set_memslot() {
    ...
    if (change =3D=3D KVM_MR_DELETE || change =3D=3D KVM_MR_MOVE) {
        kvm_activate_memslot(kvm, invalid_slot, old);
        kfree(invalid_slot);
    }
    ...
}

Will this cause KVM core to be permanently desynchronized from the hardware
DAT tree, leaving program check holes in the DAT tree?

If the guest subsequently accesses this out-of-sync memslot, can it trigger=
 an
infinite loop in the fault handler?

Looking at kvm_s390_faultin_gfn(), if the memslot still exists in KVM core,
it resolves the PFN and calls gmap_link(). Because the DAT tree still has t=
he
hole, gmap_link() returns -EAGAIN. The fault handler might loop infinitely:

arch/s390/kvm/faultin.c:kvm_s390_faultin_gfn() {
    ...
    while (rc =3D=3D -EAGAIN) {
        ...
        if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
            f->valid =3D true;
            rc =3D gmap_link(mc, kvm->arch.gmap, f, slot);
        }
    ...
}

Could an unprivileged userspace process under memory pressure intentionally
trigger this error path and cause a host denial of service?

> +}
> +
> +void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_sl=
ot *old,
> +				   const struct kvm_memory_slot *new, enum kvm_mr_change change)
> +{
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D14
