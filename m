Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbgFXMcb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 08:32:31 -0400
Date: Wed, 24 Jun 2020 14:31:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200624123147.GH4781@hirez.programming.kicks-ass.net>
References: <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
 <20200623202404.GE2483@worktop.programming.kicks-ass.net>
 <20200624090033.GD4800@hirez.programming.kicks-ass.net>
 <CANpmjNMj8FZuBrZsH62V3bZEhFvT2zXwLusVOLwNuH_-kLhp2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMj8FZuBrZsH62V3bZEhFvT2zXwLusVOLwNuH_-kLhp2g@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, bigeasy@linutronix.de, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk, "Paul E. McKenney" <paulmck@kernel.org>

On Wed, Jun 24, 2020 at 12:17:56PM +0200, Marco Elver wrote:
> On Wed, 24 Jun 2020 at 11:01, Peter Zijlstra <peterz@infradead.org> wrote:

> > And I figured a quick way to get rid of that would be something like the
> > below, seeing how volatile gets auto annotated... but that doesn't seem
> > to actually work.
> >
> > What am I missing?
> 
> There's one more in include/linux/rcupdate.h. I suggested this at some point:
> 
>     https://lore.kernel.org/lkml/20200220213317.GA35033@google.com/
> 
> To avoid volatiles as I don't think they are needed here.

Urgghh.. local_t is very expensive for this. The current code is
actually fine, even on load-store architectures. Using local_t will only
result in it being more expensive for no gain.

I'll go put data_race() around it.
