Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FD315D46;
	Mon, 22 Jun 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145633; cv=none; b=JqlfyOSjQ2/PcsSR0T0C2Ue/xu8KEe20lL9ZvWHvD8WJ82Zi//FFhSQpQeKoPurzuh+PnE7Ip9WvvO1lcwcc/N6YGTeF4tcQ3+ZAk8LZ7M0PbBoB4c6pjGpzaLODdRCuCDEggmLVAht5u/0Q70vA67SDHTzDFEnbsMo2WX0UegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145633; c=relaxed/simple;
	bh=NB/C1rIeoBqmvHQXZxAOSOHF/uMtnI7x5ka+Fl3hNIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KwgU3LJp1WxKLzTCSEtvLaHbCgO9nywKs9aTYZJQPFAk7LtYL7x8KeCVqTupr4w4atHcCP92hd4p+nlt7kJLC8VMJ+90IdbA49MY3qZU03XJhV56VR1v81K72cYhvOyYZOjX6d+txcALsvorW8HlL1kTDqLx9z7ZdsCdv4CrP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It4EtNkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It4EtNkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20A21F00A3A;
	Mon, 22 Jun 2026 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145632;
	bh=+JUuUJMkXfrUA0trMcxnwY9JiAw1QKMdlKZH2ypBUtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=It4EtNkQKwTUcIZDxTD11OnMN2E1ILjzEXVVpfJD17yglPXs9zoQcGYeT4ULRt8wW
	 hsbRet7meu+yhKJunbjWJkgsYZ0opfxN/vShLTSxVlecS9p+o/8kyW3OudCooyXGj1
	 nSCLGxxtSzuF8FzGr7gwpsYB1UtKAA4CjGEKCvZmXE+UMs/i8ocXJC6iLiluARL1tG
	 LXfnIReT7sgnpMid4HYf5bBXGnTmbJcL+UyWem5WFuqLAOoJvFr6UH/oj3Lm19a1e2
	 iwYPXYEmQGh4KB4fkg6K8EF8njwtPUDy0ZqHd0+7Y0GUwXZncdVIuyBszpFDzMOQB7
	 qfaEfoxwkFFxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] KVM: s390: Fix cmma dirty tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260622160739.202044-8-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:27:11 +0000
Message-Id: <20260622162711.F20A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] A stalled VCPU thread in `handle_essa()` racing with `kvm_s390_vm_=
start_migration()` double-counts `cmma_dirty_pages`, causing an infinite lo=
op in userspace.

Pre-existing issues:
- [Critical] Uninitialized kernel memory from `vmalloc` is leaked to usersp=
ace via the CMMA state buffer.
- [High] CMMA state of newly mapped pages can be silently lost during the s=
tart of migration due to a TOCTOU race with `gmap_set_cmma_all_dirty` runni=
ng while `migration_mode =3D=3D 0`.
--

commit d55126b5a3d84f06909a4a559b0185411825d1f2
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix cmma dirty tracking

This commit updates migration mode initialization to accurately count pages
with allocated PTEs instead of counting all pages in memslots. It also fixes
dat_get_cmma() to wrap around when searching for cmma-dirty pages.

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

[Severity: Critical]
This is a pre-existing issue, but does the values buffer leak uninitialized
kernel memory to userspace?

In kvm_s390_get_cmma_bits(), the values buffer is allocated via vmalloc()
without zeroing:

arch/s390/kvm/kvm-s390.c:kvm_s390_get_cmma_bits() {
    ...
    values =3D vmalloc(args->count);
    if (!values)
        return -ENOMEM;
    ...
}

When dat_get_cmma() iterates over guest memory, __dat_get_cmma_pte() skips
unmapped holes and non-dirty pages (cmma_d =3D=3D 0). This leaves uninitial=
ized
gaps in the state->values array between the first and last dirty pages in t=
he
batch.

Since the entire array up to args->count is later copied to userspace via
copy_to_user(), could this expose sensitive heap data?

[ ... ]
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index e6e786811db86..a9a37fdeb809b 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1075,7 +1075,13 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *m=
c, struct gmap *sg, gfn_t p_gf
> =20
>  static long __set_cmma_dirty_pte(union pte *ptep, gfn_t gfn, gfn_t next,=
 struct dat_walk *walk)
>  {
> -	__atomic64_or(PGSTE_CMMA_D_BIT, &pgste_of(ptep)->val);
> +	union pgste pgste;
> +
> +	pgste =3D pgste_get_lock(ptep);
> +	pgste.cmma_d =3D 1;
> +	pgste_set_unlock(ptep, pgste);
> +	atomic64_inc(walk->priv);

[Severity: High]
Can this cause double-counting of cmma_dirty_pages if a VCPU thread in
handle_essa() races with kvm_s390_vm_start_migration()?

If a VCPU locklessly reads migration_mode =3D=3D 1 in handle_essa(), stalls=
, and
userspace stops then restarts migration:
kvm_s390_vm_start_migration() resets cmma_dirty_pages =3D 0 and starts
gmap_set_cmma_all_dirty().

The stalled VCPU thread could then resume, enter __do_essa(), set cmma_d =
=3D 1,
and increment cmma_dirty_pages. When __set_cmma_dirty_pte() reaches the same
page later, it lacks a check for !pgste.cmma_d, blindly setting cmma_d =3D 1
and incrementing cmma_dirty_pages again.

Would this over-counting cause userspace (like QEMU) to spin infinitely when
calling the KVM_GET_CMMA_BITS ioctl, as it decrements its remaining counter
expecting more pages than actually exist?

[ ... ]
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 93141a68e0dde..cdd8b41d24ed2 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
>  	/* mark all the pages as dirty */
> +	atomic64_set(&kvm->arch.cmma_dirty_pages, 0);
>  	gmap_set_cmma_all_dirty(kvm->arch.gmap);
> -	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
> -	kvm->arch.migration_mode =3D 1;
> +	WRITE_ONCE(kvm->arch.migration_mode, 1);

[Severity: High]
This isn't a bug introduced by this patch, but does kvm_s390_vm_start_migra=
tion()
have a race condition because gmap_set_cmma_all_dirty() runs entirely while
migration_mode =3D=3D 0?

During gmap_set_cmma_all_dirty(), if a VCPU faults in a new page at an addr=
ess
already scanned by the walker, the PTE is created with cmma_d =3D 0. Since
migration_mode is still 0, the VCPU can execute ESSA instructions which
hardware handles natively.

This would modify the CMMA state in the PGSTE but leave cmma_d =3D 0. When =
the
migration scan finishes and sets migration_mode =3D 1, does the newly dirti=
ed
page remain untracked, causing guest state corruption across live migration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D7
