Return-Path: <linux-kernel-owner+w=401wt.eu-S1752264Ab0AHIfG@vger.kernel.org>
Date: Fri, 8 Jan 2010 09:34:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100108093452.15101939@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100107181632.GC13300@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
	<20100106210812.E03A1134D@magilla.sf.frob.com>
	<20100107101619.0877cf67@mschwide.boeblingen.de.ibm.com>
	<20100107181632.GC13300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 7 Jan 2010 19:16:32 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/07, Martin Schwidefsky wrote:
> >
> > On Wed,  6 Jan 2010 13:08:12 -0800 (PST)
> > Roland McGrath <roland@redhat.com> wrote:
> >
> > > That's what tracehook_signal_handler is for.  You're both doing it yourself
> > > in the arch code (by setting TIF_SINGLE_STEP), and then telling the generic
> > > code to do it (by passing stepping=1 to tracehook_signal_handler).
> >
> > Ok, so with the full utrace the semantics of tracehook_signal_handler
> > is more than just causing a SIGTRAP. It is an indication for a signal
> > AND a SIGTRAP if single-stepping is active. To make both cases work we
> > should stop setting TIF_SINGLE_STEP in do_signal and pass
> > current->thread.per_info.single_step to tracehook_signal_handler
> > instead of test_thread_flag(TIF_SINGLE_STEP).
> 
> Can't understand why do we need TIF_SINGLE_STEP at all.
> 
> Just pass current->thread.per_info.single_step to
> tracehook_signal_handler() ?
> 
> Oleg.
> 
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -504,14 +504,8 @@ void do_signal(struct pt_regs *regs)
>  			 * for a normal instruction, act like we took
>  			 * one for the handler setup.
>  			 */
> -			if (current->thread.per_info.single_step)
> -				set_thread_flag(TIF_SINGLE_STEP);
> -
> -			/*
> -			 * Let tracing know that we've done the handler setup.
> -			 */
>  			tracehook_signal_handler(signr, &info, &ka, regs,
> -					 test_thread_flag(TIF_SINGLE_STEP));
> +					 current->thread.per_info.single_step);
>  		}
>  		return;
>  	}
> 

That is what I meant in the other mail. The patch on my local disk
looks almost the same but it removes the comment prior to the
TIF_SINGLE_STEP if statement as well.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
