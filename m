Return-Path: <linux-kernel-owner+w=401wt.eu-S1754767Ab0AEP7c@vger.kernel.org>
Date: Tue, 5 Jan 2010 16:59:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100105155913.GA10652@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <20100104155225.GA16650@redhat.com> <20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com> <20100104181412.GA21146@redhat.com> <20100104211147.4CC94D532@magilla.sf.frob.com> <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com> <20100105153633.GA9376@redhat.com> <20100105164610.388effd3@mschwide.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100105164610.388effd3@mschwide.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/05, Martin Schwidefsky wrote:
>
> On Tue, 5 Jan 2010 16:36:33 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > For example, why do_signal() sets TIF_SINGLE_STEP? Why can't we do
> > 
> > 	--- a/arch/s390/kernel/signal.c
> > 	+++ b/arch/s390/kernel/signal.c
> > 	@@ -500,18 +500,10 @@ void do_signal(struct pt_regs *regs)
> > 					clear_thread_flag(TIF_RESTORE_SIGMASK);
> > 	 
> > 				/*
> > 	-			 * If we would have taken a single-step trap
> > 	-			 * for a normal instruction, act like we took
> > 	-			 * one for the handler setup.
> > 	-			 */
> > 	-			if (current->thread.per_info.single_step)
> > 	-				set_thread_flag(TIF_SINGLE_STEP);
> > 	-
> > 	-			/*
> > 				 * Let tracing know that we've done the handler setup.
> > 				 */
> > 				tracehook_signal_handler(signr, &info, &ka, regs,
> > 	-					 test_thread_flag(TIF_SINGLE_STEP));
> > 	+					current->thread.per_info.single_step);
> > 			}
> > 			return;
> > 		}
> > 
> > ?
>
> The reason why we set the TIF_SINGLE_STEP bit in do_signal is that we
> want to be able to stop the debugged program before the first
> instruction of the signal handler has been executed. The PER single
> step causes a trap after an instruction has been executed. That first
> instruction can do bad things to the arguments of the signal handler..

Yes, but afaics all we need is to pass the correct "int stepping" arg
to tracehook_signal_handler(). If it is true, the tracee does
ptrace_notify() before it returns to user-mode.

> > dmesg shows 799 lines of
> >
> > 	XXX: 2389 0
> >
> >
> > The kernel is 2.6.32.2 + utrace, but CONFIG_UTRACE is not set.
>
> With or without my bug fix ?

With, but please see another email.


I'll add clear_bit(TIF_SINGLE_STEP) into do_fork() path and re-test.

Oleg.
