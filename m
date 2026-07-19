Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480035B634
	for <linux-s390@vger.kernel.org>; Sun, 19 Jul 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784460349; cv=pass; b=caUJNv1zGlyiveBOr3Oj3cDA+3wD5NBO74Jo1fvI4OPNl2lEaFTvuWiWQ6Mj0Fs+i1wALonWeS/zs3R14zzVUkwMwhE0NxRUWcdf3GefPO0mSQ7sNdoCew5ce3ZoEtyOgRJiEhHSinf+dHOtpItGpw2WdQRQ0S/w4wWDw9Xngug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784460349; c=relaxed/simple;
	bh=rgcqbxa6lEmJgPeR85dLIKFK2p9ERX+2iKovNt7jIVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldTmxO2Tnm0vw9s99LXrUAOzGajGh3ETPx+50N6yNlkjsEJ+9h+4/q+NSdgIcQ3GdLBiBt70cUHuN8ZwjFffo1st/Dmtql4cBRdnHZ6La7NvpTJywmfNOyabNECT+SRWWE8mXo5VbPMsAGjBA/X/cGl1tOdE7b2n6lDjNxRpZ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9Eg2uDU; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9Eg2uDU"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso9261070a12.0
        for <linux-s390@vger.kernel.org>; Sun, 19 Jul 2026 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784460345; cv=none;
        d=google.com; s=arc-20260327;
        b=hoA+++av3j2QUc6rz+yMFJ8+H+GkmyqwdlR3gjnvteMlACQ2vZHeX/KtBDm8SAuV/S
         S3ijTWNHPbxq4YxkglPe0V29a+JLK1a8VMTLBKzpIw3CM1M3xm9muuz1x6C85U6fMJ+a
         H70mIuZN/buRFc6iUBblJ7cAmLxoWp7fo5Ry0laTaQnys249xDng238dpqNrA+4WWW1u
         R7ZSzrWq0eLLdw2xvnbBbNy3DQNhj19O9wlewM64kpQVnXO1NbFRK5Rn6PPKcH6aUFzB
         Z83sd2UzDEG0bzc2hg00wImX+yUH38tc6LzQ9X6jil9Bd+475v8voMkddI95qxINmuLR
         JUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        fh=3dqXDEAoeUFuH9hrPq4AewRBDsisgLQr4MNtbDLz/GA=;
        b=LLIpreS2qzasc5VWaqS1qTcrTjJY7yNnIFSR6iCeaeWp9NlK9BPsZTxJKRkLHOSGft
         +uXNZxuSnTYs88tQokzPBLbx100FT6cAQtuePJkWcH/D/dQca7DLwE4u8QuwFBb6CWDc
         ziRabNx5YCDwVJchkm36MLLfNmM7E6xlVNH1TvwzTuT8ubOBDQU49lIdvovvtkyNkWqx
         7EEWP3VJb0dbR5+MD2SDmwo58OB1ds/MY2an2K/yaOuOV2TZp2Ju1U6TbOluDHfI4mIP
         YBxEhpJ7+EzScV+tpMdF6lF7D+OnVpwn5yfJSTj9fa4no4zdyEoUqtgf1weOo8LdugN/
         fy9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784460345; x=1785065145; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        b=D9Eg2uDUSi1x0Y0zg7fYRwtO/ea3ND5A/4nTPUeApKtSEYiUynlMiE59GblVd3IOrl
         oWFLcCJp25Ys4PA6xy84FzRAl40+EnzjzRCpSvwGo7RHBsGsYMluu61eRFOFojQND+uf
         lNJOO3g5JejU7GJi6tHzDEvpZzKFqs8qHKpdvXxbKlewQ6qiZ+CA5RKcpH/KLcFJLheA
         g2ExVRjhJfMz7jIq0+v0kblCXJOFmPxGPhyEutQjLJ+4HNvh68qQ5hZaqeUXlD5xjERu
         lUwCLdeswboAyC7uRJFB1Xc36fvUf6TDNx+P0LVWtrX9LSsJKKKRbJx1t2fLrOwcBBgd
         7OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784460345; x=1785065145;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        b=CtT59cgCO6DDeUDRYOpkYP0s2S8qJNrBzMjEieXiX+cg6+UV56Hf0f51LT7e5E/Mf8
         pF6akinY8PmoSPrYM1SLaaRuriyLYTH/r7xMzuUymlqpiSHsMKjAceHw44MclMyG9NPN
         a8AECykApuVaQ39mJyV9qG/hwaE5/6x9hXy5fZuwc0NQttHGBMt2Ct4uNTW0g0mwbDFh
         /spcQFBZ4r5uHv9/Hr1q/eNxptXTTPDziKGwPrWjdSQcRg4uBTnYugYuQd0jpW9XrdOi
         pZb+UzQ9gd0QnwD2bxxUbMMQPIpTwxAUzQkbTWyPRX0D6iAXBGvEoEdcpYLUwRZnWxgz
         jZkg==
