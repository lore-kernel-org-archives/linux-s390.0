Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372A3AFD09;
	Mon, 20 Jul 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538765; cv=none; b=Dsy/ax8OrnEXhk5ekwAUtRa0yudLIuChQI10LT0AAR32VORyfKw5KUyP//JSsjMglz2cwhfTtkhcJSd8Ly/ek0wjQr3myAr6yGldtXVHTnFD6VcBEj8LI1/usqvQJkAXjP1vEz+/GqjfFcd13Y7ZEb4tL/6g71+8O+4wKLH37kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538765; c=relaxed/simple;
	bh=CM/CkvVnzCawQ/dDwAPb7WwVqxhINB5mt7kMrLAiQlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqn2s6qDh+Akw1GJk3AnG/vfnNKF7zminSk6sFfVwRiuLfAfnVpQPH0XhH2+Fd70AZz7IWczAJT/lKv5rj3wLx6eweUZ9N9xmuXp7D8Z2XrXEKhD77ADrKl8/bO5fIDqQau/uAfCPfe3QJ3K9N3af+sjwaU65d+plke+MJSecis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX/Cn7Je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX/Cn7Je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79281F000E9;
	Mon, 20 Jul 2026 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538764;
	bh=5AKsTXXMGDbg1GBeKpksk5JUDO4Kh+vXIhvYMzrrlBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eX/Cn7Je2Ex/Qtqnks5soJTeuKmbKX8aM89hi3D1AFaGrrkro0+QPycb/WUOaRH7V
	 MmRQ3x70gasfuZyQqfwmscFlbU1gebaR6tNQ8cBzTi9mq+GrecVfbHgeIrwwmNjX1c
	 6JvtBXOXZ9MYQSQ3pv97k01lRSshDTrS1jMETe2xk4cesJAJBrGjxWC1xHWfs7GpEI
	 BGNteE5oRSBPOBLV0mzaatKSyRVBK5rqdooQM2mIf3ieKJirKTeeIOha/ZWrRDnqQx
	 DXCkCiqSl4KlN3IHsIGT1STgDdcUbeMlgfK7JRRiD+XQZBheWQ3mPMFWZhJ3012R9i
	 uRO2T1NSa32PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/8] s390/mm: Add missing mm check to
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260720085834.898025-3-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:12:43 +0000
Message-Id: <20260720091243.B79281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing VMA boundary check in user space fault path can trigger a =
kernel WARN_ON_ONCE due to a race condition with concurrent munmap.
- [High] Using virt_to_folio() on arbitrary kernel fault addresses can caus=
e a kernel panic if the address is in vmalloc space.
- [High] Failing to run exception fixups for kernel-mode faults in `do_secu=
re_storage_access()` causes an infinite loop.
--

--- Patch [2]: [PATCH v4 2/8] s390/mm: Add missing mm check to do_secure_st=
orage_access() ---
commit 61b1851bdfb6749b6398a064bf9e76283ed6b1e3
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Add missing mm check to do_secure_storage_access()

Similar like the normal exception handler the secure storage access
exception handler needs to verify if mm is not NULL, which may happen
with kernel threads.

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
>  		panic("Unexpected PGM 0x3d with TEID bit 61=3D0");
>  	}
>  	if (is_kernel_fault(regs)) {
>  		folio =3D virt_to_folio((void *)addr);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does using virt_to_folio()
unconditionally here cause a kernel panic if the fault address is in vmalloc
space?

If the kernel accesses donated secure memory that was allocated via vmalloc,
virt_to_folio() on s390 uses __pa(), which only works for direct-mapped
addresses. This would produce a garbage physical address, leading to an
out-of-bounds pointer dereference in the subsequent folio_try_get() check.

>  		if (unlikely(!folio_try_get(folio)))
>  			return;
>  		rc =3D uv_convert_from_secure(folio_to_phys(folio));
[ ... ]
>  		if (rc)
>  			return handle_fault_error_nolock(regs, 0);
>  	} else {
> -		if (faulthandler_disabled())
> +		if (faulthandler_disabled() || !mm)
>  			return handle_fault_error_nolock(regs, 0);
> -		mm =3D current->mm;
>  		mmap_read_lock(mm);
>  		vma =3D find_vma(mm, addr);
                ^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does find_vma() properly check that the
address is within the VMA's boundaries before we call folio_walk_start()?

find_vma() returns the first VMA with vm_end greater than addr, but its
vm_start could also be greater than addr if the faulting address was just
unmapped by a concurrent munmap(). If this happens, we would pass a VMA
to folio_walk_start() that doesn't actually contain the address, which
triggers its strict WARN_ON_ONCE assertion. Should this be using
vma_lookup() instead?

>  		if (!vma)
>  			return handle_fault_error(regs, SEGV_MAPERR);
>  		folio =3D folio_walk_start(&fw, vma, addr, 0);
>  		if (!folio) {
>  			mmap_read_unlock(mm);
>  			return;
>  		}
>  		/* arch_make_folio_accessible() needs a raised refcount. */
>  		folio_get(folio);
>  		rc =3D arch_make_folio_accessible(folio);
>  		folio_put(folio);
>  		folio_walk_end(&fw, vma);
>  		if (rc)
>  			send_sig(SIGSEGV, current, 0);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does this error path cause an
infinite loop if the fault was triggered by a kernel-mode access like
copy_to_user()?

For kernel faults that happen in the user address space, is_kernel_fault()
is false. If arch_make_folio_accessible() fails here, we send a SIGSEGV
and return without calling fixup_exception(). Because fixup_exception() is
not run, the kernel will return to the faulting instruction rather than an
error path, causing the instruction to endlessly re-execute and lock up
the CPU.

>  		mmap_read_unlock(mm);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D2
