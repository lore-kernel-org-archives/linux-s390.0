From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 08/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_mpstate
Date: Wed, 29 Nov 2017 18:47:42 +0100
Message-ID: <70d9ce37-8c96-fcf9-b736-20455dfaf440@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-9-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171129164116.16167-9-christoffer.dall@linaro.org>
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
> implementations of kvm_arch_vcpu_ioctl_get_mpstate().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c | 11 +++++++++--
>  arch/x86/kvm/x86.c       |  3 +++
>  virt/kvm/arm/arm.c       |  3 +++
>  virt/kvm/kvm_main.c      |  2 --
>  4 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d95b4f1..396fc3d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2836,9 +2836,16 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	int ret;
> +
> +	vcpu_load(vcpu);
> +
>  	/* CHECK_STOP and LOAD are not supported yet */
> -	return is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
> -				       KVM_MP_STATE_OPERATING;
> +	ret = is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
> +				      KVM_MP_STATE_OPERATING;
> +
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a31a80a..9bf62c3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7440,6 +7440,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	vcpu_load(vcpu);
> +
>  	kvm_apic_accept_events(vcpu);
>  	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
>  					vcpu->arch.pv.pv_unhalted)
> @@ -7447,6 +7449,7 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  	else
>  		mp_state->mp_state = vcpu->arch.mp_state;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 1f448b2..a717170 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -381,11 +381,14 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	vcpu_load(vcpu);
> +
>  	if (vcpu->arch.power_off)
>  		mp_state->mp_state = KVM_MP_STATE_STOPPED;
>  	else
>  		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 19cf2d1..eac3c29 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2603,9 +2603,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  	case KVM_GET_MP_STATE: {
>  		struct kvm_mp_state mp_state;
>  
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
> -		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
