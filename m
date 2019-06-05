Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:39337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFELTa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Jun 2019 07:19:30 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
In-Reply-To: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
Date: Wed, 05 Jun 2019 21:19:22 +1000
Message-ID: <87sgsomg91.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>

Anshuman Khandual <anshuman.khandual@arm.com> writes:
> Similar notify_page_fault() definitions are being used by architectures
> duplicating much of the same code. This attempts to unify them into a
> single implementation, generalize it and then move it to a common place.
> kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
> need not be wrapped again within CONFIG_KPROBES. Trap number argument can
> now contain upto an 'unsigned int' accommodating all possible platforms.
...
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 58f69fa..1bc3b18 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -30,28 +30,6 @@
>  
>  #ifdef CONFIG_MMU
>  
> -#ifdef CONFIG_KPROBES
> -static inline int notify_page_fault(struct pt_regs *regs, unsigned int fsr)
> -{
> -	int ret = 0;
> -
> -	if (!user_mode(regs)) {
> -		/* kprobe_running() needs smp_processor_id() */
> -		preempt_disable();
> -		if (kprobe_running() && kprobe_fault_handler(regs, fsr))
> -			ret = 1;
> -		preempt_enable();
> -	}
> -
> -	return ret;
> -}
> -#else

You've changed several of the architectures from something like above,
where it disables preemption around the call into the below:

> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed
> +	 * to call kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret = 1;
> +	}
> +	return ret;
> +}

Which skips everything if we're preemptible. Is that an equivalent
change? If so can you please explain why in more detail.

Also why not have it return bool?

cheers
