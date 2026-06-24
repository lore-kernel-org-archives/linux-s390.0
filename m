Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA02276028;
	Wed, 24 Jun 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301603; cv=none; b=VttboS8hKce+fKoW8vNIfGrmk5EuQVSSqf9TZkyCyiZIwEI1uxyYJ79ctHKWjjqwHPEhd6DVMTDnDKDmd8CSzw/6o2n8Kpj79OqC2sUsCl9xmAow5U6hyg/V+IAvhiGmd/ss8KKjExWwKqpCI9yjayP2TZd+dqphvet2fnvFJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301603; c=relaxed/simple;
	bh=qB9PnJVkGw6eEA78IDRJwJwnOI6FPp/ukh1lSysauGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fTwJ3MnWwDrISzJtf0uo7coPV//JboTGu+h44Y/Q/Gp6UCss6EERo2XaZrj0freSniX8hbyyHQSWY0CFxQ6AQdsEmwXKWxk8S3XS6oXSAOUml2J5Znzb6DwIqySFxqo1TZxJ9zZkoP3fzc3pCasrZOwx9TXXSKssh8Y7SCzoJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXX+Og4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXX+Og4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EBF1F000E9;
	Wed, 24 Jun 2026 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301601;
	bh=ZWalexuGIlzEP798rVE7Iuws0w42f5Xncge/3f5W4fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXX+Og4sUo9HXV8sJeBmmf+hIT/aLRGvVuEtCefv0XMPP3ia8UWuiMThRERcZMtY2
	 NKdxTBC/Nt9guO6HQ9Trm79lNeEplvJpnT5DtJSUN1fFXfmdZq0i1ojVwyNeQ6uL4g
	 d6veqAj8Pnxc9cBmGz7iLsrb/TSU9fn508af7yPRNJ0lS++3tkaHasWxI5g7EMrrX6
	 JFx9ZiPt9N/etP8mixMbebCzP1VcFVcJ/r6A4xG76baOn8nbLwusDNPbXdKcup6Kmj
	 beLSLMY7mOXYNtedW3YnQd1LOCNjzpGB9G74Yyd7w7ZGuhlLegtKXy5U6aLfEz6Fq2
	 3qOZHO/pCYORg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 10/12] KVM: s390: Fix cmma dirty tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260624111928.144283-11-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
 <20260624111928.144283-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:46:40 +0000
Message-Id: <20260624114640.C7EBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Race between `kvm_s390_vm_stop_migration()` and `handle_essa()` ca=
uses permanent corruption of the `cmma_dirty_pages` counter.
- [High] Unbounded guest address space scan in `dat_get_cmma()` while holdi=
ng the `mmu_lock` read lock causes soft lockups.
- [High] The `cmma_dirty_pages` counter is not decremented when PGSTEs are =
zapped, leading to a permanent counter leak.

Pre-existing issues:
- [High] Decoupled locking in `__do_essa()` causes `cmma_dirty_pages` to te=
mporarily underflow, exposing a massive `remaining` value to userspace.
- [High] `KVM_S390_GET_CMMA_BITS` leaks uninitialized kernel heap memory to=
 userspace due to unpopulated array elements.
--

commit f98e5de8f917aa1f013fc20f1b092133a210644d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix cmma dirty tracking

It is possible that some guest memory areas have not been touched yet
when starting migration mode, and thus have no ptes allocated. Only
existing and allocated ptes should count toward the total of dirty cmma
entries.

[ ... ]

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index cffac7782c4bf..0ad4ebc80ebaf 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -1253,6 +1253,9 @@ int dat_get_cmma(union asce asce, gfn_t *start, uns=
igned int *count, u8 *values,
>  	};
> =20
>  	_dat_walk_gfn_range(*start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HO=
LES, &state);
> +	/* If no dirty pages were found, wrap around and continue searching */
> +	if (*start && state.start =3D=3D -1)
> +		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);

[Severity: High]
Can this wrap-around scan trigger a host soft lockup?

Since both the initial and wrap-around scans execute entirely under the
mmu_lock read lock, preemption is disabled. If a guest has a massive
memory address space that is fully populated but contains no dirty CMMA
pages, dat_get_cmma could iterate over millions of page table entries in
a tight loop without ever checking need_resched or yielding.

[Severity: High]
This is a pre-existing issue, but does dat_get_cmma leak uninitialized
kernel heap memory to userspace here?

When KVM_S390_GET_CMMA_BITS is invoked, the values array is allocated using
vmalloc without zero-initialization. If dat_get_cmma encounters clean pages
or unpopulated holes interleaved with dirty pages, __dat_get_cmma_pte skips
those array indices. The subsequent copy_to_user in kvm_s390_get_cmma_bits
then copies the entire contiguous array back to userspace, taking those
uninitialized vmalloc bytes with it.

