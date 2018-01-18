From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 04/12] KVM: s390: implement GISA IPM related primitives
Date: Thu, 18 Jan 2018 21:45:03 +0100
Message-ID: <46713077-a46c-c3e3-45d7-ad4dc4cbce2e@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-5-borntraeger@de.ibm.com>
 <249b3566-b8f3-5825-1f2b-6e0662874ca0@redhat.com>
 <bcc245f6-c29d-4ee7-2050-9e2f29be7b94@linux.vnet.ibm.com>
 <28160f0a-4056-626e-2b83-0e6f039f27fc@redhat.com>
 <2e96491f-c73e-2782-17b0-5d9764ecf5d7@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2e96491f-c73e-2782-17b0-5d9764ecf5d7@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mimu@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 18.01.2018 16:58, Michael Mueller wrote:
> 
> 
> On 18.01.18 15:33, David Hildenbrand wrote:
>> On 18.01.2018 15:29, Michael Mueller wrote:
>>>
>>>
>>> On 17.01.18 15:35, David Hildenbrand wrote:
>>>> On 16.01.2018 21:02, Christian Borntraeger wrote:
>>>>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
>>>>>
>>>>> The patch implements routines to access the GISA to test and modify
>>>>> its Interruption Pending Mask (IPM) from the host side.
>>>>>
>>>>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>>>>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>> ---
>>>>>    arch/s390/kvm/interrupt.c | 23 +++++++++++++++++++++++
>>>>>    arch/s390/kvm/kvm-s390.h  |  4 ++++
>>>>>    2 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>>>> index b94173560dcf..dfdecff302d2 100644
>>>>> --- a/arch/s390/kvm/interrupt.c
>>>>> +++ b/arch/s390/kvm/interrupt.c
>>>>> @@ -2682,3 +2682,26 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>>>>>    
>>>>>    	return n;
>>>>>    }
>>>>> +
>>>>> +#define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * 8)
>>>>
>>>> 8 -> BITS_PER_BYTE, but ...
>>>>
>>>> Am I wrong or can we only modify the 8 ipm bits this way? But we
>>>> want/have to do it in an atomic fashion?
>>>>
>>>> Using an unsigned long seems wrong, because we "rewrite" more than we
>>>> should. Esp. everything beyond ipm. oi / ni and friends are not
>>>> available on older machines.
>>>>
>>>> What about something as simple as the following
>>>>
>>>>
>>>> +void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u8 gisc)
>>>> +{
>>>> +       u8 value = (0x80 >> gisc);
>>>> +
>>>> +       __sync_fetch_and_or(&gisa->ipm, value);
>>>> +}
>>>> +
>>>>
>>>
>>> Nobody is using this compiler build-in in the kernel and a quick compile
>>> shows that it produces an ORK and CS instead of a LAOG beside a lot of
>>> supporting instructions. Unfortunately it's not saving what you promise
>>> ... ;) Will not change.
>>>
>>
>> Using unsigned long * bitmap operations to modify an u8 type atomically
>> just seems very very wrong >
> 
> I have to reconsider this...
> 
>>
> 

Actually, the problem is there are no atomic byte-based operations on
s390x without Interlocked-Access-Facility 2.

Even __sync_fetch_and_or(&gisa->ipm, value) falls back to a
Compare-And-Swap loop. And Compare-And-Swap also operates at least on 32bit.

So I assume there isn't too much we can do about it. As storage
locations following the u8 are also written - but in an atomic matter,
it should in general not matter.

But can we avoid starting the bitmap at the beginning of the gisa?

What about something like this:

+void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u8 gisc)
+{
+       set_bit_inv(gisc, (unsigned long *) &gisa->ipm);
+}

-- 

Thanks,

David / dhildenb
