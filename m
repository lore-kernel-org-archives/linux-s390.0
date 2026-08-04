Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71C353A75;
	Tue,  4 Aug 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846044; cv=none; b=PGdM7UoEdJ5Vro1yRb7ILfhvP99tyGlryToMVIQdJFIvCGQK8huAXxZmHxvIablSj+nJVP/f/2nEpOoz2PQthf6pgwMlj4rbv1Nw0msNJytNUZhTgpJdChZsJTNsadZGzYtyAvULp8K91zeNTDhQwZLHcoAeDvB2NpAAcFMsMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846044; c=relaxed/simple;
	bh=3jFkM0VHrx/rm6eVyl/xOBXOpBezCu1bTOojbM2MeCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQvKUnQFkQfVj77essFKhMADSx+m1spyfyseH1MrwIEfB5LSFoAoMACOiYQxNnw4DKw08mweLSn87D2xB6BxGsm1GncCl9TggSWRcw+H/2y4v+TiKLuIFqabL/2gbUkeWbaPit9OB7GynowTlJFyTiCG2wyJJ5F/yQRffi1s7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1iJsOae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1iJsOae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3601F00A3A;
	Tue,  4 Aug 2026 12:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846042;
	bh=wx+A0RuCo2BmDjRNS97tN25IAquoCflYRodI0PATqCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k1iJsOae1EQ/FKUNVdk9cjORTAXoUOu4+nneRd4yG8hW4r4ybMoDuX/sY6NhMI23s
	 FL7gjWi4DZqkq27RFEEd3ZbQJtZt7JlMPSEMfmZqoc3gi25HYtdNthkejFN24RgpJf
	 aNsibqKBkkaU3oaib7ReNoz34XHKUOiiMAZeGkiNyieFh53KiDUe3qtSdsmrNJz8jT
	 bYlD/1wCezfZGW4OULXhlmBXuRHuhGIlk+a0iVq4HkiIuCv45vaCIKt4DLDcTN/5er
	 yJVvlYBUwCVkthxDZYFn2byXIBBg7UxPQE2V13qsUN5/cBf2w+JZ5Hs0CELeT0SAj8
	 H+JVgTH/O5x3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(), change
 variants to inline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260804120529.1730187-2-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:20:41 +0000
Message-Id: <20260804122042.4F3601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The global shared zero page can be mapped as writable by inser=
t_pfn, leading to memory corruption.
--

--- Patch [1]: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(), cha=
nge variants to inline ---
commit 010e09346cc93d215af7040a0cfe7fd891a1bd7d
Author: Paolo Bonzini <pbonzini@redhat.com>

mm: export vmf_insert_pfn_prot_mkwrite(), change variants to inline

This commit introduces vmf_insert_pfn_prot_mkwrite() and
vmf_insert_pfn_mkwrite() to allow drivers to install writable PTEs during
faults when a mapping is under write notification. It refactors the existing
vmf_insert_pfn() family of functions into inline wrappers around this new,
more flexible variant.

> diff --git a/mm/memory.c b/mm/memory.c
> index 6637c5b13c9ba..786b114d9921a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> -vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long=
 addr,
> -			unsigned long pfn, pgprot_t pgprot)
> +vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma,
> +			unsigned long addr, unsigned long pfn, pgprot_t pgprot,
> +			bool mkwrite)
>  {
[ ... ]
>  	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
> =20
> -	return insert_pfn(vma, addr, pfn, pgprot, false);
> -}
> -EXPORT_SYMBOL(vmf_insert_pfn_prot);
> -
> -/**
> - * vmf_insert_pfn - insert single pfn into user vma
[ ... ]
> +	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
>  }
> -EXPORT_SYMBOL(vmf_insert_pfn);
> +EXPORT_SYMBOL(vmf_insert_pfn_prot_mkwrite);

[Severity: Critical]
This is a pre-existing issue, but by allowing mkwrite to be passed directly=
=20
through to insert_pfn(), can this result in the global shared zero page bei=
ng
mapped writable?

If a driver maps the zero page via vmf_insert_pfn_mkwrite(..., true) into a
shared writable VM_PFNMAP mapping, insert_pfn() in mm/memory.c handles the
new entry like this:

	/* Ok, finally just insert the thing.. */
	entry =3D pte_mkspecial(pfn_pte(pfn, prot));

	if (mkwrite) {
		entry =3D pte_mkyoung(entry);
		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
	}

Because there is no check verifying if the passed PFN is the zero page,
maybe_mkwrite() will explicitly make the PTE writable, bypassing the zero
page protections ordinarily afforded by vm_mixed_ok().=20

If the global zero page becomes writable, unprivileged userspace could write
to it, which would cause memory corruption across the system for any process
reading uninitialized memory. Should we add a defense in insert_pfn() to
explicitly reject or write-protect the zero page when mkwrite is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D1
