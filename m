Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1014AD0D
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929778; cv=none; b=OH5Ngp9EZ1/r002vlfPYDgzT1cwNkO1l4GWxYlP5sKA3xiip86YrNbn25SM88XgMhHGk8YxR1/CVQcTkS7wFicbvqb8pMwDVEPINIlp+jdZFIUN/Hn2lpxnZHQvJLpSK2/j15YdEx1yJQME51nXlCxk+mYf04pSGi94ZfB10tsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929778; c=relaxed/simple;
	bh=PGE6RDGMzwVDhtY8HsGAs0Ps1xRoQIDmL3tvMJBJhho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKZIcgF1PSnSixBuIhOE0AeTaKkEpbpxEsOZJFiS3nDpBp5yOa8FmbsokI8UpZv6U3/1wyoc35GG0/pZN4VEvIUkIBskKYSr0CznA0tqIj4iaUOUSHStdd9gmRHTTDwza+0CvSy2EtJ0ozLvA3GGPsFRsEUyXSI5JvN2Dq84xqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDvsy2j9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDvsy2j9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C0C2BCB6
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929777;
	bh=PGE6RDGMzwVDhtY8HsGAs0Ps1xRoQIDmL3tvMJBJhho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tDvsy2j9PnDtkFCwE99O71DlAaMBmGZGq6WRt9Sdf/h8Oeqx58PkMsI9VaPuT0QAY
	 fQi89eGy+/tqDtifeSyzGAKScGlRoHbd23gL9ApkQ4KWqXzeR+noPrPDXZXKgw7jdY
	 +RTD86Oyjuk2/wiHyGYYqXbThJnMLTl20hiRhl5kBZ5EMi4KukdwOxMhC96OgD0n4i
	 2/EHVOt51pvIvcjD0tn4o72kpuPhFeEjEdulHadBH8uBJiKbdmq+wGPJ18D/CuWGGk
	 0V4W41CSaqnpWKugiLOde7+n1K8Ij08Ep12gPcyV+cNjCsmTTW4nfz4jIJGOJPufa4
	 7QHSSbSqSwXQw==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a46ebe2beso6151997b3.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:16:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+0NoCJhZWMJv/Kqwhc2gxGrIZEi/nlNOJdWCrFZkoVFOysnuqQtQ4/yyxtYTD6D6JP+GcxIk1mf9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpnoB/p9nKHajG4M7oyy6LEx+VdzAmTxqjCNaCfsXeQ932OXJ
	fW5r6rJOYOxqrqN4MYIeMdqXiLfnwbUFDKgLXJ6/U4JSpviCD/WkLyJOngdtWbJF3T3vLChjPAQ
	lNWMCpT1crZRkAWNBVmBiy7YCvudBXtU=
X-Received: by 2002:a05:690c:c241:b0:79a:3e8d:9bd8 with SMTP id
 00721157ae682-79a7188db3emr77250547b3.2.1773929776689; Thu, 19 Mar 2026
 07:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-6-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-6-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:16:05 +0100
X-Gmail-Original-Message-ID: <CAD++jLkSru0GMUqrrt6yTw7G3krZgqVYb7-VpKnYE+_jDWv9rQ@mail.gmail.com>
X-Gm-Features: AaiRm51Qmj9OhyThBYRWUBuxkG1rKYZYAjAodFs5qvq19NWoEnb24r2RFgakiyw
Message-ID: <CAD++jLkSru0GMUqrrt6yTw7G3krZgqVYb7-VpKnYE+_jDWv9rQ@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 05/14] arm64: ptrace: Move rseq_syscall()
 before audit_syscall_exit()
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

> Move the rseq_syscall() check earlier in the syscall exit path to ensure
> it operates on the original instruction pointer (regs->pc) before any
> potential modification by a tracer.
>
> [Background]
> When CONFIG_DEBUG_RSEQ is enabled, rseq_syscall() verifies that a system
> call was not executed within an rseq critical section by examining
> regs->pc. If a violation is detected, it triggers a SIGSEGV.
>
> [Problem]
> Currently, arm64 invokes rseq_syscall() after report_syscall_exit().
> However, during report_syscall_exit(), a ptrace tracer can modify the
> task's instruction pointer via PTRACE_SETREGS. This leads to an
> inconsistency where rseq may analyze a post-trace PC instead of the
> actual PC at the time of syscall exit.
>
> [Why this matters]
> The rseq check is intended to validate the execution context of the
> syscall itself. Analyzing a tracer-modified PC can lead to incorrect
> detection or missed violations. Moving the check earlier ensures rseq
> sees the authentic state of the task.
>
> [Alignment]
> This change aligns arm64 with:
> - Generic entry, which calls rseq_syscall() first.
> - arm32 implementation, which also performs the check before audit.
>
> [Impact]
> There is no functional change to signal delivery; SIGSEGV will still be
> processed in arm64_exit_to_user_mode() at the end of the exit path.
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
