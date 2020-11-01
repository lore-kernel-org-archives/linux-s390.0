Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11276 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgKARcA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 12:32:00 -0500
Date: Sun, 1 Nov 2020 18:31:53 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
Message-ID: <20201101173153.GC9375@osiris>
References: <251a204d-9362-82b7-e5d9-14c55feb2df2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251a204d-9362-82b7-e5d9-14c55feb2df2@kernel.dk>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org

On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
> Wire up TIF_NOTIFY_SIGNAL handling for s390.
> 
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> 
> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> for details:
> 
> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
> 
> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> as that will enable a set of cleanups once all of them support it. I'm
> happy carrying this patch if need be, or it can be funelled through the
> arch tree. Let me know.
> 
>  arch/s390/include/asm/thread_info.h | 2 ++
>  arch/s390/kernel/entry.S            | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
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
> index 86235919c2d1..a30d891e8045 100644
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
> @@ -463,6 +464,8 @@ ENTRY(system_call)
>  #endif
>  	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
>  	jo	.Lsysc_syscall_restart
> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
> +	jo	.Lsysc_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>  	jo	.Lsysc_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
> @@ -857,6 +860,8 @@ ENTRY(io_int_handler)
>  #endif
>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>  	jo	.Lio_sigpending
> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
> +	jo	.Lio_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>  	jo	.Lio_notify_resume
>  	TSTMSK	__TI_flags(%r12),_TIF_GUARDED_STORAGE

(full quote so you can make sense of the patch below).

Please merge the patch below into this one. With that:

Acked-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index a30d891e8045..31f16d903ef3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -464,9 +464,7 @@ ENTRY(system_call)
 #endif
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
 	jo	.Lsysc_syscall_restart
-	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
-	jo	.Lsysc_sigpending
-	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
+	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
 	jo	.Lsysc_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lsysc_notify_resume
@@ -858,9 +856,7 @@ ENTRY(io_int_handler)
 	TSTMSK	__TI_flags(%r12),_TIF_PATCH_PENDING
 	jo	.Lio_patch_pending
 #endif
-	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
-	jo	.Lio_sigpending
-	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
+	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
 	jo	.Lio_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lio_notify_resume
