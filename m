Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PREEMPT-RT] [PATCH] s390/cpum_sf: Remove superfluous SMP
 function call
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris>
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Message-ID: <57039DC2.6090907@linutronix.de>
Date: Tue, 5 Apr 2016 13:13:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160405104912.GC3937@osiris>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de
List-ID: <linux-s390.vger.kernel.org>

On 04/05/2016 12:49 PM, Heiko Carstens wrote:
>> --- a/arch/s390/kernel/perf_cpum_sf.c
>> +++ b/arch/s390/kernel/perf_cpum_sf.c
>> @@ -1510,7 +1510,6 @@ static void cpumf_measurement_alert(stru
>>  static int cpumf_pmu_notifier(struct notifier_block *self,
>>  			      unsigned long action, void *hcpu)
>>  {
>> -	unsigned int cpu = (long) hcpu;
>>  	int flags;
>>
>>  	/* Ignore the notification if no events are scheduled on the PMU.
>> @@ -1523,11 +1522,15 @@ static int cpumf_pmu_notifier(struct not
>>  	case CPU_ONLINE:
>>  	case CPU_DOWN_FAILED:
>>  		flags = PMC_INIT;
>> -		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
>> +		local_irq_disable();
>> +		setup_pmc_cpu(&flags);
>> +		local_irq_enable();
>>  		break;
> 
> ...but at least the CPU_DOWN_FAILED callback will not necessarily be called
> on the cpu that couldn't be brought offline.

I don't follow.

Sebastian
