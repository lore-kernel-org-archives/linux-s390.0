From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Thu, 23 Aug 2018 10:08:47 +0200
Message-ID: <34678638-a242-1394-a673-74c4e90e3ee3@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-2-git-send-email-pmorel@linux.ibm.com>
 <8300634d-8500-1898-e283-175fc893054a@redhat.com>
 <c5e8669d-3d8e-5d66-66da-b61e509b04e0@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5e8669d-3d8e-5d66-66da-b61e509b04e0@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23/08/2018 10:02, Janosch Frank wrote:
> On 22.08.2018 18:53, David Hildenbrand wrote:
>> On 22.08.2018 18:51, Pierre Morel wrote:
>>> Copy the key mask to the right offset inside the shadow CRYCB
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   arch/s390/kvm/vsie.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 9175518..12b9707 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>   		return set_validity_icpt(scb_s, 0x0039U);
>>>   
>>>   	/* copy only the wrapping keys */
>>> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
>>> +	if (read_guest_real(vcpu, crycb_addr + 72,
>>> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>   
>>>   	scb_s->ecb3 |= ecb3_flags;
>>>
>>
>> Please fixup the subject as requested. (were there more RB-s?)
>>
> 
> Yes, he seems to have ignored mine...
> 
Sorry,
I focused on your comment and the answer from David and forgot it.

thanks Janosch I will add it of course

regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
