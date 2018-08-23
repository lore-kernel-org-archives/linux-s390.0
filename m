From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Do the CRYCB validation first
Date: Thu, 23 Aug 2018 10:01:22 +0200
Message-ID: <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-6-git-send-email-pmorel@linux.ibm.com>
 <e985a036-1b19-0feb-e50c-d55dec3dc9e7@redhat.com>
 <01047750-cdc6-b462-1e4f-c79c1036ab94@linux.ibm.com>
 <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23/08/2018 09:31, David Hildenbrand wrote:
> On 23.08.2018 09:17, Pierre Morel wrote:
>> On 22/08/2018 19:15, David Hildenbrand wrote:
>>> On 22.08.2018 18:51, Pierre Morel wrote:
>>>> When entering the SIE the CRYCB validation better
>>>> be done independently of the instruction's
>>>> availability.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    arch/s390/kvm/vsie.c | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>> index 7ee4329..fca25aa 100644
>>>> --- a/arch/s390/kvm/vsie.c
>>>> +++ b/arch/s390/kvm/vsie.c
>>>> @@ -164,17 +164,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>    	/* format-1 is supported with message-security-assist extension 3 */
>>>>    	if (!test_kvm_facility(vcpu->kvm, 76))
>>>>    		return 0;
>>>> -	/* we may only allow it if enabled for guest 2 */
>>>> -	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>> -		     (ECB3_AES | ECB3_DEA);
>>>> -	if (!ecb3_flags)
>>>> -		return 0;
>>>>    
>>>>    	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>>>>    		return set_validity_icpt(scb_s, 0x003CU);
>>>>    	if (!crycb_addr)
>>>>    		return set_validity_icpt(scb_s, 0x0039U);
>>>>    
>>>> +	/* we may only allow it if enabled for guest 2 */
>>>> +	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>> +		     (ECB3_AES | ECB3_DEA);
>>>> +	if (!ecb3_flags)
>>>> +		return 0;
>>>> +
>>>>    	/* copy only the wrapping keys */
>>>>    	if (read_guest_real(vcpu, crycb_addr + 72,
>>>>    			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>>
>>>
>>> That makes sense, especially if ECB3_AES is used but effectively turned
>>> off by us.
>>>
>>> What is the expected behavior if ECB3_AES | ECB3_DEA are not set by g2
>>> for g3?
>>>
>>
>> The use of functions PCKMO-Encrypt-DEA/AES induce a specification error.
>>
>> However other MSA3 function will continue to be usable.
> 
> No, I meant which checks should be performed here.

The SIE should check the validity of the CRYCB.

However since we do not copy the key masks we do not
expect any access error on crycb_o

So it is more a philosophical problem, should the
hypervizor enforce an error here to act as the firmware?


regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
