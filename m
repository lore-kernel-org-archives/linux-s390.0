Return-Path: <linux-kernel-owner+w=401wt.eu-S1754049Ab0AGVlw@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
In-Reply-To: Martin Schwidefsky's message of  Thursday, 7 January 2010 10:16:19 +0100 <20100107101619.0877cf67@mschwide.boeblingen.de.ibm.com>
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
Message-Id: <20100107214141.7500B7300@magilla.sf.frob.com>
Date: Thu,  7 Jan 2010 13:41:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> Hmm, command for tracehook_signal_handler say this for stepping:
> @stepping:           nonzero if debugger single-step or block-step in
> use

Are you saying you would like me to clarify that wording somehow?  It's
meant to be implicit that the arch code is not doing any special fakery
about single-step for signal handlers, only processing real single-step
traps (and faking them for a syscall instruction if the arch requires
that).  No other arch does it, so it didn't occur to me that s390 would.
Before tracehook some had ptrace_notify calls there, and the call to
tracehook_signal_handler replaced that call.

> > In ptrace (including utrace-based ptrace), this winds up with sending a
> > SIGTRAP.  So when we finally do get out of do_signal and TIF_SINGLE_STEP
> > causes a second SIGTRAP, it's already pending and the second one makes no
> > difference.
> 
> So we have been lucky so far.

Actually, Oleg rightly points out:

> Confused again, perhaps I just misunderstood what you mean...
> 
> Without utrace, tracehook_signal_handler() doesn't send SIGTRAP, it
> merely does ptrace_notify(SIGTRAP), this means that
[...]
> even without utrace we can have unexpected SIGTRAP.

That is quite true, and I just misremembered when writing that paragraph.

So indeed we have been lucky, but it's not the luck of the problem not
happening on s390, but the luck of nobody ever caring. :-)

> Ok, so with the full utrace the semantics of tracehook_signal_handler
> is more than just causing a SIGTRAP. It is an indication for a signal
> AND a SIGTRAP if single-stepping is active. 

In short, it is the indication of a signal handler having been set up, just
like its kerneldoc description says.  Whatever that should mean to tracing
(SIGTRAP or otherwise) is in the purview of the generic tracing layer, not
the arch layer.

> To make both cases work we
> should stop setting TIF_SINGLE_STEP in do_signal and pass
> current->thread.per_info.single_step to tracehook_signal_handler
> instead of test_thread_flag(TIF_SINGLE_STEP).

Correct.


Thanks,
Roland
