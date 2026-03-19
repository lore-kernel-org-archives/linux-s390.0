Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F82356A3E
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930099; cv=none; b=bTIUQnYDBeTZZ6uDp2bV2BBg2ptNGn79ZWhkLiz+RefZZFrKc1AA2S94NrO3EA84xfZMH5cyyFykhzUl8Ug3HOTUwft1UO0LFsr/S79lmPCHCFDhoYz2qLZx7g3yIbkkYh/BYoPsmyCAjyYRwypdHZXzuEBviZZ1lXg76B8d6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930099; c=relaxed/simple;
	bh=fosI3YoOXqBAqX1ZoDA9gABty1blUjmS5M1S48wnuG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlLL4umoaRoLcqAs2KCaJ2ij9YRy1orvvv3rztl6RbT0+Nu+rMcMeqW4A2/Dyg64aJRZM0YwzovSNmwd6IAat8xqiZSQREdg6OfhRjPkDAdR1qUiiJZaf226wI7Y5tl7InFd/40h7jhODTO7+Acs50sJNWmVCYUo+BnMj3J1EaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6usaKwm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6usaKwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505BC2BCB3
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930098;
	bh=fosI3YoOXqBAqX1ZoDA9gABty1blUjmS5M1S48wnuG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G6usaKwmcGYkRNdXro0Ui6/r1Qc/nYgtT5qsmjHWeKBR0L3AKOq2M9ZguMXGpY4DS
	 fW4j0vsRki634YSpMQsUNqEXjtMSaFoXocn+FJMlGxaT7HTz92+Zx3QTsUNn85cA4H
	 WSdAeh9x5NbgbPHllJb6WTpeIq9mLS+jErPF3n9pFUpB5sxBSFdnbjr/9YIpJSzfd0
	 ll5MgaQrJVT+pkcMuwaHaHfxLluGiigBQph2YCGo/zCtkSDvJx7ckB5zcvKGwTrWVp
	 bOWL3CjVdWSn8LCR/eO6FTplZ8KtWU8DrMRt+70DdzUIlqOFzqIEIGyHzjjvSw0VHv
	 XpkVv3ZcWtHLQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986fb839f5so11024977b3.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:21:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbQ7pOavkQUTNOZ1us0j/aP+uk0r/VGTdNUt9RfafCeSzVG/E7pySRMe7oOmcGufudUIi+7cyfJ3Sn@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUbimTTRJ4XqoTLjxVpAWoCGumVTLLLAZ6p/c1/0noe1cQj7L
	hQKtQ5WSIctwMHcJ9JjyzWa/kCg45Fck2EKa2rW/9BqCxbLhNQ0/a8NfSyOTA23XedBl4dgXdUc
	+12F5NGWzymENQPTHmWYugqOgoLY5VZg=
X-Received: by 2002:a05:690c:e3e8:b0:79a:40fb:9360 with SMTP id
 00721157ae682-79a718c84dbmr73964587b3.22.1773930097887; Thu, 19 Mar 2026
 07:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-10-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-10-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:21:26 +0100
X-Gmail-Original-Message-ID: <CAD++jLnrirhyYL53sqtaz4yFde0Hj20D_Zfxhga6Xeb+b=Aogw@mail.gmail.com>
X-Gm-Features: AaiRm51t9aCq8PsQDeNoeLd6T2lxcXs6sGRh_TP0xmsVwXgmplkaeHFKo5tX3d8
Message-ID: <CAD++jLnrirhyYL53sqtaz4yFde0Hj20D_Zfxhga6Xeb+b=Aogw@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 09/14] arm64: entry: Convert to generic entry
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

> Implement the generic entry framework for arm64 to handle system call
> entry and exit. This follows the migration of x86, RISC-V, and LoongArch,
> consolidating architecture-specific syscall tracing and auditing into
> the common kernel entry infrastructure.
>
> [Background]
> Arm64 has already adopted generic IRQ entry. Completing the conversion
> to the generic syscall entry framework reduces architectural divergence,
> simplifies maintenance, and allows arm64 to automatically benefit from
> improvements in the common entry code.
>
> [Changes]
>
> 1. Kconfig and Infrastructure:
> - Select GENERIC_ENTRY and remove GENERIC_IRQ_ENTRY (now implied).
>
> - Migrate struct thread_info to use the syscall_work field instead
>   of TIF flags for syscall-related tasks.
>
> 2. Thread Info and Flags:
> - Remove definitions for TIF_SYSCALL_TRACE, TIF_SYSCALL_AUDIT,
>   TIF_SYSCALL_TRACEPOINT, TIF_SECCOMP, and TIF_SYSCALL_EMU.
>
> - Replace _TIF_SYSCALL_WORK and _TIF_SYSCALL_EXIT_WORK with the
>   generic SYSCALL_WORK bitmask.
>
> - Map single-step state to SYSCALL_EXIT_TRAP in debug-monitors.c.
>
> 3. Architecture-Specific Hooks (asm/entry-common.h):
> - Implement arch_ptrace_report_syscall_entry() and _exit() by
>   porting the existing arm64 logic to the generic interface.
>
> - Add arch_syscall_is_vdso_sigreturn() to asm/syscall.h to
>   support Syscall User Dispatch (SUD).
>
> 4. Differentiate between syscall and interrupt entry/exit paths to handle
>    RSEQ slice extensions correctly.
> - For irq/exception entry/exit: use irqentry_enter_from_user_mode() and
>   irqentry_exit_to_user_mode_prepare().
> - For syscall entry/exit: use enter_from_user_mode() and
>   syscall_exit_to_user_mode_prepare().
> - Remove exit_to_user_mode_prepare_legacy() which is no longer necessary.
>
> 5. rseq_syscall() will be replaced with the static key version, that is
>    "rseq_debug_syscall_return()"
>
> 6. Cleanup and Refactoring:
> - Remove redundant arm64-specific syscall tracing functions from
>   ptrace.c, including syscall_trace_enter(), syscall_exit_work(),
>   and related audit/step helpers.
>
> - Update el0_svc_common() in syscall.c to use the generic
>   syscall_work checks and entry/exit call sites.
>
> [Why this matters]
> - Unified Interface: Aligns arm64 with the modern kernel entry standard.
>
> - Improved Maintainability: Bug fixes in kernel/entry/common.c now
>   apply to arm64 automatically.
>
> - Feature Readiness: Simplifies the implementation of future
>   cross-architecture syscall features.
>
> [Compatibility]
> This conversion maintains full ABI compatibility with existing
> userspace. The ptrace register-saving behavior, seccomp filtering, and
> syscall tracing semantics remain identical to the previous implementation=
.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

This looks really neat.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
