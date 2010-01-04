Return-Path: <linux-kernel-owner+w=401wt.eu-S1754089Ab0ADVL7@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
In-Reply-To: Oleg Nesterov's message of  Monday, 4 January 2010 19:14:12 +0100 <20100104181412.GA21146@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
Message-Id: <20100104211147.4CC94D532@magilla.sf.frob.com>
Date: Mon,  4 Jan 2010 13:11:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> This probably means that copy_process()->user_disable_single_step()
> is not enough to clear the "this task wants single-stepping" copied
> from parent.

I would suspect s390's TIF_SINGLE_STEP flag here.  That flag means "a
single-step trap occurred".  This is what causes do_single_step to be
called before returning to user mode, rather than the machine trap doing it
directly as is done in the other arch implementations.

If I'm right, then "this task wants single-stepping" is not the problem,
and that really is fully cleared.  In fact, looking at s390's copy_thread
(arch/s390/kernel/process.c) it clears out all the state that is actually
touched by user_enable_single_step and user_disable_single_step.  So for
s390 the new fork.c call is actually superfluous AFAICT.

The problem is that the copied parent state includes the "this task has a
pending single-step to report" flag.  IMHO it clearly makes sense for
s390's copy_thread to clear this flag in a new task, which it does not do now.

An alternative to that would be just to make its user_disable_single_step
clear the flag.  That could in theory also have an effect on e.g. the
(authentic) pending step report of a tracee that was stopped with
TIF_SINGLE_STEP set when its tracer detached.  This might be considered a
good thing, but since every other arch posts the SIGTRAP immediately they
all have the equivalent issue and s390 doesn't need to be any "better" than
they are before we have a generic resolution to the whole subject of
tracer-induced signals (which we won't get into now).  I'm not even sure
from my insufficient reading of the s390 assembly code whether this path is
even possible, i.e. do_signal called before do_single_step.

Martin, I suggest having copy_thread clear TIF_SINGLE_STEP.
That bit is always task-private state that should not be copied.

Btw, given the complexity of FixPerRegisters (and its new additional cost
on task==current), you might want to make user_*_single_step bail out if
per_info.single_step is already set/clear on entry.


Thanks,
Roland
