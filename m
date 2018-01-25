From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 12/12] KVM: s390: introduce the format-1 GISA
Date: Thu, 25 Jan 2018 17:46:40 +0100
Message-ID: <4a5c9393-c262-ef97-6377-7c2fb0cf1972@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-13-borntraeger@de.ibm.com>
 <e1e0ef1e-1311-af08-faff-72b116ce4a9d@redhat.com>
 <a17b62ac-d4a6-46ab-594a-b31a5bf1e0b0@de.ibm.com>
 <bd3eec0e-c717-5c14-e2a3-985d2f36fd8a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <bd3eec0e-c717-5c14-e2a3-985d2f36fd8a@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2018 05:16 PM, David Hildenbrand wrote:
> On 25.01.2018 16:43, Christian Borntraeger wrote:
>>
>>
>> On 01/25/2018 04:31 PM, David Hildenbrand wrote:
>> [...]
>>>>  struct kvm_s390_vsie {
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index 68d7eef..efde264 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -2518,6 +2518,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
>>>>  	vcpu->arch.sie_block->icpua = id;
>>>>  	spin_lock_init(&vcpu->arch.local_int.lock);
>>>>  	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
>>>> +	if (vcpu->arch.sie_block->gd && sclp.has_gisaf)
>>>> +		vcpu->arch.sie_block->gd |= GISA_FORMAT1;
> 
> wonder if the would be nicer via
> 
> if (kvm->arch.gisa) {
> 	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
> 	if (sclp.has_gisaf)
> 		cpu->arch.sie_block->gd |= GISA_FORMAT1;
> }

Dont know. I leave it as is.

> 
>>>>  	seqcount_init(&vcpu->arch.cputm_seqcount);
>>>>  
>>>>  	rc = kvm_vcpu_init(vcpu, kvm, id);
>>>>
>>>
>>> So, what does this bring us? We don't seem to be using any new GISA-1
>>> features.
>>
>> Preparation for device pass-through interrupt forwarding.
>>
> 
> Can you add something like that to the patch description?

done.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
