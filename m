Return-Path: <linux-kernel-owner+w=401wt.eu-S1754921Ab0AEPqe@vger.kernel.org>
Date: Tue, 5 Jan 2010 16:46:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100105164610.388effd3@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100105153633.GA9376@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Jan 2010 16:36:33 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/05, Martin Schwidefsky wrote:
> >
> > On Mon,  4 Jan 2010 13:11:47 -0800 (PST)
> > Roland McGrath <roland@redhat.com> wrote:
> >
> > > > This probably means that copy_process()->user_disable_single_step()
> > > > is not enough to clear the "this task wants single-stepping" copied
> > > > from parent.
> > >
> > > I would suspect s390's TIF_SINGLE_STEP flag here.  That flag means "a
> > > single-step trap occurred".  This is what causes do_single_step to be
> > > called before returning to user mode, rather than the machine trap doing it
> > > directly as is done in the other arch implementations.
> >
> > Just my thinking as well.
> 
> Oh, I am not sure. But I don't understand TIF_SINGLE_STEP on s390,
> absolutely.
> 
> For example, why do_signal() sets TIF_SINGLE_STEP? Why can't we do
> 
> 	--- a/arch/s390/kernel/signal.c
> 	+++ b/arch/s390/kernel/signal.c
> 	@@ -500,18 +500,10 @@ void do_signal(struct pt_regs *regs)
> 					clear_thread_flag(TIF_RESTORE_SIGMASK);
> 	 
> 				/*
> 	-			 * If we would have taken a single-step trap
> 	-			 * for a normal instruction, act like we took
> 	-			 * one for the handler setup.
> 	-			 */
> 	-			if (current->thread.per_info.single_step)
> 	-				set_thread_flag(TIF_SINGLE_STEP);
> 	-
> 	-			/*
> 				 * Let tracing know that we've done the handler setup.
> 				 */
> 				tracehook_signal_handler(signr, &info, &ka, regs,
> 	-					 test_thread_flag(TIF_SINGLE_STEP));
> 	+					current->thread.per_info.single_step);
> 			}
> 			return;
> 		}
> 
> ?

The reason why we set the TIF_SINGLE_STEP bit in do_signal is that we
want to be able to stop the debugged program before the first
instruction of the signal handler has been executed. The PER single
step causes a trap after an instruction has been executed. That first
instruction can do bad things to the arguments of the signal handler..

> Apart from arch/s390/signal.c, TIF_SINGLE_STEP is used by entry.S
> but I don't understand this asm at all.
> 
> Anyway. I modified the debugging patch a bit:
> 
> --- K/arch/s390/kernel/traps.c~	2009-12-22 10:41:52.909174198 -0500
> +++ K/arch/s390/kernel/traps.c	2010-01-05 09:49:19.541792379 -0500
> @@ -384,6 +384,8 @@ void __kprobes do_single_step(struct pt_
>  	}
>  	if (tracehook_consider_fatal_signal(current, SIGTRAP))
>  		force_sig(SIGTRAP, current);
> +	else
> +		printk("XXX: %d %d\n", current->pid, test_thread_flag(TIF_SINGLE_STEP));
>  }
> 
>  static void default_trap_handler(struct pt_regs * regs, long interruption_code)
> -------------------------------------------------------------------------------
> 
> Now, when I run this test-case
> 
> 	#include <stdio.h>
> 	#include <unistd.h>
> 	#include <signal.h>
> 	#include <sys/ptrace.h>
> 	#include <sys/wait.h>
> 	#include <assert.h>
> 
> 	int main(void)
> 	{
> 		int pid, status;
> 
> 		if (!(pid = fork())) {
> 			assert(ptrace(PTRACE_TRACEME) == 0);
> 			kill(getpid(), SIGSTOP);
> 
> 			if (!fork())
> 				return 43;
> 
> 			wait(&status);
> 			return WEXITSTATUS(status);
> 		}
> 
> 
> 		for (;;) {
> 			assert(pid == wait(&status));
> 			if (WIFEXITED(status))
> 				break;
> 			assert(ptrace(PTRACE_SINGLESTEP, pid, 0,0) == 0);
> 		}
> 
> 		assert(WEXITSTATUS(status) == 43);
> 		return 0;
> 	}
> 
> dmesg shows 799 lines of
> 
> 	XXX: 2389 0
> 
> 
> The kernel is 2.6.32.2 + utrace, but CONFIG_UTRACE is not set.

With or without my bug fix ?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
