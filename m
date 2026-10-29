Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280459;
	b=pOTkIURSbjh6mId3IVV4uw4a7iBO5yM20zUGuDuHxANf4qTfej+p491Nz1SBqfJ2D7Q5
	 ZRlryfEgnkucAVrlLT0x1G1DPB4lgrRX9ZFjlMavEFRw5PZwzzXsgYhOayU7P86KOOzzA
	 3MIyixE8GVZUsNaRwH1oNfvMjD3twBENi4J/9NQkGMcEt0ZvxUKkot5pxzAZHCAXO0Jx0
	 4thmuDkMNHlIGPM2BmZxLerh0b/JfOo3GU1uSGd8WUh+UrIHnuDuDT7OV46hM1/Lvj1bA
	 6cmPRO2eg/bKOUlWq3Lncdri4LgwgICJ7f4Cc8+Kqw4+8tCmFmNmy8ipbavJYlIHB3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vJRcnIPKWOwBREEH/wlD+9dd/OkW3UF4Ksvn8M7yNwM=;
	b=RIgeEkT3TcSfze8GkKSqyzLy3CDva8tDo4v1wuOU8G2ifl6K8Dc+QM4QxzUiByFdAmBI
	 i5U1QK3UF/a9rgtwpTeymXYgnfZNrs3/c/c8JefszMX2L/UU+AldUbz0iw0UDdzyenNLj
	 x57xjNZ/G015qDt/Lf8vLXltNuidwvx0mqHBSmQbKIU37V8GNLNsHsBAtjVlhqDOkuJf+
	 0VWj17sgHrPvJTPY8XLMPdboIBoUYNn7mBjvjR7S5VKVehh4f9BHz4QjiqwTXv5W1Hx92
	 dkCWLwiaeV0i3dAMkIFFvsvjpoI9DDhA52y7178hgS3v+4/hF5mCaA2M5qqBQLiJVIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+j5uNKj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15389606A31A;
	Thu, 29 Oct 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+j5uNKj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD721F01825;
	Thu, 29 Oct 2026 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793280458;
	bh=vJRcnIPKWOwBREEH/wlD+9dd/OkW3UF4Ksvn8M7yNwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+j5uNKjIV47O5NtKMUvNIDYGLFgCYLbSc/l4arH8nAsmrkFRS8TiWkyxEDAFvjXl
	 emdV9GM87efmaKQsdjvANYrewWMdOKsAHriw4WgQvd8B2MdG7+bmLTh/Xr6JIEJsaj
	 D17FBlk4JNEL4IsE1Wi0uvs2Z82R2kstlgxQ7Edt35lWsd9gLqMr3dhqO1t2xlxyHj
	 Dfik4OqvgFavXgf2LbeCqyaJ2mOY1BabY7EFnortK98oOmQbg8ONFZ6fO+3wFOvJSO
	 OG4jmMRkbY1EKjEOKDhj5soTsiByNQ95+x2JvIBPmQdi0a2AFMoCjYUgiqeljjViUg
	 PHTR2djejflFQ==
Message-ID: <sashiko-outbox-189375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] KVM: s390: Allocate page tables when CMMA is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-8-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:27:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM: s390: missing kvm->srcu lock in kvm_s390_set_cmma_bits()
- [High] KVM: s390: gmap_enable_cmm_already_locked() leaves hugepage flags =
enabled
- [Medium] KVM: s390: premature GMAP_FLAG_USES_CMM in gmap_enable_cmm_alrea=
dy_locked()
--

commit a6917c9210f677a52613d12ec2b02b039accdef5
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Allocate page tables when CMMA is used

This commit replaces direct GMAP_FLAG_USES_CMM bit setting in handle_essa()
and kvm_s390_set_cmma_bits() with calls to gmap_enable_cmm() and
gmap_enable_cmm_already_locked() so that all page tables are allocated and
existing large page mappings are split when CMMA is enabled.

> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index 856939acf012f..f7f49c2338b6f 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
> @@ -1241,14 +1241,14 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
>  		/*
>  		 * CMMA is enabled in the KVM settings, but is disabled in
> -		 * the SIE block and in the mm_context, and we are not doing
> -		 * a migration. Enable CMMA in the mm_context.
> -		 * Since we need to take a write lock to write to the context
> +		 * the SIE block and in the gmap, and we are not doing a
> +		 * migration. Enable CMMA in the gmap.
> +		 * Since we need to take a mutex to write to the gmap
>  		 * to avoid races with storage keys handling, we check if the
>  		 * value really needs to be written to; if the value is
>  		 * already correct, we do nothing and avoid the lock.
>  		 */
> -		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> +		gmap_enable_cmm(vcpu->arch.mc, vcpu->arch.gmap);

[Severity: Medium]
Can a second vCPU racing in handle_essa() observe GMAP_FLAG_USES_CMM before
gmap_enable_cmm_already_locked() finishes allocating page tables and splitt=
ing
large pages?

In arch/s390/kvm/gmap/gmap.h, gmap_enable_cmm() checks uses_cmm(gmap) before
taking slots_arch_lock:

    static inline void gmap_enable_cmm(struct kvm_s390_mmu_cache *mc, struc=
t gmap *gmap)
    {
        /* CMMA already enabled, nothing to do */
        if (uses_cmm(gmap))
            return;

        guard(mutex)(&gmap->kvm->slots_arch_lock);

        gmap_enable_cmm_already_locked(mc, gmap);
    }

