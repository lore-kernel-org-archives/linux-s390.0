From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] KVM: s390: vsie: Only accept FORMAT1 CRYCB for
 guest2
Date: Thu, 23 Aug 2018 09:42:19 +0200
Message-ID: <f8773390-7342-4488-bb46-b65adad8e04d@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-3-git-send-email-pmorel@linux.ibm.com>
 <c1ebcecb-e2fb-6ff0-8bc7-e285af62129b@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1ebcecb-e2fb-6ff0-8bc7-e285af62129b@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22/08/2018 18:55, David Hildenbrand wrote:
> On 22.08.2018 18:51, Pierre Morel wrote:
>> As the comment above the function suggested the shadowing
>> of the guest2 CRYCB can only accept a format 1 since
>> AP instructions are not supported in the guest.
>>
>> Let's modify the check which allowed to accept a format 2 too.
> 
> As the bit is ignored without AP/APXA, it is perfectly valid to accept a
> format 2, we just have to interpret it as format 1 (which is what we do)
> 
> What am I missing?
> 

Nothing.
I was still having AP interpretation in mind.


>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 12b9707..56a9d47 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -156,7 +156,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	u8 ecb3_flags;
>>   
>>   	scb_s->crycbd = 0;
>> -	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>> +	if (!(crycbd_o == CRYCB_FORMAT1))
>> +		return 0;
> 
> huh, this looks very broken. The address is still in there.
completely broken you are right

anyway this broken useless patch disappear.

Thanks,

regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
