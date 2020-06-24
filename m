Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXPTL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 11:19:11 -0400
Date: Wed, 24 Jun 2020 17:18:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200624151814.GI4781@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
 <20200623202404.GE2483@worktop.programming.kicks-ass.net>
 <20200624113246.GA170324@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624113246.GA170324@elver.google.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk, paulmck@kernel.org

On Wed, Jun 24, 2020 at 01:32:46PM +0200, Marco Elver wrote:
> From: Marco Elver <elver@google.com>
> Date: Wed, 24 Jun 2020 11:23:22 +0200
> Subject: [PATCH] kcsan: Make KCSAN compatible with new IRQ state tracking
> 
> The new IRQ state tracking code does not honor lockdep_off(), and as
> such we should again permit tracing by using non-raw functions in
> core.c. Update the lockdep_off() comment in report.c, to reflect the
> fact there is still a potential risk of deadlock due to using printk()
> from scheduler code.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks!

I've put this in front of the series at hand. I'll wait a little while
longer for arch people to give feedback on their header patches before I
stuff the lot into tip/locking/core.
