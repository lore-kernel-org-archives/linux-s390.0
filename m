Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC07E792
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486507; cv=none; b=q/trsqtKZRsQzhFQ8BXTJsIfwU4ckuXODvxV5Aj9dCe9FNri6qMTpySjARkthyPUrAdRAG57tqlrlBx+qk5O1ucyk2W7Jn2ScdebzYTSaascedJcrk5ql6p0GzSi9ZQ+L89yLlYLVTTZYmF85yBQ+Ilqpb9Dvglj0NSmN8yxpxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486507; c=relaxed/simple;
	bh=ufI+fVFl1wQNuAPFdjYTm0pvZ0OMw3mnJrsNATHnstw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PPu/ju0oKClf+nh63O5LpAe/ZX/MfP/3ap6pZ3gBZ2/LIM8JF1qGwg/Iw7y4BKo0mjos4Rb6Hm7yDaKEIHri9F7o+8v1+mN0ZGfeVq5sDud8/C0jDN/+5Y5b6wpDF0TzJqbzmBw6etbsSktmq5mOgC9ngcNr5HjFF+UBHUETrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbhLswEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbhLswEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670FA1F000E9;
	Sun, 23 Aug 2026 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787486505;
	bh=0uAo17WiwQxHn5eoB0DteNEhV18GnTtDo/miJGVbK3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BbhLswEhaUHPzbNLLDPcl7hDN7oQfUiPAVZvceZvronsK8sz6xKUd1MdMEqgk/WjE
	 dCmgoNKV01ffclf7y+VG9ja3n1MT+pDxbs1nYk6NyzrlXo6rLD1eyJthe5M6KMe38i
	 W2niz2M5OJANZra/3j7L+3Of0mRGHRocpwcP2VdHcLI69byGWPDSUSv2pSoLO6rpZj
	 aepjAAWf1YDKrcz8QXvZXRW+ruOPBTfbxxdJgWZ74dagYztCL1fgpPxIp2EEvizsft
	 Jsjwk66xXPuxNU6/PXk5yFZGjSls2xpzkUguXQcFnm46UhNcQANEwm0UrarFaYX/9p
	 1nIm1w0tBUAHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX
 cache allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-5-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
 <20260823-execmem-set-vm-perms-v0-2-v2-5-b013a37d84b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 12:01:44 +0000
Message-Id: <20260823120145.670FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling vfree() on a PMD-aligned sub-chunk frees the entire vm=
alloc allocation, causing a Use-After-Free for the remaining active portion=
s.
- [High] Ignored error return from mas_store_gfp() in execmem_cache_clean()=
 leaves dangling pointers in the free list.
- [High] Unchecked maple tree operations in execmem_cache_alloc_locked() ca=
use double allocations or memory leaks.
--

--- Patch [5]: [PATCH v2 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX =
cache allocations ---
commit f503523d30f2f6d683938f00baaaf0596b27fd33
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache allocations

This commit removes the custom wrappers for set_direct_map APIs in
execmem by utilizing VM_FLUSH_RESET_PERMS for vmalloc allocations. It
simplifies the handling of the ROX cache when allocating and freeing
PMD-aligned chunks.

> diff --git a/mm/execmem.c b/mm/execmem.c
> index 74a178a87e758..d35f1d0ea54a4 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c

[ ... ]

> @@ -169,9 +148,6 @@ static void execmem_cache_clean(struct work_struct *w=
ork)
> =20
>  		if (IS_ALIGNED(size, PMD_SIZE) &&
>  		    IS_ALIGNED(mas.index, PMD_SIZE)) {
> -			struct vm_struct *vm =3D find_vm_area(area);
> -
> -			execmem_set_direct_map_valid(vm, true);
>  			mas_store_gfp(&mas, NULL, GFP_KERNEL);
>  			vfree(area);

[Severity: High]
This isn't a bug introduced by this patch, but what happens if
mas_store_gfp() fails?

The return value of mas_store_gfp() is ignored right before calling
vfree(area). If the maple tree operation fails with -ENOMEM during
rebalancing, the free chunk remains in the tree while the memory is freed
via vfree().

Could this lead to a use-after-free if the allocator hands out the freed
memory to a new caller?

[Severity: Critical]
This is a pre-existing issue, but does calling vfree() on a PMD-aligned
sub-chunk here free the entire vmalloc allocation?

If a caller initially allocates a large region (e.g., 4MB) which is later
partially allocated by smaller requests, it can leave behind a free chunk
starting at a PMD-aligned index (like p + 2MB).

When execmem_cache_clean() runs, it sees that both the size and index are
PMD-aligned and calls vfree() on that sub-chunk. Since vfree() uses an
interval tree lookup to resolve inner pointers, it will find and free the
entire original 4MB vmap_area.

Could this leave the other 2MB of actively executing memory in a
use-after-free state?

>  		}

[ ... ]

> @@ -312,18 +288,15 @@ static void *execmem_cache_populate_alloc(struct ex=
ecmem_range *range, size_t si
>  	 */
>  	mutex_lock(mutex);
>  	err =3D execmem_cache_add_locked(p, alloc_size, GFP_KERNEL);
> -	if (err)
> -		goto err_reset_direct_map;
> -
> -	p =3D execmem_cache_alloc_locked(range, size);
> -
> +	if (!err)
> +		p =3D execmem_cache_alloc_locked(range, size);

[Severity: High]
This is a pre-existing issue, but does execmem_cache_alloc_locked() handle
maple tree operation failures correctly?

Inside execmem_cache_alloc_locked(), mas_store_gfp() is used to remove a
chunk from free_areas, but the return value is ignored. If it fails, the
memory is given to the caller but remains in free_areas, which seems like
it could cause a double allocation.

Furthermore, if the free area was split and re-inserting the remainder
fails:

mm/execmem.c:execmem_cache_alloc_locked() {
    ...
	mas_set_range(&mas_free, addr + size, last);
	err =3D mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
	if (err) {
		mas_store_gfp(&mas_busy, NULL, GFP_KERNEL);
		return NULL;
	}
    ...
}

The allocation is aborted and the entry is cleared from busy_areas, but the
original free chunk is not restored back into free_areas. Does this
permanently leak the entire chunk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-execmem-se=
t-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org?part=3D5
