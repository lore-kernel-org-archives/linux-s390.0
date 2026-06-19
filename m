Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE602D5408;
	Fri, 19 Jun 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885344; cv=none; b=UPhDEYdEyvRxXcI/sP3h3nAdUjSlfBhOHBZFYXPEaukSaa6fUyGNUipCYxrojbpdvDkUNIa3KgSQEy9yW1WDXW/eZ57tpm5Rr2y67fFA6554VtpKQQBqx4WWy+wvAlYSzhuDafcA4t9rQWyoauJbxIb2MEK78YmaLD/iHJa0B9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885344; c=relaxed/simple;
	bh=sl+FDzeatLjYpy9So+USFb/AyemfnvBp/ka+IoYwY4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AFzs128OKYKiba8fJNAaHzhW/bOaqoxZ3MI30Ic3BSJD6yYxP89KsFiqyrpJ+zj5r0xdGRvpMaNwI/7HZyXDB6QG12fSi97pP75Ngh0vANxRMNuKrbsl8q/8ShwtfTnDlRh3srs3TUBc+IJ/3wMUjSwl/yCD9e/+w4pbxXWTAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeDWeEFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeDWeEFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681931F000E9;
	Fri, 19 Jun 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885342;
	bh=fgxm1jPcGnTkHP020R5hNsLkAD/POh03wHSJ/D9uPbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BeDWeEFGYIJyRafUocfY3UD4p07+8FrlPh1sCyDKn9UcS0NvP26Xh4Ua42Yj2UDjO
	 EgfWyeLPZn1TbBP9aus5pRQYMQpOAh+l2tfs9ncvZICiWl482UUJcbARlyOMQR95w7
	 OtTJ0lxmF/0ArShg0kTPh04hk/l92xIfDpXvd7gnp+SIs6VAocpzNSFUr3GVWkBcGP
	 3/LBMMMGXXp5MSg9x45WGXOZJnfMAw3A3s8OqOr/gRBjB4epfLTOsRLs3m9EosdF4m
	 +VkUiXwR2XFna/AfMRjCkfuG/QZce8+tuhQZFxrgW4OfeC9TyEQLqIcgjsppdkvOrT
	 atwaHJ9YxRnaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] KVM: s390: cmma: Fix cmma dirty tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260619155154.307572-7-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
 <20260619155154.307572-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 16:09:02 +0000
Message-Id: <20260619160902.681931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `cmma_dirty_pages` counter permanently leaks and becomes artif=
icially inflated across VM CMMA resets or memslot removals, leading to an i=
nfinite polling loop in userspace during the final migration phase.

Pre-existing issues:
- [High] `kvm_s390_get_cmma_bits` leaks uninitialized kernel memory to user=
space because the `values` buffer is allocated with `vmalloc` and gaps corr=
esponding to non-dirty pages are never initialized.
--

commit ae0c1471cfdb2824a403c917222645798560f3c1
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix cmma dirty tracking
   =20
It is possible that some guest memory areas have not been touched yet
when starting migration mode, and thus have no ptes allocated. Only
existing and allocated ptes should count toward the total of dirty cmma
entries.

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
This is a pre-existing issue, but does kvm_s390_get_cmma_bits() leak
uninitialized kernel memory to userspace?

In kvm_s390_get_cmma_bits(), the values array is allocated using vmalloc()
which does not clear the memory:

kvm_s390_get_cmma_bits() {
    ...
    values =3D vmalloc(args->count);
    if (!values)
        return -ENOMEM;
    ...
}

When dat_get_cmma() populates this array via __dat_get_cmma_pte(), it itera=
tes
over the guest's page tables and only writes to indices corresponding to pa=
ges
where cmma_d =3D=3D 1.

For pages where cmma_d =3D=3D 0, the callback simply returns and skips them,
leaving those intermediate array indices untouched:

arch/s390/kvm/dat.c:__dat_get_cmma_pte() {
    ...
    if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
        return 0;
    ...
}

The total count returned is calculated as state.end - state.start,
encompassing the entire span from the first to the last dirty page found,
including the skipped uninitialized gaps.

This array is then copied to userspace via copy_to_user(), leaking
uninitialized kernel memory.

> +	/* If no dirty pages were found, wrap around and continue searching */
> +	if (*start && state.start =3D=3D -1)
> +		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);
> =20
>  	if (state.start =3D=3D -1) {
>  		*count =3D 0;

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ffb20a64d328f..907d2ca9951da 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1191,7 +1191,6 @@ static int kvm_s390_vm_start_migration(struct kvm *=
kvm)
>  {
>  	struct kvm_memory_slot *ms;
>  	struct kvm_memslots *slots;
> -	unsigned long ram_pages =3D 0;
>  	int bkt;
> =20
>  	/* migration mode already enabled */
> @@ -1208,12 +1207,10 @@ static int kvm_s390_vm_start_migration(struct kvm=
 *kvm)
>  	kvm_for_each_memslot(ms, bkt, slots) {
>  		if (!ms->dirty_bitmap)
>  			return -EINVAL;
> -		ram_pages +=3D ms->npages;
>  	}
> +	kvm->arch.migration_mode =3D 1;
>  	/* mark all the pages as dirty */
>  	gmap_set_cmma_all_dirty(kvm->arch.gmap);
> -	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);

[Severity: High]
Does removing this reset of cmma_dirty_pages cause the counter to permanent=
ly
leak and become artificially inflated?

The cmma_dirty_pages counter tracks the number of pages with the cmma_d bit
set.

However, when CMMA states are cleared (e.g., via the KVM_S390_VM_MEM_CLR_CM=
MA
ioctl) or when memory is unmapped, the cmma_d bits are cleared but the
cmma_dirty_pages counter is never decremented:

arch/s390/kvm/dat.c:dat_reset_cmma_pte() {
    ...
    pgste.cmma_d =3D 0;
    ...
}

When migration is started again, __set_cmma_dirty_pte() unconditionally
increments cmma_dirty_pages for every page that has its cmma_d bit flipped
from 0 to 1, compounding the leaked counter:

arch/s390/kvm/gmap.c:__set_cmma_dirty_pte() {
    ...
    if (!pgste.cmma_d) {
        pgste.cmma_d =3D 1;
        atomic64_inc(walk->priv);
    }
    ...
}

During migration, KVM reports this artificially inflated counter to userspa=
ce
via args->remaining.

Once QEMU successfully retrieves all actual dirty pages, KVM will return
count =3D=3D 0 but remaining > 0 (due to the leak). Could this trap QEMU in=
 an
infinite migration polling loop waiting for pages that do not exist?

> -	kvm->arch.migration_mode =3D 1;
>  	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619155154.3075=
72-1-imbrenda@linux.ibm.com?part=3D6
