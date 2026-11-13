Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590687;
	b=P2AXOFc2yZMFSa04NUnB1GKuDjxwRthvYkn5AldKiWwdyRUs9aCZgbpmXzUZZcveAHeM
	 +HsgvRBVr85iqUA19WnJm1GZZPaUJQVRmAlbnuD3SwEivYOMbs+yOYDYuk2j4VTCvrMHb
	 unOAcfj1ULiOg01T0cH16EZ7RztasXRa5QPta0i2mXGffeCiNa7e9Pb8OyPzt75L2U0B2
	 JGzTgxer47t2HCNYlT731pWWBDCTTjc60kWnst7kU7/K1xvQSLNDC9Cfm16BasEMP8Er5
	 cckBXePCsz0gc8U+HA26+J6EhbdJ6d1GjNoka+p6cQUiVMCAlRWsMomgtIeM3CQO0Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590687;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q7arucSm+78qFdMEupCF+3S92mCCl5KHMf06gu80zrc=;
	b=N3zi3Y97D88uEOosQ+l3GT2mJsUaxp3AwCT/+0JLCKeCz7Pk5cZCUnTFMoCg2peR4qCA
	 SJgm5XSdA0XviyRolnJJq0j1ukHTBc+6JXyeM/W7rlLdoE2Hdd75bQ+T7ck7YHI0+Uxcw
	 X+CUVifwBxN1KNNDTpyNIxaBkSPP0fMvoPvIEECHt427oObC0BEbP7yCZlP3cmJbfgRMU
	 qSLdMk6bH45FKK+mUEPmj8/kRHjakq6yaz1NMPCbPP+lS9N9QgY2vuokZADlHuB+rGFAE
	 FNtSkOrCA8pRMEZg4nS2aykTHQm/xvzF+imRJmuR18BKAMhOaRLnn2SI1LYgU/ukJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoCD6VZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C98606CEE2
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoCD6VZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6612A1F000CA;
	Fri, 13 Nov 2026 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590686;
	bh=q7arucSm+78qFdMEupCF+3S92mCCl5KHMf06gu80zrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoCD6VZEkcjMfbzgHkbl3ZMr+LMDjHuuTO6flXz7vFwrWz8to6tU4Z9A80K9ci4xi
	 gTaNKn0bgsfj+TNhQ7FHBvAbzYDvYR6YX//bSp9XT/Du68K9qKxsAzDVgDncrnkl8c
	 rEt8hAvjjBKFTr0y3es6J6HA+s3jOcdcAXk+pxnWJrBqjECMEgwjARWjfhZuCzA+1S
	 DXkWMzGIIJjzQD/IGho32d9pnIeMkJy6EWwdpT3gDX6DiwWpXuEbAFVrvm0QJkYAGs
	 w9Q95OePkY9/4V7uZT6S20/8Iw4hdNqWIBVa9MpWLfmRyWZz1uLljVhNi8RyLaGIbm
	 f/xcX5sM5ROBA==
Message-ID: <sashiko-outbox-213302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall
 skipping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113165509.229869-3-renzo@cs.unibo.it>
References: <20261113165509.229869-1-renzo@cs.unibo.it>
 <20261113165509.229869-3-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:24:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] ptrace: ptrace_set_syscall_info_seccomp_skip() breaks syscall
  skip on powerpc
- [Medium] ptrace: stale SECCOMP op in ptrace_get_syscall_info_op()
  after syscall skip
--

commit 8c9888f26aefc1ee67703974a37b40daf729c189
Author: Renzo Davoli <renzo@cs.unibo.it>

ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support

This commit extends PTRACE_SET_SYSCALL_INFO to allow a tracer at a
PTRACE_SYSCALL_INFO_SECCOMP stop to skip the system call and set its return
value by changing info.op to PTRACE_SYSCALL_INFO_EXIT.

> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 3f2fe68ccb140..7630fcd398105 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c

[ ... ]

