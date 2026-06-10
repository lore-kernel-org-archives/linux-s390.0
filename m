Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE36343889;
	Wed, 10 Jun 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111417; cv=none; b=Hg9c1wDxIc1tbsSZ48hVWI/E/Q8hTll2920G1TYPjkbPhP3eHNgNFFnQkgn+f5h+I0SEZpHV1V5FQkGj2J5yMKxRQqw3pTqOaPZpKzz6AwDzWFAfWEFKDi2IHfr45JlAQVfgmECi7rvs/lwXefJqYhe78UuwDe7cHbaj+X5HfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111417; c=relaxed/simple;
	bh=Zs+/eKHR1G+oSZqQzMRrp9/82WEPdGRVgXXv/Oe8FFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+ytQQnZ3dL8au8+Abr49kf/5HABHGKF/uA2BYLsr3PDrlGe+87AP8cy+kYdVuoH3aQbu9Ttusn1GP11j0fcrHAXXQnTk+Z210DR8EBD36V7NyD0Bxp2XE/KCA5ZHnelPWqd8OER28i6ZiZTZGmdGMSHOcnCP4lgdszvTKjjxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myEVfyWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myEVfyWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF171F00893;
	Wed, 10 Jun 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111415;
	bh=7ZAGKryEwvzrV+qPCmD0sNJ9Zooj1OIXWHwiSkPibXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myEVfyWbIgNXXBbf5fqK5BvVmgrK4ZMH1B5Qp+iBjRsoEtZreDMG8NAKrUYIWoq2n
	 lPBquOKoldwAC30ntYGgsJEkXxLkJMECPr8JLUOwl9PYZ//3lETewQv05sUnK5IK+T
	 US4Y9gpFwZiCkpyJ0aM0cCogeFv7x+i7bXnOZ7m+zFBSaEsKfGXV13kQWdMXU8CRgF
	 mXSedS8ZXD79LoJMquYuqkV1AEktBqeCNmMBan+XNPYhLfQ5OrnJqogR1ttBrw8ii3
	 UaAdc0McS/ccqp4taeMuTixe4+bBHMV0UJlMEi0zfPADDOjgl6tU2cjOgSLOxxGq++
	 HRjBggAHJzQUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Use mmu cache to allocate rmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260610165247.238366-6-imbrenda@linux.ibm.com>
References: <20260610165247.238366-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:10:14 +0000
Message-Id: <20260610171015.2AF171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite loop under memory pressure due to MMU cache depletion dur=
ing shadow fault retries.
--

commit 3403f763f43a4ac3038b79807dbaad26fc1a966a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Use mmu cache to allocate rmap

The patch modifies gmap_insert_rmap() to allocate rmaps using
kvm_s390_mmu_cache_alloc_rmap() rather than kzalloc_obj() with GFP_ATOMIC.
This aims to ensure forward progress by leveraging pre-allocated cache item=
s.

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 52d55ddea8d4f..1d289f8fa3b20 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1000,7 +1000,8 @@ int gmap_pv_destroy_range(struct gmap *gmap, gfn_t =
start, gfn_t end, bool interr
>  	return 0;
>  }
> =20
> -int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int leve=
l)
> +int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn=
_t p_gfn,
> +		     gfn_t r_gfn, int level)
>  {
>  	struct vsie_rmap *rmap __free(kvfree) =3D NULL;
>  	struct vsie_rmap *temp;
> @@ -1010,7 +1011,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, =
gfn_t r_gfn, int level)
>  	KVM_BUG_ON(!is_shadow(sg), sg->kvm);
>  	lockdep_assert_held(&sg->host_to_rmap_lock);
> =20
> -	rmap =3D kzalloc_obj(*rmap, GFP_ATOMIC);
> +	rmap =3D kvm_s390_mmu_cache_alloc_rmap(mc);

[Severity: High]
Does this code leak the pre-allocated cache items during retries?

If gmap_insert_rmap() finds a duplicate mapping, it returns 0 without retur=
ning
the allocated rmap to the MMU cache. Instead, the __free(kvfree) cleanup
attribute returns it to the generic slab allocator:

arch/s390/kvm/gmap.c:gmap_insert_rmap() {
	...
	rmap =3D kvm_s390_mmu_cache_alloc_rmap(mc);
	if (!rmap)
		return -ENOMEM;

	rmap->r_gfn =3D r_gfn;
	...
	if (slot) {
		rmap->next =3D radix_tree_deref_slot_protected(slot, &sg->host_to_rmap_lo=
ck);
		for (temp =3D rmap->next; temp; temp =3D temp->next) {
			if (temp->val =3D=3D rmap->val)
				return 0; // rmap freed via __free(kvfree)
	...
}

In the retry loop inside _gaccess_shadow_fault(), memory allocation failures
trigger a retry:

	do {
		radix_tree_preload(GFP_KERNEL);
		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
			rc =3D ___gaccess_shadow_fault(vcpu, sg, saddr, seq, walk);
		radix_tree_preload_end();
	} while (rc =3D=3D -ENOMEM);

The MMU cache is only topped up outside of this loop. Because the pre-alloc=
ated
cache items can be quickly depleted across partial retries and freed to the=
 slab
allocator rather than the cache, kvm_s390_mmu_cache_alloc_rmap() will fall =
back
to kzalloc_obj() with GFP_ATOMIC.

Under memory pressure, this atomic allocation will consistently fail, retur=
ning
-ENOMEM. Since the loop never yields, reclaims memory, or re-tops the cache,
could this create a deterministic infinite loop, leading to a soft lockup?

>  	if (!rmap)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165247.2383=
66-1-imbrenda@linux.ibm.com?part=3D5
