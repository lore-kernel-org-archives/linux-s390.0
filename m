Return-Path: <linux-kernel-owner+w=401wt.eu-S1752575AbYKCRSc@vger.kernel.org>
Message-ID: <490F317C.9040603@redhat.com>
Date: Mon, 03 Nov 2008 11:14:36 -0600
From: David Smith <dsmith@redhat.com>
MIME-Version: 1.0
Subject: Re: [patch 15/21] ptrace changes
References: <20081001083317.782967473@de.ibm.com> <20081001084129.042880937@de.ibm.com>
In-Reply-To: <20081001084129.042880937@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Note that I know ~0 about s390 register layouts, but...

Martin Schwidefsky wrote:
> Index: quilt-2.6/arch/s390/kernel/ptrace.c
> ===================================================================
> --- quilt-2.6.orig/arch/s390/kernel/ptrace.c
> +++ quilt-2.6/arch/s390/kernel/ptrace.c
> @@ -639,40 +640,44 @@ long compat_arch_ptrace(struct task_stru
>  }
>  #endif
>
> -asmlinkage void
> -syscall_trace(struct pt_regs *regs, int entryexit)
> +asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  {

...

> +	if (unlikely(current->audit_context))
> +		audit_syscall_entry(test_thread_flag(TIF_31BIT) ?
> +					AUDIT_ARCH_S390 : AUDIT_ARCH_S390X,
> +				    regs->gprs[2], regs->orig_gpr2,
> +				    regs->gprs[3], regs->gprs[4],
> +				    regs->gprs[5]);
> +	return ret;
> +}

According to the above, the syscall number is in regs->gprs[2] and the
1st syscall argument is in regs->orig_gpr2.

Then in:

> Index: quilt-2.6/arch/s390/include/asm/syscall.h
> ===================================================================

...

> +static inline long syscall_get_nr(struct task_struct *task,
> +				  struct pt_regs *regs)
> +{
> +	if (regs->trap != __LC_SVC_OLD_PSW)
> +		return -1;
> +	return regs->gprs[2];
> +}

... according to the syscall_get_nr(), the syscall number is in
regs->gprs[2], which matches what is in arch/s390/kernel/ptrace.c ...

> +static inline void syscall_get_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 unsigned int i, unsigned int n,
> +					 unsigned long *args)
> +{
> +	BUG_ON(i + n > 6);
> +#ifdef CONFIG_COMPAT
> +	if (test_tsk_thread_flag(task, TIF_31BIT)) {
> +		if (i + n == 6)
> +			args[--n] = (u32) regs->args[0];
> +		while (n-- > 0)
> +			args[n] = (u32) regs->gprs[2 + i + n];
> +	}
> +#endif
> +	if (i + n == 6)
> +		args[--n] = regs->args[0];
> +	memcpy(args, &regs->gprs[2 + i], n * sizeof(args[0]));
> +}
> +
> +static inline void syscall_set_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 unsigned int i, unsigned int n,
> +					 const unsigned long *args)
> +{
> +	BUG_ON(i + n > 6);
> +	if (i + n == 6)
> +		regs->args[0] = args[--n];
> +	memcpy(&regs->gprs[2 + i], args, n * sizeof(args[0]));
> +}
> +
> +#endif	/* _ASM_SYSCALL_H */

According to syscall_get_arguments()/syscall_set_arguments(), the 1st
syscall argument is in regs->gprs[2], which *doesn't* match what is in
arch/s390/kernel/ptrace.c.

Is this correct, or should the 1st syscall argument be found in
regs->orig_gpr2 by syscall_get_arguments()/syscall_set_arguments()?

-- 
David Smith
dsmith@redhat.com
Red Hat
http://www.redhat.com
256.217.0141 (direct)
256.837.0057 (fax)
