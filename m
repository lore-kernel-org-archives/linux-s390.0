From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 09/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_mpstate
Date: Wed, 29 Nov 2017 18:46:33 +0100
Message-ID: <7332a8d3-2ff9-54db-0c05-a45303d184ad@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-10-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171129164116.16167-10-christoffer.dall@linaro.org>
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
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On 29.11.2017 17:41, Christoffer Dall wrote:
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_mpstate().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c |  3 +++
>  arch/x86/kvm/x86.c       | 15 ++++++++++++---
>  virt/kvm/arm/arm.c       |  9 +++++++--
>  virt/kvm/kvm_main.c      |  2 --
>  4 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 396fc3d..8fade85 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2853,6 +2853,8 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  {
>  	int rc = 0;
>  
> +	vcpu_load(vcpu);
> +
>  	/* user space knows about this interface - let it control the state */
>  	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
>  
> @@ -2870,6 +2872,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  		rc = -ENXIO;
>  	}
>  
> +	vcpu_put(vcpu);
>  	return rc;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9bf62c3..ee357b6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7456,15 +7456,20 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	int ret;

initialize ret directly to -EINVAL ?

> +
> +	vcpu_load(vcpu);
> +
> +	ret = -EINVAL;
>  	if (!lapic_in_kernel(vcpu) &&
>  	    mp_state->mp_state != KVM_MP_STATE_RUNNABLE)
> -		return -EINVAL;
> +		goto out;
>  
>  	/* INITs are latched while in SMM */
>  	if ((is_smm(vcpu) || vcpu->arch.smi_pending) &&
>  	    (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED ||
>  	     mp_state->mp_state == KVM_MP_STATE_INIT_RECEIVED))
> -		return -EINVAL;
> +		goto out;
>  
>  	if (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
>  		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
> @@ -7472,7 +7477,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  	} else
>  		vcpu->arch.mp_state = mp_state->mp_state;
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
> -	return 0;
> +
> +	ret = 0;
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a717170..9a3acbc 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -395,6 +395,10 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	int ret = 0;
> +
> +	vcpu_load(vcpu);
> +
>  	switch (mp_state->mp_state) {
>  	case KVM_MP_STATE_RUNNABLE:
>  		vcpu->arch.power_off = false;
> @@ -403,10 +407,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  		vcpu_power_off(vcpu);
>  		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>  
> -	return 0;
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  /**
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index eac3c29..f360005 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2618,9 +2618,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
> -		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_TRANSLATE: {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
