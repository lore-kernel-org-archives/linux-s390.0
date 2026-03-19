Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44C317174
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929857; cv=none; b=g0kF/Tx24bPFkzrHZ6KIGT7eNPFDV7I4MbGj6biLhZEyVH5zcGOYxUPlgfTZjiTzxE6krdeh+9GxU5NTy8dPTjSSVAm/w3E1m1E233mIlk72w+aPwAUIBFDczF7am9ky5PDbVOoDZDalPZTqtricdqokYfmVJ+KjykkUoVJpWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929857; c=relaxed/simple;
	bh=Ql5U0alZoc5TzG7XTlVBYbrEVy0XJbc7/erGCXEYuxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTW8n8mdvPsTYuPVAJwB0DBk14TRGwnITKhSH6mnCiTfNrr++sxN7Ue4Goh/DLIpKzPTEN3G+M1aKL3/2ChINCPoT5dWsSTLWlzt3WY35xopapvG/oIS3RuL06lFNNHKUyHq17pkdVUsdDkziCHmZIYdySX90ZDMYQiHOArpDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk9ApcrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk9ApcrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E5CC4AF18
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929857;
	bh=Ql5U0alZoc5TzG7XTlVBYbrEVy0XJbc7/erGCXEYuxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kk9ApcrN5QNpxxKm6orsebjbxysoVfC60G7/YPyR7X/jESbfhLQkP9nllOD7t5zxN
	 gqp/M272U7FpHWKa1g5bpiOorlddVJOxRQHHWDqGIFRY5Tj2z0MBipXhRLKP7Sj5g4
	 GbyqGw18ggWuxQspxaMPOYftXtcW/pgj6oJ4N+jENy3IYpUMvHhaf0o7rHUk15EH8v
	 C1v/8bBpg01bzIW/a9p7S9U6U8pVeEKLTMxd1PmjBXHp6hmKA8ptCxZ4nIthxozkul
	 lqLglTzRj64LIOxnVEo18S3Dqs7H/VfEjeNTqIfTbC1YsFYk6a/D20fUQg7JRnCT4l
	 p7IxH9EX/d2ig==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a5ad7cc52so11012807b3.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:17:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhar4yB/YZ4VOe7gaQcrDYKMPHlFlnJf1AkxTmldJcoI7LXDMAN0d3OOGT1ItSymGqkCVt+gBeA4dX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5raq8UZglrim1a3YSmogAnG8GQAgo4hdlYLhjgOertZbFZLpy
	+mYKZ3LDPfPe8zrc64ujFtdtUtZCJIGMcR9U6HlWFycsNOcSkdRfl4WtpKLhTjTZcWz0tp2ZsTy
	fyri8xEvcGLDZmASMswDckgAgaOl2tts=
X-Received: by 2002:a0d:dc03:0:b0:798:5b22:ecb0 with SMTP id
 00721157ae682-79a718c8d4bmr58731417b3.22.1773929856576; Thu, 19 Mar 2026
 07:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-7-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-7-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:17:25 +0100
X-Gmail-Original-Message-ID: <CAD++jLmaOY8h5RCoLRRKkSc=yxxkDkJMeQVM+L-KzmU5WQN9fw@mail.gmail.com>
X-Gm-Features: AaiRm53s3W3J-fTbgjw_94ULRUSuAwmNxoFGQySXaaYRnKYlXZH05M7W2SXB1Jw
Message-ID: <CAD++jLmaOY8h5RCoLRRKkSc=yxxkDkJMeQVM+L-KzmU5WQN9fw@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 06/14] arm64: syscall: Introduce syscall_exit_to_user_mode_work()
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

> Refactor the system call exit path to align with the generic entry
> framework. This consolidates thread flag checking, rseq handling, and
> syscall tracing into a structure that mirrors the generic
> syscall_exit_to_user_mode_work() implementation.
>
> [Rationale]
> The generic entry code employs a hierarchical approach for
> syscall exit work:
>
> 1. syscall_exit_to_user_mode_work(): The entry point that handles
>    rseq and checks if further exit work (tracing/audit) is required.
>
> 2. syscall_exit_work(): Performs the actual tracing, auditing, and
>    ptrace reporting.
>
> [Changes]
> - Rename and Encapsulate: Rename syscall_trace_exit() to
>   syscall_exit_work() and make it static, as it is now an internal
>   helper for the exit path.
>
> - New Entry Point: Implement syscall_exit_to_user_mode_work() to
>   replace the manual flag-reading logic in el0_svc_common(). This
>   function now encapsulates the rseq_syscall() call and the
>   conditional execution of syscall_exit_work().
>
> - Simplify el0_svc_common(): Remove the complex conditional checks
>   for tracing and CONFIG_DEBUG_RSEQ at the end of the syscall path,
>   delegating this responsibility to the new helper.
>
> - Helper Migration: Move has_syscall_work() to asm/syscall.h
>   to allow its reuse across ptrace.c and syscall.c.
>
> - Clean up RSEQ: Remove the explicit IS_ENABLED(CONFIG_DEBUG_RSEQ)
>   check in the caller, as rseq_syscall() is already a no-op when the
>   config is disabled.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
