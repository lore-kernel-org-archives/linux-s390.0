Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35004 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbgBRJNz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:13:55 -0500
Subject: Re: [PATCH v2 24/42] KVM: s390: protvirt: STSI handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-25-borntraeger@de.ibm.com>
 <380a9214-ad1a-42a0-0d7b-49289a20ff37@redhat.com>
 <aaa49efd-3c81-dcd6-cfcb-e45fb85541e8@de.ibm.com>
 <148c5d6c-fef4-6cec-af85-8b48c936cc79@redhat.com>
 <c9df9696-a2b0-fd19-cfc7-1c382e8ac4fa@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8270819c-b9d8-eb35-49b9-dc16419a95ab@redhat.com>
Date: Tue, 18 Feb 2020 10:13:46 +0100
MIME-Version: 1.0
In-Reply-To: <c9df9696-a2b0-fd19-cfc7-1c382e8ac4fa@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

>> Yeah, but can this ever trigger without the check? AFAIKs, no. So why
>> add it?
> 
> It can. the GPRS can contain stale data and so can operand2.
> 

Oh, ok. Makes sense.

>>
>> (rather add a BUG_ON in kvm_s390_inject_program_int() in case we are in
>> PV mode)
>>
>>>>
>>>>>  
>>>>>  	switch (fc) {
>>>>> @@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>>>  		handle_stsi_3_2_2(vcpu, (void *) mem);
>>>>>  		break;
>>>>>  	}
>>>>> -
>>>>> -	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
>>>>> +	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>>>>> +		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
>>>>> +		       PAGE_SIZE);
>>>>> +		rc = 0;
>>>>> +	} else {
>>>>> +		rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
>>>>> +	}
>>>>>  	if (rc) {
>>>>>  		rc = kvm_s390_inject_prog_cond(vcpu, rc);
>>>>>  		goto out;
>>>>>
>>>>
>>>> I'd pull the interrupt injection into the else case, makes things clearer.
>>>
>>> Well, no. Thhe else case could set rc to 0.
>>
>> Huh?!
>>
>> if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> 	memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
>> 	rc = 0;
>> } else {
>> 	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
>> 	if (rc) {
>> 		rc = kvm_s390_inject_prog_cond(vcpu, rc);
>> 		goto out;
>> 	}
>> }
>>
> 
> Hmm, I find that one harder to read.

It's clearer that you only inject a program check when not in pv mode
... ;) No strong feelings.

-- 
Thanks,

David / dhildenb
