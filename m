Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82386311583;
	Fri, 17 Jul 2026 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281209; cv=none; b=Eqywxg0zYWvh+QDbs6V77/aQTUuW1dCxpDfYRAS1LmOrru5wZFvr9BcOiG0xqktqh5QYgNAOzCn1D/UAc1T7y9yHbv1Ls3VFUTfx+p9ardh4Y8Td9D33P/80cOe1WQEY8kbOBZcK8Qh0M6odjqqlxdWAlvyWa50aJGhImZMiBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281209; c=relaxed/simple;
	bh=Ci/YEKSm7Tu6mfFANfdGiCrbQsIG7+gBHCTb3/xR2j4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M2GVsoxkn5L7/jCs8Yckw0TkRm7ECl5BeOSWe77heZwONvDOe9mLU0s/1AJokCiOHSwgbYloaEtREZV/q08OpsAn2x4e9/ERcf2sIro/4dKV69Zd/HS7ZL5slWEf6esZVchOvP0loG4DZ491WXh0O0bRPeQWUZmN32Jh1FyWp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEz3BgWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEz3BgWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCD1F000E9;
	Fri, 17 Jul 2026 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281208;
	bh=HMIHsZKH+4hM69wbntZN6+hLkFckAqPhtxAQraLLI0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OEz3BgWasNuMwCBaDLG0HWwmP8aSxl8aySnvNZrs1hrq7I/mZYh/geTZWQ7mgV4YL
	 URkdNdbUoEvZqEM6yB2Vfq2QeoM/Jqsyq0hyqAiXM4sUirWdzIkVakWh/u6WToBk1/
	 iwDsyfQYE/gto1Dw1ctGStCJuJ1PvMta7FKf4m+EOcvln+R7rB0Ltw4V4+yC8YNd8u
	 EevO3h7DjD+9Cmx0HqaHA2DT/00IREMuhMrGw60tQa7U4Xplc9OPVFqaQNJnVAuheX
	 tRe1Soe7PsHelT7YvzdhQRYYdQVeGy+rU0e4dNc8ysXU/BOY1O+KfCG80NrFJ2KkQa
	 Y3PsVJhuQ+A1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260717092415.3039699-2-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:40:07 +0000
Message-Id: <20260717094008.03CCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Physical pages are freed to the buddy allocator before their kerne=
l page table entries (PTEs) are cleared and TLBs are flushed, creating a da=
ngerous Use-After-Free window.
- [High] The page table walker callback `uv_alloc_range_cb` performs a slee=
ping memory allocation (`GFP_KERNEL_ACCOUNT`) while holding a spinlock.
--

--- Patch [1]: [PATCH v2 1/4] KVM: s390: pv: Use VM_SPARSE area for guest v=
ariable storage area ---
commit 3aa87ec52bc96aa3b06650c2d3924417b23be4ca
Author: Heiko Carstens <hca@linux.ibm.com>

KVM: s390: pv: Use VM_SPARSE area for guest variable storage area

The guest variable storage area is allocated with vmalloc and then
donated to the ultravisor. This commit changes the allocation to use
a VM_SPARSE area so that if the area is read via /proc/kcore,
vread_iter() returns zeroes instead of causing an exception.

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a284f98d97168..d1cdc5ae5e270 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
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
Does this create a window where the physical page is freed to the buddy
allocator but still mapped in the kernel page tables?

If another CPU reallocates the freed page before free_vm_area() unmaps and
flushes the TLB, could speculative execution or a stray kernel access to the
old virtual address read or corrupt the new owner's data?

> +	return 0;
> +}
> +
> +void uv_free_stor_var(void *stor_var)
> +{
> +	unsigned long addr, size;
> +	struct vm_struct *area;
> +
> +	if (!stor_var)
> +		return;
> +	area =3D find_vm_area(stor_var);
> +	if (WARN_ON_ONCE(!area || !(area->flags & VM_SPARSE)))
> +		return;
> +	size =3D get_vm_area_size(area);
> +	addr =3D (unsigned long)area->addr;
> +	apply_to_existing_page_range(&init_mm, addr, size, uv_free_range_cb, NU=
LL);
> +	free_vm_area(area);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");
> +
> +static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	struct page *page;
> +	pte_t pte;
> +
> +	page =3D alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);

[Severity: High]
Can this allocation sleep while holding a spinlock?

The apply_to_page_range() function loops over the page tables and acquires
the page table spinlock (ptl) via pte_alloc_map_lock() before invoking the
callback.

Since GFP_KERNEL_ACCOUNT implies __GFP_DIRECT_RECLAIM, which can sleep
and invoke the scheduler, could calling this while holding the page table
spinlock trigger a scheduling while atomic bug or deadlock?

> +	if (!page)
> +		return -ENOMEM;
> +	pte =3D __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
> +	set_pte(ptep, pte);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717092415.3039=
699-1-hca@linux.ibm.com?part=3D1
