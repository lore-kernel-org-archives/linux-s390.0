From: David Hildenbrand <david@redhat.com>
Date: Tue, 06 Mar 2018 13:16:19 +0000
Subject: Re: [PATCH RFC 2/2] KVM: s390: vsie: store guest addresses of satellite blocks in vsie_page
Message-Id: <1ba0d3ff-2ab1-447c-ac5f-4cad595c2e2e@redhat.com>
In-Reply-To: <ca50248c-944b-e5de-4633-b5cea593ccd6@de.ibm.com>
References: <ca50248c-944b-e5de-4633-b5cea593ccd6@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06.03.2018 14:14, Christian Borntraeger wrote:
> 
> 
> On 03/06/2018 02:01 PM, David Hildenbrand wrote:
>> On 06.03.2018 12:53, Christian Borntraeger wrote:
>>>
>>>
>>> On 03/06/2018 12:38 PM, Christian Borntraeger wrote:
>>>> On 03/06/2018 12:32 PM, Christian Borntraeger wrote:
>>>>> David, 
>>>>>
>>>>> this seems to have broken VSIE f�r guests with >64vcpus as we only pin
>>>>> the first page of the SCA. Starting guest3 with 240 vcpu triggers
>>>>> quickly guest2 crashes. Can you have a look?
>>>>>
>>>>
>>>> Hmm, or maybe it was always broken and we never supported pinning of
>>>> ESCA properly?
>>>
>>> 4.15.0 is also broken, must be an earlier change.
>>>
>>
>> Maybe something as simple as this:
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 77d7818130db..321bfbc67d3d 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2146,6 +2146,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
>>                 /* we still need the basic sca for the ipte control */
>>                 vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
>>                 vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
>> +               return;
>>         }
>>         read_lock(&vcpu->kvm->arch.sca_lock);
>>         if (vcpu->kvm->arch.use_esca) {
>>
>>
> 
> 
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> can you spin a patch with proper Fixes tags?
> 

Sure, thanks for reporting!

-- 

Thanks,

David / dhildenb
