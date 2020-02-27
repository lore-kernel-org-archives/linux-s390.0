Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:33892 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0Kbb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Feb 2020 05:31:31 -0500
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/18] genirq: Remove setup_irq()
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
Date: Thu, 27 Feb 2020 11:31:15 +0100
Message-ID: <87y2somido.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: afzal mohammed <afzal.mohd.ma@gmail.com>, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>

Afzal,

afzal mohammed <afzal.mohd.ma@gmail.com> writes:

> While trying to understand internals of irq handling, came across a
> thread [1] in which tglx was referring to avoid usage of setup_irq().
> Existing callers of setup_irq() reached mostly via 'init_IRQ()' &
> 'time_init()', while memory allocators are ready by 'mm_init()'.
>
> Hence instances of setup_irq() is replaced by request_irq() &
> setup_irq() (along with remove_irq()) definition deleted in the last
> patch.
>
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().

thanks a lot for tackling this!

Vs. merging this series, I suggest the following approach:

   - Resubmit the individual changes as single patches or small series
     to the relevant maintainers and subsystem mailing lists. They have
     no dependency on a core change and can be applied where they belong
     to.

   - After 5.6-rc6, verify which parts have made their way into
     linux-next and resubmit the ignored ones as a series to me along
     with the removal of the core parts.

That way we can avoid conflicting changes between subsystems and the tip
irq/core branch as much as possible.

Thanks,

        tglx