X-Forwarded-Encrypted: i=1; AHgh+RpV6l93YE7W+/tabcliZtj1QA93oTOR2RiSU7ZQCJ09Juxyiu9QUahnwGdU+2wjf6dD+3ctPmyLpJi4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PMjY0+Hia4W/W55zjNTZgQOAu6cbw+CgDw/78v2Uu5pDrXC+
	+eQCZm7GnUr0KPBsz+ejBZczBu59qOpKppyTahc+2nv8OpU6BXF9k8XcXhRD9zLh2TZ/LcMRB6q
	yPMLQpHl2q2PXv0tZRIeAlgSW+6jX8ko=
X-Gm-Gg: AfdE7cmF31VC0xMvBm3rd2BEhGcZ3IphXIrqgzFEKPECS7z/yK+t9p22tb+tVU4zeCM
	Z5KZmTcR2WWsWRRKDARoCWDhifj4ITLBAWYOtDcHwRltxnafWGUHCwQhfTdZXNOng3PxIwc4AV4
	dtvIWKtW4uHv+1eN71uWz0siI9WiaXEWUuF+mgUWvvwuNX+ScrUrXrUhQjZIxPmpjiTa1BEW7R+
	CB40YfAiNTCyvOTvBHSwCoqtLi1CtMRqhe7LhK1cChCyXN5/xDaF9KFTi2IGjHHljdlp3zrPlqi
	+1tgGuJ9myCEK/ODfIap9fYuUNiidLGqWf6N+m/cxg==
X-Received: by 2002:a05:6402:34d5:b0:698:3b7b:e48a with SMTP id
 4fb4d7f45d1cf-69e652f908dmr3652615a12.32.1784460344585; Sun, 19 Jul 2026
 04:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 19 Jul 2026 13:25:32 +0200
X-Gm-Features: AUfX_mzTzrHRlu_CZJHA0P1GUw_Z2tfq0CbfsG-DFTqsEJDFIQx7LWbdfB3YWqk
Message-ID: <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>

Hi Thomas,

I did another round of testing of this series on Alpha, this time with my
Alpha GENERIC_ENTRY conversion rebased on top of this series.

For this test I also manually applied the seccomp fixup discussed earlier in
this thread, i.e. fixing the recheck-after-trace logic in
__seccomp_filter() along the lines suggested by Jinjie/Oleg.

With that in place, the kernel boots on Alpha and I do not see any
regressions in the seccomp_bpf kernel selftest or in the strace testsuite.

One note: the seccomp_bpf selftest run on Alpha uses this not-yet-upstream
Alpha selftest enablement patch:

https://lore.kernel.org/linux-alpha/20260203063357.14320-1-linmag7@gmail.com/

One Alpha-specific wrinkle I hit while rebasing the GENERIC_ENTRY patch is
that Alpha cannot unconditionally pre-seed the normal -ENOSYS return state
before calling into the generic entry code: syscall_set_return_value() also
updates r19/a3, which is still syscall argument 4 on the normal entry path.
Doing that too early broke early userspace mmap() during boot.

The Alpha conversion therefore handles this on the no-dispatch path instead:
after the generic entry helper returns, if the syscall is not to be invoked
or the resulting syscall number is invalid, Alpha skips the call, preserves
any ptrace/seccomp/BPF-provided return value, and only synthesizes -ENOSYS if
the return state was otherwise unchanged. That was needed for the
TRACE_syscall.ptrace.syscall_faked and syscall_errno seccomp_bpf cases to
pass.

So from the Alpha side, with the seccomp fixup applied:

Tested-by: Magnus Lindholm linmag7@gmail.com

Are you planning to send a v2 with the seccomp recheck fix and any other
review fixups folded in? Is the intention to route this upstream
during the next merge window?

Thanks,
Magnus
