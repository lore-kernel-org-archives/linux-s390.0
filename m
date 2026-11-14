Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681869;
	b=DV2EFIJbrtuJQp+CKr2E6SHvzNiw/9m/+U9RMq/58Sqs78zJx7K/gvkdIrRd1s3SW6mX
	 snworHcGZQPFvpGkTf4DeUB2aJskU2W1Pdtu0hSLGuqNqOdv3ZLRwS6PFn+YwroSsZc3S
	 6+3l/Nywvdg6l0Xfma/PLeg3aoIItsDMcIJGA6zx2+awi31jrM2QvQkcY+i0ioBH6SDmZ
	 gjKBVEUfpMexf8DAa/Cn7zaHr3BOQl+uHuxQ7Sc5YYGv+GrPnaiSmYfX4Asc/Jy3IlWKv
	 1CfQlu9/jON/ueb2A+pPBHoGLl11sFXLdZlXxIZzJp5DWJ3+/7xwM75ukc7aKU1MLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681869;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fr1dG/FFCTrWvTjxK8Y4u1acgGYTK2kcjlsb0UPgU7w=;
	b=2fvfrP/kn+vaa47i+Zfg1QLax186dOJC1M+DnaWNvDMgUQb0amg1Ord5QTjAS//sp1Cq
	 7st9fIG0DV2lhodYXe1vN/2jcPQB2m+ut40GT7XITgO1AnBUYDOy7oe8efYom/yzQt64S
	 zqWLQKuB4K+PVPIqrQjb+M7083SXzJmT3m5fD883ybh2dkEjNiWLfEO1ROfUawtfrzOuz
	 e1cjpyHo/WKHhCKczzWo3DUtx4bOTjGBLQmS1eY57Gf5Ui3kxb48mHguBXvOIbAaizaLW
	 NzK7SFJUU4KMw2OdU4Qi+oxyATOoGHfQcDNXfy5/W5OlLY3GPxTMBvYwvwb3Lo+fYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+3TF2NJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D1606A32D
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+3TF2NJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ED31F000C4;
	Sat, 14 Nov 2026 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681868;
	bh=fr1dG/FFCTrWvTjxK8Y4u1acgGYTK2kcjlsb0UPgU7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+3TF2NJkZC0DEFB93LwjpLdyrkGnk7BBvtocwsybWw0q20mxoJmFVx1zb17n/y36
	 ct0VU6LV0OLjv/JGecd7ej8B8QArvAtvHcKIs9QwlpYqFd7cTs00zRvxwXErzLR+05
	 DXs75Au2b49jbw5z5P3BgpAIZdE8fx8gwLY26vgisB869a9TdrDoHn/WNZCctxZHmS
	 3MAvBkJQijYrEK7kjSYJwXNK3VBrqX9rIBnpvEKuhpM4uusfEubzPCAagZTr4qWsQX
	 ZVyu1hG7qzegzAGyJWgvHKaRNv/rE1/vsmi4XVluSmKu2OLmT0hQ0wJuvJisF9o6Re
	 YFn23CS03BlZw==
Message-ID: <sashiko-outbox-214908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall
 skipping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114181923.370930-3-renzo@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-3-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:44:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] ptrace: ptrace_set_syscall_info_seccomp_skip() breaks syscall
  skip on powerpc
--

commit 18172201986e4a2acbcbbd3f1822583db8925569
Author: Renzo Davoli <renzo@cs.unibo.it>

ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support

This commit extends PTRACE_SET_SYSCALL_INFO to allow a tracer to skip a
system call at a PTRACE_SYSCALL_INFO_SECCOMP stop by changing the operation
to PTRACE_SYSCALL_INFO_EXIT and specifying the return value.

> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 3f2fe68ccb140..ab6f5dab02238 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c

[ ... ]

> @@ -1119,12 +1128,35 @@ ptrace_set_syscall_info_exit(struct task_struct *=
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
Does calling ptrace_set_syscall_info_exit() from the tracer while the tracee
is stopped at PTRACE_EVENT_SECCOMP break both the tracer and the tracee on
powerpc?

ptrace_set_syscall_info_exit() calls syscall_set_return_value(child, regs,
...), which on powerpc sets TIF_SYSCALL_RET on current rather than on task:

arch/powerpc/include/asm/syscall.h:syscall_set_return_value() {
    ...
	/*
	 * We are returning from the syscall, so anything that
	 * depends on the regs being in the entry state is now invalid.
	 */
	set_thread_flag(TIF_SYSCALL_RET);
}

Because ptrace_set_syscall_info_seccomp_skip() runs in the tracer's task
context, TIF_SYSCALL_RET is set on the tracer.  On the tracer's next system
call (such as PTRACE_GET_SYSCALL_INFO or PTRACE_CONT),
system_call_exception() sees TIF_SYSCALL_RET set, clears it, and returns
syscall_get_error(current, regs) (0) without executing the system call:

arch/powerpc/kernel/syscall.c:system_call_exception() {
    ...
	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
			test_thread_flag(TIF_SYSCALL_RET))) {
		clear_thread_flag(TIF_SYSCALL_RET);
		return syscall_get_error(current, regs);
	}
    ...
}

In addition, when the tracee resumes from the skipped seccomp stop,
syscall_enter_from_user_mode_randomize_stack() returns false and
system_call_exception() returns syscall_get_error(current, regs), which
syscall_exit_prepare() writes into regs->gpr[3].  When info->exit.is_error =
is
0, syscall_get_error() returns 0, overwriting any non-error return value set
by the tracer in regs->gpr[3].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114181923.3709=
30-1-renzo@cs.unibo.it?part=3D2
