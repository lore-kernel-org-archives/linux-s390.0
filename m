Return-Path: <linux-kernel-owner+w=401wt.eu-S932919Ab0AGJQd@vger.kernel.org>
Date: Thu, 7 Jan 2010 10:16:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100107101619.0877cf67@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100106210812.E03A1134D@magilla.sf.frob.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
	<20100106210812.E03A1134D@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Wed,  6 Jan 2010 13:08:12 -0800 (PST)
Roland McGrath <roland@redhat.com> wrote:

> > Oh, I am not sure. But I don't understand TIF_SINGLE_STEP on s390,
> > absolutely.
> > 
> > For example, why do_signal() sets TIF_SINGLE_STEP? Why can't we do
> 
> I think we could.  That would be more consistent with other machines.  On
> s390, once we set TIF_SINGLE_STEP, we are going to post a SIGTRAP
> eventually before going to user mode.  But then tracehook_signal_handler()
> also gets stepping=1 and the expected meaning of this is that the arch code
> is not itself simulating a single-step for the handler setup.  So the
> tracehook (i.e. ptrace/utrace) code does what it does for "need a fake
> single-step".  

Hmm, command for tracehook_signal_handler say this for stepping:
@stepping:           nonzero if debugger single-step or block-step in
use

> In ptrace (including utrace-based ptrace), this winds up with sending a
> SIGTRAP.  So when we finally do get out of do_signal and TIF_SINGLE_STEP
> causes a second SIGTRAP, it's already pending and the second one makes no
> difference.

So we have been lucky so far.
 
> But for the general case of utrace, we'll have the UTRACE_SIGNAL_HANDLER
> report, followed by a SIGTRAP that appears to be an authentic single-step
> trap, but takes place on the same instruction.  If the resumption after the
> UTRACE_SIGNAL_HANDLER report didn't use stepping, then this is an entirely
> unexpected extra SIGTRAP.  If we do continue stepping, then we are
> expecting the SIGTRAP, but this gets us a spurious and errnoeous report
> that looks like the instruction right before the handler's entry point in
> memory was just executed.
>
> [Martin:]
> > The reason why we set the TIF_SINGLE_STEP bit in do_signal is that we
> > want to be able to stop the debugged program before the first
> > instruction of the signal handler has been executed. The PER single
> > step causes a trap after an instruction has been executed. That first
> > instruction can do bad things to the arguments of the signal handler..
> 
> That's what tracehook_signal_handler is for.  You're both doing it yourself
> in the arch code (by setting TIF_SINGLE_STEP), and then telling the generic
> code to do it (by passing stepping=1 to tracehook_signal_handler).

Ok, so with the full utrace the semantics of tracehook_signal_handler
is more than just causing a SIGTRAP. It is an indication for a signal
AND a SIGTRAP if single-stepping is active. To make both cases work we
should stop setting TIF_SINGLE_STEP in do_signal and pass
current->thread.per_info.single_step to tracehook_signal_handler
instead of test_thread_flag(TIF_SINGLE_STEP).

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