> @@ -1119,12 +1120,35 @@ ptrace_set_syscall_info_exit(struct task_struct *=
child, struct pt_regs *regs,
>  	return 0;
>  }
> =20
> +/*
> + * Skip the system call at a PTRACE_SYSCALL_INFO_SECCOMP stop and set its
> + * return value as specified by info->exit.
> + *
> + * The skip request is passed to seccomp out of band instead of by setti=
ng
> + * the system call number to -1: on some architectures the syscall numbe=
r,
> + * or the register seccomp reads it from, shares a register with the ret=
urn
> + * value, and on others -1 cannot be represented as a syscall number.
> + */
> +static int
> +ptrace_set_syscall_info_seccomp_skip(struct task_struct *child,
> +				     struct pt_regs *regs,
> +				     struct ptrace_syscall_info *info)
> +{
> +	int ret =3D ptrace_set_syscall_info_exit(child, regs, info);
> +
> +	if (!ret)
> +		seccomp_ptrace_skip_syscall(child);
> +
> +	return ret;
> +}

[Severity: High]
Does calling ptrace_set_syscall_info_exit() -> syscall_set_return_value() f=
rom
a seccomp stop work on powerpc?

arch/powerpc/include/asm/syscall.h:syscall_set_return_value() {
    ...
	set_thread_flag(TIF_SYSCALL_RET);
}

arch/powerpc/kernel/syscall.c:system_call_exception() {
	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
			test_thread_flag(TIF_SYSCALL_RET))) {
		clear_thread_flag(TIF_SYSCALL_RET);
		return syscall_get_error(current, regs);
	}
    ...
}

Because syscall_set_return_value() calls set_thread_flag(TIF_SYSCALL_RET)
rather than set_tsk_thread_flag(task, TIF_SYSCALL_RET), calling it from the
tracer sets TIF_SYSCALL_RET on current (the tracer), causing
system_call_exception() to skip the tracer's next system call (such as
PTRACE_CONT) and return 0.

In addition, when the tracee resumes from the skipped seccomp stop with a
non-error return value (info->exit.is_error =3D=3D 0), system_call_exceptio=
n()
returns syscall_get_error(current, regs), which is 0 when no error is set, =
and
syscall_exit_prepare() overwrites regs->gpr[3] with that 0, clobbering the
return value set by the tracer.

> =20
>  static int
>  ptrace_set_syscall_info(struct task_struct *child, unsigned long user_si=
ze,
>  			const void __user *datavp)
>  {
>  	struct pt_regs *regs =3D task_pt_regs(child);
>  	struct ptrace_syscall_info info;
> +	int op;
> =20
>  	if (user_size < sizeof(info))
>  		return -EINVAL;
> @@ -1141,8 +1165,25 @@ ptrace_set_syscall_info(struct task_struct *child,=
 unsigned long user_size,
>  	if (info.flags || info.reserved)
>  		return -EINVAL;
> =20
> -	/* Changing the type of the system call stop is not supported yet. */
> -	if (ptrace_get_syscall_info_op(child) !=3D info.op)
> +	op =3D ptrace_get_syscall_info_op(child);
> +
> +	/*
> +	 * Changing the type of the system call stop is not supported, except
> +	 * that a PTRACE_SYSCALL_INFO_SECCOMP stop can be turned into a
> +	 * PTRACE_SYSCALL_INFO_EXIT one to skip the system call and set its
> +	 * return value.  Once that is done, the system call number and
> +	 * arguments cannot be changed anymore during the same stop, as the
> +	 * return value might share registers with them.
> +	 */
> +	if (op =3D=3D PTRACE_SYSCALL_INFO_SECCOMP) {
> +		if (info.op =3D=3D PTRACE_SYSCALL_INFO_EXIT)
> +			return ptrace_set_syscall_info_seccomp_skip(child, regs,
> +								    &info);
> +		if (seccomp_ptrace_syscall_skipped(child))
> +			return -EINVAL;
> +	}

[Severity: Medium]
Should ptrace_get_syscall_info_op() also return PTRACE_SYSCALL_INFO_EXIT on=
ce
seccomp_ptrace_syscall_skipped(child) is true?

Right now, ptrace_get_syscall_info_op() continues to return
PTRACE_SYSCALL_INFO_SECCOMP for SIGTRAP | (PTRACE_EVENT_SECCOMP << 8) even
after the syscall has been skipped.  If the tracer calls
PTRACE_GET_SYSCALL_INFO later during the same stop, ptrace_get_syscall_info=
()
still reports op =3D=3D PTRACE_SYSCALL_INFO_SECCOMP and populates info.secc=
omp from
pt_regs whose syscall number or argument registers may already have been
overwritten by syscall_set_return_value(), and passing that structure back =
to
PTRACE_SET_SYSCALL_INFO fails with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113165509.2298=
69-1-renzo@cs.unibo.it?part=3D2