However, in arch/s390/kvm/gmap/gmap.c, gmap_enable_cmm_already_locked() sets
GMAP_FLAG_USES_CMM at the very beginning, before iterating over the memslot=
s:

    if (uses_cmm(gmap))
        return;

    set_bit(GMAP_FLAG_USES_CMM, &gmap->flags);

    slots =3D kvm_memslots(gmap->kvm);
    ...
    kvm_for_each_memslot(ms, bkt, slots) {
        ...
    }

While the first vCPU is still walking memslots in
gmap_enable_cmm_already_locked(), another vCPU intercepting on ESSA will see
uses_cmm(gmap) as true in gmap_enable_cmm(), skip slots_arch_lock, set
ECB2_CMMA in its SIE control block, and retry ESSA in hardware against
segments whose page tables have not yet been allocated or split.

Should GMAP_FLAG_USES_CMM be set only after the memslot walk completes (with
store-release / load-acquire ordering against the lockless uses_cmm() check=
)?

[Severity: High]
Also in gmap_enable_cmm_already_locked(), what happens if
GMAP_FLAG_ALLOW_HPAGE_1M or GMAP_FLAG_ALLOW_HPAGE_2G is set on gmap->flags?

When gmap_enable_cmm_already_locked() runs, it sets GMAP_FLAG_USES_CMM and
walks existing memslots with DAT_WALK_ALLOC | DAT_WALK_SPLIT, but unlike
kvm_s390_pv_init_vm(), it does not clear GMAP_FLAG_ALLOW_HPAGE_1M or
GMAP_FLAG_ALLOW_HPAGE_2G, and gmap_1m_allowed() / gmap_2g_allowed() do not
check uses_cmm(gmap).

If a memslot is later created or moved, or if gmap_enable_cmm_already_locke=
d()
returns early when kvm_s390_mmu_cache_topup() fails, subsequent faults in
gmap_link() will still see gmap_1m_allowed() or gmap_2g_allowed() as true a=
nd
install 1M or 2G mappings without PGSTEs while CMMA is active:

    if (order >=3D get_order(_REGION3_SIZE) && gmap_2g_allowed(gmap, f, slo=
t))
        level =3D TABLE_TYPE_REGION3;
    else if (order >=3D get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f=
, slot))
        level =3D TABLE_TYPE_SEGMENT;

In addition, if GMAP_FLAG_ALLOW_HPAGE_2G remains set after a 2G PUD is split
into a segment table (either while mmu_lock is dropped between 1M iterations
or after an early -ENOMEM return from kvm_s390_mmu_cache_topup()), a fault =
on
an unvisited PMD will call _gmap_link() with level =3D=3D TABLE_TYPE_REGION=
3. In
dat_entry_walk():

    if (walk_level =3D=3D TABLE_TYPE_REGION3 &&
        continue_anyway && !entry.pud.h.fc && !entry.h.i) {
        walk_level =3D TABLE_TYPE_PAGE_TABLE;
        allocate =3D false;
    }

Because allocate and split are false at the segment level, dat_entry_walk()
will fail with -ENOENT or -EFBIG on an unallocated or unsplit PMD, causing
_gmap_link() to return -EAGAIN and kvm_s390_faultin_gfn() to loop.

Should gmap_enable_cmm_already_locked() clear GMAP_FLAG_ALLOW_HPAGE_1M and
GMAP_FLAG_ALLOW_HPAGE_2G (or should gmap_1m_allowed() and gmap_2g_allowed()
reject huge pages when uses_cmm(gmap) is true)?

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 18fb200f854a8..23be83c0c0d8f 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -2349,6 +2349,8 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>  	if (r)
>  		return -EFAULT;
> =20
> +	gmap_enable_cmm_already_locked(mc, kvm->arch.gmap);

[Severity: High]
Does calling gmap_enable_cmm_already_locked() from kvm_s390_set_cmma_bits()
violate the SRCU locking requirement for kvm_memslots()?

In kvm_arch_vm_ioctl(), the KVM_S390_SET_CMMA_BITS path only acquires
kvm->slots_arch_lock before calling kvm_s390_set_cmma_bits():

    case KVM_S390_SET_CMMA_BITS: {
        ...
        mutex_lock(&kvm->slots_arch_lock);
        r =3D kvm_s390_set_cmma_bits(kvm, &args);
        mutex_unlock(&kvm->slots_arch_lock);
        break;
    }

When uses_cmm(gmap) is false, gmap_enable_cmm_already_locked() calls
kvm_memslots(gmap->kvm) and iterates the memslots with kvm_for_each_memslot=
():

    slots =3D kvm_memslots(gmap->kvm);
    if (!slots || kvm_memslots_empty(slots))
        return;

    flags =3D DAT_WALK_ALLOC | DAT_WALK_SPLIT | (uses_skeys(gmap) ? DAT_WAL=
K_USES_SKEYS : 0);

    kvm_for_each_memslot(ms, bkt, slots) {

In include/linux/kvm_host.h, __kvm_memslots() requires either kvm->srcu or
kvm->slots_lock to be held:

    return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
            lockdep_is_held(&kvm->slots_lock) ||
            !refcount_read(&kvm->users_count));

Because neither kvm->srcu nor kvm->slots_lock is held on this ioctl path,
won't this trigger a suspicious RCU usage warning under CONFIG_PROVE_RCU (j=
ust
as kvm_s390_vm_set_migration() takes guard(srcu)(&kvm->srcu) outside
guard(mutex)(&kvm->slots_arch_lock) before calling
gmap_enable_cmm_already_locked())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D7
