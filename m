Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC42408033;
	Fri,  5 Jun 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641022; cv=none; b=qfTQ6/TLCO0QAFhPAwjeKzIrfTPHPp/u+hCaxJPz7zkej5mbudYvb2cH5XzuJWTNXVaVBfrNMXu30Z2ohDuH3QcMHTpXjwf+5Hvc9d34eP3pMVV8rS7uWSMsjhTJJH7iWjlzpwqdlDZk1s1QjmG67s6Jb2E/03RzqQXZuBVGWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641022; c=relaxed/simple;
	bh=b7fyKzhjw4yx3OaqAa3FKuCwhuCp9NuXnczYKyFON00=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UhFftrMDU+4CLJl5lKP259bKhhkcuJ5Q/mwMw7DbDrwEpjhS1Rw2oG80F5jBWJLf+Ri3uIqZu8xiDYNUgH5qHXRgPuH5pbty7cnRchgRw8u7z8uMQps5LPaH9G1+1O/6fd1KaS/aIJuVQs5wQRnHZcP4EElDEFr30BtA0/fBtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4dTp+wV reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4dTp+wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53EC1F00893;
	Fri,  5 Jun 2026 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641020;
	bh=ZuCEbTdg7Jvg/3RTGozyLFZtT0FjVHWOOoiUv+zGjX8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H4dTp+wVDiRNcUShgm1dL5dR6Tk83U4HJ3+rbGVRR2YEQt9BGsgO6w0jLtbvThZLx
	 AyyU7p0Z/0eIMfhQQFZvPw4FjH/6jaKXWtQ1rFzkGeewQpukxF1bejycPV5P2pxt94
	 4Z/a2iSiVNzHCgdYm3sDI/uPYEICv4kGu52Ya2Bh1CTftj0yqZp3A7D51TstjWB5AS
	 DRSg8zbg4eTysQr4pKWQlt+Lrni9PITOiUg/HgOrBNoVk1WsWkR3ueAZuWQKjZtiXA
	 umEJLRkkAN5OIbh6H0UdUQ4AM39TQ8rPBGytoRWDg0yTBchxBEEEgU/7e3LDF5Gy/X
	 jDGbyjUG7DthA==
Content-Type: multipart/mixed; boundary="===============2479707455285012343=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab3d42abe5ed92f3a7c40a961ed14ae1dbad4789f9d41b0c484a020e723e8ac4@mail.kernel.org>
In-Reply-To: <20260605054128.5925-11-boqun@kernel.org>
References: <20260605054128.5925-11-boqun@kernel.org>
Subject: Re: [PATCH v3 10/13] preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS
From: bot+bpf-ci@kernel.org
To: boqun@kernel.org,peterz@infradead.org
Cc: catalin.marinas@arm.com,will@kernel.org,jonas@southpole.se,stefan.kristiansson@saunalahti.fi,shorne@gmail.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com,svens@linux.ibm.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,arnd@arndb.de,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,boqun@kernel.org,longman@redhat.com,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,ojeda@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ruanjinjie@huawei.com,lyude@redhat.com,thuth@redhat.com,sohil.mehta@intel.com,pawan.kumar.
 gupta@linux.intel.com,seanjc@google.com,nikunj@amd.com,xin@zytor.com,joelagnelf@nvidia.com,andriy.shevchenko@linux.intel.com,rdunlap@infradead.org,ynorov@nvidia.com,bigeasy@linutronix.de,linux-kernel@vger.kernel.org,linux-openrisc@vger.kernel.org,linux-s390@vger.kernel.org,linux-arch@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,rust-for-linux@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 06:30:18 +0000 (UTC)

--===============2479707455285012343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f3f7cb01d69d..bf8288b3d52b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -327,6 +327,7 @@ config X86
>  	select USER_STACKTRACE_SUPPORT
>  	select HAVE_ARCH_KCSAN			if X86_64
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS		if X86_64
>  	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX

A subsystem pattern flags this as potentially concerning: selecting
HAS_SEPARATE_PREEMPT_RESCHED_BITS with only the X86_64 condition may
bypass the PREEMPT_COUNT dependency.

Looking at the definition in kernel/Kconfig.preempt, the config symbol
HAS_SEPARATE_PREEMPT_RESCHED_BITS explicitly depends on both PREEMPT_COUNT
and 64BIT:

kernel/Kconfig.preempt:
    config HAS_SEPARATE_PREEMPT_RESCHED_BITS
        bool
        depends on PREEMPT_COUNT && 64BIT

PREEMPT_COUNT is not always enabled. It gets selected by PREEMPTION, and
by a few debug configs (CONFIG_DEBUG_PREEMPT, DEBUG_ATOMIC_SLEEP,
PREEMPT_TRACER, etc.), but a standard CONFIG_PREEMPT_NONE=y configuration
without any of those debug options will have PREEMPT_COUNT=n.

In such a configuration, the select statement (gated only by X86_64)
will force HAS_SEPARATE_PREEMPT_RESCHED_BITS=y while its depends on
PREEMPT_COUNT is unmet. This will produce a Kconfig unmet-dependency
warning: "WARNING: unmet direct dependencies detected for
HAS_SEPARATE_PREEMPT_RESCHED_BITS / Depends on [n]: PREEMPT_COUNT &&
64BIT / Selected by [y]: - X86 [=y]".

Sashiko-bot raised this concern in both v2 and v3 of this patch (message
IDs <20260526195703.C90E31F000E9@smtp.kernel.org> and
<20260605055956.46EC81F00893@smtp.kernel.org>), escalating it from Low to
Medium severity:

https://lore.kernel.org/all/20260605055956.46EC81F00893@smtp.kernel.org/

Should this select be conditional on PREEMPT_COUNT? For example:

    select HAS_SEPARATE_PREEMPT_RESCHED_BITS  if X86_64 && PREEMPT_COUNT

[ ... ]

> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 88c594c6d7fc..35f546a042b1 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -122,6 +122,10 @@ config PREEMPT_RT_NEEDS_BH_LOCK
>  config PREEMPT_COUNT
>         bool
>
> +config HAS_SEPARATE_PREEMPT_RESCHED_BITS
> +	bool
> +	depends on PREEMPT_COUNT && 64BIT
> +

This commit fixes a bug but lacks a Fixes: tag. The commit corrects
underflow detection logic in preempt_count_sub() by changing from a signed
comparison to unsigned wraparound detection. The bug was introduced when
commit 7c346d37f86b expanded the preempt_count bit layout by adding 8-bit
HARDIRQ_DISABLE_BITS, increasing total bit usage from 21 to 29 bits.

This expansion highlighted the flaw in the existing signed comparison
underflow check (val > preempt_count()), which doesn't correctly detect
unsigned underflow. The fix properly uses unsigned arithmetic (pc - uval >
pc) to detect wraparound.

Should this include:

  Fixes: 7c346d37f86b ("preempt: Introduce HARDIRQ_DISABLE_BITS")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26998319662
--===============2479707455285012343==--
