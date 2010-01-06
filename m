Return-Path: <linux-kernel-owner+w=401wt.eu-S932835Ab0AFVI0@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
In-Reply-To: Oleg Nesterov's message of  Tuesday, 5 January 2010 16:36:33 +0100 <20100105153633.GA9376@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
Message-Id: <20100106210812.E03A1134D@magilla.sf.frob.com>
Date: Wed,  6 Jan 2010 13:08:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> Oh, I am not sure. But I don't understand TIF_SINGLE_STEP on s390,
> absolutely.
> 
> For example, why do_signal() sets TIF_SINGLE_STEP? Why can't we do

I think we could.  That would be more consistent with other machines.  On
s390, once we set TIF_SINGLE_STEP, we are going to post a SIGTRAP
eventually before going to user mode.  But then tracehook_signal_handler()
also gets stepping=1 and the expected meaning of this is that the arch code
is not itself simulating a single-step for the handler setup.  So the
tracehook (i.e. ptrace/utrace) code does what it does for "need a fake
single-step".  

In ptrace (including utrace-based ptrace), this winds up with sending a
SIGTRAP.  So when we finally do get out of do_signal and TIF_SINGLE_STEP
causes a second SIGTRAP, it's already pending and the second one makes no
difference.

But for the general case of utrace, we'll have the UTRACE_SIGNAL_HANDLER
report, followed by a SIGTRAP that appears to be an authentic single-step
trap, but takes place on the same instruction.  If the resumption after the
UTRACE_SIGNAL_HANDLER report didn't use stepping, then this is an entirely
unexpected extra SIGTRAP.  If we do continue stepping, then we are
expecting the SIGTRAP, but this gets us a spurious and errnoeous report
that looks like the instruction right before the handler's entry point in
memory was just executed.

[Martin:]
> The reason why we set the TIF_SINGLE_STEP bit in do_signal is that we
> want to be able to stop the debugged program before the first
> instruction of the signal handler has been executed. The PER single
> step causes a trap after an instruction has been executed. That first
> instruction can do bad things to the arguments of the signal handler..

That's what tracehook_signal_handler is for.  You're both doing it yourself
in the arch code (by setting TIF_SINGLE_STEP), and then telling the generic
code to do it (by passing stepping=1 to tracehook_signal_handler).


Thanks,
Roland
