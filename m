Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1835DA45;
	Fri, 13 Mar 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403069; cv=none; b=SN6ESMzmO4CsQbKTC5102aXTGlVYg5033+kOKxZQ3cN++QaarOvj+MmHeaqTvQpFqvvjJ4RiEIh25bfdau9YIjBPGyA6XcU2RKn+JV6IDONsH6gYUH7/yGu/OEPWXmBES/X5IF8S9pGLX84TOX04ysE+k1m3tmZdQvi8DoG5AJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403069; c=relaxed/simple;
	bh=CrD3I2JAdDJPk+hpeYfNjnkJT2Gk2XwXZZ5AIzoGlgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P71tkdDgOmQKEiNcc7c57sxdrICnLE/VmxfvZigjOUuariEsPAYmr1rmuo5GnJdHXuxq5o2WgRyFHTdD/8eAHt7HChsfGRhDMP/ByjyWOUpDw+huyPHwVyaue7fewHHy7ZpaMy1f3WBAFD0Htmx8FzWZzZOW5AteA0kRFdUvdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qo6KOLQw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qo6KOLQw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nfiAMheGFm3B9wEX22RY8FMrrz8Bp0H6yrIVSJqYtkE=; b=qo6KOLQwMn3ekceaiDDnPHv4WD
	4LWyiqlIbC6wYdeylyf9WLTAPNBuMAu7HbV83tzMs+RHgKMEo7Dn4seWf33zhVoIIbciY79dBnuYT
	O50eaYNg09aG+RDcwFoWbX4nelYbeolVOadVpLNr6gKLqeOP6A4iFIxdNhIVGFVhRQLIbX/AjX+Xq
	xRwPeJ1fSfLTnwzSKSyUiTQbulTS2G9M380PMs0MeDA5zC82qkooDB7+Jt61zJSyqLdI6BwH8SLGx
	0s4pVcM5WPIteXG3NkLiPG3ucRI01SzT/GSdau0kCE51WzUfzVZDwd9odSAVFBkKPMXPtjnG3VBki
	J5OBlXWg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w118X-0000000D2cC-3C3g;
	Fri, 13 Mar 2026 11:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87EC930327F; Fri, 13 Mar 2026 12:57:00 +0100 (CET)
Date: Fri, 13 Mar 2026 12:57:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, shuah@kernel.org, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, kevin.brodsky@arm.com,
	charlie@rivosinc.com, macro@orcam.me.uk, deller@gmx.de,
	ldv@strace.io, anshuman.khandual@arm.com, song@kernel.org,
	ryan.roberts@arm.com, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	broonie@kernel.org, pengcan@kylinos.cn, liqiang01@kylinos.cn,
	thuth@redhat.com, andreas@gaisler.com,
	schuster.simon@siemens-energy.com, jremus@linux.ibm.com,
	jgross@suse.com, mathieu.desnoyers@efficios.com,
	yeoreum.yun@arm.com, kmal@cock.li, dvyukov@google.com,
	akpm@linux-foundation.org, reddybalavignesh9979@gmail.com,
	richard.weiyang@gmail.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 00/12] arm64: entry: Convert to Generic Entry
Message-ID: <20260313115700.GA2872@noisy.programming.kicks-ass.net>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313094738.3985794-1-ruanjinjie@huawei.com>

On Fri, Mar 13, 2026 at 05:47:26PM +0800, Jinjie Ruan wrote:

> Jinjie Ruan (11):
>   arm64/ptrace: Refactor syscall_trace_enter/exit() to accept flags
>     parameter
>   arm64/ptrace: Expand secure_computing() in place
>   arm64/ptrace: Use syscall_get_arguments() helper for audit
>   arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
>   arm64: syscall: Introduce syscall_exit_to_user_mode_work()
>   arm64/ptrace: Define and use _TIF_SYSCALL_EXIT_WORK
>   arm64/ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
>   arm64: entry: Convert to generic entry
>   arm64: Inline el0_svc_common()
>   s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
>   arm64: Use generic TIF bits for common thread flags
> 
> kemal (1):
>   selftests: sud_test: Support aarch64
> 
>  arch/arm64/Kconfig                            |   3 +-
>  arch/arm64/include/asm/entry-common.h         |  76 ++++++++++++
>  arch/arm64/include/asm/syscall.h              |  19 ++-
>  arch/arm64/include/asm/thread_info.h          |  76 ++++--------
>  arch/arm64/kernel/debug-monitors.c            |   7 ++
>  arch/arm64/kernel/ptrace.c                    | 115 ------------------
>  arch/arm64/kernel/signal.c                    |   2 +-
>  arch/arm64/kernel/syscall.c                   |  29 ++---
>  arch/s390/include/asm/thread_info.h           |   7 +-
>  arch/s390/kernel/process.c                    |   2 +-
>  arch/s390/kernel/ptrace.c                     |  20 +--
>  arch/s390/kernel/signal.c                     |   6 +-
>  arch/x86/include/asm/thread_info.h            |   6 +-
>  include/asm-generic/thread_info_tif.h         |   5 +
>  .../syscall_user_dispatch/sud_benchmark.c     |   2 +-
>  .../syscall_user_dispatch/sud_test.c          |   4 +
>  16 files changed, 166 insertions(+), 213 deletions(-)

AFAICT arm64 is still using exit_to_user_mode_prepare_legacy() after
this. This cannot be right.
