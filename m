Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793410366;
	b=Q5WXpIruZ2ueKH5D184ROHkY5Bwic+0GT3dwwYFURp5Ss0xvEv5fursXHSP/78YF/o8/
	 Hcw2cYNEx4xUMxFgt3D2XAJhKLiHqJFpxcNfBVqyq8YdbFCDC7PEfwte9PcAOydRlneOO
	 5XSEMWVe2zKQ13S8Ir9JtCnq46gdNADZeTt5VQ4GCw//icpPQ9r4QrhL6uPkczDTdfqz5
	 IQkUzqxl6sseqy9cji21wAC1FoLnsA2Z952WwjsWA3asl9UYTUja0ICJvcsXaaNy+7xht
	 fsBPdGQmUOnAo3pp3t322gZHUvKKHyoFGYkRK51zPPVP2wHCJ9CYGrpmOjzmMBDAR1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GEkzvAL/4KdJas9NXUiUXBpT4XGk/dMi/5YD/tf5gEs=;
	b=X3z+Eh9ltjyLjrtQtNFinvWCzsxDw+RacPQ/eoDK0dPVhrKJwseHJJ8et1Bau4APN1CV
	 ZLqR8gliycHvYw18nq+TOOpQNnocpgpxVojDwpfq7sOj2GOmLnfN3t7Tl6Fo7o8O4oXJp
	 kDufxwkJAf1Rj3SUERCuWIxNbLnejRCYwknHZos3znt8JfzBUOhlspvnmRqBWJIYuuHMk
	 jonPjo/92zXOneH59OXFRTG+OZm9pDPD4nUNAuMl789Gxmtj27HikD0BEmlWnK+T03so1
	 pzCyqOYPxvk0AMdDchzJOGXenhs1LABhZsc5EbQkjW/bBw1gcHVY0kZt4ItecYQ4BBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIkgyQlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F96606A31C;
	Sat, 31 Oct 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIkgyQlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE33F1F000C1;
	Sat, 31 Oct 2026 01:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793410366;
	bh=GEkzvAL/4KdJas9NXUiUXBpT4XGk/dMi/5YD/tf5gEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VIkgyQlvfQvpGvKJKwzT9NDPMiuBRWbWBg56sp6aXJZZbO+e7Yux6LCtZboeqCOi4
	 wYWlFXow03qcJUZhJw4cih1v4J/9mgPL0DzGK00R4sYRTaOFq9ZL04KmuR0PwQjwpH
	 4pToAlHszyXZyMmGpinJdEYeig+YQo97ThuSzd0odYBtdZ0awzqYjgVQtdXA9B1rV5
	 iw3NHfWuWC0ONZXqfuR6sTPCNWnHO5L9cWN8O4mu+NlzVHGG7Rp9ANPkEbkM7j96FY
	 kWeq0Bz0AkKeKBop9An7iayR2Hd41r+EAUl38GRX4Tv1HfKX9UyRTmJ9ESbpusvb+q
	 W0GCrdhLWGoWg==
Message-ID: <sashiko-outbox-191692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/entry: Fix ptrace regression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Gleixner" <tglx@kernel.org>
Cc: linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <87mrrvxaty.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com> <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 01:32:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/entry: missing nr !=3D -1L check in do_syscall_32_irqs_on()
--

commit 99103a6b0e601cd2293cec25712d5b3e23db9efc
Author: Thomas Gleixner <tglx@kernel.org>

x86/entry: Fix ptrace regression

This commit restores the historical syscall entry behavior of preserving
tracer modifications to regs->ax when a syscall is aborted with -1L while
overwriting regs->ax with -ENOSYS when the syscall number is rewritten to an
invalid value.

Closes: https://lore.kernel.org/all/20261022142425.3Wx-RrU5@linutronix.de

> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index a59509bb460ab..1f91444d01a8e 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -77,6 +77,8 @@ static __always_inline void do_syscall_32_irqs_on(struc=
t pt_regs *regs, unsigned
>  	if (likely(nr < IA32_NR_syscalls)) {
>  		nr =3D array_index_nospec(nr, IA32_NR_syscalls);
>  		regs->ax =3D ia32_sys_call(regs, (unsigned int)nr);
> +	} else {
> +		regs->ax =3D -ENOSYS;
>  	}
>  }

[Severity: High]
Should the else branch in do_syscall_32_irqs_on() in
arch/x86/entry/syscall_32.c also check that nr !=3D -1L before setting
regs->ax =3D -ENOSYS, matching the check added to do_syscall_64() in
arch/x86/entry/syscall_64.c and the logic prior to commit 1b1f3b3e1b39
("x86/entry: Get rid of the sys_ni_syscall() indirection")?

When a 32-bit syscall (entered via do_int80_emulation(),
fred_int80_emulation(), do_int80_syscall_32(), or __do_fast_syscall_32()) is
traced with PTRACE_SYSCALL without SYSCALL_WORK_SYSCALL_EMU,
syscall_enter_from_user_mode_work() runs:

include/linux/entry-common.h:syscall_enter_from_user_mode_work() {
    ...
	if (unlikely(!syscall_trace_enter(regs, work, *syscall)))
		return false;

	/* Reread the syscall number as it might have been modified */
	*syscall =3D syscall_get_nr(current, regs);

	return true;
}

If the tracer aborts the syscall at the syscall-entry stop by setting
orig_ax to -1 and writing a return value into regs->ax,
syscall_trace_enter() -> arch_ptrace_report_syscall_permit_entry() ->
ptrace_report_syscall_permit_entry() returns true (unless a fatal signal is
pending). syscall_enter_from_user_mode_work() then updates *syscall to -1L
and returns true.

The caller then passes nr =3D=3D (unsigned long)-1L into
do_syscall_32_irqs_on(), where nr < IA32_NR_syscalls is false and the
unconditional else branch overwrites the tracer-supplied regs->ax value with
-ENOSYS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/87mrrvxaty.ffs@fw13=
?part=3D1
