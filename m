From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Tue, 21 Aug 2018 16:36:19 +0200
Message-ID: <4c91cd0c-d679-eecc-0566-ed45158f6b7f@redhat.com>
References: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
 <20180821163348.327ce02d.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821163348.327ce02d.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 21.08.2018 16:33, Cornelia Huck wrote:
> On Tue, 21 Aug 2018 16:19:38 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
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
> 
> Don't you need the address here?

As it is defined as an array, the address would result in the same value.

(&vsie_page->crycb.dea_wrapping_key_mask[0])

> 
>>  		return set_validity_icpt(scb_s, 0x0035U);
>>  
>>  	scb_s->ecb3 |= ecb3_flags;
> 


-- 

Thanks,

David / dhildenb
