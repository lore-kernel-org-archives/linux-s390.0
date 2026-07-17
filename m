Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B3FD125;
	Fri, 17 Jul 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294627; cv=none; b=QVLfDnYM6RuLjvr0NaRNrxTSxdZ1Ke0pmygKlpWd37hkKMSuB49jfACeFHGixE1xy/bs5HSs7Ud53AZworzW3LWUTa4Vdvv/X4AkOA8f3rafysufiAIF3IWdMmvDxHnCtlK11BdpW5A8qt4baZ3HDFA6EhSBBcdDd0hHe3kjQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294627; c=relaxed/simple;
	bh=an4wbqlztKZ70Fmd7vZp50QJieW2y7B1E+VgvviC/Mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IpnjqbLS73B5a3ZbBzkKkxMxe+uAs79QEeRBZJkCguL21MlTVaWXtSb9zuDvTaWqaW1MxYQ9Gf0afYvjg1xNhbLLTfUPjnF8BO33n3tCvxCcjNPQOerpP5qBnH85tYNgxDbSyLz61TFsaLfoEYz3A3pGvvZHhX2ApXQoa50Mp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VllROZlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VllROZlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539A11F00A3A;
	Fri, 17 Jul 2026 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294626;
	bh=DJUZcjZm1ztcQvWSC8sM6FRT6s95fc9tPzk/X111cX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VllROZlwtP/m1kgpPJXnfhOgymVJbeWniE47gyPDOrUIT7dVOgReoU2fkrUHKURQl
	 ZGJfzA05MQucWhOXG4PP0HrCaY8FAVluSS78OrPu5/S8/p7E/ERju7AJF4debVBRnT
	 zNJNCvRmPfVAonmq6RaQ1ph1oKx40IvykGaEpp/ZkxgdfpUSCBDdaZdzMd4hCTHvHN
	 UAyUjcg8Jvu//9mBwyVkkeLKNjmxO9mZwAS/5M5Lqq4BUkSjmyR3+jf5OlfvyttLZK
	 t65kl90wP79oqFnLno1ZR0eh1ELO0vIF+cHnKrsD1/unABTdz2AIxFXdEdFJKagRgP
	 gyz9xs2obBU2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/mm: Add missing vm_start <= addr check to
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260717131407.855327-1-hca@linux.ibm.com>
References: <20260717131407.855327-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:23:44 +0000
Message-Id: <20260717132345.539A11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing !mm check in do_secure_storage_access allows kernel thread=
s faulting on user-space accesses to trigger a NULL pointer dereference.
--

--- Patch [1]: [PATCH] s390/mm: Add missing vm_start <=3D addr check to do_=
secure_storage_access() ---
commit 925b56344e2c328b11b68034f7f630693a6c6b31
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Add missing vm_start <=3D addr check to do_secure_storage_access()

This patch converts do_secure_storage_access() to use lock_mm_and_find_vma(=
)=20
to ensure the faulting address is properly checked against the VMA boundari=
es.

Link: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.o=
rg/

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6f..d6c58d78edc5a 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -456,10 +456,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		if (faulthandler_disabled())
>  			return handle_fault_error_nolock(regs, 0);
>  		mm =3D current->mm;
> -		mmap_read_lock(mm);
> -		vma =3D find_vma(mm, addr);
> +		vma =3D lock_mm_and_find_vma(mm, addr, regs);

[Severity: High]
This is a pre-existing issue, but does this lack of a NULL check on mm lead=
=20
to a crash if a kernel thread faults on a user-space access?

When a kernel thread (which has current->mm =3D=3D NULL) triggers a secure
storage access exception (for instance, via a copy_from_user() mapped to a
secure page), it enters this branch. The mm pointer is set to NULL and then
passed to lock_mm_and_find_vma():

vma =3D lock_mm_and_find_vma(mm, addr, regs);

Inside lock_mm_and_find_vma(), it unconditionally calls mmap_read_lock(mm):

mm/mmap_lock.c:lock_mm_and_find_vma() {
        ...
        mmap_read_lock(mm);
        ...
}

Could this result in a NULL pointer dereference? The do_page_fault() path
handles this gracefully with an explicit !mm check and exception fixups, but
do_secure_storage_access() appears to be missing this check.

>  		if (!vma)
> -			return handle_fault_error(regs, SEGV_MAPERR);
> +			return handle_fault_error_nolock(regs, SEGV_MAPERR);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717131407.8553=
27-1-hca@linux.ibm.com?part=3D1
