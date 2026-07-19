Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315143F08E;
	Sun, 19 Jul 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466789; cv=none; b=a8q8ALIK0PxwXLgEBaOX7AEr4NqaPsnzMwevQ3WJTZQ7yJnYKCogsoHPfW8OT18elP3g3ReUTXN2f3e26E6dZE65tMARcC86kTQFo2uBlFmoviIIwC8M8tMr/WpET4mUzbBReUMT8sLEl8NfoUwHNRzk/jEB5l5ifgUQ+twVQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466789; c=relaxed/simple;
	bh=W18JH2kghUuTWfbppTbMbvuHfwrSXm7Yirr8jj7zjzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JFuELNenP39XunyEmDg0WGf/Ln6Zf20D6/ulxexeL/FBIT9hLku9OaTc3ATNxFEXuWB31izvQt243WEsVyCaMSCSwCexxjWGFOWf1zAmjH6fB0sejJDxY1ctRf1THlMD0+n8ag/bOloWuO71M1hKPPwZwjw6Jh7RP0DkO83YaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU9rSMAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU9rSMAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40B61F000E9;
	Sun, 19 Jul 2026 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466788;
	bh=ZzH3SislvqtsOTWI1ABS9/miqC3h9sBqfk3bC85nD7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HU9rSMAak/hCoXJZLVDb5w0U1smOemm7qkiLaGAoownIOPm90ZMLudoZXualG15tk
	 N+xE5Oc7nOMUJow1IgstlIKeYjZQmCoPYj1QkSPuAsRqc0nx5wtp+csb/v6m6PIt64
	 lugbUEJREnKvI6yhDNp4inJBgTtC/52tGALPOBMgQYzoRQH0ZxsjYP2kNlsfFWLNoY
	 0bCGx/qlI1FY9rt7jGXKFWt/sVQWPh1dR9mjdsOpsvSQ3x/vUcBuVFj1X5vovkCRal
	 oBNi32imEA0gq8648/6NDaP5T8CE2b3HUmnouJ0BFaU6cd2DBdZTux5v4sgwbN+eF7
	 pDqK2FC+ZyzPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] s390/mm: Add missing mm check to
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260719130006.3882764-3-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
 <20260719130006.3882764-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:13:07 +0000
Message-Id: <20260719131307.E40B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing VMA Bounds Check allows Denial of Service via WARN_ON_ONCE.
- [High] Invalid Memory Access / Kernel Crash via virt_to_folio() on non-di=
rect-mapped addresses.
--

--- Patch [2]: [PATCH v3 2/6] s390/mm: Add missing mm check to do_secure_st=
orage_access() ---
commit 55ed80680943e84fffd67209605311fedc0e28ae
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Add missing mm check to do_secure_storage_access()
   =20
Similar like the normal exception handler the secure storage access
exception handler needs to verify if mm is not NULL, which may happen
with kernel threads.
   =20
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260717132345.539A11F00A3A@smtp.kernel=
.org/

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6f..2839d7a64401c 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -409,9 +409,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>  {
>  	union teid teid =3D { .val =3D regs->int_parm_long };
>  	unsigned long addr =3D get_fault_address(regs);
> +	struct mm_struct *mm =3D current->mm;
>  	struct vm_area_struct *vma;
>  	struct folio_walk fw;
> -	struct mm_struct *mm;
>  	struct folio *folio;
>  	int rc;
> =20

[ ... ]

> @@ -453,9 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		if (rc)
>  			return handle_fault_error_nolock(regs, 0);
>  	} else {
> -		if (faulthandler_disabled())
> +		if (faulthandler_disabled() || !mm)
>  			return handle_fault_error_nolock(regs, 0);
> -		mm =3D current->mm;
>  		mmap_read_lock(mm);
>  		vma =3D find_vma(mm, addr);
>  		if (!vma)

[Severity: High]
This isn't a bug introduced by this patch, but can this cause memory
corruption?

Earlier in this same function:

arch/s390/mm/fault.c:do_secure_storage_access() {
    ...
	if (is_kernel_fault(regs)) {
		folio =3D virt_to_folio((void *)addr);
    ...
}

When the kernel accesses a secure guest page through a vmalloc mapping,
is_kernel_fault(regs) evaluates to true. Then virt_to_folio() is
unconditionally applied to the faulting kernel address without validating t=
hat
it is a direct-mapped address.

Since virt_to_folio() subtracts the direct map offset, wouldn't it produce a
bogus PFN for vmalloc addresses, leading to dereferencing a garbage struct =
page
pointer?

[Severity: High]
This is also a pre-existing issue, but could this lead to a denial of servi=
ce
via WARN_ON_ONCE?

Looking at do_secure_storage_access() in arch/s390/mm/fault.c, find_vma()
returns a VMA that may start after the faulting address, which is not verif=
ied
before use.

If a concurrent thread unmaps the VMA between the time the hardware generat=
es
the secure storage exception and the handler acquires the mmap lock, could
find_vma() return the next adjacent VMA?

If so, passing this potentially unrelated VMA to folio_walk_start():

arch/s390/mm/fault.c:do_secure_storage_access() {
    ...
		vma =3D find_vma(mm, addr);
		if (!vma)
			return handle_fault_error(regs, SEGV_MAPERR);
		folio =3D folio_walk_start(&fw, vma, addr, 0);
    ...
}

would trigger the WARN_ON_ONCE(addr < vma->vm_start || addr >=3D vma->vm_en=
d)
safety check. Could a malicious user-space program exploit this race by
repeatedly triggering secure storage accesses while concurrently unmapping
regions to crash the system if panic_on_warn is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719130006.3882=
764-1-hca@linux.ibm.com?part=3D2
