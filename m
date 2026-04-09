Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5237F75B;
	Thu,  9 Apr 2026 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720571; cv=none; b=TsAs93D767QXCoaNj6S6RrSFQRAJo4n8uMOWpEKM0YuZvUFHcaHKRpXc3uwBMfLfGJ7KPIP0HVndY05WtlXbV7tzkg/1xviIzAsp6pNgX8Uh91vKnuyt66ZLru3TVjg3dX65cuLVWX0EZUv9FjHDiENblUu4z1wdl6fFOWqcBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720571; c=relaxed/simple;
	bh=1WW7kSn9WxA8RcNQPxCAbLe2xCMWLXrH3wMCxgS7DNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGFa7gu8pGFuaVTl7wif5iSYWgRG3dyT/ZWQJIqsNLw6hIUxyVwAFRGJUaO7lH0hImmyBZ5I8zwES4A4+2a6wtuYOZrVrO0ZbjghBEFeDxlvBl10pOYSthTwo1W4h0/Ws4P8gmm7RLcjNFEEgfRRMFb7795I/fozJ21QjSydt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d8GUs/B3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d8GUs/B3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 020763561;
	Thu,  9 Apr 2026 00:42:40 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2BFD3F632;
	Thu,  9 Apr 2026 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775720565; bh=1WW7kSn9WxA8RcNQPxCAbLe2xCMWLXrH3wMCxgS7DNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8GUs/B3jDW2frdZiV8QPiYbk9v18VZd7X15RxiS1RqB+79dOyj9M/gsATt3nMdbo
	 sfUtUYCcV+gEJlbpIFOxTu0F6+OEFgVqJOQyRKt9wK39FJm3q0cUrfDwdmVVz7kTRT
	 6fWMWLO4tHky73CtIu7mYttYuuLUx2FUb47JuCq0=
Date: Thu, 9 Apr 2026 08:42:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, oleg@redhat.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, shuah@kernel.org,
	kevin.brodsky@arm.com, yeoreum.yun@arm.com,
	anshuman.khandual@arm.com, thuth@redhat.com, ryan.roberts@arm.com,
	song@kernel.org, ziyao@disroot.org, linusw@kernel.org,
	schuster.simon@siemens-energy.com, jremus@linux.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v14 2/4] asm-generic: Move TIF_SINGLESTEP to generic TIF
 bits
Message-ID: <addYbV3_9eFZg_b4@J2N7QTR9R3>
References: <20260320104222.1381274-1-ruanjinjie@huawei.com>
 <20260320104222.1381274-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320104222.1381274-3-ruanjinjie@huawei.com>

On Fri, Mar 20, 2026 at 06:42:20PM +0800, Jinjie Ruan wrote:
> Currently, x86, ARM64, s390, and LoongArch all define and use
> TIF_SINGLESTEP to track single-stepping state.

Do the architectures actually use the flag in the same way?

I'd expect that this is used subtly differently across those
architectures, and so isn't necessarily generic.

> Since this flag is shared across multiple major architectures and serves
> a common purpose in the generic entry/exit paths, move TIF_SINGLESTEP
> into the generic Thread Information Flags (TIF) infrastructure.
> 
> This consolidation reduces architecture-specific boilerplate code and
> ensures consistency for generic features that rely on single-step
> state tracking.

Is it necessary to make this generic in order to move to generic irq
flags? I'd expect that generic code cannot make use of this due to the
different semantics across architectures, as noted abobve.

I think it's probably better to keep this architecture-specific for now,
where architectures can clearly define how they're using this bit.

Am I missing some reason why it's necessary to make this generic?

Mark.

