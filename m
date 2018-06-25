Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 25 Jun 2018 15:48:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Message-ID: <20180625134851.GB2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com>
 <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
 <20180625092229.GW2494@hirez.programming.kicks-ass.net>
 <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: tglx@linutronix.de, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 08:32:41AM -0400, Pavel Tatashin wrote:
> > It _should_ all work.. but scary, who knows where this early stuff ends
> > up being used.
> 
> I have tested this patch

Sure,.. but call me paranoid.

> However, the other way to fix this bug is to change:
> arch/x86/kernel/jump_label.c
> 
> -void arch_jump_label_transform(struct jump_entry *entry,
> +void __ref arch_jump_label_transform(struct jump_entry *entry,
>                                enum jump_label_type type)
>  {
> +       void *(*poker)(void *, const void *, size_t) = NULL;
> +
> +       if (unlikely(!after_bootmem))
> +               poker = text_poke_early;
> +
>         mutex_lock(&text_mutex);
> -       __jump_label_transform(entry, type, NULL, 0);
> +       __jump_label_transform(entry, type, poker, 0);
>         mutex_unlock(&text_mutex);
>  }

No need to elide that mutex I think, by going through the normal
static_key_enable() stuff you already take a whole bunch of them, and
they should work early just fine (no contention etc.).

Also, I think the better condition is @early_boot_irqs_disabled, until
we enable IRQs for the first time, text_poke_early() should be fine. And
once we enable interrupts, all that other crud should really be working.

This gives:

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..425ba6102828 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -46,6 +46,9 @@ static void __jump_label_transform(struct jump_entry *entry,
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
+	if (early_boot_irqs_disabled)
+		poker = text_poke_early;
+
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			/*

> Also, modify text_poke_early to call sync_core().

and that.
