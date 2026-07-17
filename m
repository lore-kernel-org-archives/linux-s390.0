Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490A3F9F51
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297452; cv=none; b=WC13a7P8KnSxQZBHnXvlscntizoixqqRlkc64AHp+gRz5Fj4xVV/FQt0Ay+hbntU1fLz2vb5mNF0qiebMFBJDojrcxM1jcPWcfhwYUsNeSpJuQ+C43fAlk3VcZpuEPnKLGxZrVqbblvFUccLq3eCEP4K+BdkRCrRDRToLOvgxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297452; c=relaxed/simple;
	bh=nnvrMHk4bezYdPNX2oMxfF/ZZlpHethI6CTcTBM2VvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=flHrmvLznRQMROXLBLwOfesiC3BG8PL3iAwiHoMwnG1ggcxCNdD7wwK3IkHDaTBdMOE4UxiyaERVgTwnYoZZvaDrrcCZixBeHv2Fap6UtTrqZvlHm+EFZGgoN0KgMiTbfGXcuehL4F0P5VqmESFSCjXE2YJ0Y+sOmRbr+3+GTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL8LXxm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL8LXxm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA171F000E9;
	Fri, 17 Jul 2026 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784297451;
	bh=At0Eyf0P5IDjsucWH8IW+mojwjps8hA9A6rAK8k/eCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZL8LXxm0hV0cpM7ba2v4o846RLRFrRGsmqbwOLZ+r0EO6CrkGQ5kvFpt+MoUVfDAw
	 tK78enlD3H9Pg+74SjNl+uEFW1K6RzP+MWZyu6+gdTPfhZKxdcShtfD1DdjTDd4W6j
	 yOgatUm3/7u5I8P1oJaQBYfylsOmGOzF36DoJx50/dUNb0+zhp0OCOAdPPROH3eh1L
	 JFLmU3lhmTteSKsXBWRkn8NSzbZzvaohD5+kMUhXZW6FM2pz286G5+RJaJPnWF/Epn
	 1QHjGJg6V0pYLETMzcQ8uQWaEJWFeJ8yCCxUVIAUF+XhCyFyvMqzOuoAoi14Ja4Fnp
	 IHvAlmUmyiX1A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] mm: introduce ptep_get_nopgtable() and
 set_pte_nopgtable() accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <19627b802d38510a6e006ec666d3177278ad8a38.1784292223.git.agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
 <19627b802d38510a6e006ec666d3177278ad8a38.1784292223.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:10:50 +0000
Message-Id: <20260717141051.0FA171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation breakage due to missing include for `PageTable` in `<li=
nux/pgtable.h>`.
--

--- Patch [2]: [RFC PATCH 2/4] mm: introduce ptep_get_nopgtable() and set_p=
te_nopgtable() accessors ---
commit 678225e92a04ea7f858c641009b79bba768aafec
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm: introduce ptep_get_nopgtable() and set_pte_nopgtable() accessors

This patch adds helpers to safely access PTE values stored outside page
tables, such as in stack variables. It updates folio_pte_batch_flags()
and write_protect_page() to use the new accessors.

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a8..a359e80400986 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -489,6 +489,31 @@ static inline int pudp_set_access_flags(struct vm_ar=
ea_struct *vma,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
> =20
> +#ifndef ptep_get_nopgtable
> +static inline pte_t ptep_get_nopgtable(pte_t *ptep)
> +{
> +	/*
> +	 * Ensure this is a pointer to a copy not a pointer into a page table.
> +	 * If this is a stack value, it won't be a valid virtual address, but
> +	 * that's fine because it also cannot be pointing into the page table.
> +	 */
> +	VM_WARN_ON(virt_addr_valid(ptep) && PageTable(virt_to_page(ptep)));

[Severity: Low]
Does include/linux/pgtable.h need to include <linux/page-flags.h> for the
PageTable() macro?

If a translation unit includes <linux/pgtable.h> without previously includi=
ng
<linux/page-flags.h>, it looks like the compiler will emit an implicit
function declaration error for PageTable() used here and in
set_pte_nopgtable().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784292223.gi=
t.agordeev@linux.ibm.com?part=3D2
