Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589251;
	b=d9AwAOsbcYi6PdrFh63koNPpstXS5wjAGC+ZrfYXPa9yIqKuBsqfCLnsnIg9SlQ0b/4A
	 iYlv150Dt2Rygxc8giYNMBf5bAwBD1fgMHckjXy4wgFT0ZKBvb4IxamT46jP6FiAmpmF8
	 U3EJ2OoLzby6vD6cTN3GdiexRNzEyBTsedzEOiUTFgVQw95xFG0czl/rGaScqm11uAP1l
	 SaGSdd+5CKa/rSk27hlbssp6qh8WSzxGRUnixs61wDitVL7PrwwEZ++F6/QmOdxRmAN/+
	 6uNLbD2HzwIc5fUOSHav6HH7O0C4kzl6w/Y+KF9t/AzGjuxDzFUh5lbXiYA0J0UcjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589251;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4z9Sa+JViCOTSakOD9HbpweO8YTLQtkt8xYTAZEBusI=;
	b=NymbiuQnE3BPUdjKbBz8r4FUBVFhxK40+PAcckSmtuFUn+x7q5s+CdmoLodbjk7J0/hl
	 l6xYO/V7JCHbYHhR49j3G8UZmSaXc30CjWl0CTfuGXHUxJlmjEJHGnHYUsIb3hdAld5Yg
	 q6DjtTBDKPJgLxWPPJVgUxeaYHcSTXOtvctj3obzCT0CABjs96kZ/CbHqewQTvSSFWObt
	 XAkW36eDRiMUaBcrlPC+Vu+nThHFXPRViXRPAPOvto+uoHkn2rQKe2F6ijrBm4MjJHSDM
	 RZj22lJDmOfurNrHdZPE8UTfdRQFpR3y0Dy/6GaSBGK5duJ9pYU4a0r6I5nxlpAMlew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QshswpSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85E606A31A
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QshswpSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3BA1F000C4;
	Wed, 21 Oct 2026 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792589251;
	bh=4z9Sa+JViCOTSakOD9HbpweO8YTLQtkt8xYTAZEBusI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QshswpSjWw5J3+OKjXz1KnVzzy1k//3rba5rs+qYYLS1PCf5VyIVOjFQF62KJgVVl
	 0QBia/xPj2GONzaYGzEaUjwFF8Bp03CoCtmUNpx5prGj7wpqZ4z4SL+qcRCMzY0xdW
	 IHma2gBl1W3HIn3kTcTITD8f2XfB1Ebsnzq21bmF6pBjCoUsUaA+8NiNaPkKJPKP4W
	 R0XWQes1cONpFJOuB6yQflmIrAn6WqLIAgSMsxtbRY258URu383tH//yEWfMeq1UoX
	 OsMH3vxfdIYik+CMF2t/2W5IsA9FmEf8IxTR32EkFBCQp/f8CrlgROWiCYRNJi8UTm
	 HEzLa50PCvgXA==
Message-ID: <sashiko-outbox-180303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] s390/syscall: Sign extend system call number
 retrieved via syscall_get_nr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021125911.1550331-1-hca@linux.ibm.com>
References: <20261021125911.1550331-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:27:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] s390/syscall: syscall_get_nr() sign extension skips -ENOSYS in __d=
o_syscall()
- [Medium] s390/syscall: inconsistent nr sign extension and return value in=
 __do_syscall()
--

commit 6009c1b6249f84606771eedb6feddc0743454bc7
Author: Heiko Carstens <hca@linux.ibm.com>

s390/syscall: Sign extend system call number retrieved via syscall_get_nr()

This commit sign-extends the 16-bit system call number in syscall_get_nr() =
on
s390 so that negative system call numbers such as -1 are returned as -1
instead of 65535. It also removes the s390-specific 16-bit mask workaround =
in
the ptrace set_syscall_info selftest.

> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/sysc=
all.h
> index 5f310caad1fce..c67eeca3f33a1 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -20,7 +20,7 @@ static inline long syscall_get_nr(struct task_struct *t=
ask,
>  				  struct pt_regs *regs)
>  {
>  	return test_pt_regs_flag(regs, PIF_SYSCALL) ?
> -		(regs->int_code & 0xffff) : -1;
> +		(s16)(regs->int_code & 0xffff) : -1;
>  }

