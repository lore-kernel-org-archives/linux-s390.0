Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgKCPK0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 10:10:26 -0500
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
References: <yt9do8ke4seh.fsf@linux.ibm.com>
        <75a238c7-fc37-21dd-bd89-d4c87a206eaa@kernel.dk>
Date: Tue, 03 Nov 2020 16:03:09 +0100
In-Reply-To: <75a238c7-fc37-21dd-bd89-d4c87a206eaa@kernel.dk> (Jens Axboe's
        message of "Tue, 3 Nov 2020 07:09:06 -0700")
Message-ID: <yt9dk0v21o0i.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>

Hi Jens,

Jens Axboe <axboe@kernel.dk> writes:

> On 11/3/20 4:00 AM, Sven Schnelle wrote:
>> Hi Jens,
>> 
>> Heiko Carstens <hca () linux ! ibm ! com> writes:
>> 
>>> On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
>>>> Wire up TIF_NOTIFY_SIGNAL handling for s390.
>>>>
>>>> Cc: linux-s390@vger.kernel.org
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>
>>>> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
>>>> for details:
>>>>
>>>> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>>>>
>>>> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
>>>> as that will enable a set of cleanups once all of them support it. I'm
>>>> happy carrying this patch if need be, or it can be funelled through the
>>>> arch tree. Let me know.
>>>>
>>>>  arch/s390/include/asm/thread_info.h | 2 ++
>>>>  arch/s390/kernel/entry.S            | 7 ++++++-
>>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
>>>> index 13a04fcf7762..0045341ade48 100644
>>>> --- a/arch/s390/include/asm/thread_info.h
>>>> +++ b/arch/s390/include/asm/thread_info.h
>>>> @@ -65,6 +65,7 @@ void arch_setup_new_exec(void);
>>>>  #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
>>>>  #define TIF_PATCH_PENDING	5	/* pending live patching update */
>>>>  #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
>>>> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>>>>  #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
>>>>  #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
>>>>  
>>>> @@ -82,6 +83,7 @@ void arch_setup_new_exec(void);
>>>>  #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
>>>>  
>>>>  #define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
>>>> +#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
>>>>  #define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
>>>>  #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
>>>>  #define _TIF_UPROBE		BIT(TIF_UPROBE)
>>>> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
>>>> index 86235919c2d1..a30d891e8045 100644
>>>> --- a/arch/s390/kernel/entry.S
>>>> +++ b/arch/s390/kernel/entry.S
>>>> @@ -52,7 +52,8 @@ STACK_SIZE  = 1 << STACK_SHIFT
>>>>  STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
>>>>  
>>>>  _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
>>>> -		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING)
>>>> +		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING | \
>>>> +		   _TIF_NOTIFY_SIGNAL)
>>>>  _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
>>>>  		   _TIF_SYSCALL_TRACEPOINT)
>>>>  _CIF_WORK	= (_CIF_ASCE_PRIMARY | _CIF_ASCE_SECONDARY | _CIF_FPU)
>>>> @@ -463,6 +464,8 @@ ENTRY(system_call)
>>>>  #endif
>>>>  	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
>>>>  	jo	.Lsysc_syscall_restart
>>>> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
>>>> +	jo	.Lsysc_sigpending
>>>>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>>>>  	jo	.Lsysc_sigpending
>>>>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>>>> @@ -857,6 +860,8 @@ ENTRY(io_int_handler)
>>>>  #endif
>>>>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>>>>  	jo	.Lio_sigpending
>>>> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
>>>> +	jo	.Lio_sigpending
>>>>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>>>>  	jo	.Lio_notify_resume
>>>>  	TSTMSK	__TI_flags(%r12),_TIF_GUARDED_STORAGE
>>>
>>> (full quote so you can make sense of the patch below).
>>>
>>> Please merge the patch below into this one. With that:
>>>
>>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>>>
>>> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
>>> index a30d891e8045..31f16d903ef3 100644
>>> --- a/arch/s390/kernel/entry.S
>>> +++ b/arch/s390/kernel/entry.S
>>> @@ -464,9 +464,7 @@ ENTRY(system_call)
>>>  #endif
>>>  	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
>>>  	jo	.Lsysc_syscall_restart
>>> -	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
>>> -	jo	.Lsysc_sigpending
>>> -	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>>> +	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
>>>  	jo	.Lsysc_sigpending
>> 
>> We need to also change the jo to jnz - in combination with tm, jo means
>> 'jump if all tested bits are set' while jnz means 'jump if at least one
>> bit is set'
>
> Ah thanks, good catch. And you also caught the braino in signal.c, here's
> the end result:
>
>
> commit 0eb7d372d5319970bd15f2dbc18264ea576214d4
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Oct 9 15:34:12 2020 -0600
>
>     s390: add support for TIF_NOTIFY_SIGNAL
>     
>     Wire up TIF_NOTIFY_SIGNAL handling for s390.
>     
>     Cc: linux-s390@vger.kernel.org
>     Acked-by: Heiko Carstens <hca@linux.ibm.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
> index 13a04fcf7762..0045341ade48 100644
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -65,6 +65,7 @@ void arch_setup_new_exec(void);
>  #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
>  #define TIF_PATCH_PENDING	5	/* pending live patching update */
>  #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>  #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
>  #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
>  
> @@ -82,6 +83,7 @@ void arch_setup_new_exec(void);
>  #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
>  
>  #define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
> +#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
>  #define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
>  #define _TIF_UPROBE		BIT(TIF_UPROBE)
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 86235919c2d1..19a89f292290 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -52,7 +52,8 @@ STACK_SIZE  = 1 << STACK_SHIFT
>  STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
>  
>  _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
> -		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING)
> +		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING | \
> +		   _TIF_NOTIFY_SIGNAL)
>  _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
>  		   _TIF_SYSCALL_TRACEPOINT)
>  _CIF_WORK	= (_CIF_ASCE_PRIMARY | _CIF_ASCE_SECONDARY | _CIF_FPU)
> @@ -463,8 +464,8 @@ ENTRY(system_call)
>  #endif
>  	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
>  	jo	.Lsysc_syscall_restart
> -	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
> -	jo	.Lsysc_sigpending
> +	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
> +	jnz	.Lsysc_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>  	jo	.Lsysc_notify_resume
>  	TSTMSK	__LC_CPU_FLAGS,(_CIF_ASCE_PRIMARY|_CIF_ASCE_SECONDARY)
> @@ -855,8 +856,8 @@ ENTRY(io_int_handler)
>  	TSTMSK	__TI_flags(%r12),_TIF_PATCH_PENDING
>  	jo	.Lio_patch_pending
>  #endif
> -	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
> -	jo	.Lio_sigpending
> +	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
> +	jnz	.Lio_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>  	jo	.Lio_notify_resume
>  	TSTMSK	__TI_flags(%r12),_TIF_GUARDED_STORAGE
> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 9e900a8977bd..b27b6c1f058d 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -472,7 +472,7 @@ void do_signal(struct pt_regs *regs)
>  	current->thread.system_call =
>  		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
>  
> -	if (get_signal(&ksig)) {
> +	if (test_thread_flag(TIF_SIGPENDING) && get_signal(&ksig)) {
>  		/* Whee!  Actually deliver the signal.  */
>  		if (current->thread.system_call) {
>  			regs->int_code = current->thread.system_call;

Looks good, feel free to add my Acked-by.

Thanks
Sven
