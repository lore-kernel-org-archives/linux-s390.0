From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 02/16] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
Date: Wed, 29 Nov 2017 18:25:46 +0100
Message-ID: <4c2cd2f8-41e6-afdc-a3c0-a5872ba9b929@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-3-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171129164116.16167-3-christoffer.dall@linaro.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 29.11.2017 17:41, Christoffer Dall wrote:
> In preparation for moving calls to vcpu_load() and vcpu_put() into the
> architecture specific implementations of the KVM vcpu ioctls, move the
> calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> of the ioctl select statement.  This allows us to move the vcpu_load()
> and vcpu_put() calls into architecture specific implementations of vcpu
> ioctls, one by one.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/kvm_main.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 39961fb..480b16c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2525,13 +2525,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  
>  	if (mutex_lock_killable(&vcpu->mutex))
>  		return -EINTR;
> -	vcpu_load(vcpu);
>  	switch (ioctl) {
>  	case KVM_RUN: {
>  		struct pid *oldpid;
>  		r = -EINVAL;
>  		if (arg)
>  			goto out;
> +		vcpu_load(vcpu);
>  		oldpid = rcu_access_pointer(vcpu->pid);
>  		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
>  			/* The thread running this VCPU changed. */
> @@ -2543,6 +2543,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			put_pid(oldpid);
>  		}
>  		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
> +		vcpu_put(vcpu);
>  		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
>  		break;
>  	}
> @@ -2553,7 +2554,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
>  		if (!kvm_regs)
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out_free1;
>  		r = -EFAULT;
> @@ -2573,7 +2576,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			r = PTR_ERR(kvm_regs);
>  			goto out;
>  		}
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
> +		vcpu_put(vcpu);
>  		kfree(kvm_regs);
>  		break;
>  	}
> @@ -2582,7 +2587,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!kvm_sregs)
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2598,13 +2605,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			kvm_sregs = NULL;
>  			goto out;
>  		}
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_GET_MP_STATE: {
>  		struct kvm_mp_state mp_state;
>  
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2619,7 +2630,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_TRANSLATE: {
> @@ -2628,7 +2641,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&tr, argp, sizeof(tr)))
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2643,7 +2658,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&dbg, argp, sizeof(dbg)))
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_SET_SIGNAL_MASK: {
> @@ -2674,7 +2691,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!fpu)
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2690,14 +2709,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			fpu = NULL;
>  			goto out;
>  		}
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	default:
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> +		vcpu_put(vcpu);
>  	}
>  out:
> -	vcpu_put(vcpu);
>  	mutex_unlock(&vcpu->mutex);
>  	kfree(fpu);
>  	kfree(kvm_sregs);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
