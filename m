Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480892609EE;
	Tue, 23 Jun 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229831; cv=none; b=q/qECSvxfwKtH4maVU6bHWauLrretwXIIKu7ufbbLsUkwttk6axlSKp5sAUh4iMNFCaQBlyedb9plrGNpQxTrH2HHydv4U2rZEgFI2yS/wp8Tk3N6j+wc8Xt66se3DuZ22Ix6WAmoZ7VYWteaidbFPCdUL/TrEW0ij6c4Sixw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229831; c=relaxed/simple;
	bh=G/812yDKdvmXIJir7h0KuwGy9+sjbLWdpZen064kkS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tSu2MnUHj1A0FHck5x2tRsG/FVWRlPaGVJwd27WHAnEEdmuhtUWSLCLNCpJh+ivoKEiydbjixbq/+gbmn7iI1XaVH+ZnJS0WwTujb+t8sHeD+adCa0dUw9neoukfKxi9yEX1tKOGBjLeBLsO6ctEA+VY7V6UUNPLEX0CXvgPtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqZkQjj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqZkQjj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4821F000E9;
	Tue, 23 Jun 2026 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782229829;
	bh=vc0/9cYfvVTGZXx4FD3o8CYnGDU+MV1yLnEvlwW3kl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqZkQjj1wo87oBraw9PLcT5zF3es58+XBam32Go4X8asGP+JVT2rAnRzyQBG0o9fb
	 fD5K1DQuW0M1HZu/+zzomAg8czjU0bmPQd1DsrFBsnY6+AtuID95T8QHc7myI/iNmW
	 tAivE+JAlvs/XOjKGEOyr77JM0hJndHKgGblW8HXyIyjbdaWX9RLoMbvo9lPdI20Xl
	 huBKAGxfuR06NlJLPSc08ozFyGUPyzGvikWwVAEpM/YOUdNK3uF8Z3iInFluFw7+Zz
	 zGb08UFLZcrEjc9kIfDqGIJqwHo4KzXgyAzcNGqs72Kd3/hvWA3su09F6thbsvtc7j
	 qSyA9JKnQTPBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] KVM: s390: Fix cmma dirty tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260623153331.233784-8-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
 <20260623153331.233784-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:50:27 +0000
Message-Id: <20260623155028.CF4821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Race condition between kvm_s390_vm_stop_migration() and handle_ess=
a() causes cmma_dirty_pages undercounting and data loss.
- [Medium] Missing curly braces around the kvm->arch.use_cmma condition in =
kvm_s390_vm_stop_migration() causes an unconditional, highly expensive gues=
t page table walk.

Pre-existing issues:
- [High] Page table walk skips pages and silently overwrites return values =
in dat_crste_walk_range(), breaking dat_test_age_gfn() and dat_reset_skeys(=
).
- [High] Uninitialized vmalloc memory is copied to user space in kvm_s390_g=
et_cmma_bits(), leaking kernel memory.
- [High] The CMMA dirty tracking allows native hardware execution of ESSA i=
nstructions during the full memory walk, potentially causing dirty CMMA sta=
te to be missed during live migration.
--

commit 9bad94601846b4f7b13bcf1ade41fc1b47e4dedf
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix cmma dirty tracking

This commit modifies the CMMA dirty tracking to set the migration_mode flag
before marking all existing PGSTEs as cmma-dirty. It also attempts to clear
the cmma_d bit and reset the dirty page count when stopping migration, and
addresses a wrap-around case in dat_get_cmma() when searching for pages.

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

[Severity: High]
This is a pre-existing issue, but does dat_get_cmma() leave memory uninitia=
lized
when skipping clean pages?

Looking at kvm_s390_get_cmma_bits(), the values array is allocated using
vmalloc(args->count), which leaves the memory uninitialized. When
dat_get_cmma() writes the dirty states, it skips clean pages (cmma_d =3D=3D=
 0)
and unmapped holes without writing to those indices. Does the subsequent
copy_to_user() in kvm_s390_get_cmma_bits() then leak this uninitialized
kernel memory to user space?

[Severity: High]
This is also a pre-existing issue, but does the page table walk in
dat_crste_walk_range() silently overwrite return values?

When _dat_walk_gfn_range() calls dat_crste_walk_range(), the loop logic
places the if (rc) break; condition before the child walk is checked:

