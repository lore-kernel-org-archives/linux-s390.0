Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbfLCQYk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Dec 2019 11:24:40 -0500
Subject: Re: [PATCH v2] KVM: s390: Add new reset vcpu API
References: <20191203162055.3519-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f08ed440-b159-84f5-13cf-03165765f7e6@redhat.com>
Date: Tue, 3 Dec 2019 17:24:27 +0100
MIME-Version: 1.0
In-Reply-To: <20191203162055.3519-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 03.12.19 17:20, Janosch Frank wrote:
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
>  	case KVM_SET_ONE_REG:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 52641d8ca9e8..f4fc865775a5 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PMU_EVENT_FILTER 173
>  #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
>  #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
> +#define KVM_CAP_S390_VCPU_RESETS 180
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -1461,6 +1462,9 @@ struct kvm_enc_region {
>  /* Available with KVM_CAP_ARM_SVE */
>  #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
>  

Maybe also a comment like

"Available with KVM_CAP_S390_VCPU_RESETS" ?

> +#define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
> +#define KVM_S390_CLEAR_RESET    _IO(KVMIO,   0xc4)
> +
>  /* Secure Encrypted Virtualization command */
>  enum sev_cmd_id {
>  	/* Guest initialization commands */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
