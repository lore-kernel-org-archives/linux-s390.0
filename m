From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Thu, 17 Aug 2017 21:17:24 +0200
Message-ID: <edb9403f-3a94-605d-5f06-9bc81ca4d2c3@suse.de>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de> <20170817145411.GE2566@flask>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817145411.GE2566@flask>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Christoffer Dall <cdall@linaro.org>, Paul Mackerras <paulus@ozlabs.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 17.08.17 16:54, Radim Krčmář wrote:
> 2017-08-17 09:04+0200, Alexander Graf:
>> On 16.08.17 21:40, Radim Krčmář  wrote:
>>> The goal is to increase KVM_MAX_VCPUS without worrying about memory
>>> impact of many small guests.
>>>
>>> This is a second out of three major "dynamic" options:
>>>    1) size vcpu array at VM creation time
>>>    2) resize vcpu array when new VCPUs are created
>>>    3) use a lockless list/tree for VCPUs
>>>
>>> The disadvantage of (1) is its requirement on userspace changes and
>>> limited flexibility because userspace must provide the maximal count on
>>> start.  The main advantage is that kvm->vcpus will work like it does
>>> now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
>>> allow dynamic kvm->vcpus array",
>>> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html
>>>
>>> The main problem of (2), this series, is that we cannot extend the array
>>> in place and therefore require some kind of protection when moving it.
>>> RCU seems best, but it makes the code slower and harder to deal with.
>>> The main advantage is that we do not need userspace changes.
>>
>> Creating/Destroying vcpus is not something I consider a fast path, so why
>> should we optimize for it? The case that needs to be fast is execution.
> 
> Right, the creation is not important.  I was concerned about the use of
> lock() and unlock() needed for every access -- both in performance and
> code, because the common case where hotplug doesn't happen and all VCPUs
> are created upfront doesn't even need any runtime protection.
> 
>> What if we just sent a "vcpu move" request to all vcpus with the new pointer
>> after it moved? That way the vcpu thread itself would be responsible for the
>> migration to the new memory region. Only if all vcpus successfully moved,
>> keep rolling (and allow foreign get_vcpu again).
> 
> I'm not sure if I understood this.  You propose to cache kvm->vcpus in
> vcpu->vcpus and do an extensions of this,
> 
>    int vcpu_create(...) {
>      if (resize_needed(kvm->vcpus)) {
>        old_vcpus = kvm->vcpus
>        kvm->vcpus = make_bigger(kvm->vcpus)

if (kvm->vcpus != old_vcpus) :)

>        kvm_make_all_cpus_request(kvm, KVM_REQ_UPDATE_VCPUS)

IIRC you'd need some manual bookkeeping to ensure that all users have 
switched to the new array. Or set the KVM_REQUEST_WAIT flag :).

>        free(old_vcpus)
>      }
>      vcpu->vcpus = kvm->vcpus
>    }
> 
> with added extra locking, (S)RCU, on accesses that do not come from
> VCPUs (irqfd and VM ioctl)?

Well, in an ideal world we wouldn't have any users to vcpu structs 
outside of the vcpus obviously. Every time we do, we should either 
reconsider whether the design is smart and if we think it is, protect 
them accordingly. Maybe even hard code separate request mechanisms for 
the few cases where it's reasonable?

> 
>> That way we should be basically lock-less and scale well. For additional
>> icing, feel free to increase the vcpu array x2 every time it grows to not
>> run into the slow path too often.
> 
> Yeah, I skipped the growing as it was not necessary for the
> illustration.

Sure.

I'm also not fully advocating my solution here, but wanted to make sure 
we have it on the radar. I *think* this option has the least runtime 
overhead and best readability score, as it sticks to the same frameworks 
we already have and use throughout the code base ;).

That said, I'd love to get proven wrong.


Alex
