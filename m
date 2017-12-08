From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 05/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_regs
Date: Fri, 8 Dec 2017 17:22:32 +0100
Message-ID: <42542ab3-9005-61f4-c446-09c33d2d8f52@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-6-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171204203538.8370-6-cdall@kernel.org>
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
To: Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

On 04.12.2017 21:35, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_regs().
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
> index adfca57420d1..3a898712d6cd 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1151,6 +1151,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
>  		vcpu->arch.gprs[i] = regs->gpr[i];
>  	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
> @@ -1158,6 +1160,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	vcpu->arch.lo = regs->lo;
>  	vcpu->arch.pc = regs->pc;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index d85bfd733ccd..24bc7aabfc44 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -528,6 +528,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	kvmppc_set_pc(vcpu, regs->pc);
>  	kvmppc_set_cr(vcpu, regs->cr);
>  	kvmppc_set_ctr(vcpu, regs->ctr);
> @@ -548,6 +550,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
>  		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index e0e4f04c5535..bcbbeddc3430 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1462,6 +1462,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	vcpu->arch.pc = regs->pc;
>  	kvmppc_set_cr(vcpu, regs->cr);
>  	vcpu->arch.ctr = regs->ctr;
> @@ -1483,6 +1485,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
>  		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 37b7caae2484..e3476430578a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2712,7 +2712,9 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>  
>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> +	vcpu_load(vcpu);
>  	memcpy(&vcpu->run->s.regs.gprs, &regs->gprs, sizeof(regs->gprs));
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 597e1f8fc8da..75eacce78f59 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7350,6 +7350,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  
>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> +	vcpu_load(vcpu);
> +
>  	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
>  	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
>  
> @@ -7379,6 +7381,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 843d481f58cb..963e249d7b79 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2572,9 +2572,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			r = PTR_ERR(kvm_regs);
>  			goto out;
>  		}
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
> -		vcpu_put(vcpu);
>  		kfree(kvm_regs);
>  		break;
>  	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
