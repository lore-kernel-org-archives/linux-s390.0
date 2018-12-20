From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
Date: Thu, 20 Dec 2018 17:40:46 +0100
Message-ID: <cc659889-af32-fdbb-d615-edeadabd548a@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-6-mimu@linux.ibm.com>
 <20181220120614.65acacac.cohuck@redhat.com>
 <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
 <20181220132130.33a417fa.cohuck@redhat.com>
 <83553348-0b10-8bcc-34b0-c87a0e2f95ac@linux.ibm.com>
 <3944cf13-130a-d4ea-8d14-f8b055506339@mnis.fr>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3944cf13-130a-d4ea-8d14-f8b055506339@mnis.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pierre morel <pmorel@mnis.fr>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 20.12.18 16:43, pierre morel wrote:
> 
> 
> Le 12/20/18 à 13:33, Michael Mueller a écrit :
>>
>>
>> On 20.12.18 13:21, Cornelia Huck wrote:
>>> On Thu, 20 Dec 2018 12:49:56 +0100
>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>
>>>> On 20.12.18 12:06, Cornelia Huck wrote:
>>>>> On Wed, 19 Dec 2018 20:17:46 +0100
>>>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>>>> Use a single function with parameter irq_flags to differentiate
>>>>>> between cases.
>>>>>>
> ...snip
>>>>>>    }
>>>>>> -static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu 
>>>>>> *vcpu)
>>>>>> +static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, 
>>>>>> u16 irq_flags)
>>>>>
>>>>> Any deeper reason why this is a u16? 16 bits should be enough for
>>>>> everyone? :)
>>>>
>>>> I want to use the 8 bits for the IRQ type and the other 8 for 
>>>> additional
>>>> controls, see: "KVM: s390: restore IAM in get_ipm() when IPM is clean"
>>>
>>> Still need to look at that patch, but my question mainly was "why only
>>> 16 bits"? I would think making this local variable larger is cheap.
>>>
> 
> +1
> 
>>
>> I will enlarge the flag mask to u32 with 16 bits for the IRQ types then.
> 
> AFAIK CPU generally work better with int (or long)
> Is there any hardware reason to restrict the size?

It's already changed to 4 bytes

> 
>>
>>>>
>>>>>>    {
>>>>>> -    return vcpu->kvm->arch.float_int.pending_irqs |
>>>>>> -        vcpu->arch.local_int.pending_irqs;
>>>>>> -}
>>>
>>
> 
