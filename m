Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Sat, 23 Jun 2018 17:29:35 -0400
Message-ID: <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: tglx@linutronix.de
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> So you forgot to answer this question. I did not find a system yet, which
> actually exposes this behaviour on mainline.
>
> Is this an artifact of your early sched clock thing?
>

Yes, it is. Let me explain how it happens.

So, the problem is introduced in patch "sched: early boot clock" by this change:

-       if (unlikely(!sched_clock_running))
-               return 0ull;
+       /* Use early clock until sched_clock_init_late() */
+       if (unlikely(sched_clock_running < 2))
+               return sched_clock() + __sched_clock_offset;

As soon as sched_clock() starts output non-zero values, we start
output time without correcting the output as it is done in
sched_clock_local() where unstable TSC and backward motion are
detected. But, since early in boot interrupts are disabled, we cannot
really correct invalid time, and therefore must rely on sched_clock()
to provide us with a contiguous and sane time. In earlier versions of
this project, I was solving this problem by adjusting
__sched_clock_offset every time sched_clock()'s continuity was changed
by using a callback function into sched/clock.c. But, Peter was
against that approach.
