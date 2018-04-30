From: David Hildenbrand <david@redhat.com>
Date: Mon, 30 Apr 2018 15:44:18 +0000
Subject: Re: [PATCH v1 1/3] KVM: s390: introduce defines for control registers
Message-Id: <fdfc7964-f4b3-e1c1-633b-fb9e6a9ca9a3@redhat.com>
In-Reply-To: <1a1657fe-aef3-ec82-2cbc-58d3a7d55730@linux.ibm.com>
References: <1a1657fe-aef3-ec82-2cbc-58d3a7d55730@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 30.04.2018 17:41, Janosch Frank wrote:
> On 30.04.2018 15:23, David Hildenbrand wrote:
>> On 27.04.2018 14:36, David Hildenbrand wrote:
>>> In KVM code we use masks to test/set control registers.
>>>
>>> Let's define the ones we use in arch/s390/include/asm/ctl_reg.h and
>>> replace all occurrences in KVM code.
>>>
>>> As we will be needing the define for Clock-comparator sign control soon,
>>> let's also add it.
>>>
>>> Suggested-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> Just realized that I was sending out an older version of the patch,
>> (partially updated due to new SIGN bit) the following two hunks are
>> missing
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 5a30fc275a4c..daa09f89ca2d 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -172,7 +172,7 @@ static int ckc_irq_pending(struct kvm_vcpu *vcpu)
>>         const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
>>         const u64 ckc = vcpu->arch.sie_block->ckc;
>>
>> -       if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
>> +       if (vcpu->arch.sie_block->gcr[0] & CR0_CLOCK_COMPARATOR_SIGN) {
>>                 if ((s64)ckc >= (s64)now)
>>                         return 0;
>>         } else if (ckc >= now) {
>> @@ -1062,7 +1062,7 @@ static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
>>         u64 cputm, sltime = 0;
>>
>>         if (ckc_interrupts_enabled(vcpu)) {
>> -               if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
>> +               if (vcpu->arch.sie_block->gcr[0] & CR0_CLOCK_COMPARATOR_SIGN) {
>>                         if ((s64)now < (s64)ckc)
>>                                 sltime = tod_to_ns((s64)ckc - (s64)now);
>>                 } else if (now < ckc) {
>>
>>
>> Christian/Janosch, please tell me if you can fix this up by applying
>> or if I should resend.
>>
> 
> Please send a v2 of this patch as a reply, no need for a full resend.
> Thanks for the work, have a nice first of May.

Yes, will send as reference to v1. Thanks - to you, too!

> 
> If possible try to get the linux.vnet.ibm.com addresses out of your
> address books. We dropped the vnet bit recently.
> 

Oh, haven't noticed that. Thanks for the heads up. maybe in another 10
years you'll be back to a pure "@ibm.com", one step at a time :P

-- 

Thanks,

David / dhildenb
