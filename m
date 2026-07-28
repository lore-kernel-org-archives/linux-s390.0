Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73C3A59A8;
	Tue, 28 Jul 2026 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259375; cv=none; b=A+Xa4RweLM/DVTbsgYgxwYPWQ+8PEYTozvJy/XuE65iZxGk1PYVCgIeS1W26ZB46+s5ReWNMoI55Whpv3Hgrbk5N4PsTa0tZiODg8TXzqpXbJ8dQ6FgQ9o39DYG4teewJXYYiQQXcXQZ95ZwgXn3OVMsiv+HIiUv0sljR44p3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259375; c=relaxed/simple;
	bh=4Xu9kftZEyuQlgaeum0aj7MOHeFV4RrS6h+W2reT/5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h5w+P3VqFljdvvzOdVNCv1JUwFXPmppV613e+LhfLeZdWvEzhrqZ8KakyZw0XgcCJ3mIqolioGZsh4YOfOt+cqlE5bySpMZQ3UHjekOHPCmCcPVJyGE6gOug0fsVd6uACWMoO2F3m9TYWAv/bTLq+NWFZDAM+ej0QDrR7nkmHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzYF/yDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzYF/yDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0A71F000E9;
	Tue, 28 Jul 2026 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259374;
	bh=8bCrJAOOX7pPujFi/oSmmwAkziwQEWq3hj5wWf1YFc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzYF/yDkjZ3pPK4zB76ys5NNHTep9C7Za0jMCvSAVS/upYgjXIdqP9EQL7DMhYy2c
	 9GkFPUxDhNKA9DGHvjYpVaH+kDLPWVSWhF/NkhOPlVB9JQNZGW6MTTicWdEl13Cw1f
	 Y8chNK9JaRTpc5h1MZBuqTPoU9wGZTatTZUP/rNzNDXUcdlWRiAVRU3LpTZrwycuA+
	 TiKgg5YQc138IJORSaDd2mw/ae232bdvL19lK1kC+7q2lEJQ8weJjhx8yn6i0msH2A
	 rOYbyRUNhHj6GNj72Q/s3sANmy3+3eNHDSL+MKQwCyoVpCZidx+z30H3mpC7sh8Ffz
	 XPIxa0ofBaoRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/13] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-5-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:22:53 +0000
Message-Id: <20260728172253.AD0A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double-decrement of `cmma_dirty_pages` counter on `-ENOMEM` retry =
paths
- [Medium] Mixing goto-based error handling and split definition-initializa=
tion with scope-based cleanup helpers (`__free` and `guard`)
--

--- Patch [4]: [PATCH v4 04/13] KVM: s390: cmma: Fix dirty tracking when re=
moving memslot ---
commit 335967b9cb5dc29aafc1953486ce5288ed03df4d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot
   =20
This patch fixes cmma-dirty tracking by appropriately decrementing the
cmma-dirty counter when a memslot is removed. It also opportunistically
switches kvm_arch_commit_memory_region() to use __free() for the MMU
cache.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1952f592a80a1..5046de39d739e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5803,14 +5803,24 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>  	return 0;
>  }
> =20
> +static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, str=
uct dat_walk *walk)
> +{
> +	if (pgste_of(ptep)->cmma_d)
> +		atomic64_dec(walk->priv);
> +	return 0;
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

[Severity: Medium]
This isn't a bug, but does mixing goto-based error handling and split
definition-initialization with scope-based cleanup helpers go against the
cleanup subsystem guidelines?

In kvm_arch_commit_memory_region(), mc is initialized to NULL at the
function start. Later, the code continues to handle errors with a goto:

    mc =3D kvm_s390_new_mmu_cache();
    if (!mc)
        goto out;

Could the goto out; be replaced with a direct return to avoid mixing
cleanup patterns, and could the variable be declared at the point of
allocation?

>  	int rc =3D 0;
> =20
> +	guard(mutex)(&kvm->slots_arch_lock);
> +
>  	if (change =3D=3D KVM_MR_FLAGS_ONLY)
>  		return;
[ ... ]
> @@ -5821,6 +5831,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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

[Severity: High]
Can this result in a double-decrement of the cmma_dirty_pages counter?

Looking at kvm_arch_commit_memory_region(), this block executes inside a
retry loop:

    retry:
        scoped_guard(write_lock, &kvm->mmu_lock) {
            if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
                _dat_walk_gfn_range(..., &ops, ...);
            }
           =20
            switch (change) {
            case KVM_MR_DELETE:
                rc =3D dat_delete_slot(...);
                ...
        }
        if (rc =3D=3D -ENOMEM) {
            rc =3D kvm_s390_mmu_cache_topup(mc);
            if (!rc)
                goto retry;
        }

If dat_delete_slot() clears cmma_d on some PTEs and then fails with
-ENOMEM (e.g. running out of MMU cache while splitting a page table), we=20
top up the cache and jump back to the retry label. The pre-pass
_dat_walk_gfn_range() runs again, but cmma_d_count_pte() doesn't clear the
cmma_d bit on the unhandled PTEs during its traversal.

Would the second pass decrement the counter again for the PTEs that weren't
processed before the -ENOMEM failure, potentially causing the counter to
underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D4
