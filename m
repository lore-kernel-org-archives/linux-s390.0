Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DA3914F8
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262661; cv=none; b=UqaJV1ffsszbkCAA1JfLo8FNvimuPddthjoTcvyw8vMksRdF4l2dTkE5tzxTLkYC1Vnu4ld5glldEjNlX469Gq0MgCFdqPNw/PnjQzK1hgOIxSFTy6tG47WhAFs6QOBnzWs/v88oiucibaRwRd+ZgRj0GZvJhuVUoJ3ZXY5h+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262661; c=relaxed/simple;
	bh=CDMlBWMaUvEepxRjmf09CNHAMAJqjaBCxUzpWbo4uqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2uxIQgOIJ1IgilZ4/eGkEBRTEgCdf5weOBCIVKBXGYli4yHgHwm8SDM7Ls+7jnDW5dt5DwlQ0tRgGB46TKhPiSU+LL2gMJvRXVOlutGgFwdPuohqYBTsVuJndgH18eiwPHn7Py1ebSWslFc4Q85DPEY0hE+fXS/FE+R1q9PaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn0VPjOR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn0VPjOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629851F000E9;
	Tue,  1 Sep 2026 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262659;
	bh=3w4QXLI2EB57GNjZjPEmeexllh+99uuOnIQGzvDvSHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wn0VPjOR/v+fsGdIJB0dlDmdlMVSg96sm0GCyiTvc4hwa4VQjdZw2bH92oxbI4Puv
	 lDt1cNbh3qsFYdJK6ZQ9uW3h5znzfExuTx5QVp/oWHQTxjAXY8poVt4NJVg6JKSgfx
	 tDe3liGWagFxqGtMtcUdXjyA9F5gOgMU8wy0JDRBd8MyLjSD0F1aqy292AFeo106WC
	 Nrsxh2g4X1YdkNOjwPp2s/UViyKgyRtD0BIxlG6iXeFpHqIIqa41AltTNSD8rKKiAe
	 7ZXW4HmaDYl78PYuB2Lf1PLAAnncV9TV4bevkL/DC6zUJnDioS/G9T4T9ODO1+rlVt
	 +WKiE9brSPphg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc32
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-10-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-10-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:37:38 +0000
Message-Id: <20260901113739.629851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent execution of pagetable_pte_ctor() and pagetable_dtor() =
on shared backing pages corrupts folio state.
--

commit f7114a4ac52b3be28e86c3e8ab381854e55bfcf6
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc32
   =20
This commit enables MMU_GATHER_RCU_TABLE_FREE for sparc32 by using an RCU
callback to free page tables. It introduces __tlb_remove_table() and modifi=
es
__pte_free() to handle NULL mm pointers when called from softirq context.

> But more importantly - the reference count increment in pte_alloc_one() a=
nd
> decrement in __pte_free() are atomic with full ordering, so it simply isn=
't
> possible for there to be a meaningful race here.

[Severity: High]
Does this actually prevent concurrent execution of the page table construct=
or
and destructor?

The atomic refcount ensures the reference count itself is safe, but it does
not serialize the execution of the constructor and destructor bodies.

If a process unmaps memory and queues PTE pages for RCU free, a softirq cou=
ld
begin executing __pte_free() and drop the page refcount to 1, entering
pagetable_dtor().

If a process concurrently page faults and allocates a new PTE table in the =
same
4KB physical page, it increments the refcount to 2 and enters
pagetable_pte_ctor().=20

Could both threads execute the constructor and destructor concurrently,
corrupting the folio state?

> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 9a74902ad1814..2a2c7bd210114 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
[ ... ]
> @@ -359,19 +359,39 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  	return ptep;
>  }
> =20
> -void pte_free(struct mm_struct *mm, pgtable_t ptep)
> +static void __pte_free(struct mm_struct *mm, pgtable_t ptep)
>  {
> +	const bool process_context =3D mm;
>  	struct page *page;
> =20
>  	page =3D pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
> -	spin_lock(&mm->page_table_lock);
> +	if (process_context)
> +		spin_lock(&mm->page_table_lock);
>  	if (page_ref_dec_return(page) =3D=3D 1)
>  		pagetable_dtor(page_ptdesc(page));
        ^^^^

[Severity: High]
Can this page table destructor run concurrently with the page table
constructor in pte_alloc_one()?

Since process_context is false when called from softirq context via RCU, th=
is
executes without a lock protecting the physical page.

If pte_alloc_one() concurrently allocates another PTE table in the same
backing page, increments the refcount to 2, and calls
pagetable_pte_ctor(mm, page_ptdesc(page)), could this lead to non-atomic
modifications to folio->page.page_type?

Concurrent execution of __folio_clear_pgtable() in the destructor and
initialization in the constructor could corrupt the page state, which may
lead to kernel crashes when pages are returned to the buddy allocator.

> -	spin_unlock(&mm->page_table_lock);
> +	if (process_context)
> +		spin_unlock(&mm->page_table_lock);
> =20
>  	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D10
