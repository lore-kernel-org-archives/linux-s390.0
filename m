From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 19:05:07 +0100
Message-ID: <57693a50-e682-9b3b-7d8c-c46b66e33d84@de.ibm.com>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171123170642.GA28855@cbox>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/23/2017 06:06 PM, Christoffer Dall wrote:
> On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
>> On 23/11/2017 17:05, Christoffer Dall wrote:
>>> For example,
>>> arm64 is about to do significant work in vcpu load/put when running a
>>> vcpu, but not when doing things like KVM_SET_ONE_REG or
>>> KVM_SET_MP_STATE.
>>
>> Out of curiosity, in what circumstances are these ioctls a hot path?
>> Especially KVM_SET_MP_STATE.
>>
> 
> Perhaps my commit message was misleading; we only want to do that for
> KVM_RUN, and not for anything else.  We're already doing things like
> potentially jumping to hyp mode and flushing VMIDs which really
> shouldn't be done unless we actually plan on running a VCPU, and we're
> going to do things like setting up the timer to handle timer interrupts
> in an ISR, which doesn't make sense unless the VCPU is running.
> 
> Add to that, that loading an entire VM's state onto hardware, only to
> read back a single register from hardware and returning it to user
> space, doesn't really fall within optimization vs. non-optimization in
> the critical path, but is just wrong, IMHO.
> 
>>> Hi all,
>>>
>>> Drew suggested this as an alternative approach to recording the ioctl
>>> number on the vcpu struct [1] as it may benefit other architectures in
>>> general.
>>>
>>> I had a look at some of the specific ioctls across architectures, but
>>> must admit that I can't easily tell which architecture specific logic
>>> relies on having registered preempt notifiers and having called the
>>> architecture specific load function.
>>>
>>> It would be great if you would let me know if you think this is
>>> generally useful or if you prefer the less invasive approach, and in
>>> case this is useful, if you could have a look at all the vcpu ioctls for
>>> your architecture and let me know if I am being too loose or too
>>> careful in calling __vcpu_load() in this patch.
>>
>> I can suggest a third approach:
>>
>>         if (ioctl == KVM_GET_ONE_REG || ioctl == KVM_SET_ONE_REG)
>>                 return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>>
>> in kvm_vcpu_ioctl before "r = vcpu_load(vcpu);", or even better:
>>
>>         if (ioctl == KVM_GET_ONE_REG)
>> 		// call kvm_arch_vcpu_get_one_reg_ioctl(vcpu, &reg);
>> 		// and do copy_to_user
>> 		return kvm_vcpu_get_one_reg_ioctl(vcpu, arg);
>>         if (ioctl == KVM_SET_ONE_REG)
>> 		// do copy_from_user then call
>> 		// kvm_arch_vcpu_set_one_reg_ioctl(vcpu, &reg);
>> 		return kvm_vcpu_set_one_reg_ioctl(vcpu, arg);
>>
>> so that the kvm_arch_vcpu_get/set_one_reg_ioctl functions are called
>> without the lock.
>>
>> Then all architectures except ARM can be switched to do
>> vcpu_load/vcpu_put in kvm_arch_vcpu_get/set_one_reg_ioctl
> 
> That doesn't solve my need as I want to *only* do the arch vcpu_load for
> KVM_RUN, I should have been more clear in the commit message.

What about splitting arch_vcpu_load/put into two callbacks and call the 2nd
one only for VCPU_run? e.g. keep arch_vcpu_load and add arch_vcpu_load_run
and arch_vcpu_unload_run

Then every architecture can move things from arch_vcpu_load into arch_vcpu_load_run
if its only necessary for RUN.
