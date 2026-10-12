Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C083B27DB
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820206; cv=none; b=D1PH8eGasjiwkvR9ve9wVfdoMAIFOz8BIt9Jm8d8s21lOEDELykJ+LceRZOiCgvoxD8Ue59QcTin57fcruRIpOE2YAqdXBT2+hUGzH7rU4eywZiTigiAS2vzO7cn72W6M4zfVBNrJPOjVR/QOVSdJSkb5bQLSRIKXEAjYFp5r+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820206; c=relaxed/simple;
	bh=fuiS2CPoZXECKEpzeVOXh+d4abyKyIdHkZ3nvqTky6A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DNw5mg274G59EDLAJvJwB8kZuPYaxtLrR03SJdZN7GWvge0X68yzuwW0FuYgTrnrsDkCAmUmcS9sXQzhaFPLWrgve7Xuo5sSqarEgd28iDS+cLJWiITQsT/QIvu0Gy91xUklQNfIjLBGq1P4cAabHCD8vZ/6sbGEWW/7DgG+AoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM1Gox54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM1Gox54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9377F1F0089B;
	Mon, 12 Oct 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820205;
	bh=Epn5dn5V4DgdKcZQDuT3mCdtqgvM/AK1OVg/8jR2j84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TM1Gox54sr336k1EBGkd5f4U3tmM5FJPXOPLJIqqJQ+6lEw7FAxEy5sqbxA+/9jaw
	 X885+Rn5MwcBtg9cNqy6qsUg3C7CAPweosPU78y0Ae1EIcEw5oBJASX9FyCy/VFCu3
	 KvVDuXv7VUnhNpMMdN0z4Us+Fql2LjvE3tEaWaOoBsP8Tydcuq6GR/+HUgiWNyIcyk
	 79VI3CY97Z0cQstPHj2wvAkvlS7Xqn0gTF7Uhc67noj1Woa208aoljjs2lA9Dk6CQJ
	 TPE5q1xBLSroLu72ZYPdMAEpiEjmvBAc0XlItyptDONyGhSf+3QSKk63jo5OIDDBQb
	 93VLzXNlbiMOg==
Message-ID: <sashiko-outbox-168354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/signal: Fix incorrect return address in signal
 frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261012153355.1529314-1-hca@linux.ibm.com>
References: <20261012153355.1529314-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:50:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/signal: patch breaks -EINTR for -ERESTART_RESTARTBLOCK
--

commit 158e48eb13e787b0b5c2f432c9056345d015870e
Author: Heiko Carstens <hca@linux.ibm.com>

s390/signal: Fix incorrect return address in signal frame

This commit fixes an issue in arch_do_signal_or_restart() where a second ca=
ll
builds a signal frame with the wrong return address if the first call set u=
p a
vDSO system call restart. It addresses this by restoring psw.addr from
arch_data before building the signal frame.

> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 4874de5edea0a..25781d4a0ad0c 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -475,7 +475,10 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  		}
>  		/* No longer in a system call */
>  		clear_pt_regs_flag(regs, PIF_SYSCALL);
> -
> +		if (!(current->restart_block.arch_data & 1)) {
> +			regs->psw.addr =3D current->restart_block.arch_data;
> +			current->restart_block.arch_data =3D 1;
> +		}

[Severity: High]
Does this code break the -EINTR return value for system calls returning
-ERESTART_RESTARTBLOCK when interrupted by a signal?

In arch_do_signal_or_restart(), the first call without handlers might set u=
p a
vDSO restart (setting regs->gprs[2] =3D regs->orig_gpr2) and clear PIF_SYSC=
ALL.

If a signal with a handler arrives before returning to user mode, a second
call occurs. Because PIF_SYSCALL was cleared, current->thread.system_call
evaluates to 0:

arch/s390/kernel/signal.c:arch_do_signal_or_restart() {
    ...
	current->thread.system_call =3D
		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;

This bypasses the block that would normally set regs->gprs[2] =3D -EINTR:

	if (get_signal(&ksig)) {
		/* Whee!  Actually deliver the signal.  */
		if (current->thread.system_call) {
    ...

The newly added code restores regs->psw.addr to the original return address,
bypassing the vDSO stub. Without the vDSO stub executing sys_restart_syscall
(which would return -EINTR), the syscall instead returns orig_gpr2.

Could this lead to system calls like nanosleep returning their first argume=
nt
instead of -EINTR, breaking userspace error handling and POSIX compliance?

>  		rseq_signal_deliver(&ksig, regs);
>  		handle_signal(&ksig, oldset, regs);
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012153355.1529=
314-1-hca@linux.ibm.com?part=3D1
