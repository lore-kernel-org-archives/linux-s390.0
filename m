From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: cleanup struct kvm_s390_float_interrupt
Date: Wed, 10 Jan 2018 12:51:47 +0100
Message-ID: <b1976d34-2917-d8b0-df7d-22f83a7831f1@de.ibm.com>
References: <20180108193747.10818-1-david@redhat.com>
 <20180109145514.619eb7c3.cohuck@redhat.com>
 <7e81c601-bb53-50ba-0f25-68a8ed4133c7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <7e81c601-bb53-50ba-0f25-68a8ed4133c7@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 01/10/2018 12:39 PM, David Hildenbrand wrote:
> 
>> We have __set_cpuflag() to set a flag; do we also want
>> __clear_cpuflag()? Would make the code nicer, I think. (There are more
>> possible callers for that.)
> 
> Mind if we do that in a separate patch?

Yes please.

> 
> Thanks!
> 
>>
>>>  	read_lock(&vcpu->kvm->arch.sca_lock);
>>>  	if (vcpu->kvm->arch.use_esca) {
>>>  		struct esca_block *sca = vcpu->kvm->arch.sca;
> 
> 
