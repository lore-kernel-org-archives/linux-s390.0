Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com> <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
 <20180625092229.GW2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180625092229.GW2494@hirez.programming.kicks-ass.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 25 Jun 2018 08:32:41 -0400
Message-ID: <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org
Cc: tglx@linutronix.de, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Peter,

> It _should_ all work.. but scary, who knows where this early stuff ends
> up being used.

I have tested this patch, and the following patch, which moves the
jump label init early and it works as Thomas describes:
on_each_cpu() ends up calling only the current CPU.

Also, you mentioned:
> And I added a sync_core() in text_poke_early(), which I think we need
> for this.

text_poke_bp() ends up calling on_each_cpu(do_sync_core, NULL, 1);
which is called on boot CPU, and thus sync_core is called. If we keep
this patch we can remove sync_core() change from the next patch.

However, the other way to fix this bug is to change:
arch/x86/kernel/jump_label.c

-void arch_jump_label_transform(struct jump_entry *entry,
+void __ref arch_jump_label_transform(struct jump_entry *entry,
                               enum jump_label_type type)
 {
+       void *(*poker)(void *, const void *, size_t) = NULL;
+
+       if (unlikely(!after_bootmem))
+               poker = text_poke_early;
+
        mutex_lock(&text_mutex);
-       __jump_label_transform(entry, type, NULL, 0);
+       __jump_label_transform(entry, type, poker, 0);
        mutex_unlock(&text_mutex);
 }

Also, modify text_poke_early to call sync_core().

Of course, this way won't prevent us from having some other code
calling text_poke() in the future during boot where uninitialized
memory access is possible. If text_poke() is called sufficiently
early, it will fail because virt_to_page() will fail, but there is an
interval, where virt_to_page() succeeds (after paging_init()), but
pages are not yet initialized (before mem_init()). To safeguard us we
could add:

BUG_ON(!after_bootmem);

To text_poke()

Thank you,
Pavel
