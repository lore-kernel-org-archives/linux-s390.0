Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 May 2016 14:43:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: siginfo memory leak?
Message-ID: <20160523144319.7579e75f@mschwide>
In-Reply-To: <20160523111630.GN2278@dhcp22.suse.cz>
References: <20160523111630.GN2278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 May 2016 13:16:30 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> Hi,
> Aleksa has reported that strace tells a bogus si_errno while debugging
> something on s390:
> [pid 20799] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_errno=2510266, si_addr=0x100000000000000}

That is a bug.
 
> A quick look into do_sigsegv shows that siginfo is not completely
> initialized and it indeed might leak the previous stack content
> which will later gets to userspace. So unless I am missing something
> we need something like the trivial patch below. I have tried to look
> around and it seems that this is not the only place...

Indeed, for s390 four bytes of the kernel stack gets leaked to user space.
That needs fixing.

> x86 do_error_trap doesn't do any initialization at all! It is hard to
> tell other places. I have checked some and most of them do some
> (partial) initialization.
> 
> So my primary question is whether we want to fix all those potential
> places one by one or come up with something more systematic (e.g. a
> macro to declare on stack siginfo). Btw. I am not even sure partial
> initializations are correct and memset should be used unconditioanlly
> (e.g. fill_sigtrap_info does do that).
> ---
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 791a4146052c..41913fac14e4 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -248,6 +248,7 @@ static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
>  	si.si_signo = SIGSEGV;
>  	si.si_code = si_code;
>  	si.si_addr = (void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK);
> +	si.si_errno = 0;
>  	force_sig_info(SIGSEGV, &si, current);
>  }
> 

The other for place where s390 calls force_sig_info are correct.
Only do_sigsegv misses the clear of si_errno.

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index ade185a46b1d..f8b66ddbb47d 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -286,6 +286,7 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
> 
>  	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
>  			NOTIFY_STOP) {
> +		memset(&info, 0, sizeof(info));
>  		conditional_sti(regs);
>  		do_trap(trapnr, signr, str, regs, error_code,
>  			fill_trap_info(regs, signr, trapnr, &info));
> 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
