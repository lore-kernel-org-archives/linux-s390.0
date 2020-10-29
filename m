Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgJ2H6K (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Oct 2020 03:58:10 -0400
Date: Thu, 29 Oct 2020 16:58:03 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5/9] kprobes/ftrace: Add recursion protection to the
 ftrace callback
Message-Id: <20201029165803.5f6b401e5bccca4e57c70181@kernel.org>
In-Reply-To: <20201028115613.140212174@goodmis.org>
References: <20201028115244.995788961@goodmis.org>
        <20201028115613.140212174@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guo Ren <guoren@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

Hi Steve,

On Wed, 28 Oct 2020 07:52:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If a ftrace callback does not supply its own recursion protection and
> does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
> make a helper trampoline to do so before calling the callback instead of
> just calling the callback directly.

So in that case the handlers will be called without preempt disabled?


> The default for ftrace_ops is going to assume recursion protection unless
> otherwise specified.

This seems to skip entier handler if ftrace finds recursion.
I would like to increment the missed counter even in that case.

[...]
e.g.

> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index 5264763d05be..5eb2604fdf71 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -13,16 +13,21 @@ int arch_check_ftrace_location(struct kprobe *p)
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  			   struct ftrace_ops *ops, struct pt_regs *regs)
>  {
> +	int bit;
>  	bool lr_saver = false;
>  	struct kprobe *p;
>  	struct kprobe_ctlblk *kcb;
>  
> -	/* Preempt is disabled by ftrace */
> +	bit = ftrace_test_recursion_trylock();

> +
> +	preempt_disable_notrace();
>  	p = get_kprobe((kprobe_opcode_t *)ip);
>  	if (!p) {
>  		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
>  		if (unlikely(!p) || kprobe_disabled(p))
> -			return;
> +			goto out;
>  		lr_saver = true;
>  	}

	if (bit < 0) {
		kprobes_inc_nmissed_count(p);
		goto out;
	}

>  
> @@ -56,6 +61,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		 */
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> +out:
> +	preempt_enable_notrace();

	if (bit >= 0)
		ftrace_test_recursion_unlock(bit);

>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  

Or, we can also introduce a support function,

static inline void kprobes_inc_nmissed_ip(unsigned long ip)
{
	struct kprobe *p;

	preempt_disable_notrace();
	p = get_kprobe((kprobe_opcode_t *)ip);
	if (p)
		kprobes_inc_nmissed_count(p);
	preempt_enable_notrace();
}

> diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> index 4bab21c71055..5f7742b225a5 100644
> --- a/arch/parisc/kernel/ftrace.c
> +++ b/arch/parisc/kernel/ftrace.c
> @@ -208,13 +208,19 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  {
>  	struct kprobe_ctlblk *kcb;
>  	struct kprobe *p = get_kprobe((kprobe_opcode_t *)ip);

(BTW, here is a bug... get_kprobe() must be called with preempt disabled.)

> +	int bit;
>  
> -	if (unlikely(!p) || kprobe_disabled(p))
> +	bit = ftrace_test_recursion_trylock();

	if (bit < 0) {
		kprobes_inc_nmissed_ip(ip);
>  		return;
	}

This may easier for you ?

Thank you,

>  
> +	preempt_disable_notrace();
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		goto out;
> +
>  	if (kprobe_running()) {
>  		kprobes_inc_nmissed_count(p);
> -		return;
> +		goto out;
>  	}
>  
>  	__this_cpu_write(current_kprobe, p);
> @@ -235,6 +241,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		}
>  	}
>  	__this_cpu_write(current_kprobe, NULL);
> +out:
> +	preempt_enable_notrace();
> +	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index 972cb28174b2..5df8d50c65ae 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -18,10 +18,16 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  {
>  	struct kprobe *p;
>  	struct kprobe_ctlblk *kcb;
> +	int bit;
>  
> +	bit = ftrace_test_recursion_trylock();
> +	if (bit < 0)
> +		return;
> +
> +	preempt_disable_notrace();
>  	p = get_kprobe((kprobe_opcode_t *)nip);
>  	if (unlikely(!p) || kprobe_disabled(p))
> -		return;
> +		goto out;
>  
>  	kcb = get_kprobe_ctlblk();
>  	if (kprobe_running()) {
> @@ -52,6 +58,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  		 */
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> +out:
> +	preempt_enable_notrace();
> +	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index b388e87a08bf..88466d7fb6b2 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -202,13 +202,19 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  {
>  	struct kprobe_ctlblk *kcb;
>  	struct kprobe *p = get_kprobe((kprobe_opcode_t *)ip);
> +	int bit;
>  
> -	if (unlikely(!p) || kprobe_disabled(p))
> +	bit = ftrace_test_recursion_trylock();
> +	if (bit < 0)
>  		return;
>  
> +	preempt_disable_notrace();
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		goto out;
> +
>  	if (kprobe_running()) {
>  		kprobes_inc_nmissed_count(p);
> -		return;
> +		goto out;
>  	}
>  
>  	__this_cpu_write(current_kprobe, p);
> @@ -228,6 +234,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		}
>  	}
>  	__this_cpu_write(current_kprobe, NULL);
> +out:
> +	preempt_enable_notrace();
> +	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index 681a4b36e9bb..a40a6cdfcca3 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -18,11 +18,16 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  {
>  	struct kprobe *p;
>  	struct kprobe_ctlblk *kcb;
> +	int bit;
>  
> -	/* Preempt is disabled by ftrace */
> +	bit = ftrace_test_recursion_trylock();
> +	if (bit < 0)
> +		return;
> +
> +	preempt_disable_notrace();
>  	p = get_kprobe((kprobe_opcode_t *)ip);
>  	if (unlikely(!p) || kprobe_disabled(p))
> -		return;
> +		goto out;
>  
>  	kcb = get_kprobe_ctlblk();
>  	if (kprobe_running()) {
> @@ -52,6 +57,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		 */
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> +out:
> +	preempt_enable_notrace();
> +	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  
> -- 
> 2.28.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
