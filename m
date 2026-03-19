Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEC2C3259
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928227; cv=none; b=KMQmsFmCrkA1mspH7d0M/IZOWF06ScNXS1f7lK9hPiD3TZZWz6JbcG4bpxyFXyKMcmwyYaB5k8g5hPagtzgrdrXypT4FUMiSLhdTmKIkLK6KAU1JQQ+DXBHESwspj2DVNKcV6Lt4xFlZigy8yPTyDNVPvGNA9whHWk9+am+gEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928227; c=relaxed/simple;
	bh=j89Gvis/qGEGvr15cAgXc/XjTDM6TIyQH5z20F0XvZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djm/PaE+YcuitW817CGaN7aGnKFI59OsgLhokhZZWQeIJRuD1HCDB30Hk7w5f65ClrSa8/MRoxMZTaDNfplIQnYh2Ts8N7i/0dAPmOhX10mUxk58MYHKuctVP1I0d+4rCHkeQfNKQ7XC4krouPIyZSJH6iEpOBMBQa/k57Id88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKeTgbU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKeTgbU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22810C2BCB7
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928227;
	bh=j89Gvis/qGEGvr15cAgXc/XjTDM6TIyQH5z20F0XvZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BKeTgbU9/vwudKLzWjBLPA5UmvcQi0asWK0Wzm/583hhO7ifMDq6Tdc9tEsmv6ade
	 FO9Z4e2P78HtTkWWEx6xG7Kpdu1zcD1MlT0yco+5Uy08vz1MAvTwdosAsCd/60Q3CV
	 xVU4gSSD47/xcEQCVZvi7R6aXFYB3Bj0JvuF18aBA4nh0T5j6UjT+Kq81pKUQsFE3n
	 Z0B5Mulk4kFtg9eeplcyovfhdA4yYYzk4ngnZP0adoT2MElATR2zrUffEentqM3lUy
	 pZXgseNEy7xhp0Ld4c2bnh/p5r99nLBGMsBSwaaKsgPJYVJJWnJLLzgF7BweVWA1YC
	 VoGf4eE3oTeEg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7982c3b7dfcso6351527b3.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 06:50:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKpG92GOt7FXO92tcX2Nf13/1tJcqzPN8QyX0QkTeZonrZ9A+z7nAfl5BFlgwC9ZcFw21EfgxfbnC9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51PpLW0N8+8y0zpaQwguGXHuA6mhsykXZDNbnqR1SYj8QoxYX
	5EKn7Hc2d0d555jDjsJ85GNofBcbQ+mrBYW/tr3OE8cGZ3lmUXsdIz6bBiJzM3hIKXi8yfoBMXr
	q2ehbaz7IsDLLHlXkmoBiXflbjN3FNpk=
X-Received: by 2002:a05:690c:e4f0:b0:799:266:83d3 with SMTP id
 00721157ae682-79a71c2b7bfmr64114747b3.47.1773928225862; Thu, 19 Mar 2026
 06:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-3-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-3-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 14:50:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLmAxER7pR-eoJ4xs2EbGopsS4SWd+wo88xZbzkmPJp-Bw@mail.gmail.com>
X-Gm-Features: AaiRm50Qfp2UBllmGvff8saK2JFshZ6hIP4M5NvuPk-ZtFFI7-7AoZeXZeE62BY
Message-ID: <CAD++jLmAxER7pR-eoJ4xs2EbGopsS4SWd+wo88xZbzkmPJp-Bw@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 02/14] arm64/ptrace: Use syscall_get_nr()
 helper for syscall_trace_enter()
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

> Use syscall_get_nr() to get syscall number for syscall_trace_enter().
> This aligns arm64's internal tracing logic with the generic
> entry framework.
>
> [Changes]
> 1. Use syscall_get_nr() helper:
>    - Replace direct regs->syscallno access with
>      syscall_get_nr(current, regs).
>    - This helper is functionally equivalent to direct access on arm64.
>
> 2. Re-read syscall number after tracepoint:
>   - Re-fetch the syscall number after trace_sys_enter() as it may have
>     been modified by BPF or ftrace probes, matching generic entry behavio=
r.
>
> [Why this matters]
> - Aligns arm64 with the generic entry interface.
> - Makes future migration to generic entry framework.
> - Properly handles syscall number modifications by tracers.
> - Uses standard architecture-independent helpers.
>
> No functional changes intended.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
