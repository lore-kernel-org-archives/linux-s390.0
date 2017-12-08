From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
Date: Fri, 8 Dec 2017 17:26:02 +0100
Message-ID: <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-8-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-8-cdall@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


>  
>  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index f647e121070e..cdf0be02c95a 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1632,18 +1632,25 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  {
>  	int ret;
>  
> +	vcpu_load(vcpu);
> +
> +	ret = -EINVAL;

you can initialize this directly.

>  	if (vcpu->arch.pvr != sregs->pvr)
> -		return -EINVAL;
> +		goto out;
>  
>  	ret = set_sregs_base(vcpu, sregs);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	ret = set_sregs_arch206(vcpu, sregs);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
> +
> +	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
>  
> -	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 18011fc4ac49..d95b4f15e52b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2729,8 +2729,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  				  struct kvm_sregs *sregs)
>  {
> +	vcpu_load(vcpu);
> +
>  	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
>  	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
> +
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 20a5f6776eea..a31a80aee0b9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7500,15 +7500,19 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  	int mmu_reset_needed = 0;
>  	int pending_vec, max_bits, idx;
>  	struct desc_ptr dt;
> +	int ret;
> +
> +	vcpu_load(vcpu);
>  
> +	ret = -EINVAL;

dito


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
