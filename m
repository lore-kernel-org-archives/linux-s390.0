Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com> <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
 <20180625092229.GW2494@hirez.programming.kicks-ass.net> <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
 <20180625134851.GB2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180625134851.GB2494@hirez.programming.kicks-ass.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 25 Jun 2018 10:06:10 -0400
Message-ID: <CAGM2reaOZiCsJbLonrZH0-uPQFLG4Xek0mJ4gNZe7K6iJFU=Xw@mail.gmail.com>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org
Cc: tglx@linutronix.de, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-ID: <linux-s390.vger.kernel.org>

> Also, I think the better condition is @early_boot_irqs_disabled, until
> we enable IRQs for the first time, text_poke_early() should be fine. And
> once we enable interrupts, all that other crud should really be working.

Sure, I will use early_boot_irqs_disabled flag. I think, we still want
to have BUG_ON(!after_bootmem); in text_poke(). I could do
BUG_ON(early_boot_irqs_disabled), but I am worried that there are call
sites that might be using text_poke() between mem_init() and
local_irq_enable() in start_kernel().

>
> This gives:
>
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index e56c95be2808..425ba6102828 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -46,6 +46,9 @@ static void __jump_label_transform(struct jump_entry *entry,
>         const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>         const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
>
> +       if (early_boot_irqs_disabled)
> +               poker = text_poke_early;
> +
>         if (type == JUMP_LABEL_JMP) {
>                 if (init) {
>                         /*
>
> > Also, modify text_poke_early to call sync_core().

Also, we still need to add __ref to __jump_label_transform as
text_poke_early() is __init
