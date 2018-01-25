From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 12/12] KVM: s390: introduce the format-1 GISA
Date: Thu, 25 Jan 2018 17:51:24 +0100
Message-ID: <cbb017f2-f0eb-f147-0bab-c51dc96658bb@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-13-borntraeger@de.ibm.com>
 <e1e0ef1e-1311-af08-faff-72b116ce4a9d@redhat.com>
 <a17b62ac-d4a6-46ab-594a-b31a5bf1e0b0@de.ibm.com>
 <20180125164751.3034a45d.cohuck@redhat.com>
 <fe0ef85d-ee9d-a699-c078-d72feb1d1232@de.ibm.com>
 <20180125171742.484d29d1.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125171742.484d29d1.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2018 05:17 PM, Cornelia Huck wrote:
> On Thu, 25 Jan 2018 17:12:59 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 01/25/2018 04:47 PM, Cornelia Huck wrote:
>>> On Thu, 25 Jan 2018 16:43:27 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>   
>>>> On 01/25/2018 04:31 PM, David Hildenbrand wrote:
>>>> [...]  
>>>>>>  struct kvm_s390_vsie {
>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>> index 68d7eef..efde264 100644
>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>> @@ -2518,6 +2518,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
>>>>>>  	vcpu->arch.sie_block->icpua = id;
>>>>>>  	spin_lock_init(&vcpu->arch.local_int.lock);
>>>>>>  	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
>>>>>> +	if (vcpu->arch.sie_block->gd && sclp.has_gisaf)
>>>>>> +		vcpu->arch.sie_block->gd |= GISA_FORMAT1;
>>>>>>  	seqcount_init(&vcpu->arch.cputm_seqcount);
>>>>>>  
>>>>>>  	rc = kvm_vcpu_init(vcpu, kvm, id);
>>>>>>    
>>>>>
>>>>> So, what does this bring us? We don't seem to be using any new GISA-1
>>>>> features.    
>>>>
>>>> Preparation for device pass-through interrupt forwarding.
>>>>  
>>>
>>> Should we start out with a dual format-0/format-1 gisa block, then?
>>> IIUC, you'll switch to gisa-1 if the facility is there and gisa-1 can
>>> do anything that gisa-0 can do?  
>>
>> There might be systems that only have gisa-0, so I think having both makes
>> sense.
>>
> 
> Yes, that's what I meant. Just do it earlier in the series - this patch
> feels like an afterthought with no real user.

I added 

A format-1 can do everything that format-0 can and we will need it
for real HW passthrough. As there are systems with only format-0
we keep both variants.

to the patch description. Maybe its now a bit less odd?
