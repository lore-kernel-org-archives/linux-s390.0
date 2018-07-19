Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-26-pasha.tatashin@oracle.com> <20180719104838.GC2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180719104838.GC2494@hirez.programming.kicks-ass.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 19 Jul 2018 10:24:40 -0400
Message-ID: <CAGM2reZYcKqoSBZQmUP-CMO=2bLznahLjzp=t0xiTxGsAMsEng@mail.gmail.com>
Subject: Re: [PATCH v14 25/25] sched: use static key for sched_clock_running
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 19, 2018 at 6:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 17, 2018 at 10:22:11PM -0400, Pavel Tatashin wrote:
> > sched_clock_running may be read every time sched_clock_cpu() is called.
> > Yet, this variable is updated only twice during boot, and never changes
> > again, therefore it is better to make it a static key.
>
> Right, so the focus was always on making the sane TSC case fast, and if
> TSC isn't stable we'd just make do and not care too much.
>

True for CONFIG_HAVE_UNSTABLE_SCHED_CLOCK, but for other systems like
SPARC, it hurts to have this variable accessed every time, even though
they have a sane sched_clock().

> But this certainly isn't wrong, so ACK.

Thank you,
Pave
