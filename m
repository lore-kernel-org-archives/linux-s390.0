Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbgFWPZc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 11:25:32 -0400
Date: Tue, 23 Jun 2020 17:24:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623152450.GM4817@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

On Tue, Jun 23, 2020 at 05:00:31PM +0200, Ahmed S. Darwish wrote:
> On Tue, Jun 23, 2020 at 10:36:52AM +0200, Peter Zijlstra wrote:
> ...
> > -#define lockdep_assert_irqs_disabled()	do {				\
> > -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> > -			  current->hardirqs_enabled,			\
> > -			  "IRQs not disabled as expected\n");		\
> > -	} while (0)
> > +#define lockdep_assert_irqs_enabled()					\
> > +do {									\
> > +	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
> > +} while (0)
> >
> 
> Can we add a small comment on top of lockdep_off(), stating that lockdep
> IRQ tracking will still be kept after a lockdep_off call?

That would only legitimize lockdep_off(). The only comment I want to put
on that is: "if you use this, you're doing it wrong'.
