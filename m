From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3] KVM: s390: mark irq_state.flags as non-usable
Date: Fri, 24 Nov 2017 16:11:24 +0100
Message-ID: <20171124161124.0aeb9452.cohuck@redhat.com>
References: <20171124144316.34418-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171124144316.34418-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 24 Nov 2017 15:43:16 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Old kernels did not check for zero in the irq_state.flags field and old
> QEMUs did not zero the flag/reserved fields when calling
> KVM_S390_*_IRQ_STATE.  Let's add comments to prevent future uses of
> these fields.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> v2->v3:
> - be -> stay
> - also change the documentation for KVM_S390_SET_IRQ_STATE
> - cleanup copyright header while touching the file
>  Documentation/virtual/kvm/api.txt | 15 ++++++++++++---
>  arch/s390/kvm/kvm-s390.c          |  6 ++++--
>  include/uapi/linux/kvm.h          |  4 ++--
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index f670e4b..35f9758 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2901,14 +2901,19 @@ userspace buffer and its length:
>  
>  struct kvm_s390_irq_state {
>  	__u64 buf;
> -	__u32 flags;
> +	__u32 flags;        /* will stay unused for compatibility reasons */
>  	__u32 len;
> -	__u32 reserved[4];
> +	__u32 reserved[4];  /* will stay unused for compatibility reasons */
>  };
>  
>  Userspace passes in the above struct and for each pending interrupt a
>  struct kvm_s390_irq is copied to the provided buffer.
>  
> +The structure contains a flags and a reserved field for future extensions. As
> +the kernel never checked for flags == 0 and QEMU never pre-zeroed flags and
> +reserved, these fields can not be used in the future without breaking
> +compatibility.
> +
>  If -ENOBUFS is returned the buffer provided was too small and userspace
>  may retry with a bigger buffer.
>  
> @@ -2932,10 +2937,14 @@ containing a struct kvm_s390_irq_state:
>  
>  struct kvm_s390_irq_state {
>  	__u64 buf;
> +	__u32 flags;        /* will stay unused for compatibility reasons */
>  	__u32 len;
> -	__u32 pad;
> +	__u32 reserved[4];  /* will stay unused for compatibility reasons */
>  };
>  
> +The restrictions for flags and reserved apply as well.
> +(see KVM_S390_GET_IRQ_STATE apply)

s/ apply//

> +
>  The userspace memory referenced by buf contains a struct kvm_s390_irq
>  for each interrupt to be injected into the guest.
>  If one of the interrupts could not be injected for some reason the
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f47e19f..966ea61 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * hosting zSeries kernel virtual machines
> + * hosting IBM Z kernel virtual machines (s390x)
>   *
> - * Copyright IBM Corp. 2008, 2009
> + * Copyright IBM Corp. 2008, 2017
>   *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
> @@ -3831,6 +3831,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			r = -EINVAL;
>  			break;
>  		}
> +		/* do not use irq_state.flags, it will break old QEMUs */
>  		r = kvm_s390_set_irq_state(vcpu,
>  					   (void __user *) irq_state.buf,
>  					   irq_state.len);
> @@ -3846,6 +3847,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			r = -EINVAL;
>  			break;
>  		}
> +		/* do not use irq_state.flags, it will break old QEMUs */
>  		r = kvm_s390_get_irq_state(vcpu,
>  					   (__u8 __user *)  irq_state.buf,
>  					   irq_state.len);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 282d7613..496e59a 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -630,9 +630,9 @@ struct kvm_s390_irq {
>  
>  struct kvm_s390_irq_state {
>  	__u64 buf;
> -	__u32 flags;
> +	__u32 flags;        /* will stay unused for compatibility reasons */
>  	__u32 len;
> -	__u32 reserved[4];
> +	__u32 reserved[4];  /* will stay unused for compatibility reasons */
>  };
>  
>  /* for KVM_SET_GUEST_DEBUG */

With the fix above:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
