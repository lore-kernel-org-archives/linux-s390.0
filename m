Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392535AbhARN5w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 08:57:52 -0500
Subject: Re: [PATCH 1/1] KVM: s390: diag9c forwarding
References: <20210118131739.7272-1-borntraeger@de.ibm.com>
 <20210118131739.7272-2-borntraeger@de.ibm.com>
 <db1d2a6e-1947-321b-bdc2-019eee5780f4@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <5c0ca08a-d284-dc7b-3d32-c8fbc86a361f@de.ibm.com>
Date: Mon, 18 Jan 2021 14:57:04 +0100
MIME-Version: 1.0
In-Reply-To: <db1d2a6e-1947-321b-bdc2-019eee5780f4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Pierre Morel <pmorel@linux.ibm.com>, Thomas Huth <thuth@redhat.com>



On 18.01.21 14:45, Janosch Frank wrote:
> On 1/18/21 2:17 PM, Christian Borntraeger wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> When we receive intercept a DIAG_9C from the guest we verify
>> that the target real CPU associated with the virtual CPU
>> designated by the guest is running and if not we forward the
>> DIAG_9C to the target real CPU.
>>
>> To avoid a diag9c storm we allow a maximal rate of diag9c forwarding.
>>
>> The rate is calculated as a count per second defined as a
>> new parameter of the s390 kvm module: diag9c_forwarding_hz .
>>
>> The default value is to not forward diag9c.
> 
> Before Conny starts yelling I'll do it myself:
> Documentation
> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  1 +
>>  arch/s390/include/asm/smp.h      |  1 +
>>  arch/s390/kernel/smp.c           |  1 +
>>  arch/s390/kvm/diag.c             | 31 ++++++++++++++++++++++++++++---
>>  arch/s390/kvm/kvm-s390.c         |  6 ++++++
>>  arch/s390/kvm/kvm-s390.h         |  8 ++++++++
>>  6 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 74f9a036bab2..98ae55f79620 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -455,6 +455,7 @@ struct kvm_vcpu_stat {
>>  	u64 diagnose_44;
>>  	u64 diagnose_9c;
>>  	u64 diagnose_9c_ignored;
>> +	u64 diagnose_9c_forward;
>>  	u64 diagnose_258;
>>  	u64 diagnose_308;
>>  	u64 diagnose_500;
>> diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
>> index 01e360004481..e317fd4866c1 100644
>> --- a/arch/s390/include/asm/smp.h
>> +++ b/arch/s390/include/asm/smp.h
>> @@ -63,5 +63,6 @@ extern void __noreturn cpu_die(void);
>>  extern void __cpu_die(unsigned int cpu);
>>  extern int __cpu_disable(void);
>>  extern void schedule_mcck_handler(void);
>> +void notrace smp_yield_cpu(int cpu);
>>  
>>  #endif /* __ASM_SMP_H */
>> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
>> index c5abbb94ac6e..32622e9c15f0 100644
>> --- a/arch/s390/kernel/smp.c
>> +++ b/arch/s390/kernel/smp.c
>> @@ -422,6 +422,7 @@ void notrace smp_yield_cpu(int cpu)
>>  	asm volatile("diag %0,0,0x9c"
>>  		     : : "d" (pcpu_devices[cpu].address));
>>  }
>> +EXPORT_SYMBOL(smp_yield_cpu);
>>  
>>  /*
>>   * Send cpus emergency shutdown signal. This gives the cpus the
>> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
>> index 5b8ec1c447e1..fc1ec4aa81ed 100644
>> --- a/arch/s390/kvm/diag.c
>> +++ b/arch/s390/kvm/diag.c
>> @@ -150,6 +150,19 @@ static int __diag_time_slice_end(struct kvm_vcpu *vcpu)
>>  	return 0;
>>  }
>>  
>> +static unsigned int forward_cnt;
> 
> This is not per CPU, so we could have one CPU making forwards impossible
> for all others, right? Would this be a possible improvement or doesn't
> that happen in real world workloads?
> 
> The code looks ok to me but smp is absolutely not my field of expertise.
> 
>> +static unsigned long cur_slice;
>> +
>> +static int diag9c_forwarding_overrun(void)
>> +{
>> +	/* Reset the count on a new slice */
>> +	if (time_after(jiffies, cur_slice)) {
>> +		cur_slice = jiffies;
>> +		forward_cnt = diag9c_forwarding_hz / HZ;
>> +	}
>> +	return forward_cnt-- ? 1 : 0;
>> +}
>> +
>>  static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_vcpu *tcpu;
>> @@ -167,9 +180,21 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>>  	if (!tcpu)
>>  		goto no_yield;
>>  
>> -	/* target already running */
>> -	if (READ_ONCE(tcpu->cpu) >= 0)
>> -		goto no_yield;
>> +	/* target VCPU already running */
>> +	if (READ_ONCE(tcpu->cpu) >= 0) {
>> +		if (!diag9c_forwarding_hz || diag9c_forwarding_overrun())
>> +			goto no_yield;
>> +
>> +		/* target CPU already running */
>> +		if (!vcpu_is_preempted(tcpu->cpu))
>> +			goto no_yield;
>> +		smp_yield_cpu(tcpu->cpu);
> 
> This is a pure cpu yield while before we yielded to the process of the
> vcpu. Do we also want to prod the task of the VCPU we want to yield to

No we did not yielded to the process. This case is for vcpu already
running according to the host scheduler (which would result in an no-op).
See the "before hunk". it contains goto no_yield.

Instead we now check if our host CPU was potentially scheduled by the upper
layer hypervisor (e.g. LPAR) and then we ask that to also yield.

> before waking up the host cpu? Or do we expect the VCPU task to be the
> first thing that's picked up by the host cpu?
