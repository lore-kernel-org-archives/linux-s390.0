Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
In-Reply-To: <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com> <875ze2ywhy.fsf@vitty.brq.redhat.com> <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
Date: Wed, 15 Apr 2020 11:07:53 +0200
Message-ID: <87a73dxgk6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:

> On 2020/4/14 22:26, Vitaly Kuznetsov wrote:
>> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:
>> 
>>> kvm_arch_vcpu_ioctl_run() is only called in the file kvm_main.c,
>>> where vcpu->run is the kvm_run parameter, so it has been replaced.
>>>
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>> ---
>>>   arch/x86/kvm/x86.c | 8 ++++----
>>>   virt/kvm/arm/arm.c | 2 +-
>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 3bf2ecafd027..70e3f4abbd4d 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -8726,18 +8726,18 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>>   		r = -EAGAIN;
>>>   		if (signal_pending(current)) {
>>>   			r = -EINTR;
>>> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
>>> +			kvm_run->exit_reason = KVM_EXIT_INTR;
>> 
>> I have a more generic question: why do we need to pass 'kvm_run' to
>> kvm_arch_vcpu_ioctl_run() if it can be extracted from 'struct kvm_vcpu'?
>> The only call site looks like
>> 
>> virt/kvm/kvm_main.c:            r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
>> 
>
> In the earlier version, kvm_run is used to pass parameters with user 
> mode and is not included in the vcpu structure, so it has been retained 
> until now.
>

In case this is no longer needed I'd suggest we drop 'kvm_run' parameter
and extract it from 'struct kvm_vcpu' when needed. This looks like a
natural add-on to your cleanup patch.

-- 
Vitaly
