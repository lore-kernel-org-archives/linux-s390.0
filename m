Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <cafa3d94-075c-d9ed-048c-37a9b2494154@oracle.com>
Date: Sat, 23 Jun 2018 14:49:41 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Let me give you an example:
> 
>   When tsc_init() enables the usage of TSC for sched_clock() the
>   initialization of the tsc sched clock conversion data starts from zero
>   and not from the current jiffies based sched_clock() value. This makes
>   the timestamps jump backwards:
> 
>   [    0.010000] tsc: Detected 3192.137 MHz processor
>   [    0.011000] clocksource: tsc-early: mask:  ... 
>   [    0.002233] Calibrating delay loop (skipped), ....
> 
>   To address this, extend set_cyc2ns_scale() with an argument to base the
>   cyc2ns offset on the current sched_clock() value. During run time this
>   offset is 0 as the cyc2ns offset is based on the TSC sched_clock()
>   itself.
> 
> See? Precise and pure technical. No we/us/would/ and no irrelevant
> information.

Yes, thank you Thomas. I will update the changelog based on your suggestions, and no longer will impersonating my commit comments.

> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> ---
>>  arch/x86/kernel/tsc.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 186395041725..654a01cc0358 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -133,7 +133,9 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
>>  	return ns;
>>  }
>>  
>> -static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
>> +static void set_cyc2ns_scale(unsigned long khz, int cpu,
>> +			     unsigned long long tsc_now,
>> +			     unsigned long long sched_now)
> 
> sched_now is not a real good name for this as it's only used at
> initialization time. So the argument name should reflect this otherwise you
> wonder yourself when looking at that code 6 month from now, why it's 0 on
> all the run time call sites. init_offset or some other sensible name which
> makes the purpose entirely clear.
> 
>>  void __init tsc_init(void)
>>  {
>> -	u64 lpj, cyc;
>> +	u64 lpj, cyc, sch;
> 
> sch? what's wrong with sched_now or now? It's not that there is a 3 letter
> limit.

Sometimes I get caught into following the local style too much:

void __init tsc_init(void)
{
u64 lpj, cyc;
int cpu;

Hm, all the above are 3-letter variables, lets add another 3 letter one :)

I will change it to init_offset as you suggested above for set_cyc2ns_scale().

Also, I will address all the other comments that you provided in this series.

Thank you,
Pavel
