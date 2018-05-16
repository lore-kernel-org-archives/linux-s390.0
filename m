From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 16 May 2018 13:16:36 +0000
Subject: Re: [PATCH v2 1/2] KVM: s390: vsie: fix < 8k check for the itdba
Message-Id: <03dc2056-0bfc-d32c-f273-289633b4ac5a@de.ibm.com>
In-Reply-To: <20180516133224.08a1771e.cohuck@redhat.com>
References: <20180516133224.08a1771e.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/16/2018 01:32 PM, Cornelia Huck wrote:
> On Wed, 16 May 2018 10:04:45 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> On 09.05.2018 16:12, David Hildenbrand wrote:
>>> By missing an "L", we might detect some addresses to be <8k,
>>> although they are not.
>>>
>>> e.g. for itdba = 100001fff
>>> !(gpa & ~0x1fffU) -> 1
>>> !(gpa & ~0x1fffUL) -> 0
>>>
>>> So we would report a SIE validity intercept although everything is fine.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>  
>>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>
>> I'd not necessarily sent it to stable, it's neither security related nor
>> a bug that is likely to occur (IMHO) or should have dire consequences.
>> But I leave that decision to Christian.
> 
> It probably does not hurt to include it in stable, but I don't think
> it's particularly important to do so, either. Anyway,

yes, lets cc stable.

> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
>>
>>> ---
>>>  arch/s390/kvm/vsie.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 8961e3970901..969882b54266 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -578,7 +578,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>  
>>>  	gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;
>>>  	if (gpa && (scb_s->ecb & ECB_TE)) {
>>> -		if (!(gpa & ~0x1fffU)) {
>>> +		if (!(gpa & ~0x1fffUL)) {
>>>  			rc = set_validity_icpt(scb_s, 0x0080U);
>>>  			goto unpin;
>>>  		}
>>>   
>>
>>
> 
