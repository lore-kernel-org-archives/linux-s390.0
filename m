Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8236A022;
	Tue, 14 Jul 2026 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055482; cv=none; b=EpotfqoKJKHiC3g0b9bZy/v3kjse+d6BFYRju4w2vC6qiLcNH7hkWnisl0XS4AcvIdgcfAZUHRfhyoASziZvuWxHZENcnTaAfuB4WXSSXAlRw4BX6PAfs8cS36dGo7IBHlQlRj5kjz6d0zNCxUgIcCY37neCXMzGfwAXjAQTMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055482; c=relaxed/simple;
	bh=4jYhO1//W5jrcY+SJFKC3A7WGIgGEQLpvPHnyKFOGsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8tMbNS9khUdXGnItfv0YvQHEJAjc72SlXpQY5gPEgDh0ql1pX81gRldMDGQRSJR3xxbPxn5hx3nb7IU+TZ0z09At/c6GEDVQO6ErvQp/yUNCc6xu/JVKtQqgP/WdydGdc5oPgOHOsJPNMSa7AMeqQIqBhNzZrIzQK0zA6J5ouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=vVWaTmPf; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="vVWaTmPf"
Received: from bat.kanata.rendec.net (unknown [24.114.103.87])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 43614C2A88;
	Tue, 14 Jul 2026 21:57:45 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 43614C2A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1784055476;
	bh=rA5MDGxT4TvlBPI8rCIT4YVPzlsSvdsP3lxcCVyTIKQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vVWaTmPfOJk9gq5hHsN3nvtphcqSGgGhfDwbUDi10K8hF4lqNJqXCOV2mjG6z7VqZ
	 FZcupsG3m+lHKZPA/pscH5pGL0MMOcDZmaCJHK5MY48zUAFZ7ICg84mzakkPnyZICh
	 bK5Hwr/7hs0vE0AQdQGzIv/BJLEBmkh/m6sqouv1yX37iolfZatrvIkuROJY4YcajG
	 s61tJ8fPvCeFSw72lmqL99F7fmoWjDhUKRtGZTQgo5Sx55V26l97tAuewBbtGVA0jZ
	 qNWK2467NaYmSlXLKJKatLJyGkZADhvbL4XxQkdj5PlsmTXpKTTPDH2d2CzMuqUFCL
	 JnHEjHrgQ6ZEA==
Message-ID: <e35a11d2bd1a8dfa6c1b8d67fe2940c3fd507596.camel@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Michael Ellerman
	 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt	
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle	
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland	 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm	 <linmag7@gmail.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>,  Jonathan Corbet	 <corbet@lwn.net>
Date: Tue, 14 Jul 2026 14:57:41 -0400
In-Reply-To: <20260712141346.772209074@kernel.org>
References: <20260712134433.549076055@kernel.org>
	 <20260712141346.772209074@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-07-12 at 23:25 +0200, Thomas Gleixner wrote:
> The return values of syscall_enter_from_user_mode[_work]() are
> non-intuitive. Both functions return the syscall number which should be
> invoked by the architecture specific syscall entry code. The returned
> number can be:
>=20
> =C2=A0 - the unmodified syscall number which was handed in by the caller
>=20
> =C2=A0 - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
>=20
> That has an additional twist. If the return value is -1L then the caller =
is
> not allowed to modify the return value as that indicates that the modifyi=
ng
> entity requests to abort the syscall and set the return value already. Th=
at
> can obviously not be differentiated from a syscall which handed in -1 as
> syscall number.
>=20
> The most trivial way to deal with that is:
>=20
> =C2=A0=C2=A0=C2=A0 set_return_value(regs, -ENOSYS);
> =C2=A0=C2=A0=C2=A0 nr =3D syscall_enter_from_user_mode(regs, nr);
> =C2=A0=C2=A0=C2=A0 if (valid(nr))
> =C2=A0=C2=A0=C2=A0=C2=A0	handle_syscall(regs, nr);
>=20
> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> preset the return value, so when user space hands in -1 and there is
> nothing setting the return value in the entry work code, then the syscall
> is skipped but the return value is whatever random data has been in the
> return value register.
>=20
> Change the return values of syscall_enter_from_user_mode[_work]() to
> boolean and return false, when either ptrace or seccomp request to skip t=
he
> syscall. If they return true, update the syscall number as it might have
> been changed.
>=20
> That results in slightly different behaviour of the architectures versus
> tracing.
>=20
> If the syscall tracepoint has probe/BPF attached, those might set the
> syscall number to -1 and also set the return value. PowerPC and S390 will
> then overwrite that value with -ENOSYS. The other architectures will just
> ignore it like any other invalid syscall and use the modified one.
>=20
> Originally-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> V2: Change the return logic so Power and S390 can insist on being special=
.
> ---
> =C2=A0Documentation/core-api/entry.rst |=C2=A0=C2=A0 45 +++++++++++++++++=
+++++++++++++---------
> =C2=A0arch/loongarch/kernel/syscall.c=C2=A0 |=C2=A0=C2=A0 14 ++++++------
> =C2=A0arch/powerpc/kernel/syscall.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 3 +-
> =C2=A0arch/riscv/kernel/traps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 11 ++++-----
> =C2=A0arch/s390/kernel/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 7 ++++--
> =C2=A0arch/x86/entry/syscall_32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 25 ++++++++++-----------
> =C2=A0arch/x86/entry/syscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 12 +++++-----
> =C2=A0include/linux/entry-common.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
32 +++++++++++++--------------
> =C2=A08 files changed, 88 insertions(+), 61 deletions(-)

