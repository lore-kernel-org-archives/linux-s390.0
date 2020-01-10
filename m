Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727168AbgAJK2g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Jan 2020 05:28:36 -0500
Date: Fri, 10 Jan 2020 11:28:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6] KVM: s390: Add new reset vcpu API
Message-ID: <20200110112824.16047937.cohuck@redhat.com>
In-Reply-To: <20200110101906.54291-1-frankja@linux.ibm.com>
References: <20200110101906.54291-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Fri, 10 Jan 2020 05:19:06 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that on a normal reset.
> 
> Let's implement an interface for the missing normal and clear resets
> and reset all local IRQs, registers and control structures as stated
> in the architecture.
> 
> Userspace might already reset the registers via the vcpu run struct,
> but as we need the interface for the interrupt clearing part anyway,
> we implement the resets fully and don't rely on userspace to reset the
> rest.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> Based on the irc discussion.
> 
> ---
>  Documentation/virt/kvm/api.txt |  43 ++++++++++++
>  arch/s390/kvm/kvm-s390.c       | 115 +++++++++++++++++++++++----------
>  include/uapi/linux/kvm.h       |   5 ++
>  3 files changed, 130 insertions(+), 33 deletions(-)
> 

(...)

> +static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sync_regs *regs = &vcpu->run->s.regs;
> +
> +	/* Clear reset is a superset of the initial reset */
> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +
> +	memset(&regs->gprs, 0, sizeof(regs->gprs));
> +	/*
> +	 * Will be picked up via save_fpu_regs() in the initial reset
> +	 * fallthrough.

Didn't you want to remove that? (Especially now that we don't
fallthrough anymore.)

> +	 */
> +	memset(&regs->vrs, 0, sizeof(regs->vrs));
> +	memset(&regs->acrs, 0, sizeof(regs->acrs));
> +
> +	regs->etoken = 0;
> +	regs->etoken_extension = 0;
> +
> +	memset(&regs->gscb, 0, sizeof(regs->gscb));
> +	if (MACHINE_HAS_GS) {
> +		preempt_disable();
> +		__ctl_set_bit(2, 4);
> +		if (current->thread.gs_cb) {
> +			vcpu->arch.host_gscb = current->thread.gs_cb;
> +			save_gs_cb(vcpu->arch.host_gscb);
> +		}
> +		if (vcpu->arch.gs_enabled) {
> +			current->thread.gs_cb = (struct gs_cb *)
> +				&vcpu->run->s.regs.gscb;
> +			restore_gs_cb(current->thread.gs_cb);
> +		}
> +		preempt_enable();
> +	}
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> @@ -4363,8 +4403,17 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>  		break;
>  	}
> +	case KVM_S390_CLEAR_RESET:
> +		r = 0;
> +		kvm_arch_vcpu_ioctl_clear_reset(vcpu);

I'd probably have switched those two lines, but that's a really a
bikeshed thing :)

> +		break;
>  	case KVM_S390_INITIAL_RESET:
> -		r = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> +		r = 0;
> +		kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> +		break;
> +	case KVM_S390_NORMAL_RESET:
> +		r = 0;
> +		kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>  		break;
>  	case KVM_SET_ONE_REG:
>  	case KVM_GET_ONE_REG: {

With the comment removed,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
