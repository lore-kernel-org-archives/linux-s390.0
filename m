Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370225B086;
	Sun, 19 Jul 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784467651; cv=none; b=Cxba9Qgx8ZqyoogK7IHBUQHMrtUpNxf/HSe2XYWqc4cDCNyeyPsXqx2HGHPyeIV0JPh+nRFXVXGiEChMS7I3f26+lkXrpldZuL9h0M9IhuHRgOnDWulcGy3tyh4y3wOQflFbPCJAHqpkIKkVDHZMSGtj1qRk676XT/wvU5zoilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784467651; c=relaxed/simple;
	bh=B0mS37Z4SPcZBxOHdDSSdDNPeLUifOpjgksE0VPwkVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NEMBAb7QRo+pnxJzkVKXbWmgX8vtKdspABoq5VmdDeWE9B83ohCBRGF+ECOxiE/FdzVLhtBVfyrbvVtRAE+2NmRfV2e3h/5/0RoW7lo2xrQxXhgTioI3dJaONWVXn/wnZN8Rnv/z4iOCqjX8kf0lJCyijCzwAkUHfiMam0G4ZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjms5FCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjms5FCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D5C1F000E9;
	Sun, 19 Jul 2026 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784467648;
	bh=uGlgtWCpJPT+1K5zF6Pr4NaCtStOHzHH5RDDcKuQBE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjms5FCEZfG4pK0JKI2F0NTqb8UIVvn2jLXbSu8dkgONLS7DMkG5Y7sweSZWf9iXJ
	 EqUEgirYSAKETYbLi+wowBCU+5u4q4L5jbvS095AUyYmbAQadb1EJSkjSEF/gCmZjh
	 rQFl2ZMj3d/1PVLaZ+n4AlmUyXt78lX1IjpNfLY+IrBBBJq4u0fjLdDWFk8CLnI2re
	 Qjom8TsbThuTG48p3PlMlpLVMloKBcHyUxBqYf6wjxRBnLLtRJa0vZ8RxKUwV3vt4K
	 eFDca1YhH8jJysnRMMDXGSQPt0iLMZRKIk6K2YYBA2BqNGDesZH6EYVFvpP8/gncut
	 gu8HpsDpziNWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260719130006.3882764-2-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
 <20260719130006.3882764-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:27:28 +0000
Message-Id: <20260719132728.81D5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Physical pages are freed to the buddy allocator before their page =
table entries (PTEs) are cleared, creating a Use-After-Free and memory corr=
uption window.
- [Medium] A sleeping memory allocation is performed inside a pte_fn_t call=
back under lazy_mmu_mode_enable(), violating core MM API contracts.
--

--- Patch [1]: [PATCH v3 1/6] KVM: s390: pv: Use VM_SPARSE area for guest v=
ariable storage area ---
commit 2a65969cbdc861d6caeb95bb64f45d4facecff0e
Author: Heiko Carstens <hca@linux.ibm.com>

KVM: s390: pv: Use VM_SPARSE area for guest variable storage area

The guest variable storage area is allocated with vmalloc and then
donated to the ultravisor. Any kernel access to that area will result
in a secure storage access exception (aka fault).

This is a problem if such a memory area is read via /proc/kcore. This
causes an exception via vread_iter() and results in an unexpected short
read. Avoid this by allocating a custom VM_SPARSE area.

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a284f98d97168..d1cdc5ae5e270 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
[ ... ]
> @@ -209,6 +210,70 @@ int uv_convert_from_secure_pte(pte_t pte)
>  	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
>  }
> =20
> +static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	pte_t pte =3D ptep_get(ptep);
> +
> +	if (!pte_present(pte))
> +		return 0;
> +	/*
> +	 * Note: do not update the pte here, since there is no code which
> +	 * accesses the memory range, besides bugs. The invalidation of ptes
> +	 * and TLB flushing is deferred like for regular vfree() calls.
> +	 */
> +	__free_page(pte_page(pte));

[Severity: High]
Is it safe to free the physical page back to the buddy allocator while the
PTE remains fully present in the init_mm page tables?

The commit message notes that vfree() defers PTE updates, but vfree() actua=
lly
clears the PTEs via remove_vm_area() before freeing the underlying pages.
Here, the pages are freed first, and the PTEs are cleared later when
free_vm_area() is called in uv_free_stor_var().

Could this create a window where the physical page is reallocated to another
process, but the current CPU still has a valid, writable PTE pointing to it?

Any stray kernel access or speculative execution through the old vmalloc
address could then silently corrupt the new owner's memory without faulting.

> +	return 0;
> +}
> +
> +void uv_free_stor_var(void *stor_var)
> +{
[ ... ]
> +}
> +EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");
> +
> +static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	struct page *page;
> +	pte_t pte;
> +
> +	page =3D alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);

[Severity: Medium]
Does this violate the cross-architecture pte_fn_t API contract by performing
a sleeping memory allocation?

This callback is executed by apply_to_page_range(), which wraps the pte_fn_t
callbacks in a lazy MMU mode section. The MM subsystem guidelines dictate
that lazy MMU mode implies a possible atomic context (as it disables
preemption on some architectures), forbidding these callbacks from sleeping.

While lazy_mmu_mode_enable() is currently a no-op on s390, the commit messa=
ge
states s390 expects to gain full support for lazy MMU mode in the future.
Will this GFP_KERNEL allocation then introduce a preemption-disabled deadlo=
ck?

> +	if (!page)
> +		return -ENOMEM;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719130006.3882=
764-1-hca@linux.ibm.com?part=3D1