I've been staring at this for a while. My only concern is that for
powerpc and s390, which do not set a default return value, the return
value is no longer forced to -ENOSYS for the cases when
syscall_trace_enter() returns False. Previously, it was turned into a -
1 in syscall_enter_from_user_mode_work() and interpreted as a syscall
number, so the architecture specific code took the invalid syscall
number path where it set the return value to -ENOSYS explicitly.

That implies that in all 3 cases when syscall_trace_enter() returns
False, the underlying function that denied the syscall *must* also set
the syscall return value (or deliver a signal or rollback the syscall),
or else the return value would be junk. That *seems* to be the case as
far as I can tell, but the ramifications are quite deep, and I must
admit I don't fully understand everything.

With that said,

Reviewed-by: Radu Rendec <radu@rendec.net>

> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -58,26 +58,51 @@ state transitions must run with interrup
> =C2=A0Syscalls
> =C2=A0--------
> =C2=A0
> -Syscall-entry code starts in assembly code and calls out into low-level =
C code
> -after establishing low-level architecture-specific state and stack frame=
s. This
> -low-level C code must not be instrumented. A typical syscall handling fu=
nction
> -invoked from low-level assembly code looks like this:
> +Syscall-entry code starts in assembly code and calls out into low-level =
C
> +code after establishing low-level architecture-specific state and stack
> +frames. This low-level C code must not be instrumented. The recommended
> +syscall handling function invoked from low-level assembly code looks lik=
e
> +this:
> =C2=A0
> =C2=A0.. code-block:: c
> =C2=A0
> -=C2=A0 noinstr void syscall(struct pt_regs *regs, int nr)
> +=C2=A0 noinstr void syscall(struct pt_regs *regs, long nr)
> =C2=A0=C2=A0 {
> =C2=A0	arch_syscall_enter(regs);
> -	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> +	result_reg(regs) =3D -ENOSYS;
> +	if (syscall_enter_from_user_mode_randomize_stack(regs, &nr)) {
> +		instrumentation_begin();
> +		if (valid(nr)
> +			result_reg(regs) =3D invoke_syscall(regs, nr);
> +		instrumentation_end();
> +	}
> +	syscall_exit_to_user_mode(regs);
> +=C2=A0 }
> =C2=A0
> -	instrumentation_begin();
> -	if (!invoke_syscall(regs, nr) && nr !=3D -1)
> -	=C2=A0	result_reg(regs) =3D __sys_ni_syscall(regs);
> -	instrumentation_end();
> +This is the most resilent variant as it has always a guaranteed valid
> +return code. The alternative variant is:
> +
> +.. code-block:: c
> =C2=A0
> +=C2=A0 noinstr void syscall(struct pt_regs *regs, long nr)
> +=C2=A0 {
> +	arch_syscall_enter(regs);
> +	if (syscall_enter_from_user_mode_randomize_stack(regs, &nr)) {
> +		instrumentation_begin();
> +		if (valid(nr)
> +			result_reg(regs) =3D invoke_syscall(regs, nr);
> +		else
> +			result_reg(regs) =3D -ENOSYS;
> +		instrumentation_end();
> +	}
> =C2=A0	syscall_exit_to_user_mode(regs);
> =C2=A0=C2=A0 }
> =C2=A0
> +That works for most situations except when a probe/BPF attached to the
> +syscall tracepoint sets an invalid syscall number e.g. -1 and also modif=
ies
> +the result register. So this variant will obviously overwrite the modifi=
ed
> +result with -ENOSYS.
> +
> =C2=A0syscall_enter_from_user_mode_randomize_stack() first invokes
> =C2=A0enter_from_user_mode_randomize_stack() which establishes state in t=
he
> =C2=A0following order:
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -57,8 +57,8 @@ typedef long (*sys_call_fn)(unsigned lon
> =C2=A0
> =C2=A0void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
> =C2=A0{
> -	unsigned long nr;
> =C2=A0	sys_call_fn syscall_fn;
> +	unsigned long nr;
> =C2=A0
> =C2=A0	nr =3D regs->regs[11];
> =C2=A0	/* Set for syscall restarting */
> @@ -69,12 +69,12 @@ void noinstr __no_stack_protector do_sys
> =C2=A0	regs->orig_a0 =3D regs->regs[4];
> =C2=A0	regs->regs[4] =3D -ENOSYS;
> =C2=A0
> -	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> -
> -	if (nr < NR_syscalls) {
> -		syscall_fn =3D sys_call_table[array_index_nospec(nr, NR_syscalls)];
> -		regs->regs[4] =3D syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[=
6],
> -					=C2=A0=C2=A0 regs->regs[7], regs->regs[8], regs->regs[9]);
> +	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
> +		if (nr < NR_syscalls) {
> +			syscall_fn =3D sys_call_table[array_index_nospec(nr, NR_syscalls)];
> +			regs->regs[4] =3D syscall_fn(regs->orig_a0, regs->regs[5], regs->regs=
[6],
> +						=C2=A0=C2=A0 regs->regs[7], regs->regs[8], regs->regs[9]);
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	syscall_exit_to_user_mode(regs);
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,7 +18,8 @@ notrace long system_call_exception(struc
> =C2=A0	long ret;
> =C2=A0	syscall_fn f;
> =C2=A0
> -	r0 =3D syscall_enter_from_user_mode_randomize_stack(regs, r0);
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> +		return syscall_get_error(current, regs);
> =C2=A0
> =C2=A0	if (unlikely(r0 >=3D NR_syscalls)) {
> =C2=A0		if (unlikely(trap_is_unsupported_scv(regs))) {
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -332,13 +332,12 @@ void do_trap_ecall_u(struct pt_regs *reg
> =C2=A0
> =C2=A0		riscv_v_vstate_discard(regs);
> =C2=A0
> -		syscall =3D syscall_enter_from_user_mode_randomize_stack(regs, syscall=
);
> -
> -		if (syscall >=3D 0 && syscall < NR_syscalls) {
> -			syscall =3D array_index_nospec(syscall, NR_syscalls);
> -			syscall_handler(regs, syscall);
> +		if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &syscall=
))) {
> +			if (syscall >=3D 0 && syscall < NR_syscalls) {
> +				syscall =3D array_index_nospec(syscall, NR_syscalls);
> +				syscall_handler(regs, syscall);
> +			}
> =C2=A0		}
> -
> =C2=A0		syscall_exit_to_user_mode(regs);
> =C2=A0	} else {
> =C2=A0		irqentry_state_t state =3D irqentry_nmi_enter(regs);
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -96,6 +96,7 @@ SYSCALL_DEFINE0(ni_syscall)
> =C2=A0void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
> =C2=A0{
> =C2=A0	unsigned long nr;
> +	bool permit;
> =C2=A0
> =C2=A0	enter_from_user_mode_randomize_stack(regs);
> =C2=A0
> @@ -121,7 +122,9 @@ void noinstr __do_syscall(struct pt_regs
> =C2=A0		regs->psw.addr =3D current->restart_block.arch_data;
> =C2=A0		current->restart_block.arch_data =3D 1;
> =C2=A0	}
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> +
> +	permit =3D syscall_enter_from_user_mode_work(regs, &nr);
> +
> =C2=A0	/*
> =C2=A0	 * In the s390 ptrace ABI, both the syscall number and the return =
value
> =C2=A0	 * use gpr2. However, userspace puts the syscall number either in =
the
> @@ -129,7 +132,7 @@ void noinstr __do_syscall(struct pt_regs
> =C2=A0	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checke=
d here
> =C2=A0	 * and if set, the syscall will be skipped.
> =C2=A0	 */
> -	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
> +	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET) || =
!permit))
> =C2=A0		goto out;
> =C2=A0	regs->gprs[2] =3D -ENOSYS;
> =C2=A0	if (likely(nr < NR_syscalls)) {
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -161,8 +161,9 @@ static __always_inline bool int80_is_ext
> =C2=A0	nr =3D syscall_32_enter(regs);
> =C2=A0
> =C2=A0	local_irq_enable();
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> -	do_syscall_32_irqs_on(regs, nr);
> +
> +	if (likely(syscall_enter_from_user_mode_work(regs, &nr)))
> +		do_syscall_32_irqs_on(regs, nr);
> =C2=A0
> =C2=A0	instrumentation_end();
> =C2=A0	syscall_exit_to_user_mode(regs);
> @@ -223,8 +224,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> =C2=A0	nr =3D syscall_32_enter(regs);
> =C2=A0
> =C2=A0	local_irq_enable();
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> -	do_syscall_32_irqs_on(regs, nr);
> +	if (likely(syscall_enter_from_user_mode_work(regs, &nr)))
> +		do_syscall_32_irqs_on(regs, nr);
> =C2=A0
> =C2=A0	instrumentation_end();
> =C2=A0	syscall_exit_to_user_mode(regs);
> @@ -243,13 +244,13 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> =C2=A0	 * orig_ax, the int return value truncates it. This matches
> =C2=A0	 * the semantics of syscall_get_nr().
> =C2=A0	 */
> -	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> -
> -	instrumentation_begin();
> +	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
> +		instrumentation_begin();
> =C2=A0
> -	do_syscall_32_irqs_on(regs, nr);
> +		do_syscall_32_irqs_on(regs, nr);
> =C2=A0
> -	instrumentation_end();
> +		instrumentation_end();
> +	}
> =C2=A0	syscall_exit_to_user_mode(regs);
> =C2=A0}
> =C2=A0#endif /* !CONFIG_IA32_EMULATION */
> @@ -286,10 +287,8 @@ static noinstr bool __do_fast_syscall_32
> =C2=A0		return false;
> =C2=A0	}
> =C2=A0
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> -
> -	/* Now this is just like a normal syscall. */
> -	do_syscall_32_irqs_on(regs, nr);
> +	if (likely(syscall_enter_from_user_mode_work(regs, &nr)))
> +		do_syscall_32_irqs_on(regs, nr);
> =C2=A0
> =C2=A0	instrumentation_end();
> =C2=A0	syscall_exit_to_user_mode(regs);
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -78,14 +78,14 @@ static __always_inline void do_syscall_x
> =C2=A0/* Returns true to return using SYSRET, or false to use IRET */
> =C2=A0__visible noinstr bool do_syscall_64(struct pt_regs *regs, long nr)
> =C2=A0{
> -	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> +	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
> +		instrumentation_begin();
> =C2=A0
> -	instrumentation_begin();
> +		if (!do_syscall_x64(regs, nr))
> +			do_syscall_x32(regs, nr);
> =C2=A0
> -	if (!do_syscall_x64(regs, nr))
> -		do_syscall_x32(regs, nr);
> -
> -	instrumentation_end();
> +		instrumentation_end();
> +	}
> =C2=A0	syscall_exit_to_user_mode(regs);
> =C2=A0
> =C2=A0	/*
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -111,16 +111,15 @@ static __always_inline long syscall_trac
> =C2=A0 * @regs:	Pointer to currents pt_regs
> =C2=A0 * @syscall:	The syscall number
> =C2=A0 *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * enabled after invoking enter_from_user_mode(), enabling interrupts an=
d
> - * extra architecture specific work.
> + * Invoked from architecture specific syscall entry code with interrupts=
 enabled
> + * after invoking enter_from_user_mode(), enabling interrupts and extra
> + * architecture specific work with the syscall return value preset to -E=
NOSYS.
> =C2=A0 *
> - * Returns: The original or a modified syscall number
> + * Returns: True if the syscall should be invoked, False otherwise.
> =C2=A0 *
> - * If the returned syscall number is -1 then the syscall should be
> - * skipped. In this case the caller may invoke syscall_set_error() or
> - * syscall_set_return_value() first.=C2=A0 If neither of those are calle=
d and -1
> - * is returned, then the syscall will fail with ENOSYS.
> + * If the return value is false, the caller must skip the syscall and le=
ave the
> + * syscall return value unmodified as it might have been set by one of t=
he entry
> + * work functions.
> =C2=A0 *
> =C2=A0 * It handles the following work items:
> =C2=A0 *
> @@ -128,19 +127,20 @@ static __always_inline long syscall_trac
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 ptrace_report_syscall_permit_entry(), __=
seccomp_permit_syscall(), trace_sys_enter()
> =C2=A0 *=C2=A0 2) Invocation of audit_syscall_entry()
> =C2=A0 */
> -static __always_inline long syscall_enter_from_user_mode_work(struct pt_=
regs *regs, long syscall)
> +static __always_inline bool syscall_enter_from_user_mode_work(struct pt_=
regs *regs, long *syscall)
> =C2=A0{
> =C2=A0	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_wo=
rk);
> =C2=A0
> -	if (work & SYSCALL_WORK_ENTER) {
> -		if (!syscall_trace_enter(regs, work, syscall))
> -			return -1L;
> +	if (!(work & SYSCALL_WORK_ENTER))
> +		return true;
> =C2=A0
> -		/* Reread the syscall number as it might have been modified */
> -		syscall =3D syscall_get_nr(current, regs);
> -	}
> +	if (unlikely(!syscall_trace_enter(regs, work, *syscall)))
> +		return false;
> =C2=A0
> -	return syscall;
> +	/* Reread the syscall number as it might have been modified */
> +	*syscall =3D syscall_get_nr(current, regs);
> +
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0/**
