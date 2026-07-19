Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD52E54B;
	Sun, 19 Jul 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466607; cv=none; b=Gbf+AWfhFusCqjlh5qgsmj8KNgLdYj95mSItCVtEA4/vDjQZkm3jBR/3H/ZJ170qjzbPSNEpHOYw9UYiCF+nKVo2ubzfQCX0bM5fUZkxzWcW0Aohk3Y5pSboE3Pp6ASPnUhHvctTVSwSwi0kiYoDglEdvNWHRHoh+Q4k6W8CG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466607; c=relaxed/simple;
	bh=3/6WNDqdMTD4G6/P8OF/CUuJFbf8bEzccFQg9Q/sOSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQFX2gP3VFImOs04RoBfJbbwvaLU2EYZO4Mx0R3W9KENmnjfVzREs4q3wZgohTwH/5DygLllkw/qcZ2xkwfOiDrdzeOfOoHUElE/PSXOg7b5lSaj1PbWRF/8LuNNyLhu9zoUO/04nutZqDv+CVvvSNrPWXFKQFz6mSAOsqwmkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSdEIsog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSdEIsog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4481F000E9;
	Sun, 19 Jul 2026 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466605;
	bh=+gOmrm0uDXEaEIGu1Vwsyz40ra/cNXr3YK/7Lak4ba0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSdEIsogL1T/s26/KoLAAMHSdJP2RRsOdfAtZGGhdsxpFwNtdV5Pwec8L7RquYWFg
	 k9FaXE8t8tb03udhBBq2T1rG9A9quMy/IJ73bryeT0Nfg1RbX1HyyX+gAW7johgGBL
	 zC4ZYDQTqtlJ778so9qGq2sJjLGlLJFdw8j1GDhUbrNIcnv7AYCL30cO8BAY6xFrwR
	 nSApRkjvZNPb/eTGael/bRv/oG395ycnF8i9oElAyhvBKEDJGLGVdCPFyB3EzTyew8
	 54Q/YCRPg7CT5wXMLvsK1hkfyYnDGToHFSBiC1lsv148A72eZ6Rh7Dx2slGl7Tnt+R
	 V3buJXunGozww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] s390/mm: Fix handling of vmalloc area in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260719130006.3882764-5-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
 <20260719130006.3882764-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:10:05 +0000
Message-Id: <20260719131005.7C4481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning from the trap handler without fixing the exception when =
`folio_try_get()` fails causes an infinite kernel loop.
- [High] Kernel-mode accesses (e.g., `copy_from_user`) that fail to convert=
 a secure folio will infinite loop due to improper signal handling.
--

--- Patch [4]: [PATCH v3 4/6] s390/mm: Fix handling of vmalloc area in do_s=
ecure_storage_access() ---
commit 1759378fac324776e9a7cbd8390b8445f3bb360c
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Fix handling of vmalloc area in do_secure_storage_access()

Secure storage access exceptions in vmalloc area need to be handled
separately since folio_try_get() or virt_to_phys() do not work on such
addresses. Given that there cannot be a valid access let such exceptions
fail immediately. The kernel will either fixup or crash.

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c

[ ... ]

> @@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		panic("Unexpected PGM 0x3d with TEID bit 61=3D0");
>  	}
>  	if (is_kernel_fault(regs)) {
> +		if (is_vmalloc_addr((void *)addr))
> +			return handle_fault_error_nolock(regs, 0);
>  		folio =3D virt_to_folio((void *)addr);
>  		if (unlikely(!folio_try_get(folio)))
>  			return;

[Severity: High]
This isn't a bug introduced by this patch, but returning directly here in
do_secure_storage_access() without fixing the exception state when
folio_try_get() fails seems problematic.

Since PGM 0x3d is a suppressing exception on s390, the instruction pointer
isn't advanced. Returning without modifying the page state or adjusting the
instruction pointer (e.g., via fixup_exception()) will cause the hardware
to immediately re-execute the faulting instruction upon returning to the
interrupted context.

Will this trigger the exact same exception repeatedly and result in a hard
kernel lockup? Should this fail gracefully by calling
handle_fault_error_nolock(regs, 0) instead, so that exception tables can
be processed or a proper Oops generated?

[ ... ]

> 		rc =3D arch_make_folio_accessible(folio);
> 		folio_put(folio);
> 		folio_walk_end(&fw, vma);
> 		if (rc)
> 			send_sig(SIGSEGV, current, 0);
> 		mmap_read_unlock(mm);

[Severity: High]
This is also a pre-existing issue, but does this error path in
do_secure_storage_access() correctly handle kernel-mode accesses that fail
to convert a secure folio?

For accesses to user-space memory, is_kernel_fault() returns false even if
the access was performed by the kernel (e.g., copy_from_user() using second=
ary
space). If arch_make_folio_accessible() fails, the code queues a signal and
returns.

Because the fault happened in kernel mode, returning doesn't immediately
deliver the signal to user space. It resumes kernel execution and re-execut=
es
the faulting copy_from_user() instruction, hitting the secure page again and
triggering another PGM 0x3d exception.

Can this result in an infinite kernel loop repeatedly queuing SIGSEGVs with=
out
making forward progress? Should this path check !user_mode(regs) and call
handle_fault_error_nolock() (or equivalent) to apply fixup_exception() for
kernel-mode accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719130006.3882=
764-1-hca@linux.ibm.com?part=3D4
