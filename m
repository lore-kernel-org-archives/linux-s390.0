From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Thu, 17 Aug 2017 12:18:03 +0200
Message-ID: <b240630b-e991-5c1e-a2c7-8def744f275e@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
 <20170817093612.024cc4bc.cohuck@redhat.com>
 <b69bc1e0-9d7b-5412-ba56-a5261d539a5b@redhat.com>
 <20170817112829.7795820a.cohuck@redhat.com>
 <69d47131-2405-b2be-60d7-e40fbd17592a@redhat.com>
 <6609138c-6a29-5106-39a8-3219ce47f01a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6609138c-6a29-5106-39a8-3219ce47f01a@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Christoffer Dall <cdall@linaro.org>, Paul Mackerras <paulus@ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On 17/08/2017 11:55, David Hildenbrand wrote:
> On 17.08.2017 11:44, Paolo Bonzini wrote:
>> On 17/08/2017 11:28, Cornelia Huck wrote:
>>> On Thu, 17 Aug 2017 11:16:59 +0200
>>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>> On 17/08/2017 09:36, Cornelia Huck wrote:
>>>>>> What if we just sent a "vcpu move" request to all vcpus with the new 
>>>>>> pointer after it moved? That way the vcpu thread itself would be 
>>>>>> responsible for the migration to the new memory region. Only if all 
>>>>>> vcpus successfully moved, keep rolling (and allow foreign get_vcpu again).
>>>>>>
>>>>>> That way we should be basically lock-less and scale well. For additional 
>>>>>> icing, feel free to increase the vcpu array x2 every time it grows to 
>>>>>> not run into the slow path too often.  
>>>>>
>>>>> I'd prefer the rcu approach: This is a mechanism already understood
>>>>> well, no need to come up with a new one that will likely have its own
>>>>> share of problems.  
>>>>
>>>> What Alex is proposing _is_ RCU, except with a homegrown
>>>> synchronize_rcu.  Using kvm->srcu seems to be the best of both worlds.
>>>
>>> I'm worried a bit about the 'homegrown' part, though.
>>
>> I agree, that's why I'm suggesting SRCU instead.  But it's a trick that
>> has its uses.  For example, if you were only doing reads from a work
>> queue, flush_work_queue could be used as the "homegrown
>> synchronize_rcu".  In KVM you might use kvm_make_all_cpus_request, I guess.
>>
>>> I also may be misunderstanding what Alex means with "vcpu move"...
>>
>> My interpretation was "resizing the array" (so it moves in memory).
> 
> Unpopular opinion: Let's keep it simple first (straight rcu) and
> optimize later on.

RCU vs. SRCU is about correctness, not optimization...

Paolo
