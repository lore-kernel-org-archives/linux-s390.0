Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A832AAA8;
	Fri, 17 Jul 2026 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281146; cv=none; b=c21P8eZHdwWRTwZcvV91K6UZvO/pkkTR6VMkXE6w/WDyfk30SXD6L2jJkt8eWXzch1OHGeROlHe6OBP4CfyVEN4Ua7eqoQnLOy7fpRk+qgq3JbwZB6xOKerIPcEU4ug6GjI5crI5c0vCrcW2Gr9hWhhnGoW3dNUvmV5r0EPdJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281146; c=relaxed/simple;
	bh=jiSNxEjSFnra993ZqGKkojxHM6UlO3vgDKsgcL1oJek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUDxoe23SzKTMc23RcysAIFq+LG/i3BeNhw7pQABmOi85gCZjkWwsahDHv2y8t6+yvD8sunfhNq5iike0zfrma/TslOVAA22XaSgAnGqH3MsGCx8XpuX9TzK6RC+lQZOO6WaTv4DLpafiwBngsta5R/fQQQW476ZlXMJx8cfcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnaHTkuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnaHTkuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A421F00A3E;
	Fri, 17 Jul 2026 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281145;
	bh=l5ViUvmz05jxp/PWMLKuc6X39LGwU6kp4drfUTpuwlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnaHTkuPJv7rwMz93yOg4kxAFxXXUHpUvMwRbJAzpWkcTTVeVzDqQ8vEKU1Szk/In
	 uFoJfVSXNpmpZnVLs4G0mHosLGAXdI5MezUO5NEGtrU01L9ptUbG3BGKd7osCBdKDd
	 JnIEnaJRui0ENnWIPxItNSTpBKSjFo2bxKhqxquR2WLfGimy3xKhuKQCSHpDKk7+Dm
	 1TYAc5NRQfrQ5GRWElj+dxdxXoO8PFfSO1doL5bQ5Kof5RsvsELwYCFZ7hq57QpF9B
	 zA3uN/5bxoxtGKhmoK/4x4h6v6hwj8cYGNLFScCDJ7TsZQ129U3O4XwdcUHZLR3Jkv
	 qN2beCir2KoaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] s390/mm: Fix handling of secure storage access
 exceptions in vmalloc area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260717092415.3039699-3-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:39:04 +0000
Message-Id: <20260717093904.E4A421F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `do_secure_storage_access` uses `find_vma()` to locate the VMA but=
 fails to verify that the faulting address is within the returned VMA's bou=
nds, allowing an unprivileged user to reliably trigger a `WARN_ON_ONCE` via=
 a race condition.
--

--- Patch [2]: [PATCH v2 2/4] s390/mm: Fix handling of secure storage acces=
s exceptions in vmalloc area ---
commit 09ae7bc2c3bf1f10251c33af84acf243e29af836
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Fix handling of secure storage access exceptions in vmalloc area

Secure storage access exceptions in vmalloc area need to be handled
separately since folio_try_get() or virt_to_phys() do not work on such
addresses. Given that there cannot be a valid access let such exceptions
fail immediately. The kernel will either fixup or crash.

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6f..392e467420392 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		panic("Unexpected PGM 0x3d with TEID bit 61=3D0");
>  	}
>  	if (is_kernel_fault(regs)) {
> +		if (is_vmalloc_addr((void *)addr))
> +			return handle_fault_error_nolock(regs, 0);
>  		folio =3D virt_to_folio((void *)addr);
>  		if (unlikely(!folio_try_get(folio)))
>  			return;

[ ... ]

>  	} else {
>  		if (faulthandler_disabled())
>  			return handle_fault_error_nolock(regs, 0);
>  		mm =3D current->mm;
>  		mmap_read_lock(mm);
>  		vma =3D find_vma(mm, addr);
>  		if (!vma)
>  			return handle_fault_error(regs, SEGV_MAPERR);
>  		folio =3D folio_walk_start(&fw, vma, addr, 0);

[Severity: High]
This is a pre-existing issue, but does using find_vma() here allow a race
condition that could trigger a kernel warning in folio_walk_start()?

find_vma() returns the first VMA where vma->vm_end > addr, but it doesn't
guarantee that vma->vm_start <=3D addr. If a concurrent unmap happens and t=
he
exact VMA is removed before mmap_read_lock() is acquired, find_vma() might
return the next VMA in the address space.

Passing an out-of-bounds VMA to folio_walk_start() violates its API contract
and triggers a WARN_ON_ONCE().

Would using vma_lookup() instead properly validate that the address falls
within the VMA's bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717092415.3039=
699-1-hca@linux.ibm.com?part=3D2
