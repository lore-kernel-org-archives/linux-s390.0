Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3B3CCFD4
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582980; cv=none; b=majygiu8L6AE+o9vjnLzkQN86EnrnYYCKW2I0Uo0zlBSn8gYF79G3xzFDGmAPzzcvdKJAyTV8QLUK+v80BVZWkds9rVHxZSJ46ckMu8Yf249UQKfKI/z5zvF8SUN9RbLTIpxnpeU+wM6QnSNVkn17Fgdn+NML0CdnjMEVASFHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582980; c=relaxed/simple;
	bh=R01OugA8ikscP6BKT+tncujfUulD48OBnP+rOUayBtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPwD4fnz1FBS0v8bB4EfC2HhcCwCEX4s+r9MhYkNAf1OUaJPSBqTpUGy4XdWpYsySXl4MCgaNMz1hnQeZi3kPJcqw3QZvGDEWxifApv26AdSucKh1ujwHGMcQHELIQLpBzkrw1XQAWOQHdmqqb+5QjnCC76sKoMpX9/H3r/24V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8aO+bv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8aO+bv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8507B1F00A3A;
	Thu,  9 Jul 2026 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582978;
	bh=hLl/fo5d+m7N2TlnK5X8dRbh2dyb26KuQumWJCPeQQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8aO+bv7X9OM3YKFKrHgxrvVvgTf//wP6Jx68HIEVYLnZQbQlUpKAolCTzTaZBAIs
	 VJQd03Mlh+b0mDpmcEOCPUkBaUy0nJIka1dzd2gKhDAIgxojw8eOaqzjZYuKXTZypE
	 A0mcjvurNHhPBn+PMXqpCdDLM3US9GwLTWlxyFjRaaEv6eWNMJUkNBOSuAbGnmRJW1
	 uRPZRrIxt+4KzOcCfCEZnuMx1+5ZdBkHXA352rQdtoGkAKCfdXgAyGdliH6JhbppzG
	 JL/2qe9v/doD62cmkneGCPRVuhMFEbljd7RiufYHIFggHQkZJv5mOmQM5TfCensGNS
	 dRHFoD2ds1bHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709072803.3843948-1-ruanjinjie@huawei.com>
References: <20260709072803.3843948-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:42:57 +0000
Message-Id: <20260709074258.8507B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The Kconfig symbol `ARCH_SUPPORTS_SYSCALL_USER_DISPATCH` is re=
ferenced in `depends on` and `select` but is never defined anywhere, silent=
ly disabling Syscall User Dispatch globally.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but pre-exists in th=
e state restoration logic: tasks that configure Syscall User Dispatch with =
`PR_SYS_DISPATCH_INCLUSIVE_ON` cannot have their configuration restored via=
 ptrace, breaking Checkpoint/Restore (CRIU).
--

--- Patch [1]: [PATCH] syscall_user_dispatch: Introduce ARCH_SUPPORTS_SYSCA=
LL_USER_DISPATCH ---
commit 46bd6e141d4dc4cf13cdaf9787b9a2959d21a56a
Author: Jinjie Ruan <ruanjinjie@huawei.com>

syscall_user_dispatch: Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH

This commit introduces ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple
Syscall User Dispatch from GENERIC_ENTRY. It selects the new config
exclusively on x86 and removes redundant stub functions from other
architectures.

Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.=
cambridge.arm.com/

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 0c01521c2f3f2..393d0fb75eac4 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -116,6 +116,7 @@ config GENERIC_ENTRY
> =20
>  config SYSCALL_USER_DISPATCH
>  	bool "Syscall User Dispatch"
> +	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH

[Severity: Critical]
Does this regression disable Syscall User Dispatch globally? It appears
ARCH_SUPPORTS_SYSCALL_USER_DISPATCH is referenced here but never defined in
any Kconfig file. Since the symbol is undefined, Kconfig evaluates it to
false, which prevents CONFIG_SYSCALL_USER_DISPATCH from being enabled and
could break the userspace ABI where prctl(PR_SET_SYSCALL_USER_DISPATCH)
returns -EINVAL.

>  	depends on GENERIC_ENTRY
>  	default y
>  	help

[ ... ]

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b5571667a89b2..2bff333d29e84 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -336,6 +336,7 @@ config X86
>  	select SCHED_SMT			if SMP
>  	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>  	select ARCH_SUPPORTS_SCHED_MC		if SMP
> +	select ARCH_SUPPORTS_SYSCALL_USER_DISPATCH

[Severity: Critical]
Could this select statement be ineffective? Since
ARCH_SUPPORTS_SYSCALL_USER_DISPATCH is not defined anywhere, selecting it
here has no effect.

>  	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_D=
IRECT_CALLS
> =20
>  config INSTRUCTION_DECODER

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the state restoration logic break for
tasks configuring Syscall User Dispatch with PR_SYS_DISPATCH_INCLUSIVE_ON?

When a task configures PR_SYS_DISPATCH_INCLUSIVE_ON,
task_set_syscall_user_dispatch() inverts offset and len:

kernel/entry/syscall_user_dispatch.c:task_set_syscall_user_dispatch() {
    ...
	case PR_SYS_DISPATCH_INCLUSIVE_ON:
		/* ... */
		offset +=3D len;
		len =3D -len;
    ...
}

However, syscall_user_dispatch_get_config() reads these inverted values but
sets the mode to PR_SYS_DISPATCH_ON (which is EXCLUSIVE_ON), losing the
INCLUSIVE_ON distinction:

kernel/entry/syscall_user_dispatch.c:syscall_user_dispatch_get_config() {
    ...
	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
		cfg.mode =3D PR_SYS_DISPATCH_ON;
	else
		cfg.mode =3D PR_SYS_DISPATCH_OFF;

	cfg.offset =3D sd->offset;
	cfg.len =3D sd->len;
    ...
}

During restoration, task_set_syscall_user_dispatch() evaluates this state
under the EXCLUSIVE_ON branch, where the overflow check rejects the inverted
wrap-around parameters:

kernel/entry/syscall_user_dispatch.c:task_set_syscall_user_dispatch() {
    ...
	case PR_SYS_DISPATCH_EXCLUSIVE_ON:
		/* ... */
		if (offset && offset + len <=3D offset)
			return -EINVAL;
    ...
}

Could this cause ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG) to
unconditionally fail with -EINVAL for inclusive mode configurations,
breaking Checkpoint/Restore?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709072803.3843=
948-1-ruanjinjie@huawei.com?part=3D1
