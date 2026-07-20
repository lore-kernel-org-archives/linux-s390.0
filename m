Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF61386C9;
	Mon, 20 Jul 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540181; cv=none; b=WI2/E8mT/aIc17tpJNBoJpF4lfUxoVkWySNNIsLM0SdwsvqWa9fmUqeMV67/e82reXrk/7OogVZlZB2VRmlCcn8/uwTGq62tOwC16L6kM5/+uyv3Y6Mk3YJgrUHYxyImd7qBGWTmNixTO4M0/vlbOZPNpPVJONngIbImWRz/WZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540181; c=relaxed/simple;
	bh=d8RhRVleVeO8/Rk6X6cT1KzKJDgkLr7KjYA8SIW4hYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPooR2o4AZsL9PnHIZEa9W/pLUndVkFQG++DE+FzSzZB/IgmzMKmpuxYKkyJAcyi3+2xYTReipR6YZ3RE3IZCChRTFkaGheeCw23qKBCmOPr4StucyNhPm0FTqwbjeeaSBT9HOJs+HOkQEZjUuPn6DXQk9edRdfi0ReVmbB4L2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5YR+J2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5YR+J2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8371F000E9;
	Mon, 20 Jul 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540180;
	bh=yug+toqhSk/X3K8HQWji5ZeUg8gmBIoxehB9wRswSuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5YR+J2sMf7+58+BYAyqvwTOe2ogbhGfKgsN9SY7wFK+azbAiHpvx0sXh2IWVq7J6
	 G7zNxT3uh3eHGQmRuHjJ5SkU6s8Eo5VCVBhXexPkQo7/c5mPpQmfTrnc/srTsajItP
	 UQ6sR9HZ8ZG1qcSfo7Zi4+XV7GORVAY4FhTWjuzoLCxxG26K+qjf1kECuBBY9625WS
	 Sum4nC3UgHEiYJDIWJ4n3UFVtZR53wNuVe4/DvxK4LVNLc/6kh+8QZwmyptV5z8eJH
	 0lM4hkInkPm1rsdjYxSCaSwXhkIPOvyZa8EHAIBQ9Ce7pZqLlZpOeiX9bRQQjLdqiY
	 H1U1YRE1hi9vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] s390/mm: Use goto statement in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260720085834.898025-8-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:36:19 +0000
Message-Id: <20260720093619.9D8371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Stale TLB / Premature Page Freeing in VM_SPARSE area teardown
- [High] Invalid physical address translation for module addresses
--

--- Patch [7]: [PATCH v4 7/8] s390/mm: Use goto statement in do_secure_stor=
age_access() ---
commit e37b9a92584a0cc071d6b45d285a37b7eb5137cc
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Use goto statement in do_secure_storage_access()

This patch refactors do_secure_storage_access() to use a goto statement
for unlocking mmap_read_unlock. It removes an open-coded unlock to make
it look more like do_exception().

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 2a9b9fb30d09c..666fe8e994801 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -453,10 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
[ ... ]
>  		folio_walk_end(&fw, vma);
>  		if (rc)
>  			return handle_fault_error(regs, SEGV_ACCERR);
> +out:
>  		mmap_read_unlock(mm);
>  	}
>  }

While reviewing the changes in do_secure_storage_access(), I noticed a
potential regression earlier in the same function:

arch/s390/mm/fault.c:do_secure_storage_access() {
    ...
    if (is_vmalloc_addr((void *)addr))
        return handle_fault_error_nolock(regs, 0);
    rc =3D uv_convert_from_secure(__pa(addr));
    ...
}

[Severity: High]
Does this incomplete vmalloc check allow module addresses to fall through
to the invalid __pa() translation?

On s390, module memory resides outside the VMALLOC_START..VMALLOC_END
range, so the is_vmalloc_addr() check returns false for module addresses.
The code then falls through to uv_convert_from_secure(__pa(addr)).

Since module addresses are not direct-mapped, __pa(addr) generates a
garbage physical address.

If this garbage address aligns with a valid physical page currently donated
to another guest as secure memory, would the Ultravisor erroneously convert
it, destroying the unrelated guest's secure state?

Should this check use is_vmalloc_or_module_addr() instead?


Also, looking at the VM_SPARSE area teardown sequence:

arch/s390/kernel/uv.c:uv_free_stor_var() {
    ...
    apply_to_existing_page_range(&init_mm, addr, size, uv_free_range_cb, NU=
LL);
    free_vm_area(area);
    ...
}

arch/s390/kernel/uv.c:uv_free_range_cb() {
    ...
    __free_page(pte_page(*pte));
    return 0;
    ...
}

[Severity: High]
Can this sequence cause a stale TLB or premature page freeing during
VM_SPARSE area teardown?

This sequence frees the physical pages to the buddy allocator while
intentionally leaving the kernel PTEs valid. The PTEs are only cleared
and the TLB flushed later by free_vm_area().

During this window, could any speculative or stray access to the vmalloc
address access the physical page through the valid PTE/TLB, even though
the page may have already been reallocated to another subsystem or guest,
corrupting memory?

Should the teardown sequence clear the PTEs and flush the TLB before
freeing the physical pages, as is normally done during standard vfree()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D7
