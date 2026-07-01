Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371964BCADC
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928695; cv=none; b=lkA7uJ8A/QsKRg7EmqlXJGWBiRaTzlQejdQG/6XFfN+G2mbVKqf5sAxW1QgXGW0ZkuOt0IQFXDQIDRVcHI/VB46gly2M+4vdQe4S7cj7nhJBpyXwOWgT5cUVUw4dUddbZqERFX/niq7brEG+efUYMS+tWRwCntQNSTotkYNNwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928695; c=relaxed/simple;
	bh=/kZdbhMl8Iu70a74v1ut7CLDrGaH1olnfQJ46U1pi/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/7eb0nsDN7w2B0sVAtqpYLdQKNqQcySgv9w0r7Jt8xCbLUX+Id62CeSVR7QaI0AKSyGpJMz1w0r8pNySo1wI3tGawJaXy6l5kfyR0abugnyHb01gt2blp//DitgayqSnDbgjWdzLNOnFwVXxEWxLDgjDHyb9mT5nrYNnEqqYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+Ca9qS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+Ca9qS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B051F00A3A;
	Wed,  1 Jul 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782928693;
	bh=S1l2yxdNmNze3XYApNCu4UkAVz0i5XMKjb5uQ4b+JJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+Ca9qS5g39Dw7S0uPGmZabAg2wwDsrRYHZv6SwmR+8cCUCXfINAHb5uIR9fVEytw
	 cvLEBsEZANgxlKGT/IQpH0Pke5aMM9WvywL3rxOUkWMsC/wWc7ZYv9iCowxxUSqXdO
	 w/vsb+TJM7UoOiKKxaU2k6RBWd08L5fZmKAvgoYRDu/fnIJq3KlsHUFK+cnhV0pot9
	 WrKiqZAL23xMzKTv9CY3T+RzfXypWF9TaXwO2R29xia6fZ8JSTpIWJTJEo3w0owCLS
	 RgXAJGlpeadoeRJCtX+MSc8ua7Ov6Y/drESApzgrD8acSx9ySfHJAG3IpcC5SUf6p4
	 lSVKxE/XWNUWA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 17:58:12 +0000
Message-Id: <20260701175813.83B051F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] System call execution is entirely omitted in non-FRED `do_int8=
0_emulation`.
- [High] Incompatible pointer types passed to generic entry APIs cause `-We=
rror=3Dincompatible-pointer-types` build failures across multiple architect=
ures.
- [High] Syntax error due to taking the address of an rvalue macro expansio=
n.
- [High] `add_random_kstack_offset()` is called before RCU is watching, vio=
lating context tracking and `noinstr` bounds.
- [High] Aborted system calls fail to return the default `-ENOSYS` on s390 =
and PowerPC.
- [High] The function definition for `do_syscall_64` was changed but its he=
ader declaration was not, causing a conflicting types compiler error.
--

commit cc1ccd5571695deb44c86f464ec406994af66997
Author: Michal Such=C3=A1nek <msuchanek@suse.de>

entry: Untangle the return value of syscall_enter_from_user_mode from sysca=
ll NR

The return value of syscall_enter_from_user_mode is used both for the adjus=
ted
syscall number and the indicator that a syscall should be skipped. This pat=
ch
passes the syscall number as a pointer to the inline entry functions, and u=
ses
the return value exclusively for the indication that the syscall is already
handled.

> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa87..45d11d518c517 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -20,7 +20,8 @@ notrace long system_call_exception(struct pt_regs *regs=
, unsigned long r0)
>  	syscall_fn f;
> =20
>  	add_random_kstack_offset();
> -	r0 =3D syscall_enter_from_user_mode(regs, r0);
> +	if (unlikely(syscall_enter_from_user_mode(regs, &r0)))

[Severity: High]
Will passing an unsigned long pointer to a function expecting a long pointer
cause an incompatible pointer type build failure?

Also, if a tracer aborts the syscall, will this return the unmodified regis=
ter
state via syscall_get_error() instead of falling through to assign -ENOSYS?

Tracer filters that abort without injecting a return value generally expect
the system call to naturally return -ENOSYS.

> +		return syscall_get_error(current, regs);

> diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
> index 75d5a3cab14e6..9e5b873c011d7 100644
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -121,7 +121,7 @@ void noinstr __do_syscall(struct pt_regs *regs, int p=
er_trap)
>  		regs->psw.addr =3D current->restart_block.arch_data;
>  		current->restart_block.arch_data =3D 1;
>  	}
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> +	ret =3D syscall_enter_from_user_mode_work(regs, &nr);
>  	/*
>  	 * In the s390 ptrace ABI, both the syscall number and the return value
>  	 * use gpr2. However, userspace puts the syscall number either in the
> @@ -129,7 +129,7 @@ void noinstr __do_syscall(struct pt_regs *regs, int p=
er_trap)
>  	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked here
>  	 * and if set, the syscall will be skipped.
>  	 */
> -	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
> +	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET) || =
ret))
>  		goto out;
>  	regs->gprs[2] =3D -ENOSYS;

[Severity: High]
If ret is non-zero, this skips the -ENOSYS assignment and branches directly=
 to
