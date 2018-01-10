From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: cleanup struct kvm_s390_float_interrupt
Date: Wed, 10 Jan 2018 12:56:15 +0100
Message-ID: <e75863bd-fca2-a4b0-4e1d-c09c8b5023af@redhat.com>
References: <20180108193747.10818-1-david@redhat.com>
 <e36d639f-3ddc-0f05-9e90-3d2013a04ea3@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e36d639f-3ddc-0f05-9e90-3d2013a04ea3@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 10.01.2018 12:30, Christian Borntraeger wrote:
> 
> 
> On 01/08/2018 08:37 PM, David Hildenbrand wrote:
>> "wq" is not used at all. "cpuflags" can be access directly via the vcpu,
>> just as "float_int" via vcpu->kvm.
> 
> you also use the _set_cpuflag wrapper in several places, please add that to the patch description.
> Otherwise this looks like a nice cleanup.

Can you add that to the patch description when applying, if there are no
other comments?

"While at it, reuse _set_cpuflag() to make the code look nicer.".

Thanks!

-- 

Thanks,

David / dhildenb
