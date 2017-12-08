From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 06/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_sregs
Date: Fri, 8 Dec 2017 17:23:57 +0100
Message-ID: <cd63ce04-6e7c-17ac-81bf-9f51763d5a66@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-7-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-7-cdall@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 04.12.2017 21:35, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_get_sregs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/powerpc/kvm/book3s.c | 8 +++++++-
>  arch/powerpc/kvm/booke.c  | 9 ++++++++-
>  arch/s390/kvm/kvm-s390.c  | 4 ++++
>  arch/x86/kvm/x86.c        | 3 +++
>  virt/kvm/kvm_main.c       | 2 --
>  5 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 24bc7aabfc44..6cc2377549f7 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -484,7 +484,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  				  struct kvm_sregs *sregs)
>  {
> -	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +	int ret;
> +
> +	vcpu_load(vcpu);
> +	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +	vcpu_put(vcpu);
> +
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index bcbbeddc3430..f647e121070e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1613,11 +1613,18 @@ int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>                                    struct kvm_sregs *sregs)
>  {
> +	int ret;
> +
> +	vcpu_load(vcpu);
> +
>  	sregs->pvr = vcpu->arch.pvr;
>  
>  	get_sregs_base(vcpu, sregs);
>  	get_sregs_arch206(vcpu, sregs);
> -	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e3476430578a..18011fc4ac49 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2737,8 +2737,12 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  				  struct kvm_sregs *sregs)
>  {
> +	vcpu_load(vcpu);
> +
>  	memcpy(&sregs->acrs, &vcpu->run->s.regs.acrs, sizeof(sregs->acrs));
>  	memcpy(&sregs->crs, &vcpu->arch.sie_block->gcr, sizeof(sregs->crs));
> +
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 75eacce78f59..20a5f6776eea 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7400,6 +7400,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  {
>  	struct desc_ptr dt;
>  
> +	vcpu_load(vcpu);
> +
>  	kvm_get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
>  	kvm_get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
>  	kvm_get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
> @@ -7431,6 +7433,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  		set_bit(vcpu->arch.interrupt.nr,
>  			(unsigned long *)sregs->interrupt_bitmap);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 963e249d7b79..779c03e39fa4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2581,9 +2581,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!kvm_sregs)
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
> -		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
