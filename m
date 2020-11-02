Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
References: <20201101173153.GC9375 () osiris>
 <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
 <54c02fa6-8c8a-667f-af99-e83a1f150586@kernel.dk>
 <d60d24de6b7c9b948333e4e288452fe0a39d2380.camel@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b7b2fa41-fab2-7fd4-f10f-9c352bc9c692@kernel.dk>
Date: Mon, 2 Nov 2020 12:50:07 -0700
MIME-Version: 1.0
In-Reply-To: <d60d24de6b7c9b948333e4e288452fe0a39d2380.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@redhat.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>

On 11/2/20 11:58 AM, Qian Cai wrote:
> On Mon, 2020-11-02 at 10:07 -0700, Jens Axboe wrote:
>> On 11/2/20 9:59 AM, Qian Cai wrote:
>>> On Sun, 2020-11-01 at 17:31 +0000, Heiko Carstens wrote:
>>>> On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
>>>>> Wire up TIF_NOTIFY_SIGNAL handling for s390.
>>>>>
>>>>> Cc: linux-s390@vger.kernel.org
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Even though I did confirm that today's linux-next contains this additional
>>> patch
>>> from Heiko below, a z10 guest is still unable to boot. Reverting the whole
>>> series (reverting only "s390: add support for TIF_NOTIFY_SIGNAL" introduced
>>> compiling errors) fixed the problem, i.e., git revert --no-edit
>>> af0dd809f3d3..7b074c15374c [1]
>>
>> That's odd, it should build fine without that patch. How did it fail for you?
> 
> In file included from ./arch/s390/include/asm/bug.h:5,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/percpu.h:5,
>                  from ./include/linux/context_tracking_state.h:5,
>                  from ./include/linux/hardirq.h:5,
>                  from ./include/linux/kvm_host.h:7,
>                  from arch/s390/kernel/asm-offsets.c:11:
> ./include/linux/sched/signal.h: In function ‘signal_pending’:
> ./include/linux/sched/signal.h:368:39: error: ‘TIF_NOTIFY_SIGNAL’ undeclared
> (first use in this function); did you mean ‘TIF_NOTIFY_RESUME’?
>   if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>                                        ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                                           ^
> ./include/linux/sched/signal.h:368:39: note: each undeclared identifier is
> reported only once for each function it appears in
>   if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>                                        ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                                           ^
> make[1]: *** [scripts/Makefile.build:117: arch/s390/kernel/asm-offsets.s] Error
> 1
> make: *** [Makefile:1198: prepare0] Error 2

Ah, but that's because later patches assume that TIF_NOTIFY_SIGNAL is
always there once all archs have been converted. If you just want to back
out that patch, you'll need to just revert this one:

commit 82ef6998ed9d488e56bbfbcc2ec9adf62bf78f08
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 9 16:04:39 2020 -0600

    kernel: remove checking for TIF_NOTIFY_SIGNAL

as well and I suspect it should build.

-- 
Jens Axboe
