Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725971AbfLDJdF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Dec 2019 04:33:05 -0500
Subject: Re: [PATCH v2] KVM: s390: Add new reset vcpu API
References: <20191203162055.3519-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c22eefd7-2c99-ec8e-3b5c-fabb343230a9@redhat.com>
Date: Wed, 4 Dec 2019 10:32:54 +0100
MIME-Version: 1.0
In-Reply-To: <20191203162055.3519-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 03/12/2019 17.20, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that.
> 
> Now that we have a new interface, let's properly clear out local IRQs
> and let this commit be a reminder.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 13 +++++++++++++
>  include/uapi/linux/kvm.h |  4 ++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d9e6bf3d54f0..602214c5616c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_CMMA_MIGRATION:
>  	case KVM_CAP_S390_AIS:
>  	case KVM_CAP_S390_AIS_MIGRATION:
> +	case KVM_CAP_S390_VCPU_RESETS:
>  		r = 1;
>  		break;
>  	case KVM_CAP_S390_HPAGE_1M:
> @@ -3287,6 +3288,13 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> +static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
> +{
> +	kvm_clear_async_pf_completion_queue(vcpu);
> +	kvm_s390_clear_local_irqs(vcpu);
> +	return 0;
> +}
> +
>  static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>  {
>  	kvm_s390_vcpu_initial_reset(vcpu);
> @@ -4363,7 +4371,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>  		break;
>  	}
> +	case KVM_S390_NORMAL_RESET:
> +		r = kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +		break;
>  	case KVM_S390_INITIAL_RESET:
> +		/* fallthrough */
> +	case KVM_S390_CLEAR_RESET:
>  		r = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>  		break;

Isn't clear reset supposed to do more than the initial reset? If so, I'd
rather expect it the other way round:

	case KVM_S390_CLEAR_RESET:
		/* fallthrough */
	case KVM_S390_INITIAL_RESET:
		r = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
		break;

... so you can later add the additional stuff before the "/* fallthrough
*/"?

 Thomas
