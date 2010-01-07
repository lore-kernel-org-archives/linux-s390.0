Return-Path: <linux-kernel-owner+w=401wt.eu-S1752485Ab0AGRy6@vger.kernel.org>
Date: Thu, 7 Jan 2010 18:54:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100107175446.GA13300@redhat.com>
References: <20100104211147.4CC94D532@magilla.sf.frob.com> <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com> <20100105153633.GA9376@redhat.com> <20100105164610.388effd3@mschwide.boeblingen.de.ibm.com> <20100105155913.GA10652@redhat.com> <20100105170301.GA13641@redhat.com> <20100105195818.GA20358@redhat.com> <20100106201722.GB26204@redhat.com> <20100106211329.DB4F5134D@magilla.sf.frob.com> <20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Martin, sorry for delay,

On 01/07, Martin Schwidefsky wrote:
>
> On Wed,  6 Jan 2010 13:13:29 -0800 (PST)
> Roland McGrath <roland@redhat.com> wrote:
>
> > > However, with or without CONFIG_UTRACE, 6580807da14c423f0d0a708108e6df6ebc8bc83d
> > > is needed on s390 too, otherwise the child gets unnecessary traps.
> >
> > This confuses me.  user_disable_single_step on non-current doesn't do
> > anything not already done by the memset in copy_thread.  Ooh, except
> > perhaps it does not clear PSW_MASK_PER.  Maybe that matters.  That's
> > the only thing I can think of.  Maybe Martin can make sense of it.

I am confused as well. Yes, I thought about regs->psw.mask change too,
but I don't understand why it helps..

> The additional traps should not happen anymore with this patch:
> --
> Subject: [PATCH] clear TIF_SINGLE_STEP for new process.
>
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> Clear the TIF_SINGLE_STEP bit in copy_thread. If the new process is
> not auto-attached by the tracer it is wrong to delivere SIGTRAP to
> the new process.
>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>
>  arch/s390/kernel/process.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
> --- linux-2.6/arch/s390/kernel/process.c	2009-12-03 04:51:21.000000000 +0100
> +++ linux-2.6-patched/arch/s390/kernel/process.c	2010-01-07 09:25:53.000000000 +0100
> @@ -217,6 +217,7 @@ int copy_thread(unsigned long clone_flag
>  	p->thread.mm_segment = get_fs();
>  	/* Don't copy debug registers */
>  	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
> +	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);

Even if I don't understand s390, I think this patch makes sense
anyway. Or, user_disable_single_step() can clear this bit.


But. Acoording to the testing I did (unless I did something wrong
again) this patch doesn't make any difference in this particular
case. 6580807da14c423f0d0a708108e6df6ebc8bc83d does.

And. Please note that the test-case triggers 799 "false step", but
TIF_SINGLE_STEP is surely cleared (by the caller) after the first
invocation of do_single_step().

Oleg.
