Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfFGUMH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Jun 2019 16:12:07 -0400
Date: Fri, 7 Jun 2019 13:12:03 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
Message-ID: <20190607201202.GA32656@bombadil.infradead.org>
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>

Before:

> @@ -46,23 +46,6 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
>  	return 0;
>  }
>  
> -static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
> -{
> -	if (!kprobes_built_in())
> -		return 0;
> -	if (user_mode(regs))
> -		return 0;
> -	/*
> -	 * To be potentially processing a kprobe fault and to be allowed to call
> -	 * kprobe_running(), we have to be non-preemptible.
> -	 */
> -	if (preemptible())
> -		return 0;
> -	if (!kprobe_running())
> -		return 0;
> -	return kprobe_fault_handler(regs, X86_TRAP_PF);
> -}

After:

> +++ b/include/linux/kprobes.h
> @@ -458,4 +458,20 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
>  }
>  #endif
>  
> +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
> +					      unsigned int trap)
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

Do you really think this is easier to read?

Why not just move the x86 version to include/linux/kprobes.h, and replace
the int with bool?

On Fri, Jun 07, 2019 at 04:04:15PM +0530, Anshuman Khandual wrote:
> Very similar definitions for notify_page_fault() are being used by multiple
> architectures duplicating much of the same code. This attempts to unify all
> of them into a generic implementation, rename it as kprobe_page_fault() and
> then move it to a common header.

I think this description suffers from having been written for v1 of
this patch.  It describes what you _did_, but it's not what this patch
currently _is_.

Why not something like:

Architectures which support kprobes have very similar boilerplate around
calling kprobe_fault_handler().  Use a helper function in kprobes.h to
unify them, based on the x86 code.

This changes the behaviour for other architectures when preemption
is enabled.  Previously, they would have disabled preemption while
calling the kprobe handler.  However, preemption would be disabled
if this fault was due to a kprobe, so we know the fault was not due
to a kprobe handler and can simply return failure.  This behaviour was
introduced in commit a980c0ef9f6d ("x86/kprobes: Refactor kprobes_fault()
like kprobe_exceptions_notify()")

>  arch/arm/mm/fault.c      | 24 +-----------------------
>  arch/arm64/mm/fault.c    | 24 +-----------------------
>  arch/ia64/mm/fault.c     | 24 +-----------------------
>  arch/powerpc/mm/fault.c  | 23 ++---------------------
>  arch/s390/mm/fault.c     | 16 +---------------
>  arch/sh/mm/fault.c       | 18 ++----------------
>  arch/sparc/mm/fault_64.c | 16 +---------------
>  arch/x86/mm/fault.c      | 21 ++-------------------
>  include/linux/kprobes.h  | 16 ++++++++++++++++

What about arc and mips?
