From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Thu, 23 Aug 2018 13:47:11 +0200
Message-ID: <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23/08/2018 13:33, Janosch Frank wrote:
> On 8/23/18 1:21 PM, David Hildenbrand wrote:
>> On 23.08.2018 13:05, Janosch Frank wrote:
>>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>>> The comment preceding the shadow_crycb function is
>>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>>> guest.
>>>
>>> I beg to differ:
>>>
>>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>> 		return 0;
>>
>> FORMAT2 includes bit FORMAT1 (backwards compatible)
> 
> Right, this check is very misleading because of the constant, we
> effectively test against Format 0 and Format 2.
> 
> Can we make this clearer by explicitly ANDing 0x01 or adding a comment?

yes, done, I modified the comment in front of the function.

> 
> Code makes sense:
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Thanks,

regards,
Pierre

> 
>>
>>>
>>>>
>>>> When using FORMAT2 in the host we do not need to or with
>>>> FORMAT1.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   arch/s390/kvm/vsie.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>> index 38ea5da..e0e6fbf 100644
>>>> --- a/arch/s390/kvm/vsie.c
>>>> +++ b/arch/s390/kvm/vsie.c
>>>> @@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>    * Create a shadow copy of the crycb block and setup key wrapping, if
>>>>    * requested for guest 3 and enabled for guest 2.
>>>>    *
>>>> - * We only accept format-1 (no AP in g2), but convert it into format-2
>>>> + * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
>>>> + * and we convert it into format-2 in the shadow CRYCB.
>>>>    * There is nothing to do for format-0.
>>>>    *
>>>>    * Returns: - 0 if shadowed or nothing to do
>>>> @@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>>   
>>>>   	scb_s->ecb3 |= ecb3_flags;
>>>> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
>>>> -			CRYCB_FORMAT2;
>>>> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
>>>
>>> That's purely cosmetic but valid.
>>>
>>>>   
>>>>   	/* xor both blocks in one run */
>>>>   	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
> 
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
