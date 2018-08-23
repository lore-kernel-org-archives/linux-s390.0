From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Do the CRYCB validation first
Date: Thu, 23 Aug 2018 10:40:15 +0200
Message-ID: <f4b17f4e-281e-71df-6c6e-d62a69ae179c@redhat.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-6-git-send-email-pmorel@linux.ibm.com>
 <e985a036-1b19-0feb-e50c-d55dec3dc9e7@redhat.com>
 <01047750-cdc6-b462-1e4f-c79c1036ab94@linux.ibm.com>
 <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
 <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
 <1e8abcfe-19f7-f250-77c4-35e14d181cd1@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e8abcfe-19f7-f250-77c4-35e14d181cd1@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23.08.2018 10:34, Janosch Frank wrote:
> On 23.08.2018 10:01, Pierre Morel wrote:
>> On 23/08/2018 09:31, David Hildenbrand wrote:
>>> On 23.08.2018 09:17, Pierre Morel wrote:
>>>> On 22/08/2018 19:15, David Hildenbrand wrote:
>>>>> On 22.08.2018 18:51, Pierre Morel wrote:
>>>>>> When entering the SIE the CRYCB validation better
>>>>>> be done independently of the instruction's
>>>>>> availability.
>>>>>>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>> ---
>>>>>>    arch/s390/kvm/vsie.c | 11 ++++++-----
>>>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>>> index 7ee4329..fca25aa 100644
>>>>>> --- a/arch/s390/kvm/vsie.c
>>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>>> @@ -164,17 +164,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>>>    	/* format-1 is supported with message-security-assist extension 3 */
>>>>>>    	if (!test_kvm_facility(vcpu->kvm, 76))
>>>>>>    		return 0;
>>>>>> -	/* we may only allow it if enabled for guest 2 */
>>>>>> -	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>>>> -		     (ECB3_AES | ECB3_DEA);
>>>>>> -	if (!ecb3_flags)
>>>>>> -		return 0;
>>>>>>    
>>>>>>    	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>>>>>>    		return set_validity_icpt(scb_s, 0x003CU);
>>>>>>    	if (!crycb_addr)
>>>>>>    		return set_validity_icpt(scb_s, 0x0039U);
>>>>>>    
>>>>>> +	/* we may only allow it if enabled for guest 2 */
>>>>>> +	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>>>> +		     (ECB3_AES | ECB3_DEA);
>>>>>> +	if (!ecb3_flags)
>>>>>> +		return 0;
>>>>>> +
>>>>>>    	/* copy only the wrapping keys */
>>>>>>    	if (read_guest_real(vcpu, crycb_addr + 72,
>>>>>>    			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>>>>
>>>>>
>>>>> That makes sense, especially if ECB3_AES is used but effectively turned
>>>>> off by us.
>>>>>
>>>>> What is the expected behavior if ECB3_AES | ECB3_DEA are not set by g2
>>>>> for g3?
>>>>>
>>>>
>>>> The use of functions PCKMO-Encrypt-DEA/AES induce a specification error.
>>>>
>>>> However other MSA3 function will continue to be usable.
>>>
>>> No, I meant which checks should be performed here.
>>
>> The SIE should check the validity of the CRYCB.
>>
>> However since we do not copy the key masks we do not
>> expect any access error on crycb_o
>>
>> So it is more a philosophical problem, should the
>> hypervizor enforce an error here to act as the firmware?
> 
> No it's not philosophical, that's actually regulated in the SIE
> documentation for the validity intercepts.
> 
> CRYCB is checked if (any of these is true): ECA.28, CRYCB Format is one,
> APXA installed and CRYCB Format field is three.

So independent of setting of ECB3 AES/DEA by g2. That's what I wanted to
know, thanks :)

> 
> ECB3 AES/DEA bits are handled like the matrix, i.e. they are ANDed over
> the different levels.
> 
> If that's still not what David meant to ask, then I must apologize for
> my caffeine deprived brain.


-- 

Thanks,

David / dhildenb
