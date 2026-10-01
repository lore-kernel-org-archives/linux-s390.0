Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC33B5311
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851714; cv=none; b=KrpgpWz/BmUxE058YlSJ8ps/2esOeLo4AHPwx9PcN/PTbsGgCybXtP6tcFR2yPdSWLEfVVBCHzbtIuxKrTyNvwTI2ZTF3OkzH5nIxfeYR3qqoUZ1WB9br2Vj7Fi/s9OsC7nb6US5FvpnP6CpHjAjgH7UHErMG/4nCKXSz2tqLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851714; c=relaxed/simple;
	bh=LOD+pEsQpq4fKz+KZEOOmDjEJrQ8eWYvs/7cedjAv4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XgSfNxTtmvpSpeSXUYAY0wE6urg5/8wWtvi1pUmdqXJtOIkScJ1rrjebuy3BA7IkAdpsaOPMyS5zFKYrsukHWjscv06QG38dPFwzq9CKpz4EYffXVHOj7wrdE5CQtiRbFcbkKep5csFgOK7UomKLQibOT9LkHMtnigjvfIl7jD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsJ/q9KS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsJ/q9KS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F561F000FF;
	Thu,  1 Oct 2026 10:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851713;
	bh=VHnWQk3IY9eTD9Ugi5qx8BseAlFUIeOkhiUwcVn6GdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DsJ/q9KSdgd3kiVxG6Ay1UwR+B8zqQuWf2PS8LWm2nsANneCwbtXNAs1JaXdAtz4O
	 SzUHuryQuoZeRn06PLlHrpUupBErrKppHj5nWyyABbRshloF9PRRuBccuVMPXW8yZD
	 KfdKLjiHcJWmRzHgBCpMnWx2Leeub322q/zZhTHt2OY8a3aai1AQ8w5qxUApeoMEtz
	 CgakTyBtc0D6HkN5g/0KCwVSPfVcRvMwQhCRUhy5fucZRNUoeE36o42VJkaCgaE+4q
	 cIPr8tJMFvleQGbd2fSjbqBjz/yYkPBFRq2A09mwjnJY8C/7ElLO4M5gjbPn86bK+a
	 N/V+Bciwg/7Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/32] s390/dis: Improve show_code() output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-9-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:48:32 +0000
Message-Id: <20261001104832.A2F561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/dis: NULL pointer dereference in get_trap_ip() during early=
 boot crashes
--

commit 200c2c0f6eaf1b7f28478fbaa164025c7b6d456e
Author: Heiko Carstens <hca@linux.ibm.com>
Subject: s390/dis: Improve show_code() output

This patch improves the disassembler output by using explicit markers
for the PSW address and the faulting instruction. It also introduces the
PIF_PGM_CHECK flag to indicate when the context is a program check.

> diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
> --- a/arch/s390/kernel/dis.c
> +++ b/arch/s390/kernel/dis.c
> @@ -511,6 +512,9 @@ void show_code(struct pt_regs *regs)
>  	pswaddr =3D regs->psw.addr;
>  	if (test_pt_regs_flag(regs, PIF_PSW_ADDR_ADJUSTED))
>  		pswaddr =3D __forward_psw(regs->psw, regs->int_code >> 16);
> +	pgm_check =3D test_pt_regs_flag(regs, PIF_PGM_CHECK);
> +	if (pgm_check)
> +		trapaddr =3D get_trap_ip(regs);

[Severity: Medium]
Could this call to get_trap_ip() cause a NULL pointer dereference during an
early boot crash?

If an early boot exception occurs with the transaction abort bit set
(regs->int_code & 0x200), __do_early_pgm_check() will handle the exception,
set PIF_PGM_CHECK, and eventually call show_regs() which calls show_code().

In get_trap_ip(), there is a check for the transaction abort bit:

arch/s390/kernel/traps.c:get_trap_ip() {
    ...
    if (regs->int_code & 0x200)
        psw.addr =3D current->thread.trap_tdb.data[3];
    ...
}

Since the current task pointer in the lowcore is not initialized during ear=
ly
boot (before setup_arch() completes), dereferencing current here would resu=
lt
in a nested panic or double fault.

Would this obscure the original crash details and cause the stack trace and
disassembly to be lost?

[ ... ]

> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -159,6 +159,7 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
>  	regs->int_parm_long =3D lc->trans_exc_code;
>  	regs->last_break =3D lc->pgm_last_break;
>  	regs->monitor_code =3D lc->monitor_code;
> +	set_pt_regs_flag(regs, PIF_PGM_CHECK);

[Severity: Medium]
Setting this flag here is what enables the problematic code path in
show_code() during early boot.

Does there need to be an additional check before calling get_trap_ip() or
dereferencing current, to ensure the system is fully initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D8
