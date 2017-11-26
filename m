From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH 14/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
Date: Sun, 26 Nov 2017 10:09:43 +0100
Message-ID: <20171126090943.GH28855@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-15-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171125205718.7731-15-christoffer.dall@linaro.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

[replying to myself]

On Sat, Nov 25, 2017 at 09:57:17PM +0100, Christoffer Dall wrote:
> Move the calls to vcpu_load() and vcpu_put() in to the architecture
> specific implementations of kvm_arch_vcpu_ioctl() which dispatches
> further architecture-specific ioctls on to other functions.
> 
> Some architectures support asynchronous vcpu ioctls which cannot call
> vcpu_load() or take the vcpu->mutex, because that would prevent
> concurrent execution with a running VCPU, which is the intended purpose
> of these ioctls, for example because they inject interrupts.
> 
> We move the checks for these specifics into the architecture code for
> MIPS, S390 and PPC, and it has the added benefit of getting rid of the
> ifdef in the generic dispatcher.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c       | 51 +++++++++++++++++++++++----------------
>  arch/powerpc/kvm/powerpc.c | 15 +++++++-----
>  arch/s390/kvm/kvm-s390.c   | 21 +++++++++-------
>  arch/x86/kvm/x86.c         | 24 ++++++++++++++-----
>  virt/kvm/arm/arm.c         | 60 ++++++++++++++++++++++++++++++++--------------
>  virt/kvm/kvm_main.c        | 15 +-----------
>  6 files changed, 114 insertions(+), 72 deletions(-)
> 

[...]

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 66e5c2445a87..027a6259c3c4 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1621,16 +1621,18 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	void __user *argp = (void __user *)arg;
>  	long r;
>  
> -	switch (ioctl) {
> -	case KVM_INTERRUPT: {
> +	if (ioctl == KVM_INTERRUPT) {
>  		struct kvm_interrupt irq;
> -		r = -EFAULT;
>  		if (copy_from_user(&irq, argp, sizeof(irq)))
> -			goto out;
> -		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> -		goto out;
> +			return -EFAULT;
> +		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
>  	}
>  
> +	r = vcpu_load(vcpu);
> +	if (r)
> +		return r;
> +
> +	switch (ioctl) {
>  	case KVM_ENABLE_CAP:
>  	{
>  		struct kvm_enable_cap cap;
> @@ -1670,6 +1672,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	}
>  
>  out:
> +	vcpu_put(r);
>  	return r;

This should obviously be
	vcpu_put(vcpu);

Fixed for v2.

Thanks,
-Christoffer
