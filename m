Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924C38DC65;
	Thu, 30 Jul 2026 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430085; cv=none; b=dOSf7cdo6gXgt4w0GY/pX2y2wU4SIW/KVxHos2HvKaPaky4UEyxvgTTj6+NzpWXUUoDJKg1RLELUIoIKZ9TGwHjkXJeQlzCXxcEUwhkR5MzYK4TVDBdFV21YBrMNexg7GadOQc+fLT71xKoMczFLuXahvnc34Ll5UqZb8vQ2Jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430085; c=relaxed/simple;
	bh=1B7uqwnKXc9Ua6SFK80ZQFC4S3xMSYlpXUCP+HcbYa0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RmAj9BECJ4RNkVBQquQ7f7hzjdOyJqeR107wUDW7RWnl8M2eCvHOjVs6hu0Y1guddzAYNXCoXtbG4DwnYEbuyauTAk3oaKDk9VOZ92drNcVMzzmF75QebgIWydzJFtrehUdCvqtQtQuXBMhMg+u6bF10gQXjArPO2rmldCf6odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaViEJzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaViEJzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC81F000E9;
	Thu, 30 Jul 2026 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430083;
	bh=4H9bEOpXTcJkadGRWWZWzgTd2Bp48F7LNKtcJrTM2wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaViEJzuKJ92v7rK8twbhUM+I0EzXiayASOmrPkDwwIOyOOZjWW3/oURBrM+L6aJ1
	 y8AhYQO/oRzRfRNRhn/ncBh1fqSRtGXyWw/Rvct7dZ8qUYLnk7SR4d7hSTd6JSWYdx
	 cH8qpPfwgJHr4lqpRwzXkh5SJGBvip0gfE8h6zI/Lr6LnxoYWaaeOHR+m9KrILs/dY
	 to/ZPP2CnKD3yEvTatf4XKB4ke+BRYQykOyKz2BHvo14LWBJV8k8i/vzZ3uMKSsylW
	 uPvqa5OxuuvHwatmwF+oKjlcoP6pIHdKCBPqsUzynN3YUCnJuWzF+sNz3Amy/MLa9d
	 kudvUWf7Fms0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/14] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730162714.133327-8-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:48:03 +0000
Message-Id: <20260730164803.8FEC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Mixing goto-based error handling with scope-based cleanup (__fre=
e and guard) in the same function.

Pre-existing issues:
- [Critical] Silent ENOMEM failures in commit_memory_region leave stale gue=
st page tables, causing host Use-After-Free.
- [High] KVM_MR_MOVE operations can exhaust the MMU cache (`mc`), leading t=
o silent memslot corruption.
--

--- Patch [7]: [PATCH v6 07/14] KVM: s390: cmma: Fix dirty tracking when re=
moving memslot ---
commit fbfd75bf3afca84e6e947282c2cd405f559d2839
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot

This patch updates memslot removal to appropriately decrement the
cmma-dirty counter to keep it accurate when the system is in migration
mode. It also updates kvm_arch_commit_memory_region() to use __free()
for the struct kvm_s390_mmu_cache.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 24c3bfcd5db26..c1984fe2f9a40 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5809,14 +5809,30 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>  	return 0;
>  }
> =20
> +static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, str=
uct dat_walk *walk)
> +{
[ ... ]
> +}
> +
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				struct kvm_memory_slot *old,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)
>  {
> -	struct kvm_s390_mmu_cache *mc =3D NULL;
> +	const struct dat_walk_ops ops =3D { .pte_entry =3D cmma_d_count_pte, };
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) =3D NULL;
>  	int rc =3D 0;
> =20
> +	guard(mutex)(&kvm->slots_arch_lock);
> +

[Severity: Medium]
Does this mix scope-based cleanup with goto-based error handling?

The patch adds __free() and guard() here, but kvm_arch_commit_memory_region=
()
still retains legacy goto-based error handling shortly after this:

	mc =3D kvm_s390_new_mmu_cache();
	if (!mc) {
		rc =3D -ENOMEM;
		goto out;
	}

The cleanup guidelines in include/linux/cleanup.h state that a function
must use scope-based cleanup entirely or not at all, to prevent subtle
resource leaks when cleanup order (LIFO) is misunderstood.


[Severity: Critical]
This is a pre-existing issue, but can this silent ENOMEM failure leave stale
guest page tables?

If kvm_s390_new_mmu_cache() fails in the snippet above, the deletion of
guest page tables is skipped.

Since KVM's generic memslot management removes the memslot and allows host
userspace to unmap the backing memory, the guest's hardware page tables
(gmap) would retain valid PTE mappings to those physical pages, potentially
leading to a host use-after-free.

>  	if (change =3D=3D KVM_MR_FLAGS_ONLY)
>  		return;
> =20
> @@ -5827,6 +5843,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	}
> =20
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
> +			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
> +					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
> +					    &kvm->arch.cmma_dirty_pages);
> +		}
> +
>  		switch (change) {
>  		case KVM_MR_DELETE:
>  			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);
> @@ -5848,7 +5870,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  out:
>  	if (rc)
>  		pr_warn("failed to commit memory region\n");
> -	kvm_s390_free_mmu_cache(mc);
>  	return;
>  }

[Severity: High]
This is a pre-existing issue, but can a KVM_MR_MOVE operation exhaust the
MMU cache?

Looking at the KVM_MR_MOVE case in kvm_arch_commit_memory_region():

		case KVM_MR_MOVE:
			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npa=
ges);
			if (rc)
				break;
			fallthrough;
		case KVM_MR_CREATE:
			rc =3D dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->npa=
ges);

dat_delete_slot() and dat_create_slot() are called sequentially without
replenishing the MMU cache (mc) in between.

If both operations require splitting large pages, the cache could be
exhausted, and dat_create_slot() might fail with -ENOMEM. The generic KVM
code would assume the move succeeded, but the new guest page tables would be
unmapped, leading to a guest crash on access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D7
