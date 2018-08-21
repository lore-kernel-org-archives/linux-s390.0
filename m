From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Tue, 21 Aug 2018 16:58:03 +0200
Message-ID: <afe5eb8d-359b-60b7-bd4c-6d0ddda1b65b@redhat.com>
References: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
 <929b67bc-44aa-a9ff-0ac2-9a35c2b456ef@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <929b67bc-44aa-a9ff-0ac2-9a35c2b456ef@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 21.08.2018 16:43, Janosch Frank wrote:
> On 21.08.2018 16:19, Pierre Morel wrote:
>> Copy the key mask to the right offset inside the shadow CRYCB
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  arch/s390/kvm/vsie.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 63844b9..a2b28cd 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>  		return set_validity_icpt(scb_s, 0x0039U);
>>  
>>  	/* copy only the wrapping keys */
>> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
>> +	if (read_guest_real(vcpu, crycb_addr + 72,
>> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>  		return set_validity_icpt(scb_s, 0x0035U);
>>  
>>  	scb_s->ecb3 |= ecb3_flags;
>>
> 
> Are we able to use offsetof and sizeof here? I'd rather have a few more
> characters than magic offsets.
> What about CC stable?

Thought about both things, too.

1. offsetof and sizeof will most likely make sense (although will most
likely make this very ugly due to the long names involved)

2. I am not sure about wrapping keys. We never had migration problems,
so I assume this does not break migration (maybe it will break once we
fix it on one side :) ). As we xor with the g2 keys, we will never match
the g2 keys. HW will xor with our keys either way, so it cannot match
our keys.

But two g3 guests will now have the same wrapping keys, I assume that's bad?

I guess we'll have to wait for Christian, I remember he was one of the
people that understood what wrapping keys are actually good for (and the
real key used in HW can simply, silently change, e.g. when migrating to
another system - due to the xoring).

Not having understood/looked into the details, I guess this should be
stable material.

> 
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 


-- 

Thanks,

David / dhildenb
