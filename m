Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA53EF0AC;
	Thu, 19 Mar 2026 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939961; cv=none; b=C+Q6gLcFaJIscUzsDxlDFxNAqez5ty6J9yG1tGYtPIK+5CMQYWrpAuTujVMG+J91DopWh3sgAusLvJK5qSh65HMBKeZ7dknLzv3fjBdTUhAcunxY/ooyl/XrpYnezD1zrCL+/TupEX9rjQl2xt8ErjogiAC2ft9FIkKGMiWOXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939961; c=relaxed/simple;
	bh=Ls+mlgIowV8QKL/4RoOexl9oFDqYAejYbw2aCMinSWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rtu0X48HMhb2uSxezppFsTHDM+yxbA72C9zkwYnuMJH3VTAvk7LzN5cOGOCZEFYSS38TVIfw/u8CcRkUaRAumkp6TR+eWvvDF4L7sorkWqTs/0H/tmxhEBR6+I0NkQZ093JvJVOSeiFLiuljw7DNrO3/K2FCwhsFtY8md6GJkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E051758;
	Thu, 19 Mar 2026 10:05:52 -0700 (PDT)
Received: from [10.57.60.82] (unknown [10.57.60.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D40B3F778;
	Thu, 19 Mar 2026 10:05:50 -0700 (PDT)
Message-ID: <ad0096a6-91b2-465e-bda2-3fecbdd73570@arm.com>
Date: Thu, 19 Mar 2026 18:05:48 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 RESEND 12/14] asm-generic: Move TIF_SINGLESTEP to
 generic TIF bits
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
 <20260317082020.737779-13-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260317082020.737779-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2026 09:20, Jinjie Ruan wrote:
> Currently, x86, ARM64, s390, and LoongArch all define and use
> TIF_SINGLESTEP to track single-stepping state.
>
> Since this flag is shared across multiple major architectures and serves
> a common purpose in the generic entry/exit paths, move TIF_SINGLESTEP
> into the generic Thread Information Flags (TIF) infrastructure.
>
> This consolidation reduces architecture-specific boilerplate code and
> ensures consistency for generic features that rely on single-step
> state tracking.
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

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
