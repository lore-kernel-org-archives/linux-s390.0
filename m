From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 17:17:00 +0100
Message-ID: <72357599-798d-14d0-336a-69a083f17863@redhat.com>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171123160521.27260-1-christoffer.dall@linaro.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On 23/11/2017 17:05, Christoffer Dall wrote:
> For example,
> arm64 is about to do significant work in vcpu load/put when running a
> vcpu, but not when doing things like KVM_SET_ONE_REG or
> KVM_SET_MP_STATE.

Out of curiosity, in what circumstances are these ioctls a hot path?
Especially KVM_SET_MP_STATE.

> Hi all,
> 
> Drew suggested this as an alternative approach to recording the ioctl
> number on the vcpu struct [1] as it may benefit other architectures in
> general.
> 
> I had a look at some of the specific ioctls across architectures, but
> must admit that I can't easily tell which architecture specific logic
> relies on having registered preempt notifiers and having called the
> architecture specific load function.
> 
> It would be great if you would let me know if you think this is
> generally useful or if you prefer the less invasive approach, and in
> case this is useful, if you could have a look at all the vcpu ioctls for
> your architecture and let me know if I am being too loose or too
> careful in calling __vcpu_load() in this patch.

I can suggest a third approach:

        if (ioctl == KVM_GET_ONE_REG || ioctl == KVM_SET_ONE_REG)
                return kvm_arch_vcpu_ioctl(filp, ioctl, arg);

in kvm_vcpu_ioctl before "r = vcpu_load(vcpu);", or even better:

        if (ioctl == KVM_GET_ONE_REG)
		// call kvm_arch_vcpu_get_one_reg_ioctl(vcpu, &reg);
		// and do copy_to_user
		return kvm_vcpu_get_one_reg_ioctl(vcpu, arg);
        if (ioctl == KVM_SET_ONE_REG)
		// do copy_from_user then call
		// kvm_arch_vcpu_set_one_reg_ioctl(vcpu, &reg);
		return kvm_vcpu_set_one_reg_ioctl(vcpu, arg);

so that the kvm_arch_vcpu_get/set_one_reg_ioctl functions are called
without the lock.

Then all architectures except ARM can be switched to do
vcpu_load/vcpu_put in kvm_arch_vcpu_get/set_one_reg_ioctl

Paolo
