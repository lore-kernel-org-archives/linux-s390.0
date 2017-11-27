From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH 11/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
Date: Mon, 27 Nov 2017 20:28:25 +0100
Message-ID: <20171127192825.GA16941@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-12-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171125205718.7731-12-christoffer.dall@linaro.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replying to myself again...

On Sat, Nov 25, 2017 at 09:57:14PM +0100, Christoffer Dall wrote:
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_guest_debug().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/guest.c    | 17 ++++++++++++++---
>  arch/powerpc/kvm/book3s.c |  6 ++++++
>  arch/powerpc/kvm/booke.c  | 21 +++++++++++++++------
>  arch/s390/kvm/kvm-s390.c  | 14 +++++++++++---
>  arch/x86/kvm/x86.c        |  6 +++++-
>  virt/kvm/kvm_main.c       |  4 ----
>  6 files changed, 51 insertions(+), 17 deletions(-)
> 

[...]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index aa76d2988178..ac26d95444c9 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2819,15 +2819,20 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  					struct kvm_guest_debug *dbg)
>  {
> -	int rc = 0;
> +	int rc;
> +
> +	rc = vcpu_load(vcpu);
> +	if (rc)
> +		return rc;
>  
>  	vcpu->guest_debug = 0;
>  	kvm_s390_clear_bp_data(vcpu);
>  
> +	rc = -EINVAL;
>  	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
> -		return -EINVAL;
> +		goto out;
>  	if (!sclp.has_gpere)
> -		return -EINVAL;
> +		goto out;
>  
>  	if (dbg->control & KVM_GUESTDBG_ENABLE) {
>  		vcpu->guest_debug = dbg->control;
> @@ -2847,6 +2852,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
>  	}
>  
> +	rc = 0;

This is totally broken (although not clearly visible in the diff),
because it overrides a potential error code.

I'll fix it for v2.

> +out:
> +	vcpu_put(vcpu);
>  	return rc;
>  }
>  

Thanks,
-Christoffer
