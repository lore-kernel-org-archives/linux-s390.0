From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
Date: Mon, 4 Feb 2019 16:15:42 +0100
Message-ID: <4d3977bf-63ec-5732-b2fc-ea8654f444e3@redhat.com>
References: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
 <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
 <ccdc89cd-5299-e674-3329-74e9131dd874@redhat.com>
 <3bb397e9-d679-1152-1b42-d633682b3272@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3bb397e9-d679-1152-1b42-d633682b3272@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, Claudio Imbrenda <imbrenda@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01.02.19 14:37, Pierre Morel wrote:
> On 01/02/2019 11:56, David Hildenbrand wrote:
>> On 01.02.19 10:52, Pierre Morel wrote:
>>> The case when the SIE for guest3 is not setup for using
>>> encryption keys nor Adjunct processor but the guest2
>>> does use these features was not properly handled.
>>>
>>> This leads SIE entry for guest3 to crash with validity intercept
>>> because the guest2, not having the use of encryption keys nor
>>> Adjunct Processor did not initialize the CRYCB designation.
>>>
>>> In the case where none of ECA_APIE, ECB3_AES or ECB3_DEA
>>> are set in guest3 a format 0 CRYCB is allowed for guest3
>>> and the CRYCB designation in the SIE for guest3 is not checked
>>> on SIE entry.
>>>
>>> Let's allow the CRYCD designation to be ignored when the
>>> SIE for guest3 is not initialized for encryption key usage
>>> nor AP.
>>>
>>> Fixup: d6f6959 (KVM: s390: vsie: Do the CRYCB validation first)
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> ---
>>>   arch/s390/kvm/vsie.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index a153257..a748f76 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -300,6 +300,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>   	if (!apie_h && !key_msk)
>>>   		return 0;
>>>   
>>> +	if (!(scb_o->eca & ECA_APIE) && !(scb_o->ecb3 & (ECB3_AES | ECB3_DEA)))
>>> +		return 0;
>>> +
>>>   	if (!crycb_addr)
>>>   		return set_validity_icpt(scb_s, 0x0039U);
>>>   
>>>
>>
>> The original patch said
>>
>> "We need to handle the validity checks for the crycb, no matter what the
>>   settings for the keywrappings are. So lets move the keywrapping checks
>>   after we have done the validy checks."
>>
>> Can you explain why keywrapping now is important? These patches seem to
>> contradict.
>>
> 
> No it does not, having the flags set or not is part of the validity check.
> but, I acted too fast.
> 
> The problem seems to be even clearer:
> key_msk is defined as
>     int key_msk = test_kvm_facility(vcpu->kvm, 76);
> 
> If it is defined, as it should for a mask, as
> 	(scb_o->ecb3 & (ECB3_AES | ECB3_DEA))
> 
> all is clear..., key_msk is not use but for this test, so I do not 
> understand why it is set as facility 76.
> 
> so I think I better do:
> 
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a153257..30843a8 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -289,7 +289,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, 
> struct vsie_page *vsie_page)
>          unsigned long *b1, *b2;
>          u8 ecb3_flags;
>          int apie_h;
> -       int key_msk = test_kvm_facility(vcpu->kvm, 76);
> +       int key_msk = scb_o->ecb3 & (ECB3_AES | ECB3_DEA);
>          int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
>          int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>          int ret = 0;
> 
> 
> So just define a mask a mask.
> I verify the functionality and test on Monday  and if in between it 
> seems better to you so too I post the patch.

Without documentation at hand I cannot really judge what is the right
approach. You have to read the architecture description very carefully
and thimk about the different scenarios. I cannot help here.

test_kvm_facility(vcpu->kvm, 76) means "hardware knows key wrapping exists"

scb_o->ecb3 & (ECB3_AES | ECB3_DEA) means "key wrapping was actually
enabled for AES or DEA"

> 
> Thanks,
> Pierre
> 


-- 

Thanks,

David / dhildenb
