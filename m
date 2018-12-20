From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
Date: Thu, 20 Dec 2018 13:33:14 +0100
Message-ID: <83553348-0b10-8bcc-34b0-c87a0e2f95ac@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-6-mimu@linux.ibm.com>
 <20181220120614.65acacac.cohuck@redhat.com>
 <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
 <20181220132130.33a417fa.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220132130.33a417fa.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 20.12.18 13:21, Cornelia Huck wrote:
> On Thu, 20 Dec 2018 12:49:56 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> On 20.12.18 12:06, Cornelia Huck wrote:
>>> On Wed, 19 Dec 2018 20:17:46 +0100
>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>    
>>>> Use a single function with parameter irq_flags to differentiate
>>>> between cases.
>>>>
>>>> New irq flag:
>>>>      IRQ_FLAG_LOCAL: include vcpu local interruptions pending
>>>>      IRQ_FLAG_FLOATING: include vcpu floating interruptions pending
>>>>      IRQ_FLAG_GISA: include GISA interruptions pending in IPM
>>>
>>> I presume that means that irqs may be in more than one set? Or are gisa
>>> irqs not considered floating irqs, because they use a different
>>> mechanism?
>>
>> Currently, the interruptions managed in GISA are floating only. But
>> that might change in future. The idea is not to subsume IRQ_FLAG_GISA
>> in IRQ_FLAG_FLOATING but to be able to address the right set of
>> procedures to determine the irq pending set for a given subset of irq
>> types that have different implementations.
>>
>> There might be a better name for IRQ_FLAG_FLOATING then?
> 
> So the split is:
> 
> - local interrupts that are pending via kvm structures;
> - floating interrupts that are pending via kvm structures;
> - interrupts that are pending via gisa?
> 
> If so, what about
> - IRQ_FLAG_KVM_LOCAL
> - IRQ_FLAG_KVM_FLOATING
> - IRQ_FLAG_GISA (or maybe IRQ_FLAG_GISA_FLOATING, if you need to
>    distinguish those later on?)


yes, that's the split and I will go with:

IRQ_FLAG_KVM_LOCAL
IRQ_FLAG_KVM_FLOATING
IRQ_FLAG_GISA

initially.

The floating and local selection can be done by related masks

IRQ_MASK_LOCAL
IRQ_MASK_FLOATING

if required.

Thanks!

> 
>>
>>>    
>>>>
>>>> New irq masks:
>>>>      IRQ_MASK_ALL: include all types
>>>>      IRQ_MASK_NO_GISA: include all types but GISA
>>>>
>>>> Examples:
>>>>      pending_irqs(vcpu, IRQ_MASK_ALL)
>>>>      pending_irqs(vcpu, IRQ_MASK_NO_GISA)
>>>>
>>>> There will be more irq flags with upcoming patches.
>>>>
>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>>> ---
>>>>    arch/s390/kvm/interrupt.c | 33 +++++++++++++++++++++------------
>>>>    1 file changed, 21 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>>> index 093b568b6356..4ab20d2eb180 100644
>>>> --- a/arch/s390/kvm/interrupt.c
>>>> +++ b/arch/s390/kvm/interrupt.c
>>>> @@ -31,6 +31,13 @@
>>>>    #define PFAULT_DONE 0x0680
>>>>    #define VIRTIO_PARAM 0x0d00
>>>>    
>>>> +#define IRQ_FLAG_LOCAL    0x8000 /* include local interruption pending mask */
>>>> +#define IRQ_FLAG_FLOATING 0x4000 /* include float interruption pending mask */
>>>> +#define IRQ_FLAG_GISA     0x2000 /* include GISA interruption pending mask */
>>>> +
>>>> +#define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
>>>> +#define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
>>>> +
>>>>    /* handle external calls via sigp interpretation facility */
>>>>    static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>>>>    {
>>>> @@ -237,16 +244,18 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
>>>>    	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>>>>    }
>>>>    
>>>> -static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>>>> +static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
>>>
>>> Any deeper reason why this is a u16? 16 bits should be enough for
>>> everyone? :)
>>
>> I want to use the 8 bits for the IRQ type and the other 8 for additional
>> controls, see: "KVM: s390: restore IAM in get_ipm() when IPM is clean"
> 
> Still need to look at that patch, but my question mainly was "why only
> 16 bits"? I would think making this local variable larger is cheap.
> 

I will enlarge the flag mask to u32 with 16 bits for the IRQ types then.

>>
>>>    
>>>>    {
>>>> -	return vcpu->kvm->arch.float_int.pending_irqs |
>>>> -		vcpu->arch.local_int.pending_irqs;
>>>> -}
> 

-- 
Mit freundlichen Grüßen / Kind regards
Michael Müller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
