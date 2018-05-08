From: David Hildenbrand <david@redhat.com>
Date: Tue, 08 May 2018 08:40:49 +0000
Subject: Re: [PATCH v1 2/2] KVM: s390: vsie: simplify < 8k address checks
Message-Id: <d787f12e-accb-6350-6059-48a6bc9b6687@redhat.com>
In-Reply-To: <dda85f48-aa11-25e6-ccdf-57d9fc6e41fa@de.ibm.com>
References: <dda85f48-aa11-25e6-ccdf-57d9fc6e41fa@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08.05.2018 09:32, Christian Borntraeger wrote:
> 
> 
> On 05/08/2018 09:30 AM, Christian Borntraeger wrote:
>>
>>
>> On 05/02/2018 04:28 PM, David Hildenbrand wrote:
>>> On 02.05.2018 14:42, Heiko Carstens wrote:
>>>> On Wed, May 02, 2018 at 01:08:14PM +0200, David Hildenbrand wrote:
>>>>> This makes it certainly more readable.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  arch/s390/kvm/vsie.c | 10 +++++-----
>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>> index 969882b54266..7c51a9dc0ec8 100644
>>>>> --- a/arch/s390/kvm/vsie.c
>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>> @@ -557,7 +557,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>>  	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
>>>>>  		gpa |= (u64) READ_ONCE(scb_o->scaoh) << 32;
>>>>>  	if (gpa) {
>>>>> -		if (!(gpa & ~0x1fffUL))
>>>>> +		if (gpa < 8192)
>>>>
>>>> 2 * PAGE_SIZE, please. That's how it is done on various other places too.
>>>>
>>>
>>> Christian, does the documentation use the wording "lowcore" or "8192" / 8k?
>>>
>>> If it is lowcore, I agree to use 2 * PAGE_SIZE. If not, I prefer it to
>>> directly match documentation.
>>>
>>> Anyhow, I leave this decision to Janosch and Christian. Thanks for
>>> having alook!
>>>
>> prefix area and reverse prefix area. 
>> In fact what we check here is actually the reversed prefix area so for completeness we
>> would need an additional check.
> 
> We seem to check both for SCA so we are good for SCA.
> 

I remember that this check only had to be performed for the SCA.

I'll resend, using PAGE_SIZE * 2 then. Thanks!

-- 

Thanks,

David / dhildenb
