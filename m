Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D043F08E;
	Sun, 19 Jul 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466872; cv=none; b=Ma6lE3dDwYJ1l1UN1ul5paqnaody84trwx66EPQ48nJ5DxVdPgEZp8n/xkeER2BEFB1ImE+R6qRxQ57VJcs8rlfgaSk3Q4TOJZipZShRnA4wvad0MYP6qFHoD2X3UpQ+9x5QS3GovIp4HsBjTaOKNN96mTpL2mzJLxr3xl2CswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466872; c=relaxed/simple;
	bh=SsSLxgEbrq+W61Gdcoduityt39CXNvjtwk459r/0Uio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4/0ZBWNlu1ds4A2NvIMsR4SfN8ONg2oceyP+LrwaG78U3Xx4BPVcOlSSE+2Hbkvu+2VJixEkRiLO7pwPA/lMasVCUcrtzkCu8k7D3WQqkuEHejujDdCMtvKGx/XmhbGIsnPk0YN+Vbf+WPV9WmzZccOCWC58wNyKK0OueNessA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqp1lmvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqp1lmvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172401F000E9;
	Sun, 19 Jul 2026 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466871;
	bh=OY5Zcm1rMAfQz1tENGaRR+TSgq+B3sWYQeRuaZtyX0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sqp1lmvgTUNAZ8vk/+tHfYz6ouX9jsvpcZ2decCx6I7rbD8frzE1TBxC4KlnZlIVw
	 Xyb7D0U9pY134dJB0zSu/u+ghXeaAt6aaTJBDdY7vw4QkB/IwwJMArzriYBTehibPL
	 AFmXG+WXqTece7ROcikKk4tfStq1otEnK2P7ZV2utFvrB0KYAagTAwScYfyHuUIXuW
	 SisDtKmNBLAmVab2soGeaBqcsXv5NWMeS0wwdOSnMWIwIkQhJAP/+8GamOf7DL4Dk2
	 ZQQazU684MYcNXnoOHBpOpI7/cqeQv21pAWwGSHIf/pwTtSQ/Vs6oT/RjgjEeZ2aEM
	 v2z5/7ZuoI72A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] s390/mm: Remove folio handling for kernel faults
 in do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260719130006.3882764-6-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
 <20260719130006.3882764-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:14:30 +0000
Message-Id: <20260719131431.172401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Kernel accesses with exception fixups (e.g., speculative reads=
 or probe reads) unconditionally destroy active secure guest pages because =
uv_convert_from_secure() is executed before checking fixup_exception().
--

--- Patch [5]: [PATCH v3 5/6] s390/mm: Remove folio handling for kernel fau=
lts in do_secure_storage_access() ---
commit 475be2dbf4868b390a06f3b6bd78b394674a341a
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Remove folio handling for kernel faults in do_secure_storage_acces=
s()

This commit removes folio handling and reference counting for secure
storage access exceptions triggered via the kernel mapping. It replaces
the folio_to_phys() conversion with a direct __pa(addr) translation to
avoid data corruption from a known race condition.

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e650cdfa25231..776549d55c94a 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -440,13 +440,7 @@ void do_secure_storage_access(struct pt_regs *regs)
>  	if (is_kernel_fault(regs)) {
>  		if (is_vmalloc_addr((void *)addr))
>  			return handle_fault_error_nolock(regs, 0);
> -		folio =3D virt_to_folio((void *)addr);
> -		if (unlikely(!folio_try_get(folio)))
> -			return;
> -		rc =3D uv_convert_from_secure(folio_to_phys(folio));
> -		if (!rc)
> -			clear_bit(PG_arch_1, &folio->flags.f);
> -		folio_put(folio);
> +		rc =3D uv_convert_from_secure(__pa(addr));

[Severity: Critical]
This is a pre-existing issue, but does this unconditionally destroy active
secure guest pages on speculative reads?

Looking at do_secure_storage_access(), uv_convert_from_secure() is called
here before checking fixup_exception(). Because the Ultravisor allows the
host to reclaim active guest memory, uv_convert_from_secure() succeeds for
guest memory, scrubs the page, and returns 0.

Since the conversion succeeds, the code skips calling
handle_fault_error_nolock() where the fixup is actually evaluated:

arch/s390/mm/fault.c:do_secure_storage_access() {
        ...
        rc =3D uv_convert_from_secure(__pa(addr));
        /*
         * There are some valid fixup types for kernel
         * accesses to donated secure memory. zeropad is one
         * of them.
         */
        if (rc)
                return handle_fault_error_nolock(regs, 0);
        ...
}

If a speculative kernel read (like the mentioned load_unaligned_zeropad)
or an eBPF probe read targets an address in the direct map belonging to a
secure guest, wouldn't this silently destroy the guest's memory instead of
safely executing the fixup?

>  		/*
>  		 * There are some valid fixup types for kernel
>  		 * accesses to donated secure memory. zeropad is one

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719130006.3882=
764-1-hca@linux.ibm.com?part=3D5
