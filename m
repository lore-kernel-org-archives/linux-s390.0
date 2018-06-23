Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v12 11/11] x86/tsc: use tsc early
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-12-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806231850430.8650@nanos.tec.linutronix.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <640e2de9-22e3-24bd-4987-5b02344aa727@oracle.com>
Date: Sat, 23 Jun 2018 17:38:45 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806231850430.8650@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/23/2018 12:56 PM, Thomas Gleixner wrote:
> On Thu, 21 Jun 2018, Pavel Tatashin wrote:
>>  /*
>>   * Scheduler clock - returns current time in nanosec units.
>>   */
>> @@ -1354,6 +1364,7 @@ void __init tsc_early_delay_calibrate(void)
>>  	lpj = tsc_khz * 1000;
>>  	do_div(lpj, HZ);
>>  	loops_per_jiffy = lpj;
>> +	sched_clock_early_init(tsc_khz);
>>  }
>>  
>>  void __init tsc_init(void)
>> @@ -1382,6 +1393,7 @@ void __init tsc_init(void)
>>  	if (!tsc_khz) {
>>  		mark_tsc_unstable("could not calculate TSC khz");
>>  		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
>> +		static_branch_disable(&__use_tsc);
> 
> This wants a proper comment.

Yes, I will add a comment. Basically, this change is for a rare scenario where early in boot we were able to get TSC frequency but failed to do so later in boot when we tried to calculate it more precisely. Though, I am not sure if this is actually possible. However, if this is indeed possible, we will get into the same continuity problem as the one that is solved in "x86/tsc: prepare for early sched_clock". So, I guess we would have to modify either "jiffies_64" or  __sched_clock_offset if we want to take care of this corner case.

Thank you,
Pavel
