Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE534405C;
	Thu, 19 Mar 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940094; cv=none; b=edWrBBdEx/jNO0p0WkNjdMFh9ZCSPzQi7QrGZpHvw+UoRVAxRnRqbUpWtQeIFAKfXiEnSR3Wxzln+WO9TRnfBCqcHlxZxxWjJdGIXpTD2OUs77Qgg4Ee9RWU6Q/748NEAUMWD89JNnTsEVD/7BW9kOYJlgVOXk1wu1BVc4f+HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940094; c=relaxed/simple;
	bh=T43xfGTyy+CkhFtBZ/lvhJq/l+Hy1fuTD/+fXPUaTG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JDVTAewFAwBULLFEpp5oz/PXuvlndGsfPFW5MqwyoRzsIGOLGm1IEJ8TAC+AefiaCUuun/wlhg3qwDc3OkzLUjOST+Q6VycDEaVUH0V0tt8sj+3TnnUopXA8tEoIvo2qWngJ9GTk4IGO9um2XVcDct3vFKDidBnOQEDbfhgivgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556462247;
	Thu, 19 Mar 2026 10:08:05 -0700 (PDT)
Received: from [10.57.60.82] (unknown [10.57.60.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D683F778;
	Thu, 19 Mar 2026 10:08:01 -0700 (PDT)
Message-ID: <16598f59-df24-488b-af74-e3f2a2732755@arm.com>
Date: Thu, 19 Mar 2026 18:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 RESEND 13/14] arm64: Use generic TIF bits for common
 thread flags
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, chenhuacai@kernel.org, kernel@xen0n.name,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 arnd@arndb.de, peterz@infradead.org, luto@kernel.org, shuah@kernel.org,
 kees@kernel.org, wad@chromium.org, deller@gmx.de, macro@orcam.me.uk,
 akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com,
 song@kernel.org, ada.coupriediaz@arm.com, linusw@kernel.org,
 broonie@kernel.org, pengcan@kylinos.cn, liqiang01@kylinos.cn,
 ziyao@disroot.org, guanwentao@uniontech.com, guoren@kernel.org,
 schuster.simon@siemens-energy.com, jremus@linux.ibm.com, david@kernel.org,
 mathieu.desnoyers@efficios.com, edumazet@google.com, kmal@cock.li,
 dvyukov@google.com, reddybalavignesh9979@gmail.com, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
 <20260317082020.737779-14-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260317082020.737779-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2026 09:20, Jinjie Ruan wrote:
> Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
> standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME,
> TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
> them locally.
>
> Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
> TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.
>
> This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BITS
> combined with the generic entry infrastructure (already used by arm64).
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/thread_info.h | 62 ++++++++++++----------------
>  2 files changed, 28 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 96fef01598be..33cf901fb1a0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -224,6 +224,7 @@ config ARM64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>  	select HAVE_BUILDTIME_MCOUNT_SORT
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	select HAVE_GENERIC_TIF_BITS
>  	select HAVE_GUP_FAST
>  	select HAVE_FTRACE_GRAPH_FUNC
>  	select HAVE_FUNCTION_TRACER
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f89a15dc6ad5..be1a0651cfe2 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -58,42 +58,34 @@ void arch_setup_new_exec(void);
>  
>  #endif
>  
> -#define TIF_SIGPENDING		0	/* signal pending */
> -#define TIF_NEED_RESCHED	1	/* rescheduling necessary */
> -#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
> -#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
> -#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
> -#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
> -#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
> -#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> -#define TIF_PATCH_PENDING	13	/* pending live patching update */
> -#define TIF_MEMDIE		18	/* is terminating due to OOM killer */
> -#define TIF_FREEZE		19
> -#define TIF_RESTORE_SIGMASK	20
> -#define TIF_SINGLESTEP		21
> -#define TIF_32BIT		22	/* 32bit process */
> -#define TIF_SVE			23	/* Scalable Vector Extension in use */
> -#define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
> -#define TIF_SSBD		25	/* Wants SSB mitigation */
> -#define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
> -#define TIF_SME			27	/* SME in use */
> -#define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
> -#define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
> -#define TIF_TSC_SIGSEGV		30	/* SIGSEGV on counter-timer access */
> -#define TIF_LAZY_MMU_PENDING	31	/* Ops pending for lazy mmu mode exit */
> +/*
> + * Tell the generic TIF infrastructure which bits arm64 supports
> + */
> +#define HAVE_TIF_NEED_RESCHED_LAZY
> +#define HAVE_TIF_RESTORE_SIGMASK
> +#define HAVE_TIF_SINGLESTEP
> +
> +#include <asm-generic/thread_info_tif.h>
> +
> +#define TIF_FOREIGN_FPSTATE	16	/* CPU's FP state is not current's */
> +#define TIF_MTE_ASYNC_FAULT	17	/* MTE Asynchronous Tag Check Fault */
> +#define TIF_FREEZE		18

Turns out this flag became unused a long time ago, see commit
d88e4cb67197 ("freezer: remove now unused TIF_FREEZE"), and it was
probably reintroduced by mistake in the original arm64 implementation,
commit b3901d54dc4f ("arm64: Process management"). Good opportunity to
remove it I think.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> +#define TIF_32BIT		19      /* 32bit process */
> +#define TIF_SVE			20	/* Scalable Vector Extension in use */
> +#define TIF_SVE_VL_INHERIT	21	/* Inherit SVE vl_onexec across exec */
> +#define TIF_SSBD		22	/* Wants SSB mitigation */
> +#define TIF_TAGGED_ADDR		23	/* Allow tagged user addresses */
> +#define TIF_SME			24	/* SME in use */
> +#define TIF_SME_VL_INHERIT	25	/* Inherit SME vl_onexec across exec */
> +#define TIF_KERNEL_FPSTATE	26	/* Task is in a kernel mode FPSIMD section */
> +#define TIF_TSC_SIGSEGV		27	/* SIGSEGV on counter-timer access */
> +#define TIF_LAZY_MMU_PENDING	28	/* Ops pending for lazy mmu mode exit */
>  
> -#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> -#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> -#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
> -#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> -#define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
> -#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
> -#define _TIF_UPROBE		(1 << TIF_UPROBE)
> -#define _TIF_32BIT		(1 << TIF_32BIT)
> -#define _TIF_SVE		(1 << TIF_SVE)
> -#define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
> -#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
> -#define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
> +#define _TIF_FOREIGN_FPSTATE	BIT(TIF_FOREIGN_FPSTATE)
> +#define _TIF_32BIT		BIT(TIF_32BIT)
> +#define _TIF_SVE		BIT(TIF_SVE)
> +#define _TIF_MTE_ASYNC_FAULT	BIT(TIF_MTE_ASYNC_FAULT)
> +#define _TIF_TSC_SIGSEGV	BIT(TIF_TSC_SIGSEGV)
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  #define INIT_SCS							\
