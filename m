Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Apr 2020 09:56:17 +0100
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
In-Reply-To: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
Message-ID: <17097df45c7fe76ee3c09ac180b844d2@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: pbonzini@redhat.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org

Tianjia,

On 2020-04-13 04:45, Tianjia Zhang wrote:
> kvm_arch_vcpu_ioctl_run() is only called in the file kvm_main.c,
> where vcpu->run is the kvm_run parameter, so it has been replaced.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kvm/x86.c | 8 ++++----
>  virt/kvm/arm/arm.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3bf2ecafd027..70e3f4abbd4d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8726,18 +8726,18 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu
> *vcpu, struct kvm_run *kvm_run)
>  		r = -EAGAIN;
>  		if (signal_pending(current)) {
>  			r = -EINTR;
> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
> +			kvm_run->exit_reason = KVM_EXIT_INTR;
>  			++vcpu->stat.signal_exits;
>  		}
>  		goto out;
>  	}
> 
> -	if (vcpu->run->kvm_valid_regs & ~KVM_SYNC_X86_VALID_FIELDS) {
> +	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_X86_VALID_FIELDS) {
>  		r = -EINVAL;
>  		goto out;
>  	}
> 
> -	if (vcpu->run->kvm_dirty_regs) {
> +	if (kvm_run->kvm_dirty_regs) {
>  		r = sync_regs(vcpu);
>  		if (r != 0)
>  			goto out;
> @@ -8767,7 +8767,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu
> *vcpu, struct kvm_run *kvm_run)
> 
>  out:
>  	kvm_put_guest_fpu(vcpu);
> -	if (vcpu->run->kvm_valid_regs)
> +	if (kvm_run->kvm_valid_regs)
>  		store_regs(vcpu);
>  	post_kvm_run_save(vcpu);
>  	kvm_sigset_deactivate(vcpu);
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 48d0ec44ad77..ab9d7966a4c8 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -659,7 +659,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
> struct kvm_run *run)
>  		return ret;
> 
>  	if (run->exit_reason == KVM_EXIT_MMIO) {
> -		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
> +		ret = kvm_handle_mmio_return(vcpu, run);
>  		if (ret)
>  			return ret;
>  	}

Do you have any number supporting the idea that you are optimizing 
anything
here? Performance, code size, register pressure or any other relevant 
metric?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