>  	if (state.start =3D=3D -1) {
>  		*count =3D 0;

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 221b2fb199d4e..9ad6bd4edbce3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -1210,28 +1210,54 @@ static int kvm_s390_vm_start_migration(struct kvm=
 *kvm)
>  	kvm_for_each_memslot(ms, bkt, slots) {
>  		if (!ms->dirty_bitmap)
>  			return -EINVAL;
> -		ram_pages +=3D ms->npages;
>  	}
> -	/* mark all the pages as dirty */
> -	gmap_set_cmma_all_dirty(kvm->arch.gmap);
> -	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
> -	kvm->arch.migration_mode =3D 1;
> +	/*
> +	 * Set the flag and let KVM handle ESSA manually, potentially setting
> +	 * the cmma_d bit in some PGSTEs and increasing cmma_dirty_pages.
> +	 * At this point cmma_dirty_pages is still 0, and all existing PGSTEs
> +	 * have their cmma_d bit set to 0.
> +	 * Any newly allocated page table has its entries marked as cmma-clean,
> +	 * which is fine because the CMMA values are not dirty.
> +	 */
> +	WRITE_ONCE(kvm->arch.migration_mode, 1);
>  	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
> +	/*
> +	 * Mark all PGSTEs as cmma-dirty, increasing cmma_dirty_pages as needed,
> +	 * but without double-counting pages that have become dirty on their own
> +	 * in the meantime.
> +	 * At this point some pages might have become dirty on their own already
> +	 * and cmma_dirty_pages might therefore be non-zero.
> +	 */
> +	gmap_set_cmma_all_dirty(kvm->arch.gmap);

[Severity: High]
Could this lead to a permanent leak in the cmma_dirty_pages counter?

This establishes an invariant that the cmma_dirty_pages counter mirrors the
global number of PGSTEs with the cmma_d bit set. However, if host userspace
unmaps memory or deletes a memslot while migration mode is active,
dat_free_pt destroys the page tables and associated PGSTEs without
decrementing cmma_dirty_pages. This leaves the counter artificially inflate=
d,
potentially trapping the VMM in an infinite migration loop.

>  	return 0;
>  }
> =20
>  /*
> - * Must be called with kvm->slots_lock to avoid races with ourselves and
> - * kvm_s390_vm_start_migration.
> + * Must be called with kvm->slots_lock to avoid races with ourselves,
> + * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
>   */
>  static int kvm_s390_vm_stop_migration(struct kvm *kvm)
>  {
>  	/* migration mode already disabled */
>  	if (!kvm->arch.migration_mode)
>  		return 0;
> -	kvm->arch.migration_mode =3D 0;
> +	/*
> +	 * Unset the flag and propagate to all vCPUs. From now on the cmma_d
> +	 * bit will not be touched on any PGSTE.
> +	 * At this point cmma_dirty_pages is possibly non-zero, and thus some
> +	 * PGSTEs might have cmma_d set.
> +	 */
> +	WRITE_ONCE(kvm->arch.migration_mode, 0);
>  	if (kvm->arch.use_cmma)
>  		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
> +	/* Clear cmma_d on all existing PGSTEs and set cmma_dirty_pages to 0. */
> +	gmap_set_cmma_all_clean(kvm->arch.gmap);
> +	atomic64_set(&kvm->arch.cmma_dirty_pages, 0);

[Severity: High]
Is there a race condition here with concurrent ESSA instructions?

kvm_s390_sync_request_broadcast does not wait for vCPUs currently executing
host code. If a vCPU executing handle_essa reads migration_mode as 1, it
will proceed to __do_essa. Because gmap_set_cmma_all_clean and __do_essa
can overlap, the stop-migration thread might clear cmma_dirty_pages to 0
right before __do_essa calls atomic64_inc. This would leave the counter at
1 with no actual dirty PGSTEs, breaking migration invariants.

> +	/*
> +	 * At this point the system has the expected state: migration_mode is 0,
> +	 * cmma_dirty_pages is 0, and all existing PGSTEs have their cmma_d bit
> +	 * set to 0.
> +	 */
>  	return 0;
>  }

[ ... ]

> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9bc6fd02ff777..ad0ddc433a73c 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -1236,7 +1236,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  						: ESSA_SET_STABLE_IF_RESIDENT))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> =20
> -	if (!vcpu->kvm->arch.migration_mode) {
> +	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {

[Severity: High]
This is a pre-existing issue, but does the decoupling of the PGSTE lock
and the global counter increment in __do_essa open a race window?

In __do_essa, dat_perform_essa sets the cmma_d bit under the PGSTE lock,
but the global cmma_dirty_pages counter is incremented outside of that
critical section. Concurrently, dat_get_cmma could acquire the same PGSTE
lock, see the bit set, clear it, and decrement cmma_dirty_pages before
__do_essa has incremented it. If the counter starts at 0, it temporarily
underflows to -1. If kvm_s390_get_cmma_bits reads it at that moment, it
exposes ULLONG_MAX to userspace as the remaining count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624111928.1442=
83-1-imbrenda@linux.ibm.com?part=3D10
