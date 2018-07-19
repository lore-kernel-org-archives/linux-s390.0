Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 18:19:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
In-Reply-To: <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
Message-ID: <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com> <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
 <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Jul 2018, Pavel Tatashin wrote:
> On 07/19/2018 07:01 AM, Thomas Gleixner wrote:
> 
> And hpet_pmtime_calibrate_cpu() contains all the hpet/pmtime stuff.
> 
> However, when cpu_khz = x86_platform.calibrate_cpu() is called the first
> time, we still call hpet_pmtime_calibrate_cpu() from
> native_calibrate_cpu(). We cannot simply split native_calibrate_cpu()
> into two independent functions because it is also called from
> recalibrate_cpu_khz().

> So, the question is how to enforce that the first time we do not call hpet/pmtime?
> 
> 1. Use a new global variable? Kind of ugly.
> 2. Use system_state == SYSTEM_BOOTING ? Ugly, and probably not very safe.

Both are horrible.

So create two functions. native_...early..() and native....(). The early
one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
with the late one which contains all of it.

Hmm?

Thanks,

	tglx
