From: Michael Mueller <mimu@linux.ibm.com>
Date: Tue, 06 Nov 2018 12:29:24 +0000
Subject: Re: [PATCH 07/10] KVM: s390: add function process_gib_alert_list()
Message-Id: <70df3c70-4e61-f6e9-c502-9f8f3540aa0a@linux.ibm.com>
In-Reply-To: <fd3134f2-0031-85ef-f6ad-73287c60dd78@linux.ibm.com>
References: <fd3134f2-0031-85ef-f6ad-73287c60dd78@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05.11.18 17:55, Pierre Morel wrote:
>>>
>>>> +������� /* wake-up a vcpu of the kvm this gisa belongs to */
>>>> +������� kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>>>> +������� __floating_irq_kick(kvm, KVM_S390_INT_IO(1, 0, 0, 0));
>>>
>>> Do we really need to insert a floating interrupt?
>>> Wouldn't a simple kvm_s390_vcpu_wakeup() after choosing the vcpu be 
>>> enough?
>>>
>>
>> We need to find a suitable vcpu before calling kvm_s390_vcpu_wakeup().
>> That is exactly what __floating_irq_kick() does for us, right?
> 
> Yes right, it is just an optimization, we have two unnecessary tests, 
> one for interrupt type and another for GISA availability.

I will factor out a function  __find_vcpu_for_irq()

> 
>>
>> It is *not* inserting a floating interruption.
>>
>>>
>>>> +��� }
>>>> +
>>>> +��� if (gisa_to_nullify)
>>>> +������� nullify_gisa(gisa_to_nullify);
