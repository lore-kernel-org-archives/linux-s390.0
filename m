Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:57117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbgLOUVu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Dec 2020 15:21:50 -0500
Subject: Re: [PATCH] arch: fix 'unexpected IRQ trap at vector' warnings
References: <20201207143146.30021-1-info@metux.net>
 <877dptt5av.fsf@mpe.ellerman.id.au> <87y2i7298s.fsf@nanos.tec.linutronix.de>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <33001e60-cbfc-f114-55bf-f347f21fee9b@metux.net>
Date: Tue, 15 Dec 2020 21:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <87y2i7298s.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: tl
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman <mpe@ellerman.id.au>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org

On 09.12.20 00:01, Thomas Gleixner wrote:

> There are a few situations why it is invoked or not:
> 
>   1) The original x86 usage is not longer using it because it complains
>      rightfully about a vector being raised which has no interrupt
>      descriptor associated to it. So the original reason for naming it
>      vector is gone long ago. It emits:
> 
>      pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
>                           __func__, smp_processor_id(), vector);
> 
>      Directly from the x86 C entry point without ever invoking that
>      function.  Pretty popular error message due to some AMD BIOS
>      wreckage. :)

Of course, the term "vector" should be replaced by something like
"irqnr" or "virq", but I didn't have name changes within scope - just
wanted to fix the printing of that number, as i've stupled over it while
working on something different and wondered why the number differed from
what I had expected, until I seen that it prints hex instead of decimal.

But if you prefer a more complete cleanup, I'll be happy to do it.

>   3) It's invoked from __handle_domain_irq() when the 'hwirq' which is
>      handed in by the caller does not resolve to a mapped Linux
>      interrupt which is pretty much the same as the x86 situation above
>      in #1, but it prints useless data.
> 
>      It prints 'irq' which is invalid but it does not print the really
>      interesting 'hwirq' which was handed in by the caller and did
>      not resolve.

I wouldn't say the irq-nr isn't interesting. In my particular case it
was quite what I've been looking for. But you're right, hwirq should
also be printed.

>      In this case the Linux irq number is uninteresting as it is known
>      to be invalid and simply is not mapped and therefore does not
>      exist.

In my case it came in from generic_handle_irq(), and in this case this
irq number (IMHO) has been valid, but nobody handled it, so it went to
ack_bad_irq.

Of course, if this function is meant as a fallback to ack some not
otherwise handled IRQ on the hw, the linux irq number indeed isn't quite
helpful (unless we expect that code to do a lookup to the hw irq).

... rethinking this further ... shouldn't we also pass in even more data
(eg. irq_desc, irqchip, ...), so this function can check which hw to
actually talk to ?

>   4) It's invoked from the dummy irq chip which is installed for a
>      couple of truly virtual interrupts where the invocation of
>      dummy_irq_chip::irq_ack() is indicating wreckage.
> 
>      In that case the Linux irq number is the thing which is printed.
> 
> So no. It's not just inconsistent it's in some places outright
> wrong. What we really want is:
> 
> ack_bad_irq(int hwirq, int virq)

is 'int' correct here ?

BTW: I also wonder why the virq is unsigned int, while hwirq (eg. in
struct irq_data) is unsigned long. shouldn't the virtual number space
be at least as big (or even bigger) than the hw one ?

 {
>         if (hwirq >= 0)
>            print_useful_info(hwirq);
>         if (virq > 0)
>            print_useful_info(virq);
>         arch_try_to_ack(hwirq, virq);
> }
>     
> for this to make sense. Just fixing the existing printk() to be less
> wrong is not really an improvement.

Okay, makes sense.

OTOH: since both callers (dummychip.c, handle.c) already dump out before
ack_bad_irq(), do we need to print out anything at all ?

I've also seen that many archs increase a counter (some use long, others
atomic_t) - should we also consolidate this in an arch-independent way
in handle.c (or does kstat_incr_irqs_this_cpu already do this) ?

--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