[Severity: High]
When a system call is skipped under SECCOMP_RET_TRACE on s390, can this cau=
se
__do_syscall() to return the wrong value to userspace instead of -ENOSYS?

Previously, syscall_get_nr() returned an unsigned 16-bit value (65535 when =
nr
was set to -1), so after PTRACE_EVENT_SECCOMP in
kernel/seccomp.c:__seccomp_filter():

	/* Check if the tracer forced the syscall to be skipped. */
	this_syscall =3D syscall_get_nr(current, current_pt_regs());
	if (this_syscall < 0)
		goto skip;

this check was not taken on s390. syscall_enter_from_user_mode_work()
returned permit =3D true with nr =3D 65535, and arch/s390/kernel/syscall.c:
__do_syscall() set regs->gprs[2] =3D -ENOSYS before skipping the
sys_call_table dispatch.

With syscall_get_nr() now returning -1, __seccomp_filter() jumps to skip and
returns false without calling syscall_set_return_value(), so
syscall_enter_from_user_mode_work() returns permit =3D false. In
arch/s390/kernel/syscall.c:__do_syscall():

	regs->gprs[2] =3D nr;
	...
	permit =3D syscall_enter_from_user_mode_work(regs, &nr);
	...
	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET) || !pe=
rmit))
		goto out;
	regs->gprs[2] =3D -ENOSYS;

when permit is false, execution jumps to out before setting
regs->gprs[2] =3D -ENOSYS:

- If a tracer skips the syscall at PTRACE_EVENT_SECCOMP via
  PTRACE_SET_SYSCALL_INFO with nr =3D -1, syscall_set_nr() only updates
  regs->int_code and leaves regs->gprs[2] holding the original positive
  syscall number, returning that positive number to userspace.
- If the tracer skips the syscall via PTRACE_POKEUSR or PTRACE_SETREGSET by
  writing -1 to gprs[2], __poke_user() writes -1 into regs->gprs[2] without
  setting PIF_SYSCALL_RET_SET, returning -1 (-EPERM) instead of -ENOSYS.
- If userspace invokes syscall(-1) directly under a SECCOMP_RET_TRACE filter
  without the tracer modifying registers, regs->gprs[2] remains 65535 and is
  returned to userspace instead of -ENOSYS.

[Severity: Medium]
Should arch/s390/kernel/syscall.c:__do_syscall() and
arch/s390/include/asm/syscall.h:syscall_set_nr() also be updated to keep the
syscall number representation consistent with syscall_get_nr()?

In arch/s390/kernel/syscall.c:__do_syscall():

	nr =3D regs->int_code & 0xffff;
	if (likely(!nr)) {
		nr =3D regs->gprs[1] & 0xffff;
		regs->int_code &=3D ~0xffffUL;
		regs->int_code |=3D nr;
	}
	regs->gprs[2] =3D nr;

nr and regs->gprs[2] are still extracted as zero-extended 16-bit values. Wh=
en
userspace invokes a negative syscall number such as syscall(-1), regs->gprs=
[2]
(the ptrace ABI register for the syscall number at entry) and the initial nr
passed into syscall_enter_from_user_mode_work() are 65535 while
syscall_get_nr() and PTRACE_GET_SYSCALL_INFO report -1.

Similarly, in arch/s390/include/asm/syscall.h:syscall_set_nr():

	regs->int_code =3D (regs->int_code & ~0xffff) | (nr & 0xffff);

only regs->int_code is updated while regs->gprs[2] is left unchanged. If a
tracer modifies the syscall number via PTRACE_SET_SYSCALL_INFO, subsequent
reads via PTRACE_PEEKUSR or PTRACE_GETREGSET(NT_PRSTATUS) during syscall
entry still see the old syscall number in regs->gprs[2], and writing back
NT_PRSTATUS via PTRACE_SETREGSET overwrites regs->int_code with that stale
regs->gprs[2] value in __poke_user().

> =20
>  static inline void syscall_set_nr(struct task_struct *task,

[ ... ]

>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021125911.1550=
331-1-hca@linux.ibm.com?part=3D1
