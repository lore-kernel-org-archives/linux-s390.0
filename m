Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
 <20180719103340.GA2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
Date: Thu, 19 Jul 2018 11:58:41 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 07/19/2018 07:01 AM, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Peter Zijlstra wrote:
>> On Tue, Jul 17, 2018 at 10:22:06PM -0400, Pavel Tatashin wrote:
>>> During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
>>> and the second time in tsc_init().
>>>
>>> Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
>>> the calibration is done only early, and make tsc_init() to use the values
>>> already determined in tsc_early_init().
>>>
>>> Sometimes it is not possible to determine tsc early, as the subsystem that
>>> is required is not yet initialized, in such case try again later in
>>> tsc_init().
>>
>> It might be nice to preserve some of the information tglx dug out during
>> review of all this. Like the various methods of calibrate_*() and their
>> dependencies.
>>
>> And I note that this patch relies on the magic of native_calibrate_cpu()
>> working really early and not exploding in the quick calibration run.
>> This either wants fixing or documenting.
>>
>> I think the initial idea was to only do the fast_calibrate (cpuid, msr
>> and possibly the quick_pit) things early and delay the HPET/PMTIMER
>> magic until later.
> 
> Yes. I really would prefer to have this as an explicit expressed mechanism
> rather than relying on magic variables not being initialized.

What is the best way to achieve this?

I did the following:

1367 static bool __init determine_cpu_tsc_frequencies(bool early)
1368 {
1369         /* Make sure that cpu and tsc are not already calibrated */
1370         WARN_ON(cpu_khz || tsc_khz);
1371                    
1372         if (early) {
1373                 cpu_khz = x86_platform.calibrate_cpu();
1374                 tsc_khz = x86_platform.calibrate_tsc();
1375         } else {
1376                 cpu_khz = hpet_pmtime_calibrate_cpu();
1377         }

 833 /**
 834  * native_calibrate_cpu - calibrate the cpu on boot
 835  */
 836 unsigned long native_calibrate_cpu(void)
 837 {
 838         unsigned long flags, fast_calibrate;
 839 
 840         fast_calibrate = cpu_khz_from_cpuid();
 841         if (fast_calibrate)
 842                 return fast_calibrate;
 843 
 844         fast_calibrate = cpu_khz_from_msr();
 845         if (fast_calibrate)
 846                 return fast_calibrate;
 847 
 848         local_irq_save(flags);
 849         fast_calibrate = quick_pit_calibrate();
 850         local_irq_restore(flags);
 851         if (fast_calibrate)
 852                 return fast_calibrate;
 853 
 854         return hpet_pmtime_calibrate_cpu();
 855 }


And hpet_pmtime_calibrate_cpu() contains all the hpet/pmtime stuff.

However, when cpu_khz = x86_platform.calibrate_cpu() is called the first time, we still call hpet_pmtime_calibrate_cpu() from native_calibrate_cpu(). We cannot simply split native_calibrate_cpu() into two independent functions because it is also called from recalibrate_cpu_khz().

So, the question is how to enforce that the first time we do not call hpet/pmtime?

1. Use a new global variable? Kind of ugly.
2. Use system_state == SYSTEM_BOOTING ? Ugly, and probably not very safe.

Any other suggestion?

Thank you,
Pavel
