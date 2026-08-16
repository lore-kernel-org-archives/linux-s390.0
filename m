Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E332F8EBB
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786879048; cv=none; b=AxF9p88/KvC7krZDsCJP90U5BDi4sIeWVTVZ5BV3cFCWf6NdPjuaHtUy1rYXFzaTkc6euA6ksqrTeD6N6Gk/8ove3K+o+w/0lZrmR+YzaaAT30cDZHfupkfQSSGOjGxqbKxKf/WFvoNTPAtNzDp5Mm44HAIV3ve70gO4n9nfX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786879048; c=relaxed/simple;
	bh=L+lxN5ljZneTkZXpLbyNs1Ubc8DrqkoWeZ+PgK6piGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccH+qS46WlElUeLpCirS+a3nDqnW6IyZxWl8GTyFsx2mXZmuWWRlZcW8bve4g4pVLChYHrZRnzFd2xBOU/pn0d4PK+mXDfvG+mPJGrJfLpEejJ6JTJtHPnmGlQTE2gRtD5Q/L/4eDB0YJxVAUyvt31UdqfPuC6AcjaVRJ1ABdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj7yiLP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj7yiLP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6521F00A3D;
	Sun, 16 Aug 2026 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786879047;
	bh=ekLP6SHg/sipS4qjb40eZLmnIN0YCzCAnyVmSeUHfc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jj7yiLP7xwg5ziySv/SjjPmngLAqxaJFdkSVavL62CvJu79GguAcj98SxEJ2EBGdp
	 UxKd79YTl7e0PKLWdJsnLvmiV019YsH1XKOMiD+8ulMsiRNwaXBMGIEbs4SzqAvyIU
	 8q8eH7w65Gw5wPvhebnw7uxf+vLv/pPT63e6rHGSLX8trHqWCCrIyh3IH7itH+16rL
	 65olS+eq1wqwQP16WUKnCAg/uDZRHQ/ss+6rp93INBDKXPHxCkUk/LfZO/Ueok+VJz
	 0I+gKddw960PzowIesbfDvIaZKu50D8jbxyCy7xlo1nLKIy2Enqiwxwl37WdRW831M
	 vbZfQjObHEFaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-5-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-5-90944a3ad43f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:17:26 +0000
Message-Id: <20260816111727.0A6521F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] execmem_cache_clean() calls vfree() on partial or interior chu=
nks of a larger vmalloc allocation, causing a use-after-free for actively u=
sed regions.
- [High] Unchecked return value of mas_store_gfp() during maple tree deleti=
on can leave a dangling pointer in the free tree if deletion fails.
- [Medium] Cache memory may never be freed because execmem_vmalloc() does n=
ot guarantee PMD_SIZE alignment on all architectures, preventing execmem_ca=
che_clean() from matching its alignment checks.
--

--- Patch [5]: [PATCH 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cac=
he allocations ---
commit 32d82345ceeccc2881319ef4ff8f3be90e5de6df
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache allocations
   =20
Initially execmem removed direct map aliases for ROX cache allocations and
restored them manually. This patch leverages vmalloc's VM_FLUSH_RESET_PERMS
to handle these updates without splitting the direct map for PMD_SIZE chunk=
s,
removing the need for custom set_direct_map wrappers.

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
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
This is a pre-existing issue, but does this strict alignment check prevent
unaligned vmalloc allocations from ever being cleaned up?

execmem_cache_populate_alloc() rounds the allocation size up to PMD_SIZE,
but calls execmem_vmalloc() with vm_flags |=3D VM_ALLOW_HUGE_VMAP. If the
architecture does not support arch_vmap_pmd_supported(PAGE_KERNEL),
__vmalloc_node_range() falls back to PAGE_SIZE alignment.

If the returned base address is not PMD_SIZE aligned, the free block's
index will never be PMD-aligned, potentially permanently leaking the cache
block even when it is completely empty.

> -			struct vm_struct *vm =3D find_vm_area(area);
> -
> -			execmem_set_direct_map_valid(vm, true);
>  			mas_store_gfp(&mas, NULL, GFP_KERNEL);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but what happens if
mas_store_gfp() fails here?

Modifying a maple tree under RCU can require allocating a new node. If this
node allocation fails and returns -ENOMEM, the entry is not removed from
free_areas.=20

Since the return value is ignored, the memory is subsequently freed via
vfree(area), leaving a dangling pointer in the free tree that could be
returned by a subsequent allocation.

>  			vfree(area);
                        ^^^^^^^^^^^

[Severity: Critical]
This is a pre-existing issue, but does calling vfree() on a partial or
interior chunk of a larger vmalloc allocation cause a use-after-free for
actively used regions?

If a multi-PMD block is allocated (e.g., 4MB) and an interior PMD_SIZE free
block is formed (e.g., area =3D p + 2MB), execmem_cache_clean() blindly cal=
ls
vfree(area) on it.

However, vfree() relies on find_unlink_vmap_area(), which matches any
interior pointer to the containing vmap_area:

mm/vmalloc.c:find_unlink_vmap_area() {
    ...
    va =3D __find_vmap_area(addr, &vn->busy.root);
    ...
}

Won't this completely unmap and free the entire original 4MB block,
destroying the actively used portions alongside the free chunk? This could
potentially be triggered by userspace loading and unloading BPF programs
or kernel modules of specific sizes.

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-execmem-se=
t-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org?part=3D5
