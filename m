Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185033B71A1
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157791; cv=none; b=q2JzOKb1xHLPJ9MtLBSjsj3Q54d2cgGi3zJlM9DHVCNuGz/2pvklaRB7YIs5reuSFm1d8rWoPMxed9vlFwFJp8ptEF84a7JLUv8omPTiXvZHBiB302OE7ioHmJ2NhrA1BSzuQ3W4T0YsdQ/ZZncsEg1gOPgyYQdQOA+fQTYxXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157791; c=relaxed/simple;
	bh=w2DRtde81bOjTwPJwD00zIS7RycwlQEMWiULdQZvZF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhYktL0MCD84VdbNRqyhQi3l5umiBUuu/2vwGiou0ElZXTDyl3FO1tGCzfcfOZ71mu2nwNHETOfo3jITq3meX+qwVXKlFIOb7e+CjazZzl9a+dj6T0BDykcosfeF6bitP0OCiNiok8CfC58uBhyrMF6I5PwokVijucnc6Z6HAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjd+LVLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjd+LVLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686051F000E9;
	Mon, 31 Aug 2026 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788157789;
	bh=oC7lxMjbcqgqbeXvsmZdxr+EgZ4erjc1Xtg1rwfeMBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjd+LVLle1F3D5xgZJLMkKigsfqkfpW2xB3k+WAYPWdkf7bkfaTlJU5WBoB7jSJta
	 b2BWQFYZuPjP1fH3oxqJYZrrZhSkw9mWW1k/yhzeFBIJr+cDNcIhXk3rK9QHgGnzig
	 ePENd7atowEo3vEA5AsJ6pm39hp0SQ3AurNU/bQ+GKzaO/vuJJy3qU1mijdOAOev5i
	 alTPko7lM2E4Sx8BirMDNTg9/WEqoTM/FUlvcA2hDcSzdco0LpWzuIG2DVzIk4YeAs
	 UWZug71Yomebo9aW3jX6GzSBx3acXICBRw9+oF+J9wZEyq1tUu8v2ffNNLHZ2pVIje
	 hic6Ccf/dkMNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831054331.625505-7-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:29:48 +0000
Message-Id: <20260831062949.686051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `__get_pte_phys()` can return `NULL` on error, but its callers (`s=
et_pte_phys()` and `clear_pte_phys()`) immediately dereference the returned=
 pointer without checking, leading to a guaranteed kernel crash.
- [High] `__get_pte_phys()` uses allocation functions (`p4d_alloc`, `pud_al=
loc`, `pmd_alloc`) passing `NULL` for the `mm` argument, which will cause a=
 kernel crash if allocation is actually needed.
--

commit 0098935d861a1c9cf1496880ca35e1a49aecdf51
Author: Anshuman Khandual <anshuman.khandual@arm.com>

sh/mm: Stop using [p4d|pud|pmd]_ERROR()

This commit replaces the use of [p4d|pud|pmd]_ERROR() with pr_err() in
__get_pte_phys() when page table allocations fail. This avoids a NULL
pointer dereference when attempting to pass the failed allocation result
to the error macros.

> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 9466ae6f9f164..8d65e60688dcb 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -59,19 +59,19 @@ static pte_t *__get_pte_phys(unsigned long addr)
> =20
>  	p4d =3D p4d_alloc(NULL, pgd, addr);

[Severity: High]
This isn't a bug introduced by this patch, but passing NULL for the mm
argument to p4d_alloc() will cause a kernel panic if allocation is actually
needed. The slow path requires a valid mm_struct to acquire the page table
lock. Should this be passing &init_mm instead?

>  	if (unlikely(!p4d)) {
> -		p4d_ERROR(*p4d);
> +		pr_err("allocating p4d table failed\n");
>  		return NULL;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while this fixes a NULL
pointer dereference here in the callee, the callers still unconditionally
dereference the returned pointer.

For example, in set_pte_phys():

    pte =3D __get_pte_phys(addr);
    if (!pte_none(*pte)) {

And in clear_pte_phys():

    pte =3D __get_pte_phys(addr);
   =20
    if (pgprot_val(prot) & _PAGE_WIRED)
        tlb_unwire_entry();
       =20
    set_pte(pte, pfn_pte(0, __pgprot(0)));

Could these callers be updated to check if the returned pte is NULL
before dereferencing it to avoid guaranteed crashes on the error paths?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D6
