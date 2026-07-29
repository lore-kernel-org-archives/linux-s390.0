Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CC38331B;
	Wed, 29 Jul 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346745; cv=none; b=mgWiplDHixjKdUFa05VGuxSzAGAaMitKgfaqiB22SkwSuoPeALiwLRhhzHLsZWo4uEBRrZVAnK+1/pJFfCk12cXXRwyozdGBztRDmo6IhZDz1t1qUUKcJp50lT0aAjGGd7zFHoKTDNph+I6XeA4GfHzeMGS1BCoA3p/A/6EPm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346745; c=relaxed/simple;
	bh=T9psTN51XnKSv0/MEwoXj5Pv7EP/vSBFnKeSALuz4s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l6X29mWADrxxQz5oIXg30c005HpgPhZaMrfjUrPMdqeTbWASrdDz2dOuMw9y2khzH0ec8TGM3dGQsz3q6+4exBDG+AdS+ArkyyEJSmaL/HWXn5s9OJrr/Y0y4tO+VYG6blltjzuGzXFx6NulCKWxrYRYCRx2R99l9KVI9sj9tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP9F8iII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP9F8iII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C971F000E9;
	Wed, 29 Jul 2026 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785346740;
	bh=ChT5zN6to+qddqezJYQP4Q3G9hXYJys3zqXheJUyhdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kP9F8iIIgBkVy4zuriUsZd0UB8pF3aj3aS9Oz0FbWuqZDkHbk7f+1qIIHD6kQ99QY
	 s8BqLi8feolVkt3p9KxrCT0nYGw0zIwU/0u9Ys3wdEYDyKNIWk8b3n3Au0+e8hZF18
	 7I1aBHJOsyRVVo+ItlsOPYrscGqYQSZvOzHbntUDRUsqUnF9iK4d1dhhptMtQyAfAD
	 j3/clvc3w4t7s/JixudCuDjarXLYJBQrYIUhjqfDyav5GvHcZVwmXK10cPxtKC2n86
	 1mqvCwC+SZRnbwfABtipr5o6xybeBim8D8NDjCRce62SK8pne1F7d1fqNHOxM/HeZ3
	 l5lD+2hOd8Qkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/13] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260729152938.782383-8-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:38:59 +0000
Message-Id: <20260729173859.A4C971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing `DAT_WALK_ANY` flag skips swapped-out pages, leaking the C=
MMA dirty counter.

Pre-existing issues:
- [High] Silent failure in `kvm_arch_commit_memory_region` leaves KVM memsl=
ots and s390 DAT tables out of sync.
--

--- Patch [7]: [PATCH v5 07/13] KVM: s390: cmma: Fix dirty tracking when re=
moving memslot ---
commit 209a02966d18973e5f9b2678eee5bc92d7952603
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot
   =20
When a memslot is removed, all ptes that mapped the slot are cleared or
even deallocated. If this happens while the system is in migration
mode, and if cmma-dirty pages are removed, the cmma-dirty counter will
not reflect reality.
   =20
Fix by appropriately decrementing the cmma-dirty counter when removing
a memslot.
   =20
Opportunistically improve kvm_arch_commit_memory_region() to use
__free() for the struct kvm_s390_mmu_cache.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index a72ffd515c866..2ae431030621e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -5804,14 +5804,30 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>  	return 0;
>  }
> =20
> +static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, str=
uct dat_walk *walk)

[ ... ]

>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				struct kvm_memory_slot *old,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)
>  {
> -	struct kvm_s390_mmu_cache *mc =3D NULL;
> +	const struct dat_walk_ops ops =3D { .pte_entry =3D cmma_d_count_pte, };
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) =3D NULL;

[Severity: High]
This is a pre-existing issue, but if kvm_s390_new_mmu_cache() fails to
allocate memory and returns NULL later in this function, doesn't it
silently skip updating the DAT tables?

Since kvm_arch_commit_memory_region() returns void, KVM assumes the changes
are applied infallibly. Could this leave KVM memslots and the s390 hardware
DAT tables fatally out of sync under host memory pressure?

>  	int rc =3D 0;
> =20
> +	guard(mutex)(&kvm->slots_arch_lock);
> +
>  	if (change =3D=3D KVM_MR_FLAGS_ONLY)
>  		return;
> =20
> @@ -5822,6 +5838,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	}
> =20
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
> +			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
> +					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
> +					    &kvm->arch.cmma_dirty_pages);
> +		}

[Severity: High]
Does this walk miss swapped-out pages by omitting the DAT_WALK_ANY flag?

If DAT_WALK_ANY is not passed to _dat_walk_gfn_range(), holes are skipped
and cmma_d_count_pte() is never called for swapped-out pages, leaking the
cmma_dirty_pages count.

However, the subsequent dat_delete_slot() will process those same holes and
wipe their dirty status.

Will this cause an infinite loop in userspace migration wait loops if the
dirty count never drops to zero?

> +
>  		switch (change) {
>  		case KVM_MR_DELETE:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D7
