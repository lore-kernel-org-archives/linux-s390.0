Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39215 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgBRJjV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:39:21 -0500
Subject: Re: [PATCH v2 28/42] KVM: s390: protvirt: Add program exception
 injection
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-29-borntraeger@de.ibm.com>
 <0911c8c1-0877-047b-0da5-4c7f79aef3ae@redhat.com>
 <2374ea8d-0244-f710-36b9-54ec1e9b4b7f@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e0af7b49-bda2-ef73-a06e-ea9cd60978ef@redhat.com>
Date: Tue, 18 Feb 2020 10:39:10 +0100
MIME-Version: 1.0
In-Reply-To: <2374ea8d-0244-f710-36b9-54ec1e9b4b7f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 18.02.20 10:37, Christian Borntraeger wrote:
> 
> 
> On 18.02.20 10:33, David Hildenbrand wrote:
> eliver_prog(struct kvm_vcpu *vcpu)
>>>  {
>>>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>>> @@ -856,6 +871,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>>>  	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
>>>  					 pgm_info.code, 0);
>>>  
>>> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
>>
>> Can we actually ever have PER set, and what would happen if so?
>> Shouldn't we also return -EINVAL?
> 
> The ultravisor would add a concurrent PER event if appropriate.
> 

Please add that to the patch description.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
