Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06F3BADB5;
	Mon, 20 Jul 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538861; cv=none; b=jZKdZRNoovGPLfVUmWW/b8Wk+7bbrPF29QwrJ5sXg4OAzoQDVdBj9SEQ36b34q1ray+fjqkMMe9MhAiX/nQnEcuA8d2Q0hl3UM/a+V1t/qTWnIxHK3ayO0kTrkEBNxY8HfTAleELzU/+J7mOJi/6rQrkVJsFaa9bb1QapyNZTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538861; c=relaxed/simple;
	bh=7uoSfhBV5Zw6VIKUCNhJZNns7P4EBcXEjroYInXAk7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kU3Cv1XUavLUqMZMKY8Iw0EcX4wy8lzrEKC3B9qNrwqdSzKA6aDqG7lh0WNoV6oWP8ks8cSUstQOGXWCzeUYHAHK14PhtjLzb6mUli26wHVS6RwhpksWrlXC48rW1ier69E541kWD5U8Lu2N0V0R5kWKmkf5VgwiJ3ZJQsI+8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK+20TwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK+20TwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499CE1F00A3A;
	Mon, 20 Jul 2026 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538859;
	bh=R6K4q7r3nGkfZp+Kc8thzKbIdEN2UG8sAa+0u9FjDUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IK+20TwMpqmNyScHwgs6WOGLXX33D8GEQlFYPY+r8MMkT3EISZB0TrqUqi0WerFw0
	 M3QsbOESR5qI1TUP35MgugYhYEkmOKYzPP6OdzoZR0MEHOtownE1a5FppjRtJCSkFT
	 TNDLZMozR6SfKUZJ6fHvs94Ny7y8zKs+ZHjHAU8LvLGi3VTlFqOVt8SczR1ouNHeEd
	 uslrEJT3g7aRB7GCas0lvsd9gxnOi9AbKKQIe1UMsQboYgKkybUorjPnQAO0V+DX9l
	 xSv9DNn+68B1vwzW+JAmLhQ7y+E1hzUeKdmnKUClYPofxfOOYpaU0BeEjAs6cmaYG3
	 bUQuVTDzccv3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720085834.898025-2-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:14:18 +0000
Message-Id: <20260720091419.499CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Physical pages are returned to the buddy allocator while their pag=
e table entries (PTEs) are left valid, creating a Use-After-Free / Map-Afte=
r-Free window.
- [Medium] Sleeping memory allocation within a `pte_fn_t` callback violates=
 the `lazy_mmu_mode` API contract.
--

--- Patch [1]: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest v=
ariable storage area ---
commit 66226034e9e83eee2fe85a1e6e86baa666a0331b
Author: Heiko Carstens <hca@linux.ibm.com>

KVM: s390: pv: Use VM_SPARSE area for guest variable storage area

The patch replaces a standard vmalloc allocation for the guest variable
storage area with a custom VM_SPARSE area allocated via get_vm_area(). It
populates and tears down this memory using apply_to_page_range() and
apply_to_existing_page_range() callbacks.

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c

[ ... ]

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
Does freeing the physical page without clearing the page table entry introd=
uce
a regression where the memory could be reallocated while the kernel retains
a valid mapping to it?

The comment mentions that vfree() defers PTE invalidation, but standard
vfree() clears PTEs synchronously and only defers the TLB flush.

Because apply_to_existing_page_range() returns before free_vm_area() is
called to unmap the area, could speculative execution or a hardware page
table walk access the new owner's memory after it has been returned to the
buddy allocator?

> +	return 0;
> +}

[ ... ]

> +static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	struct page *page;
> +	pte_t pte;
> +
> +	page =3D alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);

[Severity: Medium]
Is it safe to use sleeping allocation flags during this page table walk?

The apply_to_page_range() function wraps iteration in lazy_mmu_mode_enable()
and lazy_mmu_mode_disable(). The MM page table guidelines state that lazy
MMU mode implies a possible atomic context because it disables preemption on
some architectures, meaning pte_fn_t callbacks must not sleep.

Could this cause a regression if the callback blocks, and would it be better
to use a non-sleeping allocation flag to conform to the apply_to_page_range=
()
contract?

> +	if (!page)
> +		return -ENOMEM;
> +	pte =3D __pte(page_to_phys(page) | pgprot_val(PAGE_KERNEL));
> +	set_pte(ptep, pte);
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D1
