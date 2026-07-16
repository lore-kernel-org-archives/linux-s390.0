Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F28425CEB;
	Thu, 16 Jul 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212414; cv=none; b=R0DY9V61JPnWkdWiwgUrCDjAF/P/9z2GB1QflDkbm8WWFTxZgT0etgAKzR5NtkVBxs+nc603iq/dNixOcgCtZ1ZxqG0Y+QOy4yyxtvwF1pctnPYVJBkMs3vt/a45Jgg40BlrxYTPLoeMnpiItnoHSlNMq7MkPQ4DYqrrn98q3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212414; c=relaxed/simple;
	bh=MGIk6NTWT+cmNSCG9a2u0XD1vQmkBnLp07BnLE5tKhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFf+T5NMPZ8bAbvx7tbmd8NCemFLxj44SzhdZTx0ZNp9VpdNbA6GD9mmAZqBHCllldqDvjmAWNSPI6AAWqK/do9IyRoeWlCCqN7zCbnCeJ8Fl2h/2nK3klerL/YwepA6xawttui5TB+wwdLBuQ2A2zgeQRi9zZ2kVdmYN2xB8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux3aNiPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux3aNiPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B891F00A3A;
	Thu, 16 Jul 2026 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212413;
	bh=NLzY8O2UmjgHxZjxw08VhjfSo2dIGgLJ88GM7Jp9AuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ux3aNiPLFjBlKCNOr3KRH1ibI+2y8WbZ4H6tpsLxBNKxy10bV64VKDIQiiO/s7dW1
	 mu3w9zkgnoP1rrsDHsNc58oaVpt3aCeAU312TiQFLOybOuskqSi76gOxYwoFMiEY8D
	 /axUoO4kzI4pSb1GMJlljTycVWhDZyQBUQpPam0TqEPu5+/6BmaiKpOs+UuOR72St/
	 xTAg61YE81MZY5o8dSou/TMR17esw+Hdot6KXmOQ1uqW8OehbHAlvb4+juuqOUMDYP
	 1p+AGP5AICEzHcSDPKq5+BssbkRkgcKTBskgcAAnYa+qD7gNldeOQt/nREluxtlL1n
	 PlWGIBJiJJL7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260716141436.2125703-2-hca@linux.ibm.com>
References: <20260716141436.2125703-1-hca@linux.ibm.com>
 <20260716141436.2125703-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:33:32 +0000
Message-Id: <20260716143333.20B891F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Physical pages are freed to the buddy allocator before their corre=
sponding page table entries are cleared and the TLB is flushed, creating a =
Use-After-Free vulnerability window.
- [High] Passing an unaligned `size` to `uv_alloc_stor_var()` causes an inf=
inite loop in the kernel page table walker.
--

--- Patch [1]: [PATCH 1/4] KVM: s390: pv: Use VM_SPARSE area for guest vari=
able storage area ---
commit fd3cc6954f3085a22cae9f0932705a2913ea0050
Author: Heiko Carstens <hca@linux.ibm.com>

KVM: s390: pv: Use VM_SPARSE area for guest variable storage area

The guest variable storage area is allocated with vmalloc and then
donated to the ultravisor. This patch allocates it via a custom
VM_SPARSE area to avoid unexpected short reads via /proc/kcore.

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a284f98d97168..98a7f988fc691 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c

[ ... ]

> @@ -209,6 +210,64 @@ int uv_convert_from_secure_pte(pte_t pte)
>  	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
>  }
> =20
> +static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	pte_t pte =3D ptep_get(ptep);
> +
> +	if (!pte_present(pte))
> +		return 0;
> +	__free_page(pte_page(pte));
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

[Severity: High]
Does this create a Use-After-Free window during VM teardown?

In uv_free_stor_var(), we call apply_to_existing_page_range() which invokes
uv_free_range_cb() for each page. The callback frees the physical page
directly to the buddy allocator via __free_page() while the PTE remains
fully present and writable in the init_mm page tables.

After all pages are freed, free_vm_area() is called to clear the PTEs and
flush the TLB. If a freed page is immediately reallocated to another
subsystem, can concurrent accesses via the stale vmalloc alias read or
overwrite the newly reallocated page before free_vm_area() completes?

> +}
> +EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");

[ ... ]

> +void *uv_alloc_stor_var(unsigned long size)
> +{
> +	struct vm_struct *area;
> +	unsigned long addr;
> +
> +	area =3D get_vm_area(size, VM_SPARSE);
> +	if (!area)
> +		return NULL;
> +	addr =3D (unsigned long)area->addr;
> +	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))

[Severity: High]
If an unaligned size is passed to uv_alloc_stor_var(), could this cause an
infinite loop in the page table walker?

The size parameter is passed directly to apply_to_page_range(). The internal
page table walker loop relies on the end boundary being exactly page-aligned
to terminate:

	do {
		...
	} while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);

If size is not a multiple of PAGE_SIZE, addr will increment past end without
matching it, looping indefinitely over the page tables.

Should we pass the page-aligned size of the allocated VM area instead, perh=
aps
by using get_vm_area_size(area) or explicitly aligning size beforehand?

> +		goto out;
> +	return area->addr;
> +out:
> +	uv_free_stor_var(area->addr);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(uv_alloc_stor_var, "kvm");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716141436.2125=
703-1-hca@linux.ibm.com?part=3D1
