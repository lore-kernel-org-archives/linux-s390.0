Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A33EF0A6;
	Thu, 19 Mar 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939929; cv=none; b=PxfgGnbnN6pKsVr8XHdMb+R/lHXw0EmlIbTUJdcsa11TGDIEDq0s9kqMSb2Z63e990ivs7dOueNrsPY1soZLySxMX5efevEV0qmQzMQo862+IIDfmUlxswPSWK2coBZJh9pDPu1f6Uc5DgiiM6whPVTXeRGMXqgn8uUw/A83xWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939929; c=relaxed/simple;
	bh=Gf5XBFJJvDKd0hS1w0/LnzSIYLjFJzLH0x+kzjR0qA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fj5DrnJ8oSqpkwtJf1Uqjj1m1m4v3keg9gj4GSpEpnkgFCNSsmsgXLyBJTUuOYA9mQS1smEn6SoXifjJ+LW+J9/vx38hoGogUbT3R/dkcyYoCoNy9ASPeLl4WAt3BDvuSjR/H2DEfQquzyJRa8fmPStkY7Ed1AHcFIuY1rFNP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2AF1A25;
	Thu, 19 Mar 2026 10:05:20 -0700 (PDT)
Received: from [10.57.60.82] (unknown [10.57.60.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BB053F778;
	Thu, 19 Mar 2026 10:05:16 -0700 (PDT)
Message-ID: <64da7780-3176-461f-b61d-7a5828ce55a4@arm.com>
Date: Thu, 19 Mar 2026 18:05:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 RESEND 11/14] s390: Rename TIF_SINGLE_STEP to
 TIF_SINGLESTEP
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
 <20260317082020.737779-12-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260317082020.737779-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2026 09:20, Jinjie Ruan wrote:
> Rename TIF_SINGLE_STEP to TIF_SINGLESTEP to align with the naming
> convention used by arm64, x86, and other architectures.
>
> By aligning the name, TIF_SINGLESTEP can be consolidated into the generic
> TIF bits definitions, reducing architectural divergence and simplifying
> cross-architecture entry/exit logic.
>
> No functional changes intended.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/s390/include/asm/thread_info.h |  4 ++--
>  arch/s390/kernel/process.c          |  2 +-
>  arch/s390/kernel/ptrace.c           | 20 ++++++++++----------
>  arch/s390/kernel/signal.c           |  6 +++---
>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
> index 6a548a819400..1bcd42614e41 100644
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -69,7 +69,7 @@ void arch_setup_new_exec(void);
>  #define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
>  #define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
>  #define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
> -#define TIF_SINGLE_STEP		21	/* This task is single stepped */
> +#define TIF_SINGLESTEP		21	/* This task is single stepped */
>  #define TIF_BLOCK_STEP		22	/* This task is block stepped */
>  #define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
>  
> @@ -77,7 +77,7 @@ void arch_setup_new_exec(void);
>  #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
>  #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
>  #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
> -#define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
> +#define _TIF_SINGLESTEP	BIT(TIF_SINGLESTEP)
>  #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
>  #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
>  
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index 0df95dcb2101..3accc0c064a0 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -122,7 +122,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	/* Don't copy debug registers */
>  	memset(&p->thread.per_user, 0, sizeof(p->thread.per_user));
>  	memset(&p->thread.per_event, 0, sizeof(p->thread.per_event));
> -	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
> +	clear_tsk_thread_flag(p, TIF_SINGLESTEP);
>  	p->thread.per_flags = 0;
>  	/* Initialize per thread user and system timer values */
>  	p->thread.user_timer = 0;
> diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> index 125ca4c4e30c..d2cf91f4ac3f 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c
> @@ -90,8 +90,8 @@ void update_cr_regs(struct task_struct *task)
>  	new.start.val = thread->per_user.start;
>  	new.end.val = thread->per_user.end;
>  
> -	/* merge TIF_SINGLE_STEP into user specified PER registers. */
> -	if (test_tsk_thread_flag(task, TIF_SINGLE_STEP) ||
> +	/* merge TIF_SINGLESTEP into user specified PER registers. */
> +	if (test_tsk_thread_flag(task, TIF_SINGLESTEP) ||
>  	    test_tsk_thread_flag(task, TIF_UPROBE_SINGLESTEP)) {
>  		if (test_tsk_thread_flag(task, TIF_BLOCK_STEP))
>  			new.control.val |= PER_EVENT_BRANCH;
> @@ -119,18 +119,18 @@ void update_cr_regs(struct task_struct *task)
>  void user_enable_single_step(struct task_struct *task)
>  {
>  	clear_tsk_thread_flag(task, TIF_BLOCK_STEP);
> -	set_tsk_thread_flag(task, TIF_SINGLE_STEP);
> +	set_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
>  void user_disable_single_step(struct task_struct *task)
>  {
>  	clear_tsk_thread_flag(task, TIF_BLOCK_STEP);
> -	clear_tsk_thread_flag(task, TIF_SINGLE_STEP);
> +	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
>  void user_enable_block_step(struct task_struct *task)
>  {
> -	set_tsk_thread_flag(task, TIF_SINGLE_STEP);
> +	set_tsk_thread_flag(task, TIF_SINGLESTEP);
>  	set_tsk_thread_flag(task, TIF_BLOCK_STEP);
>  }
>  
> @@ -143,7 +143,7 @@ void ptrace_disable(struct task_struct *task)
>  {
>  	memset(&task->thread.per_user, 0, sizeof(task->thread.per_user));
>  	memset(&task->thread.per_event, 0, sizeof(task->thread.per_event));
> -	clear_tsk_thread_flag(task, TIF_SINGLE_STEP);
> +	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  	clear_tsk_thread_flag(task, TIF_PER_TRAP);
>  	task->thread.per_flags = 0;
>  }
> @@ -155,19 +155,19 @@ static inline unsigned long __peek_user_per(struct task_struct *child,
>  {
>  	if (addr == offsetof(struct per_struct_kernel, cr9))
>  		/* Control bits of the active per set. */
> -		return test_thread_flag(TIF_SINGLE_STEP) ?
> +		return test_thread_flag(TIF_SINGLESTEP) ?
>  			PER_EVENT_IFETCH : child->thread.per_user.control;
>  	else if (addr == offsetof(struct per_struct_kernel, cr10))
>  		/* Start address of the active per set. */
> -		return test_thread_flag(TIF_SINGLE_STEP) ?
> +		return test_thread_flag(TIF_SINGLESTEP) ?
>  			0 : child->thread.per_user.start;
>  	else if (addr == offsetof(struct per_struct_kernel, cr11))
>  		/* End address of the active per set. */
> -		return test_thread_flag(TIF_SINGLE_STEP) ?
> +		return test_thread_flag(TIF_SINGLESTEP) ?
>  			-1UL : child->thread.per_user.end;
>  	else if (addr == offsetof(struct per_struct_kernel, bits))
>  		/* Single-step bit. */
> -		return test_thread_flag(TIF_SINGLE_STEP) ?
> +		return test_thread_flag(TIF_SINGLESTEP) ?
>  			(1UL << (BITS_PER_LONG - 1)) : 0;
>  	else if (addr == offsetof(struct per_struct_kernel, starting_addr))
>  		/* Start address of the user specified per set. */
> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 4874de5edea0..83f7650f2032 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -423,7 +423,7 @@ static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
>  	else
>  		ret = setup_frame(ksig->sig, &ksig->ka, oldset, regs);
>  
> -	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLE_STEP));
> +	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
>  }
>  
>  /*
> @@ -491,7 +491,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  			regs->gprs[2] = regs->orig_gpr2;
>  			current->restart_block.arch_data = regs->psw.addr;
>  			regs->psw.addr = VDSO_SYMBOL(current, restart_syscall);
> -			if (test_thread_flag(TIF_SINGLE_STEP))
> +			if (test_thread_flag(TIF_SINGLESTEP))
>  				clear_thread_flag(TIF_PER_TRAP);
>  			break;
>  		case -ERESTARTNOHAND:
> @@ -499,7 +499,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  		case -ERESTARTNOINTR:
>  			regs->gprs[2] = regs->orig_gpr2;
>  			regs->psw.addr = __rewind_psw(regs->psw, regs->int_code >> 16);
> -			if (test_thread_flag(TIF_SINGLE_STEP))
> +			if (test_thread_flag(TIF_SINGLESTEP))
>  				clear_thread_flag(TIF_PER_TRAP);
>  			break;
>  		}
