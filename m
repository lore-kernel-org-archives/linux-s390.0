Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgBRJJI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:09:08 -0500
Subject: Re: [PATCH v2 24/42] KVM: s390: protvirt: STSI handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-25-borntraeger@de.ibm.com>
 <380a9214-ad1a-42a0-0d7b-49289a20ff37@redhat.com>
 <aaa49efd-3c81-dcd6-cfcb-e45fb85541e8@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <148c5d6c-fef4-6cec-af85-8b48c936cc79@redhat.com>
Date: Tue, 18 Feb 2020 10:08:58 +0100
MIME-Version: 1.0
In-Reply-To: <aaa49efd-3c81-dcd6-cfcb-e45fb85541e8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 18.02.20 09:44, Christian Borntraeger wrote:
> 
> 
> On 18.02.20 09:35, David Hildenbrand wrote:
>> On 14.02.20 23:26, Christian Borntraeger wrote:
>>> From: Janosch Frank <frankja@linux.ibm.com>
>>>
>>> Save response to sidad and disable address checking for protected
>>> guests.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  arch/s390/kvm/priv.c | 11 ++++++++---
>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>>> index ed52ffa8d5d4..b2de7dc5f58d 100644
>>> --- a/arch/s390/kvm/priv.c
>>> +++ b/arch/s390/kvm/priv.c
>>> @@ -872,7 +872,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>  
>>>  	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
>>>  
>>> -	if (operand2 & 0xfff)
>>> +	if (!kvm_s390_pv_is_protected(vcpu->kvm) && (operand2 & 0xfff))
>>>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>>
>> Why is that needed? I'd assume the hardware handles this for us and this
>> case can never happen for PV? (IOW, change is not necessary)
> 
> Hardware is handling this for us AND we are not allowed to inject a specification
> exception. The ultravisor guards the program checks that we are allowed to inject.
> 

Yeah, but can this ever trigger without the check? AFAIKs, no. So why
add it?

(rather add a BUG_ON in kvm_s390_inject_program_int() in case we are in
PV mode)

>>
>>>  
>>>  	switch (fc) {
>>> @@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>  		handle_stsi_3_2_2(vcpu, (void *) mem);
>>>  		break;
>>>  	}
>>> -
>>> -	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
>>> +	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>>> +		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
>>> +		       PAGE_SIZE);
>>> +		rc = 0;
>>> +	} else {
>>> +		rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
>>> +	}
>>>  	if (rc) {
>>>  		rc = kvm_s390_inject_prog_cond(vcpu, rc);
>>>  		goto out;
>>>
>>
>> I'd pull the interrupt injection into the else case, makes things clearer.
> 
> Well, no. Thhe else case could set rc to 0.

Huh?!

if (kvm_s390_pv_is_protected(vcpu->kvm)) {
	memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
	rc = 0;
} else {
	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
	if (rc) {
		rc = kvm_s390_inject_prog_cond(vcpu, rc);
		goto out;
	}
}

What am I missing?

-- 
Thanks,

David / dhildenb
