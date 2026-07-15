Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745B2BEFEF
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124291; cv=none; b=ll/sY5K+oxixO5ExK4zdSc/Nc/3uegMIp2pBQDlT7iVyj2FaJPkdvFyD4QD+EteRpzvO3dAv9daJsnriwzaY/889N45ysNpeoloFIcV0KhVH2jaSHo5ZexeQgCNGgOP3DpnOSX+0Bkttc0nlzX6/uHTzxmw5EPW06dymSUpf6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124291; c=relaxed/simple;
	bh=P6y78eWvuU/4Dvntm3Cpt/FXCZrNHSl/bIqTOAiMUyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iTf8UfhQwl4KVWY3RoCAlvfsotisjxJ/pbMIBSUD8y8G/V47eWqgY+lIlFrKoxmy3s4GQuuZtMnH8eVtcAce7pnuj5M/aNZW3bsAwW5eBfKc9Yl6tufO4booDjl6/W3CewCemlZWLkBeFMF340F8m+bvkwWXWrgkywDDFpgnNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi0wHGRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi0wHGRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A621F000E9;
	Wed, 15 Jul 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124289;
	bh=OLTKP7LQELxOhaqwcFlscPOLhbTUoj+Aa4S9jAXRvuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oi0wHGRAwPYrzS9q2CTakHnzI5VFdLLOgWGwnKLtKtJarPub0sRKw3iMTunNluLWf
	 0fRhg6Jctyh9bgLq9/twBrZw7stZlqd9eKbAm5gwzEGnZm1CYRH3ZCxOKKLjzGpEFj
	 Fb6/f+1CO8Hix/eZNrT8FZGLbX3bRziyHkSTPUVkjHRgVzu309p9fB/sjGUIzpFokW
	 P7qAWHko0eO8saDX1QhZuWuHOTpo+TxjyLYe7iswPzA51wJlkaDeM/BHAjEPoWOHi4
	 yF/RgwBJJ43dqYDKLvfxPVzDo8cApcKqHBEWIWzyhnE38SdEJnsP/20XRVTFrijMul
	 qOX1+/C6rkm2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/syscall: Keep syscall return in extra ptregs
 member
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sven Schnelle" <svens@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260715133830.2619853-2-svens@linux.ibm.com>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
 <20260715133830.2619853-2-svens@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:04:49 +0000
Message-Id: <20260715140449.A6A621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Tracer modifications to syscall return values during exit stops ar=
e completely ignored.
- [Low] The patch leaves behind an unused and broken macro `_PIF_SYSCALL_RE=
T_SET`.

Pre-existing issues:
- [High] `syscall_rollback()` register restoration is unconditionally clobb=
ered by `-ENOSYS` assignment.
--

--- Patch [1]: [PATCH 1/2] s390/syscall: Keep syscall return in extra ptreg=
s member ---
commit 0354447a3b4a9b11afa78187a684a62c8037dee7
Author: Sven Schnelle <svens@linux.ibm.com>

s390/syscall: Keep syscall return in extra ptregs member

This patch introduces a new member syscall_ret in struct pt_regs to keep
the syscall return value separate from gprs[2]. It copies this value back
to gprs[2] before exit to userspace, resolving issues where setting both a
return value and skipping the syscall was impossible with seccomp or ptrace.

Link: https://lore.kernel.org/all/20260703105718.GO751831@noisy.programming=
.kicks-ass.net/

> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrac=
e.h
> index 495e310c3d6d7..f39b349da9a7d 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -15,9 +15,8 @@
> =20
>  #define PIF_SYSCALL			0	/* inside a system call */
>  #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
> -#define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
> -#define PIF_GUEST_FAULT			3	/* indicates program check in sie64a */
> -#define PIF_FTRACE_FULL_REGS		4	/* all register contents valid (ftrace) =
*/
> +#define PIF_GUEST_FAULT			2	/* indicates program check in sie64a */
> +#define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) =
*/

[Severity: Low]
Could this leave behind a broken macro? Since PIF_SYSCALL_RET_SET is deleted
here, it looks like _PIF_SYSCALL_RET_SET (which is defined right below this
using BIT(PIF_SYSCALL_RET_SET)) will cause a compilation failure if it is e=
ver
used.

[ ... ]

> diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
> index 75d5a3cab14e6..ce244dceec6dc 100644
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -117,25 +117,16 @@ void noinstr __do_syscall(struct pt_regs *regs, int=
 per_trap)

[ ... ]

>  	if (likely(nr < NR_syscalls)) {
>  		nr =3D array_index_nospec(nr, NR_syscalls);
> -		regs->gprs[2] =3D sys_call_table[nr](regs);
> +		regs->syscall_ret =3D sys_call_table[nr](regs);
>  	}
> -out:
> +	regs->gprs[2] =3D regs->syscall_ret;

[Severity: High]
Are tracer modifications to the syscall return value being ignored here?

The assignment regs->gprs[2] =3D regs->syscall_ret happens before we call
syscall_exit_to_user_mode().

If a tracer stops the process during exit hooks inside
syscall_exit_to_user_mode() and modifies the return value, it updates
regs->syscall_ret via syscall_set_return_value(), but this change is never
propagated to the actual CPU register gprs[2].

Will the process resume using the unmodified original return value, complet=
ely
breaking exit-time return value injection?

[Severity: High]
This is a pre-existing issue, but isn't the register restoration from
syscall_rollback() clobbered by this assignment?

If a seccomp filter uses SECCOMP_RET_TRAP to abort the syscall, it triggers=
 a
rollback which restores regs->orig_gpr2 into regs->gprs[2]:

arch/s390/include/asm/syscall.h:syscall_rollback() {
    ...
    regs->gprs[2] =3D regs->orig_gpr2;
    ...
}

However, this restored value is then immediately overwritten here by the
assignment regs->gprs[2] =3D regs->syscall_ret (which holds -ENOSYS for abo=
rted
syscalls).

Does this break userspace seccomp signal handlers that expect the restored
state in gprs[2]?

>  	syscall_exit_to_user_mode(regs);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715133830.2619=
853-1-svens@linux.ibm.com?part=3D1
