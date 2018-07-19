Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
 <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com> <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
 <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
In-Reply-To: <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 19 Jul 2018 14:38:09 -0400
Message-ID: <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: tglx@linutronix.de
Cc: peterz@infradead.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 19, 2018 at 12:49 PM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> > So create two functions. native_...early..() and native....(). The early
> > one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
> > with the late one which contains all of it.
>
> Good idea. Actually, the late one will contain only hpet/pmtimer and I
> will set it only if tsc frequency was not determined only.

If we determined tsc early in boot using one of the quick methods:
from cpuid/msr/quick_pit, can we assume that frequencies of all other
CPUs will be determined the same way? Or do we still have to fallback
to PIT/HPET/PMTIMER? I wondering if we support heterogeneous
multi-socket platforms with different CPUs, because that the only
platforms where I see such scenario is possible.

Thank you,
Pavel
