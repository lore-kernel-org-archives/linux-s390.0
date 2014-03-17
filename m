From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 2/5] KVM: Add per-vm capability enablement.
Date: Mon, 17 Mar 2014 23:09:13 +0100
Message-ID: <53277289.9010706@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com> <1395079899-29239-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079899-29239-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17/03/14 19:11, Cornelia Huck wrote:
> Allow KVM_ENABLE_CAP to act on a vm as well as on a vcpu. This makes more
> sense when the caller wants to enable a vm-related capability.
> 
> s390 will be the first user; wire it up.
> 
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  Documentation/virtual/kvm/api.txt |    6 ++++--
>  arch/s390/kvm/kvm-s390.c          |   24 ++++++++++++++++++++++++
>  include/uapi/linux/kvm.h          |    5 +++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 4714f28..faf6fe9 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -932,9 +932,9 @@ documentation when it pops into existence).
> 
>  4.37 KVM_ENABLE_CAP
> 
> -Capability: KVM_CAP_ENABLE_CAP
> +Capability: KVM_CAP_ENABLE_CAP, KVM_CAP_ENABLE_CAP_VM
>  Architectures: ppc, s390
> -Type: vcpu ioctl
> +Type: vcpu ioctl, vm ioctl (with KVM_CAP_ENABLE_CAP_VM)
>  Parameters: struct kvm_enable_cap (in)
>  Returns: 0 on success; -1 on error
> 
> @@ -965,6 +965,8 @@ function properly, this is the place to put them.
>         __u8  pad[64];
>  };
> 
> +The vcpu ioctl should be used for vcpu-specific capabilities, the vm ioctl
> +for vm-wide capabilities.
> 
>  4.38 KVM_GET_MP_STATE
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 7337c57..9f1e99f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -159,6 +159,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_S390_CSS_SUPPORT:
>  	case KVM_CAP_IOEVENTFD:
>  	case KVM_CAP_DEVICE_CTRL:
> +	case KVM_CAP_ENABLE_CAP_VM:
>  		r = 1;
>  		break;
>  	case KVM_CAP_NR_VCPUS:
> @@ -187,6 +188,21 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>  	return 0;
>  }
> 
> +static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
> +{
> +	int r;
> +
> +	if (cap->flags)
> +		return -EINVAL;
> +
> +	switch (cap->cap) {
> +	default:
> +		r = -EINVAL;
> +		break;
> +	}
> +	return r;
> +}
> +
>  long kvm_arch_vm_ioctl(struct file *filp,
>  		       unsigned int ioctl, unsigned long arg)
>  {
> @@ -204,6 +220,14 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		r = kvm_s390_inject_vm(kvm, &s390int);
>  		break;
>  	}
> +	case KVM_ENABLE_CAP: {
> +		struct kvm_enable_cap cap;
> +		r = -EFAULT;
> +		if (copy_from_user(&cap, argp, sizeof(cap)))
> +			break;
> +		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
> +		break;
> +	}
>  	default:
>  		r = -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index a7518be..46ea1b4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -741,6 +741,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_EXT_EMUL_CPUID 95
>  #define KVM_CAP_HYPERV_TIME 96
>  #define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
> +#define KVM_CAP_ENABLE_CAP_VM 98
> 
>  #ifdef KVM_CAP_IRQ_ROUTING
> 
> @@ -1076,6 +1077,10 @@ struct kvm_s390_ucas_mapping {
>  /* Available with KVM_CAP_DEBUGREGS */
>  #define KVM_GET_DEBUGREGS         _IOR(KVMIO,  0xa1, struct kvm_debugregs)
>  #define KVM_SET_DEBUGREGS         _IOW(KVMIO,  0xa2, struct kvm_debugregs)
> +/*
> + * vcpu version available with KVM_ENABLE_CAP
> + * vm version available with KVM_CAP_ENABLE_CAP_VM
> + */
>  #define KVM_ENABLE_CAP            _IOW(KVMIO,  0xa3, struct kvm_enable_cap)
>  /* Available with KVM_CAP_XSAVE */
>  #define KVM_GET_XSAVE		  _IOR(KVMIO,  0xa4, struct kvm_xsave)
> 
