Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSNv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 14:13:51 -0400
Date: Tue, 23 Jun 2020 20:12:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623181232.GB4800@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623175957.GA106514@elver.google.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

On Tue, Jun 23, 2020 at 07:59:57PM +0200, Marco Elver wrote:
> On Tue, Jun 23, 2020 at 06:37PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> > > Well, freshly merged code is using it. For example, KCSAN:
> > > 
> > >     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
> > >     => kernel/kcsan/report.c:
> > > 
> > >     void kcsan_report(...)
> > >     {
> > > 	...
> > >         /*
> > >          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
> > >          * we do not turn off lockdep here; this could happen due to recursion
> > >          * into lockdep via KCSAN if we detect a race in utilities used by
> > >          * lockdep.
> > >          */
> > >         lockdep_off();
> > > 	...
> > >     }
> > 
> > Marco, do you remember what exactly happened there? Because I'm about to
> > wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
> > lockdep_off().
> 
> Yeah, I was trying to squash any kind of recursion:
> 
> 	lockdep -> other libs ->
> 		-> KCSAN
> 		-> print report
> 		-> dump stack, printk and friends
> 		-> lockdep -> other libs
> 			-> KCSAN ...
> 
> Some history:
> 
> * Initial patch to fix:
> 	https://lore.kernel.org/lkml/20200115162512.70807-1-elver@google.com/

That patch is weird; just :=n on lockdep.c should've cured that, the
rest is massive overkill.

> * KCSAN+lockdep+ftrace:
> 	https://lore.kernel.org/lkml/20200214211035.209972-1-elver@google.com/

That doesn't really have anything useful..

> lockdep now has KCSAN_SANITIZE := n, but we still need to ensure that
> there are no paths out of lockdep, or the IRQ flags tracing code, that
> might lead through other libs, through KCSAN, libs used to generate a
> report, and back to lockdep.
> 
> I never quite figured out the exact trace that led to corruption, but
> avoiding any kind of potential for recursion was the only thing that
> would avoid the check_flags() warnings.

Fair enough; I'll rip it all up and boot a KCSAN kernel, see what if
anything happens.
