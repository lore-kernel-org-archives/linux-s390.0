Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9D3B7747
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522430; cv=none; b=rcT6Hm67wnw8wB5PAPM6ZTsIVwyNGIKxFclhisJDO8v4wdkB52CgYf+EHVmMsz89i30BetP9bh2gC5CkLd/c2hzjrZLHFSiTl+Ah8oXwWBV+ulFYI9q4EUPB+09rTcP3WWhu9mx98iKC41BwtBH5AOoZPp3oKgcxWvJxpYBZf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522430; c=relaxed/simple;
	bh=eBKeiNSNs0wFnCjvRO/KagqkD7AAh9rjnb1Qohb8uqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSCop2LzBHmuWPKY9uKiJl3fZzi8CU21GGGmXbxj/yyhMCez06HDZT7TR1ZqIlukOtsPgwxSJdW7VUUfaSf8LLmX23fnCeAAalaoZWsLg52uxUDWPQHB5fVCMwk7ZMxfAyAcTleDucKvNQy92rEAf6S6d/1h3HBJP0C+giQUhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAf4vaAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAf4vaAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D6E1F000E9;
	Wed,  8 Jul 2026 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522429;
	bh=CH44dOMm4b5aAyJtkduh1paa2Du9rBLS/j/bgp29hCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAf4vaAITdAGDhASVRxXh4nUFkrXs/Ny1xxtOgk6pbvcVOMBrou0frIpGkN+qJlRO
	 /MZp0beHAjsoAJ03/gh7yV8Nz7eTy15D5wvxtsNed12IE5jyP6X24eBC2wgmEBRj9g
	 edTiJXr7Ku6+WzvgDZ3nzyUZ5+XpLYIkELRf8zy60ijhMJaBQ3Dcj7edR6kfHIPnQ7
	 F1fp8ltnbXX7+b97Y1oLQAsb64Qmeb8vIiVZZ7hM8+ECJdkfaMIIAfjk1Kvv9C9d6e
	 tuQ0pPfw9LyCVkoAnzYl7F8qkruLvPRR+YSW8ZGybwvHhc2yfpOJcIthvxZc945s+s
	 03gu4Mlb5bzeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] mm/bootmem_info: allow calling
 free_bootmem_page() on pages without a bootmem_type
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260708-bootmem_info_part2-v1-4-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-4-156ce4986598@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:53:48 +0000
Message-Id: <20260708145348.D5D6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Freeing unregistered vmemmap pages at runtime directly via `free_r=
eserved_page()` bypasses atomic refcount checks, causing a Use-After-Free o=
r double-free when racing with PFN scanners.
--

--- Patch [4]: [PATCH 04/10] mm/bootmem_info: allow calling free_bootmem_pa=
ge() on pages without a bootmem_type ---
commit a34f9e5045801f37b33acf3125423a2dfdea2fc8
Author: David Hildenbrand (Arm) <david@kernel.org>
Subject: mm/bootmem_info: allow calling free_bootmem_page() on pages withou=
t a bootmem_type

This commit allows free_bootmem_page() to temporarily support freeing
unregistered vmemmap pages allocated during boot. Instead of triggering a
BUG, pages without a bootmem_type now fall back to being freed via
free_reserved_page().

> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index f724340755e55..486acc6127039 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -44,12 +44,12 @@ static inline void free_bootmem_page(struct page *pag=
e)
>  {
>  	enum bootmem_type type =3D bootmem_type(page);
> =20
> -	VM_BUG_ON_PAGE(page_ref_count(page) !=3D 2, page);
> -
> -	if (type =3D=3D SECTION_INFO || type =3D=3D MIX_SECTION_INFO)
> +	if (type =3D=3D SECTION_INFO || type =3D=3D MIX_SECTION_INFO) {
> +		VM_WARN_ON_PAGE(page_ref_count(page) !=3D 2, page);
>  		put_page_bootmem(page);
> -	else
> -		VM_BUG_ON_PAGE(1, page);
> +	} else {
> +		free_reserved_page(page);

[Severity: High]
Can this race with PFN scanners and cause a use-after-free or double-free?

Since this is used for freeing unregistered vmemmap pages at runtime (via
HugeTLB Vmemmap Optimization), a physical memory scanner like DAMON might
concurrently iterate over this PFN and take a reference using folio_try_get=
().

If that happens, calling free_reserved_page() directly here bypasses atomic
refcount checks. Looking at free_reserved_pages() in mm/page_alloc.c, it
unconditionally clobbers any concurrent reference:

mm/page_alloc.c:free_reserved_pages() {
	...
	for (i =3D 0; i < nr_pages; i++) {
		clear_page_tag_ref(page + i);
		ClearPageReserved(page + i);
		set_page_count(page + i, 0);
	}
	...
}

Even scanners that check PageReserved can hit a race window here, as
PageReserved is cleared right before the refcount is forced to 0.

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bootmem_in=
fo_part2-v1-0-156ce4986598@kernel.org?part=3D4
