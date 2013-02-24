From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 4/4] KVM: s390: Wire up ioeventfd.
Date: Sun, 24 Feb 2013 11:45:22 +0200
Message-ID: <20130224094522.GC25269@redhat.com>
References: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
 <1361534989-38884-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361534989-38884-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 22, 2013 at 01:09:49PM +0100, Cornelia Huck wrote:
> Enable ioeventfd support on s390 and hook up diagnose 500 virtio-ccw
> notifications.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  arch/s390/kvm/Kconfig    |  1 +
>  arch/s390/kvm/Makefile   |  2 +-
>  arch/s390/kvm/diag.c     | 25 +++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c |  1 +
>  4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index b58dd86..3c43e30 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -22,6 +22,7 @@ config KVM
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
> +	select HAVE_KVM_EVENTFD
>  	---help---
>  	  Support hosting paravirtualized guest machines using the SIE
>  	  virtualization capability on the mainframe. This should work
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 3975722..8fe9d65 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -6,7 +6,7 @@
>  # it under the terms of the GNU General Public License (version 2 only)
>  # as published by the Free Software Foundation.
>  
> -common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
> +common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o eventfd.o)
>  
>  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>  
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index a390687..13cf74a 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -104,6 +104,29 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
>  	return -EREMOTE;
>  }
>  
> +static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
> +{
> +	int ret, idx;
> +
> +	/* No virtio-ccw notification? Get out quickly. */
> +	if (!vcpu->kvm->arch.css_support ||
> +	    (vcpu->run->s.regs.gprs[1] != 3))
> +		return -EOPNOTSUPP;

Looks like we have:
arch/s390/include/uapi/asm/kvm_virtio.h:#define KVM_S390_VIRTIO_NOTIFY 0
arch/s390/include/uapi/asm/kvm_virtio.h:#define KVM_S390_VIRTIO_RESET 1
arch/s390/include/uapi/asm/kvm_virtio.h:#define KVM_S390_VIRTIO_SET_STATUS      2

KVM_S390_VIRTIO_CSS_NOTIFY is missing? Strange.
Maybe it should be added in that header and included here?
Do some guests use it?
Also, do you want to support KVM_S390_VIRTIO_NOTIFY as well?


> +
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	/*
> +	 * The layout is as follows:
> +	 * - gpr 2 contains the subchannel id (passed as addr)
> +	 * - gpr 3 contains the virtqueue index (passed as datamatch)
> +	 */
> +	ret = kvm_io_bus_write(vcpu->kvm, KVM_CSS_BUS,
> +				vcpu->run->s.regs.gprs[2],
> +				8, &vcpu->run->s.regs.gprs[3]);
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
> +	return ret;
> +}
> +
>  int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>  {
>  	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
> @@ -118,6 +141,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>  		return __diag_time_slice_end_directed(vcpu);
>  	case 0x308:
>  		return __diag_ipl_functions(vcpu);
> +	case 0x500:
> +		return __diag_virtio_hypercall(vcpu);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f822d36..04d2454 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -142,6 +142,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_ONE_REG:
>  	case KVM_CAP_ENABLE_CAP:
>  	case KVM_CAP_S390_CSS_SUPPORT:
> +	case KVM_CAP_IOEVENTFD:
>  		r = 1;
>  		break;
>  	case KVM_CAP_NR_VCPUS:
> -- 
> 1.7.12.4