out.

Could this leak the syscall number as the return value to userspace if a
tracer aborts the syscall without injecting a return value?

> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index 31b9492fe851d..525e99691b312 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -168,8 +168,7 @@ __visible noinstr void do_int80_emulation(struct pt_r=
egs *regs)
>  	nr =3D syscall_32_enter(regs);
> =20
>  	local_irq_enable();
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> -	do_syscall_32_irqs_on(regs, nr);
> +	syscall_enter_from_user_mode_work(regs, &nr);
> =20

[Severity: Critical]
Is it intentional to omit the system call execution here?

It looks like do_syscall_32_irqs_on was deleted without replacement, which
might cause system calls using int 0x80 to silently fail to execute on
non-FRED kernels.

>  	instrumentation_end();
>  	syscall_exit_to_user_mode(regs);

[ ... ]

> @@ -245,20 +246,17 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>  /* Handles int $0x80 on a 32bit kernel */
>  __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
>  {
> -	int nr =3D syscall_32_enter(regs);
> -
> -	/*
> -	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
> -	 * orig_ax, the int return value truncates it. This matches
> -	 * the semantics of syscall_get_nr().
> -	 */
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> -	instrumentation_begin();
> +	long nr =3D syscall_32_enter(regs);
> =20
>  	add_random_kstack_offset();
> -	do_syscall_32_irqs_on(regs, nr);
> +	if (!syscall_enter_from_user_mode(regs, &nr)) {

[Severity: High]
Does calling add_random_kstack_offset() before syscall_enter_from_user_mode=
()
violate context tracking and noinstr bounds?

syscall_enter_from_user_mode() internally calls enter_from_user_mode(),
which informs RCU that the CPU is back in the kernel.

Accessing RCU-protected variables before this happens could trigger PROVE_R=
CU
warnings.

> +		instrumentation_begin();
> =20
> -	instrumentation_end();
> +		nr &=3D & GENMASK(31, 0);

[Severity: High]
Does this cause a syntax error during compilation?

It appears to take the address of an rvalue macro expansion, which might
result in an lvalue required as unary & operand error.

> +		do_syscall_32_irqs_on(regs, nr);
> +
> +		instrumentation_end();
> +	}
>  	syscall_exit_to_user_mode(regs);
>  }

[ ... ]

> @@ -301,10 +299,9 @@ static noinstr bool __do_fast_syscall_32(struct pt_r=
egs *regs)
>  		return false;
>  	}
> =20
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> -
> -	/* Now this is just like a normal syscall. */
> -	do_syscall_32_irqs_on(regs, nr);
> +	if (!syscall_enter_from_user_mode_work(regs, &nr))

[Severity: High]
Since nr is defined as an int earlier in __do_fast_syscall_32:

	int nr =3D syscall_32_enter(regs);

Could passing it to syscall_enter_from_user_mode_work, which expects a long
pointer, cause an incompatible pointer types build failure?

> +		/* Now this is just like a normal syscall. */
> +		do_syscall_32_irqs_on(regs, nr);

> diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> index 71f032504e731..3400c2f43a62f 100644
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -84,19 +84,20 @@ static __always_inline bool do_syscall_x32(struct pt_=
regs *regs, int nr)
>  }
> =20
>  /* Returns true to return using SYSRET, or false to use IRET */
> -__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> +__visible noinstr bool do_syscall_64(struct pt_regs *regs, long nr)

[Severity: High]
Will changing this definition to take a long cause a conflicting types build
failure, since the header declaration in arch/x86/include/asm/syscall.h sti=
ll
declares it with an int parameter?

>  {
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> -
> -	instrumentation_begin();
>  	add_random_kstack_offset();
> +	if (!syscall_enter_from_user_mode(regs, &nr)) {

[Severity: High]
Could placing add_random_kstack_offset() before syscall_enter_from_user_mod=
e()
cause PROVE_RCU warnings here as well?

> =20
> -	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr !=3D -=
1) {
> -		/* Invalid system call, but still a system call. */
> -		regs->ax =3D __x64_sys_ni_syscall(regs);
> -	}

> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 416a3352261fe..4991071d01fed 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -69,10 +69,8 @@ static inline void syscall_enter_audit(struct pt_regs =
*regs, long syscall)
>  	}
>  }
> =20
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work, unsigned long *syscall)
>  {

[ ... ]

> @@ -139,14 +135,14 @@ static __always_inline long syscall_trace_enter(str=
uct pt_regs *regs, unsigned l
> -static __always_inline long syscall_enter_from_user_mode_work(struct pt_=
regs *regs, long syscall)
> +static __always_inline long syscall_enter_from_user_mode_work(struct pt_=
regs *regs, long *syscall)
>  {
>  	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_work);
> =20
>  	if (work & SYSCALL_WORK_ENTER)
> -		syscall =3D syscall_trace_enter(regs, work);
> +		return syscall_trace_enter(regs, work, syscall);

[Severity: High]
Could passing a long pointer to syscall_trace_enter, which expects an unsig=
ned
long pointer, result in an incompatible pointer type build failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/akVRcPsD_R_CE1qW@ku=
nlun.suse.cz?part=3D1