> Cc: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/loongarch/include/asm/thread_info.h | 11 +++++------
>  arch/s390/include/asm/thread_info.h      |  7 +++----
>  arch/x86/include/asm/thread_info.h       |  6 ++----
>  include/asm-generic/thread_info_tif.h    |  5 +++++
>  4 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
> index 4d7117fcdc78..a2ec87f18e1d 100644
> --- a/arch/loongarch/include/asm/thread_info.h
> +++ b/arch/loongarch/include/asm/thread_info.h
> @@ -70,6 +70,7 @@ register unsigned long current_stack_pointer __asm__("$sp");
>   */
>  #define HAVE_TIF_NEED_RESCHED_LAZY
>  #define HAVE_TIF_RESTORE_SIGMASK
> +#define HAVE_TIF_SINGLESTEP
>  
>  #include <asm-generic/thread_info_tif.h>
>  
> @@ -82,11 +83,10 @@ register unsigned long current_stack_pointer __asm__("$sp");
>  #define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
>  #define TIF_32BIT_ADDR		22	/* 32-bit address space */
>  #define TIF_LOAD_WATCH		23	/* If set, load watch registers */
> -#define TIF_SINGLESTEP		24	/* Single Step */
> -#define TIF_LSX_CTX_LIVE	25	/* LSX context must be preserved */
> -#define TIF_LASX_CTX_LIVE	26	/* LASX context must be preserved */
> -#define TIF_USEDLBT		27	/* LBT was used by this task this quantum (SMP) */
> -#define TIF_LBT_CTX_LIVE	28	/* LBT context must be preserved */
> +#define TIF_LSX_CTX_LIVE	24	/* LSX context must be preserved */
> +#define TIF_LASX_CTX_LIVE	25	/* LASX context must be preserved */
> +#define TIF_USEDLBT		26	/* LBT was used by this task this quantum (SMP) */
> +#define TIF_LBT_CTX_LIVE	27	/* LBT context must be preserved */
>  
>  #define _TIF_NOHZ		BIT(TIF_NOHZ)
>  #define _TIF_USEDFPU		BIT(TIF_USEDFPU)
> @@ -96,7 +96,6 @@ register unsigned long current_stack_pointer __asm__("$sp");
>  #define _TIF_32BIT_REGS		BIT(TIF_32BIT_REGS)
>  #define _TIF_32BIT_ADDR		BIT(TIF_32BIT_ADDR)
>  #define _TIF_LOAD_WATCH		BIT(TIF_LOAD_WATCH)
> -#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
>  #define _TIF_LSX_CTX_LIVE	BIT(TIF_LSX_CTX_LIVE)
>  #define _TIF_LASX_CTX_LIVE	BIT(TIF_LASX_CTX_LIVE)
>  #define _TIF_USEDLBT		BIT(TIF_USEDLBT)
> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
> index 1bcd42614e41..95be5258a422 100644
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -61,6 +61,7 @@ void arch_setup_new_exec(void);
>   */
>  #define HAVE_TIF_NEED_RESCHED_LAZY
>  #define HAVE_TIF_RESTORE_SIGMASK
> +#define HAVE_TIF_SINGLESTEP
>  
>  #include <asm-generic/thread_info_tif.h>
>  
> @@ -69,15 +70,13 @@ void arch_setup_new_exec(void);
>  #define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
>  #define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
>  #define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
> -#define TIF_SINGLESTEP		21	/* This task is single stepped */
> -#define TIF_BLOCK_STEP		22	/* This task is block stepped */
> -#define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
> +#define TIF_BLOCK_STEP		20	/* This task is block stepped */
> +#define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
>  
>  #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
>  #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
>  #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
>  #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
> -#define _TIF_SINGLESTEP	BIT(TIF_SINGLESTEP)
>  #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
>  #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
>  
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 0067684afb5b..f59072ba1473 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -98,9 +98,8 @@ struct thread_info {
>  #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
>  #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
>  #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
> -#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
> -#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
> -#define TIF_ADDR32		27	/* 32-bit address space on 64 bits */
> +#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
> +#define TIF_ADDR32		26	/* 32-bit address space on 64 bits */
>  
>  #define _TIF_SSBD		BIT(TIF_SSBD)
>  #define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
> @@ -112,7 +111,6 @@ struct thread_info {
>  #define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
>  #define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
>  #define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
> -#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
>  #define _TIF_ADDR32		BIT(TIF_ADDR32)
>  
>  /* flags to check in __switch_to() */
> diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thread_info_tif.h
> index da1610a78f92..b277fe06aee3 100644
> --- a/include/asm-generic/thread_info_tif.h
> +++ b/include/asm-generic/thread_info_tif.h
> @@ -48,4 +48,9 @@
>  #define TIF_RSEQ		11	// Run RSEQ fast path
>  #define _TIF_RSEQ		BIT(TIF_RSEQ)
>  
> +#ifdef HAVE_TIF_SINGLESTEP
> +#define TIF_SINGLESTEP		12	/* reenable singlestep on user return*/
> +#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
> +#endif
> +
>  #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
> -- 
> 2.34.1
> 
