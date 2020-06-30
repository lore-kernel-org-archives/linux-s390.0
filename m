Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgF3F7p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jun 2020 01:59:45 -0400
Date: Tue, 30 Jun 2020 07:59:39 +0200
From: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200630055939.GA3676007@debian-buster-darwi.lab.linutronix.de>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623083721.512673481@infradead.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

Peter Zijlstra wrote:

...

> -#define lockdep_assert_irqs_disabled()	do {			\
> -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> -			  current->hardirqs_enabled,			\
> -			  "IRQs not disabled as expected\n");		\
> -	} while (0)

...

> +#define lockdep_assert_irqs_disabled()				\
> +do {									\
> +	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
> +} while (0)

I think it would be nice to keep the "IRQs not disabled as expected"
message. It makes the lockdep splat much more readable.

This is similarly the case for the v3 lockdep preemption macros:

  https://lkml.kernel.org/r/20200630054452.3675847-5-a.darwish@linutronix.de

I did not add a message though to get in-sync with the IRQ macros above.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
