Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfF0Gyv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 02:54:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5R6qYEH081015
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 02:54:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcnvby6j4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 02:54:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 27 Jun 2019 07:54:39 +0100
Subject: Re: [PATCH v9 4/4] s390: ap: kvm: Enable PQAP/AQIC facility for the
 guest
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
 <1558452877-27822-5-git-send-email-pmorel@linux.ibm.com>
 <69ca50bd-3f5c-98b1-3b39-04af75151baf@de.ibm.com>
 <25a9ff69-47f0-fcba-e1fe-f0cc9914acba@de.ibm.com>
 <58cdbf55-6853-0523-eea9-5d07dbfb7bd0@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 27 Jun 2019 08:54:32 +0200
MIME-Version: 1.0
In-Reply-To: <58cdbf55-6853-0523-eea9-5d07dbfb7bd0@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b103b619-9aab-b5f9-0c79-9f4399f69b49@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com



On 26.06.19 23:12, Tony Krowiak wrote:
> On 6/25/19 4:15 PM, Christian Borntraeger wrote:
>>
>>
>> On 25.06.19 22:13, Christian Borntraeger wrote:
>>>
>>>
>>> On 21.05.19 17:34, Pierre Morel wrote:
>>>> AP Queue Interruption Control (AQIC) facility gives
>>>> the guest the possibility to control interruption for
>>>> the Cryptographic Adjunct Processor queues.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>   arch/s390/tools/gen_facilities.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>>> index 61ce5b5..aed14fc 100644
>>>> --- a/arch/s390/tools/gen_facilities.c
>>>> +++ b/arch/s390/tools/gen_facilities.c
>>>> @@ -114,6 +114,7 @@ static struct facility_def facility_defs[] = {
>>>>           .bits = (int[]){
>>>>               12, /* AP Query Configuration Information */
>>>>               15, /* AP Facilities Test */
>>>> +            65, /* AP Queue Interruption Control */
>>>>               156, /* etoken facility */
>>>>               -1  /* END */
>>>>           }
>>>>
>>>
>>> I think we should only set stfle.65 if we have the aiv facility (Because we do not
>>> have a GISA otherwise)
> 
> My assumption here is that you are taking the line added above
> (STFLE.65) out and replacing with one of the two suggestions
> below.

Yes, I want to replace this hunk.

 I am quite fuzzy on how all of this CPU model stuff works,
> but I am thinking that the above makes STFLE.65 available to be
> set via the CPU model (i.e., aqic=on on the QEMU command line) as
> long as it is supported by the host.

Yes, it makes it available when the host has stfle.65. But at the same
time it does not look if the adapter interruption virtualization facility
is available. For example for vsie the guest2 will enable stfle.65 for its
guests, but we do not support AIV.

 By taking that line out, we
> are relying on one of the suggestions below to make STFLE.65
> available to the guest only if AIV facility is available. Does that
> sound about right?
> 
> If that is the case, then wouldn't we also have to add a check to make
> sure that STFLE.65 is available on the host (i.e., test_facility(65))?

I think AIV in level n is enough to provide STFLE.65 in level n+1. 
On the other hand also checking for stfle.65 does not hurt.


> 
> 
>>>
>>> So something like this instead?
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 28ebd64..1501cd6 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2461,6 +2461,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>>                  set_kvm_facility(kvm->arch.model.fac_list, 147);
>>>          }
>>>   +       if (css_general_characteristics.aiv)
>>> +               set_kvm_facility(kvm->arch.model.fac_mask, 65);
>>> +
>>>          kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
>>>          kvm->arch.model.ibc = sclp.ibc & 0x0fff;
>>>  
>>
>> Maybe even just piggyback on gisa init (it will bail out early).
> 
> It could also go in the kvm_s390_crypto_init() function since it
> is related to crypto.
> 
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 9dde4d7..9182a04 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -3100,6 +3100,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>>          gi->timer.function = gisa_vcpu_kicker;
>>          memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>>          gi->origin->next_alert = (u32)(u64)gi->origin;
>> +       set_kvm_facility(kvm->arch.model.fac_mask, 65);
>>          VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>>   }
>>  
> 
