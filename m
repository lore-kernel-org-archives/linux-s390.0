Return-Path: <linux-kernel-owner+w=401wt.eu-S1756271Ab0AFUX6@vger.kernel.org>
Date: Wed, 6 Jan 2010 21:23:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100106202347.GC26204@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <20100104155225.GA16650@redhat.com> <20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com> <20100104181412.GA21146@redhat.com> <20100104211147.4CC94D532@magilla.sf.frob.com> <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/05, Martin Schwidefsky wrote:
>
> On Mon,  4 Jan 2010 13:11:47 -0800 (PST)
> Roland McGrath <roland@redhat.com> wrote:
>
> > > This probably means that copy_process()->user_disable_single_step()
> > > is not enough to clear the "this task wants single-stepping" copied
> > > from parent.
> >
> > I would suspect s390's TIF_SINGLE_STEP flag here.  That flag means "a
> > single-step trap occurred".  This is what causes do_single_step to be
> > called before returning to user mode, rather than the machine trap doing it
> > directly as is done in the other arch implementations.
>
> Just my thinking as well.
>
> > If I'm right, then "this task wants single-stepping" is not the problem,
> > and that really is fully cleared.  In fact, looking at s390's copy_thread
> > (arch/s390/kernel/process.c) it clears out all the state that is actually
> > touched by user_enable_single_step and user_disable_single_step.  So for
> > s390 the new fork.c call is actually superfluous AFAICT.
>
>         /* Don't copy debug registers */
>         memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
>
> Yep, the call from fork.c is indeed superfluous.

I can't explain this, but if I remove copy_process()->user_disable_single_step()
the test-case below triggers "XXX" printk's from do_single_step() with or
without CONFIG_UTRACE. the patch is

	--- arch/s390/kernel/traps.c~	2009-12-22 10:41:52.909174198 -0500
	+++ arch/s390/kernel/traps.c	2010-01-05 11:03:55.006487697 -0500
	@@ -384,6 +384,9 @@ void __kprobes do_single_step(struct pt_
		}
		if (tracehook_consider_fatal_signal(current, SIGTRAP))
			force_sig(SIGTRAP, current);
	+	else
	+		printk("XXX: %s/%d %d\n", current->comm, current->pid,
	+				test_thread_flag(TIF_SINGLE_STEP));
	 }
	 
	 static void default_trap_handler(struct pt_regs * regs, long interruption_code)

Oleg.

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <assert.h>

int main(void)
{
	int pid, status;

	if (!(pid = fork())) {
		assert(ptrace(PTRACE_TRACEME) == 0);
		kill(getpid(), SIGSTOP);

		if (!fork())
			return 43;

		wait(&status);
		return WEXITSTATUS(status);
	}


	for (;;) {
		assert(pid == wait(&status));
		if (WIFEXITED(status))
			break;
		assert(ptrace(PTRACE_SINGLESTEP, pid, 0,0) == 0);
	}

	assert(WEXITSTATUS(status) == 43);
	return 0;
}
