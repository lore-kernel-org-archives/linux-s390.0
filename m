Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86140926A
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524276; cv=none; b=j1CR4InXh+f+8roxp77kgRa1h94UMzdlVS6/LVzNPGoGpQEliabTS0KTYtTMyQOwiUz9uJGkK2DhfKwDLasSBQTS7CqK7O+UStAogVxRcFbyPf6/KHEYEUWaWJL2Xtitw9vmOGSo7cjnPaBkuv2/may3Nxet4EuFx22YJWHvsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524276; c=relaxed/simple;
	bh=m2sVCTuu/dYj32jUKJns5mTua0qN21K8lJfuHc9dr4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKteTa95y+bkddVb9m9ThHPZo2NfTqyWKNc8yQ+yuMmJDcAt2fLD5comyRh0FMUI9ROkDKXeaKSJRMFNX/5tWt1+5SLjZVjZT+0B+x5CbexADXEeX1TSQqy8zcslQFCP2fVuThhqMcUfy72vIpOITvdK4k5LOQNxmK46SlAxbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlA9UrXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlA9UrXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3531F00A3A;
	Wed,  8 Jul 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524274;
	bh=xZ6SBrcUNtnjlPkQG9dxb8DzlIpIxv3WQ1JGQZnjOBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nlA9UrXGFIPWOV4prdfhe+TFVAHE6E17Lz0STm7pS6n1wCShdcdUAFIhn8J3XqtDh
	 lPx3UjeWAizWK8LmGTKur3veFy8GXIMZ22+KUs9n9DiJSh9xZ6OUfg8ZND29ELtmCM
	 Eyk11cTl2kqabg1NykS+wS70WSGM8RKir1MOF8e8YedUXDg4R/1ZCy9DjipPY1+I4o
	 x9mimpwptN+Z40YV5iOAFo6c3C4JxRwsyaWw0SRIZUQKtLNhhyBsdzHw5mvtGU9dDR
	 vTZoCJyFfn6bpl0gTrnwMQVqT55Xo5jvu7uwzRUGTHMD3j1Km7CycfT1o4rdzYo+HY
	 xpcTBo/8UriSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] x86/mm: stop marking page tables as
 MIX_SECTION_INFO
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260708-bootmem_info_part2-v1-6-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-6-156ce4986598@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:24:32 +0000
Message-Id: <20260708152433.1B3531F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch leaves the entire bootmem_info infrastructure as dead cod=
e without removing it.

Pre-existing issues:
- [High] Kernel page table pages and vmemmap pages are freed to the buddy a=
llocator before their parent entries are cleared and before the TLB is flus=
hed, creating a dangling pointer window.
--

--- Patch [6]: [PATCH 06/10] x86/mm: stop marking page tables as MIX_SECTIO=
N_INFO ---
commit 898f480b722bff5d0f4c640bb5e5d118e809c16f
Author: David Hildenbrand (Arm) <david@kernel.org>
Subject: x86/mm: stop marking page tables as MIX_SECTION_INFO

This commit stops marking boot page tables as MIX_SECTION_INFO since they
are only freed when completely empty and memory offlining doesn't benefit
from it. It updates free_pagetable() to free reserved pages directly and
empties register_page_bootmem_memmap() to reflect this change.

> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 82bb0384b8ab0..1b17dcf781e66 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1002,21 +1002,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
> =20
>  static void __meminit free_pagetable(struct page *page)
>  {
> -	/* bootmem page has reserved flag */
> -	if (PageReserved(page)) {
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -		enum bootmem_type type =3D bootmem_type(page);
> -
> -		if (type =3D=3D MIX_SECTION_INFO)
> -			put_page_bootmem(page);
> -		else
> -			free_reserved_page(page);
> -#else
> +	if (PageReserved(page))
>  		free_reserved_page(page);
> -#endif
> -	} else {
> +	else
>  		pagetable_free(page_ptdesc(page));
> -	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at how free_pagetabl=
e()
is called during memory hot-remove:

arch/x86/mm/init_64.c:free_pte_table() {
    ...
	/* free a pte table */
	free_pagetable(pmd_page(*pmd));
	spin_lock(&init_mm.page_table_lock);
	pmd_clear(pmd);
	spin_unlock(&init_mm.page_table_lock);
    ...
}

arch/x86/mm/init_64.c:free_pmd_table() {
    ...
	/* free a pmd table */
	free_pagetable(pud_page(*pud));
	spin_lock(&init_mm.page_table_lock);
	pud_clear(pud);
	spin_unlock(&init_mm.page_table_lock);
    ...
}

Could freeing the page table pages to the buddy allocator before their pare=
nt
entries are cleared lead to a use-after-free window? If the freed page is
reallocated before the PMD or PUD is cleared, a lockless hardware MMU walker
might follow the dangling pointer and interpret the new page contents as va=
lid
page table entries.

Would it be safer to clear the parent entries and flush the TLB before free=
ing
the child pages?

[ ... ]

> @@ -1579,50 +1568,6 @@ int __meminit vmemmap_populate(unsigned long start=
, unsigned long end, int node,
>  void register_page_bootmem_memmap(unsigned long section_nr,
>  				  struct page *start_page, unsigned long nr_pages)
>  {
> -	unsigned long addr =3D (unsigned long)start_page;
> -	unsigned long end =3D (unsigned long)(start_page + nr_pages);
> -	unsigned long next;
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -
> -	for (; addr < end; addr =3D next) {
> -		pgd =3D pgd_offset_k(addr);
> -		if (pgd_none(*pgd)) {
> -			next =3D (addr + PAGE_SIZE) & PAGE_MASK;
> -			continue;
> -		}
> -		get_page_bootmem(section_nr, pgd_page(*pgd), MIX_SECTION_INFO);

[ ... ]

> -		if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
> -			next =3D (addr + PAGE_SIZE) & PAGE_MASK;
> -			get_page_bootmem(section_nr, pmd_page(*pmd),
> -					 MIX_SECTION_INFO);
> -		} else {
> -			next =3D pmd_addr_end(addr, end);
> -		}
> -	}
>  }

[Severity: Low]
By removing the implementation of register_page_bootmem_memmap(), is the re=
st
of the bootmem_info infrastructure left as dead code?

Without get_page_bootmem() being called here, it appears no page will ever
have its bootmem_type set to SECTION_INFO or MIX_SECTION_INFO. As a result,
the SECTION_INFO check in free_bootmem_page() would always evaluate to fals=
e,
meaning put_page_bootmem() is never executed.

Should the remaining bootmem_info code, such as
register_page_bootmem_info_node() in mm/bootmem_info.c, be removed as well =
to
clean up the unused infrastructure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bootmem_in=
fo_part2-v1-0-156ce4986598@kernel.org?part=3D6
