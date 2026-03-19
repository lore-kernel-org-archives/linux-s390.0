Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866D3612D8
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930044; cv=none; b=mqyIq0OeAH+fx8mjZNLjLpdHu4xKEQtFEYtID58gRTfvQi6Gf8oImPRuQPfBUFQnsETKivz5Y3WnI/m4ormAsGDnPV75XVfgTqcQ+0rXcvpTsNAstpspZ2e0hLSz/IiN1HDvQwmMP3EnnBeX4xYElBUTXdHmWHopinfzgcpeGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930044; c=relaxed/simple;
	bh=mojo3oAvax9/GztVjCTiOKJXIMlZnOTZaoYng3QPfOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtenhzZwtw+VDwBojzpCqXh8V4JnKW44cmtI8iGYHfHEhmy9xGjAM3qROWU5agEk0vGOtRuWn9Tj0ZYuKC3EjNk85q1CAmEsB6c6MaE/bbiFU5wLBV9zECFbZwvcmzT2Q8tuFVHZTG3p5PacRFzlxODCbuf+iagcHCsgpOQqZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrW7k6o2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrW7k6o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA864C2BCB3
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930043;
	bh=mojo3oAvax9/GztVjCTiOKJXIMlZnOTZaoYng3QPfOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VrW7k6o2Xmz4BqkpjcCuZGXErV+nf4xcjzf406LB+O1umD7d4h0gZ5hEDaGo9lhDt
	 C+lkxpfHt1eWu6d6cv8DvVrLpQqLGlBT4aJlXssUGZN+Sg16Lpk3ThkARbDqKAbv7c
	 2BhjKuW8BdVVZ/Hd+dYlW0Xc23hExpVjyTV1ONk8ETFFOjdMgQlNTgttfoSFch+6SO
	 SvyFLP6eAs/VolXNnqSMG5A5MwySyVDrXYG6uzAcpccnX5JtBi8c0mfL5YJPd8yJUN
	 GGT24llmPPzf01cd86TUlsnQFA0bOLXHaCDKsvIwVWVz1LaMDh30wXTwJVdRtOcViX
	 HQR2eun41oAnA==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-798374d0f44so30452307b3.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:20:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFd1bFd7jdzai/5gAfr5Ic9cGQdf14fRd2KXICgxJgmg4rzitE0f1H81YI9bXE+2uy6ARbK0lQC0Fa@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMcQYn7kvce710MDk6QM4gUZwJ/V6Tp5d1N6imnPlpTHkBRpP
	9Yadc8dIAGvf+PNivmQucDu7QXkVn1Gxo2mSNGVQfWN5b1f7NtLvm++jRDHtW7Ecuqt1ZhX3cDM
	hhRNzt3Rm3GAztiPBx49IPrKQL4nk+3E=
X-Received: by 2002:a05:690c:22c5:b0:79a:31ca:6663 with SMTP id
 00721157ae682-79a81c2bb7emr36396827b3.28.1773930043109; Thu, 19 Mar 2026
 07:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-9-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-9-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:20:32 +0100
X-Gmail-Original-Message-ID: <CAD++jLnHDvr0yqRvzizLB7+F_ND9REpmvHuuVVTH8-21r8qWjA@mail.gmail.com>
X-Gm-Features: AaiRm50vdTnYR88F37UdAdftTV3WbWpRHcokf0IbSenh2CTNQkgHJ3ly7MnRDsU
Message-ID: <CAD++jLnHDvr0yqRvzizLB7+F_ND9REpmvHuuVVTH8-21r8qWjA@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 08/14] arm64/ptrace: Skip syscall exit
 reporting for PTRACE_SYSEMU_SINGLESTEP
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Align the syscall exit reporting logic with the generic entry
> framework by skipping the exit stop when PTRACE_SYSEMU_SINGLESTEP is
> in effect.
>
> [Rationale]
> When a tracer uses PTRACE_SYSEMU_SINGLESTEP, both _TIF_SYSCALL_EMU
> and _TIF_SINGLESTEP flags are set. Currently, arm64 reports a syscall
> exit stop whenever _TIF_SINGLESTEP is set, regardless of the
> emulation state.
>
> However, as per the generic entry implementation (see
> include/linux/entry-common.h):
> "If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP
> is set (i.e. PTRACE_SYSEMU_SINGLESTEP). This syscall instruction has been
> already reported in syscall_trace_enter()."
>
> Since PTRACE_SYSEMU intercepts and skips the actual syscall
> execution, reporting a subsequent exit stop is redundant and
> inconsistent with the expected behavior of emulated system calls.
>
> [Changes]
> - Introduce report_single_step(): Add a helper to encapsulate the
>   logic for deciding whether to report a single-step stop at syscall
>   exit. It returns false if _TIF_SYSCALL_EMU is set, ensuring the
>   emulated syscall does not trigger a duplicate report.
>
> - Update syscall_exit_work(): Use the new helper to determine
>   the stepping state instead of directly checking _TIF_SINGLESTEP.
>
> [Impact]
> - PTRACE_SINGLESTEP: Continues to report exit stops for actual
>   instructions.
>
> - PTRACE_SYSEMU: Continues to skip exit stops.
>
> - PTRACE_SYSEMU_SINGLESTEP: Now correctly skips the redundant exit
>   stop, aligning arm64 with the generic entry infrastructure.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

These small semantic glitches underscores the need to move
to generic entry.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
