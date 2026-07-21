Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187625B0AE
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631953; cv=none; b=J8h+Ev+6ie9fQz1A8Da3Oc6Ng9VjH/ZN1sd7s0faUc12PEgKi7X6JJ8D0rv2/qPx++GLpyCiK8ZFPFxGhLxjfFkU6wTG1sF5OMh42x9JrUJLoCrQUXn6tR2zmLzafKJtoMg0iGYTtc6UOk3bvY9vMKD8Ems03mpXmfLyRGw1DKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631953; c=relaxed/simple;
	bh=eOT2czJ61Dvw5QKuhjM4fiitab89XzIzr35eeo9pf2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=emeWurdT+Mui1LtftYkBCncq5qUY35TI+hNw0IoLus1VuQ2DhhorpYqf1Lkj0MbTdJg8KW52r1s5Ek6BVoxXgejfYKgTGl6bWRCsIaNUls6E5+ciAlPFioNjmWZac19+Sn5S6Wi3mluEFFykQWWNJ/t2DMxItRFXqnNRJuhv/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqq7SBE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqq7SBE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812411F000E9;
	Tue, 21 Jul 2026 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784631951;
	bh=jJ0jQr1RJu05fofxZHrgY3GVwUBU7FFvmFLfOTO0PKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nqq7SBE8VBE9muGQoogh6c9eWZuShVW5vA2Jf1T6PT6TtoVKRT60uqIXq3ld27JX3
	 z4k2Fn43Fh1K4gH5Z8jfG8st0QJSD/mQTsk+cmhHmK43FMEiKkVBACJYQ/AMHe0RgN
	 brzKXxozv4+nuSI4NVPKEzqmBhCTFXhE5/mTLOqIotbcaVyvgxbodF16pnPrC2OdEt
	 mPm6b1M7K0z6HE224SjaPM1JXQm0349Q5rHKViOleMSmTKtUsKC17xieZLng74KKKH
	 Yp7jGLWof1gJRlpci9gf0qEOw+nmmOOGVkPaRJ4tYvOHBCHRFQ3xpbhmdxWphlFfq7
	 4zWTWFtfBnh/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] seccomp: Fix syscall skip logic on ptrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Suchanek" <msuchanek@suse.de>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <al9NlZi20xHMvla2@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <al9NlZi20xHMvla2@kunlun.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:05:51 +0000
Message-Id: <20260721110551.812411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removing the explicit check for tracer-injected negative sysca=
ll numbers breaks ptrace syscall emulation by erroneously re-evaluating the=
 seccomp BPF filter against a `-1` syscall number.
--

--- Patch [1]: [PATCH] seccomp: Fix syscall skip logic on ptrace ---
commit e1c90f3fd79c2a1c1deae6adb363b4de34006c48
Author: Michal Suchanek <msuchanek@suse.de>

seccomp: Fix syscall skip logic on ptrace

This commit removes the explicit check for negative syscall numbers after a
ptrace stop in the seccomp filter. This allows architectures where the retu=
rn
value overlaps with the syscall number or arguments to exit without flagging
the syscall as skipped.

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 25f62867a16d9..4d3ad6113b216 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1318,11 +1318,8 @@ static int __seccomp_filter(int this_syscall, cons=
t bool recheck_after_trace)
>  		 */
>  		if (fatal_signal_pending(current))
>  			goto skip;
> -		/* Check if the tracer forced the syscall to be skipped. */
> -		this_syscall =3D syscall_get_nr(current, current_pt_regs());
> -		if (this_syscall < 0)
> -			goto skip;
> =20
> +		this_syscall =3D syscall_get_nr(current, current_pt_regs());

[Severity: Critical]
By removing this check, does this break ptrace syscall emulation?

The standard mechanism for syscall emulation using ptrace and seccomp (used
by gVisor, User-Mode Linux, proot, and strace) involves changing the syscall
number to -1 to skip the real kernel syscall and setting a custom return
value.

Without this check, when the tracee resumes and re-enters __seccomp_filter(=
),
the -1 syscall number will fall through to the BPF evaluation below. Since
most seccomp profiles use strict allowlists, won't this cause the -1 syscall
to hit the default action (like SECCOMP_RET_KILL_PROCESS or
SECCOMP_RET_ERRNO) instead of skipping it?

Could this lead to tracees being unexpectedly killed or having their preset
return values overwritten?

>  		/*
>  		 * Recheck the syscall, since it may have changed. This
>  		 * intentionally uses a NULL struct seccomp_data to force

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/al9NlZi20xHMvla2@ku=
nlun.suse.cz?part=3D1
