Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbfFZVMh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 17:12:37 -0400
Subject: Re: [PATCH v9 4/4] s390: ap: kvm: Enable PQAP/AQIC facility for the
 guest
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
 <1558452877-27822-5-git-send-email-pmorel@linux.ibm.com>
 <69ca50bd-3f5c-98b1-3b39-04af75151baf@de.ibm.com>
 <25a9ff69-47f0-fcba-e1fe-f0cc9914acba@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <58cdbf55-6853-0523-eea9-5d07dbfb7bd0@linux.ibm.com>
Date: Wed, 26 Jun 2019 17:12:10 -0400
MIME-Version: 1.0
In-Reply-To: <25a9ff69-47f0-fcba-e1fe-f0cc9914acba@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com

On 6/25/19 4:15 PM, Christian Borntraeger wrote:
> 
> 
> On 25.06.19 22:13, Christian Borntraeger wrote:
>>
>>
>> On 21.05.19 17:34, Pierre Morel wrote:
>>> AP Queue Interruption Control (AQIC) facility gives
>>> the guest the possibility to control interruption for
>>> the Cryptographic Adjunct Processor queues.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   arch/s390/tools/gen_facilities.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>> index 61ce5b5..aed14fc 100644
>>> --- a/arch/s390/tools/gen_facilities.c
>>> +++ b/arch/s390/tools/gen_facilities.c
>>> @@ -114,6 +114,7 @@ static struct facility_def facility_defs[] = {
>>>   		.bits = (int[]){
>>>   			12, /* AP Query Configuration Information */
>>>   			15, /* AP Facilities Test */
>>> +			65, /* AP Queue Interruption Control */
>>>   			156, /* etoken facility */
>>>   			-1  /* END */
>>>   		}
>>>
>>
>> I think we should only set stfle.65 if we have the aiv facility (Because we do not
>> have a GISA otherwise)

My assumption here is that you are taking the line added above
(STFLE.65) out and replacing with one of the two suggestions
below. I am quite fuzzy on how all of this CPU model stuff works,
but I am thinking that the above makes STFLE.65 available to be
set via the CPU model (i.e., aqic=on on the QEMU command line) as
long as it is supported by the host. By taking that line out, we
are relying on one of the suggestions below to make STFLE.65
available to the guest only if AIV facility is available. Does that
sound about right?

If that is the case, then wouldn't we also have to add a check to make
sure that STFLE.65 is available on the host (i.e., test_facility(65))?




>>
>> So something like this instead?
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 28ebd64..1501cd6 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2461,6 +2461,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>                  set_kvm_facility(kvm->arch.model.fac_list, 147);
>>          }
>>   
>> +       if (css_general_characteristics.aiv)
>> +               set_kvm_facility(kvm->arch.model.fac_mask, 65);
>> +
>>          kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
>>          kvm->arch.model.ibc = sclp.ibc & 0x0fff;
>>   
>>
> 
> Maybe even just piggyback on gisa init (it will bail out early).

It could also go in the kvm_s390_crypto_init() function since it
is related to crypto.

> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9dde4d7..9182a04 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3100,6 +3100,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>          gi->timer.function = gisa_vcpu_kicker;
>          memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>          gi->origin->next_alert = (u32)(u64)gi->origin;
> +       set_kvm_facility(kvm->arch.model.fac_mask, 65);
>          VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>   }
>   
> 
