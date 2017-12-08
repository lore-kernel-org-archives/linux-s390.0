From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 04/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_regs
Date: Fri, 8 Dec 2017 17:21:30 +0100
Message-ID: <a7b0fbc3-ad11-66f6-5646-14844d00b1f5@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-5-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-5-cdall@kernel.org>
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
> implementations of kvm_arch_vcpu_ioctl_get_regs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c      | 3 +++
>  arch/powerpc/kvm/book3s.c | 3 +++
>  arch/powerpc/kvm/booke.c  | 3 +++
>  arch/s390/kvm/kvm-s390.c  | 2 ++
>  arch/x86/kvm/x86.c        | 3 +++
>  virt/kvm/kvm_main.c       | 2 --
>  6 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index b5c28f0730f8..adfca57420d1 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1165,6 +1165,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
>  		regs->gpr[i] = vcpu->arch.gprs[i];
>  
> @@ -1172,6 +1174,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	regs->lo = vcpu->arch.lo;
>  	regs->pc = vcpu->arch.pc;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 72d977e30952..d85bfd733ccd 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -497,6 +497,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	regs->pc = kvmppc_get_pc(vcpu);
>  	regs->cr = kvmppc_get_cr(vcpu);
>  	regs->ctr = kvmppc_get_ctr(vcpu);
> @@ -518,6 +520,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
>  		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 83b485810aea..e0e4f04c5535 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1431,6 +1431,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	regs->pc = vcpu->arch.pc;
>  	regs->cr = kvmppc_get_cr(vcpu);
>  	regs->ctr = vcpu->arch.ctr;
> @@ -1452,6 +1454,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
>  		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2b3e874ea76c..37b7caae2484 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2718,7 +2718,9 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  
>  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> +	vcpu_load(vcpu);
>  	memcpy(&regs->gprs, &vcpu->run->s.regs.gprs, sizeof(regs->gprs));
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d9deb6222055..597e1f8fc8da 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7309,6 +7309,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  
>  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> +	vcpu_load(vcpu);
> +
>  	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
>  		/*
>  		 * We are here if userspace calls get_regs() in the middle of
> @@ -7342,6 +7344,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	regs->rip = kvm_rip_read(vcpu);
>  	regs->rflags = kvm_get_rflags(vcpu);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 198f2f9edcaf..843d481f58cb 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2552,9 +2552,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
>  		if (!kvm_regs)
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
> -		vcpu_put(vcpu);
>  		if (r)
>  			goto out_free1;
>  		r = -EFAULT;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
