From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] KVM: s390: mark irq_state.flags as non-usable
Date: Tue, 21 Nov 2017 16:18:53 +0100
Message-ID: <638982df-e3a1-16d4-51a2-5a400075ac3d@redhat.com>
References: <20171121150806.47075-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171121150806.47075-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.11.2017 16:08, Christian Borntraeger wrote:
> Old kernels did not check for zero in the irq_state.flags field and old
> QEMUs did not zero the flag field when calling KVM_S390_*_IRQ_STATE.
> Let's add a comment and dummy code to prevent future usage of flags
> and pad.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 6a5e02f..1baa393 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3834,6 +3834,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			r = -EINVAL;
>  			break;
>  		}
> +		if (irq_state.flags) {

I don't see the need for if (do I need more coffee?).

> +			/*
> +			 * This is a placeholder to make sure that nobody uses
> +			 * flags and pad. Old kernels did not check for zero
> +			 * and old QEMUs did not zero the flag field.
> +			 * That means that we cannot use the flags field for
> +			 * any possible extension.
> +			 */
> +			irq_state.flags = 0;
> +		}
>  		r = kvm_s390_set_irq_state(vcpu,
>  					   (void __user *) irq_state.buf,
>  					   irq_state.len);
> @@ -3849,6 +3859,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			r = -EINVAL;
>  			break;
>  		}
> +		if (irq_state.flags) {

dito

> +			/* see above */

/* same handling as for kvm_s390_set_irq_state() */

> +			irq_state.flags = 0;
> +		}
>  		r = kvm_s390_get_irq_state(vcpu,
>  					   (__u8 __user *)  irq_state.buf,
>  					   irq_state.len);
> 


-- 

Thanks,

David / dhildenb