arch/s390/kvm/dat.c:dat_crste_walk_range() {
    ...
    the_op =3D walk->ops->crste_ops[crste.h.tt];
    if (the_op) {
        rc =3D the_op(walk->last, cur, next, walk);
        ...
    }
    if (rc)
        break;
    if (!crste.h.i && !crste.h.fc) {
        if (!is_pmd(crste))
            rc =3D dat_crste_walk_range(...);
        else if (walk->ops->pte_entry)
            rc =3D dat_pte_walk_range(...);
    }
}

When dat_pte_walk_range() returns a positive rc, the loop proceeds to the
next iteration. If the_op executes (for example, _dat_test_young_crste
returning 0), does it overwrite the previous positive rc, causing the loop
to fail to break and ignoring yield requests or young-page hits?

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fe0ae15e5ad07..91cf7a3c55c79 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1210,28 +1210,54 @@ static int kvm_s390_vm_start_migration(struct kvm=
 *kvm)
>  	kvm_for_each_memslot(ms, bkt, slots) {
>  		if (!ms->dirty_bitmap)
>  			return -EINVAL;
> -		ram_pages +=3D ms->npages;
>  	}
> -	/* mark all the pages as dirty */
> +	/*
> +	 * Set the flag and let KVM handle ESSA manually, potentially setting
> +	 * the cmma_d bit in some PGSTEs and increasing cmma_dirty_pages.
> +	 * At this point cmma_dirty_pages is still 0, and all existing PGSTEs
> +	 * have their cmma_d bit set to 0.
> +	 * Any newly allocated page table has its entries marked as cmma-clean,
> +	 * which is fine because the CMMA values are not dirty.
> +	 */
> +	WRITE_ONCE(kvm->arch.migration_mode, 1);
> +	/*
> +	 * Mark all PGSTEs as cmma-dirty, increasing cmma_dirty_pages as needed,
> +	 * but without double-counting pages that have become dirty on their own
> +	 * in the meantime.
> +	 * At this point some pages might have become dirty on their own already
> +	 * and cmma_dirty_pages might therefore be non-zero.
> +	 */
>  	gmap_set_cmma_all_dirty(kvm->arch.gmap);
> -	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
> -	kvm->arch.migration_mode =3D 1;
>  	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);

[Severity: High]
This is a pre-existing issue, but does this sequence allow native hardware
execution of ESSA instructions during the full memory walk?

Since the KVM_REQ_START_MIGRATION broadcast (which clears ECB2_CMMA to
disable hardware ESSA execution) is issued after gmap_set_cmma_all_dirty()
completes, a vCPU could execute ESSA natively on a newly allocated page
that lies behind the current walk pointer. Since newly allocated PGSTEs
start with cmma_d =3D 0 and the walk has already passed them, could this
cause dirty CMMA state to be missed during live migration?

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

[Severity: Medium]
Are curly braces missing around the kvm->arch.use_cmma condition?

Because they are absent, gmap_set_cmma_all_clean() and atomic64_set()
execute unconditionally. For VMs where use_cmma is false, this seems to for=
ce
an unnecessary full walk of the entire guest page table under mmu_lock to
clear bits that were never set, which could stall the host and VM.

[Severity: High]
Can a race condition between kvm_s390_vm_stop_migration() and handle_essa()
cause cmma_dirty_pages to undercount?

If handle_essa() reads migration_mode locklessly and enters __do_essa()
concurrently with kvm_s390_vm_stop_migration():

CPU1 (kvm_s390_vm_stop_migration):
    gmap_set_cmma_all_clean(kvm->arch.gmap);

CPU2 (handle_essa -> __do_essa):
    Sets cmma_d =3D 1 on a PTE that CPU1 already cleaned
    atomic64_inc(&kvm->arch.cmma_dirty_pages);

CPU1 (kvm_s390_vm_stop_migration):
    atomic64_set(&kvm->arch.cmma_dirty_pages, 0);

Would this unconditional reset to 0 overwrite CPU2's increment, leaving a
PTE with cmma_d =3D=3D 1 but cmma_dirty_pages =3D=3D 0, leading to prematur=
e stops
in dat_get_cmma() and data loss during the next migration?

> +	/*
> +	 * At this point the system has the expected state: migration_mode is 0,
> +	 * cmma_dirty_pages is 0, and all existing PGSTEs have their cmma_d bit
> +	 * set to 0.
> +	 */
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623153331.2337=
84-1-imbrenda@linux.ibm.com?part=3D7
