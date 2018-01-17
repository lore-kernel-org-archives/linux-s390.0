From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 04/12] KVM: s390: implement GISA IPM related primitives
Date: Wed, 17 Jan 2018 15:35:59 +0100
Message-ID: <249b3566-b8f3-5825-1f2b-6e0662874ca0@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-5-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 16.01.2018 21:02, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The patch implements routines to access the GISA to test and modify
> its Interruption Pending Mask (IPM) from the host side.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 23 +++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.h  |  4 ++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b94173560dcf..dfdecff302d2 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2682,3 +2682,26 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>  
>  	return n;
>  }
> +
> +#define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * 8)

8 -> BITS_PER_BYTE, but ...

Am I wrong or can we only modify the 8 ipm bits this way? But we
want/have to do it in an atomic fashion?

Using an unsigned long seems wrong, because we "rewrite" more than we
should. Esp. everything beyond ipm. oi / ni and friends are not
available on older machines.

What about something as simple as the following


+void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u8 gisc)
+{
+       u8 value = (0x80 >> gisc);
+
+       __sync_fetch_and_or(&gisa->ipm, value);
+}
+


> +
> +void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +}
> +
> +u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
> +{
> +	return (u8) READ_ONCE(gisa->ipm);
> +}
> +
> +void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +}
> +
> +int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +}
> +

shouldn't these be static inline instead?

> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 8877116f0159..b17e4dea7ea5 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -367,6 +367,10 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu,
>  			   void __user *buf, int len);
>  int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu,
>  			   __u8 __user *buf, int len);
> +void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc);
> +u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa);
> +void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc);
> +int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc);
>  
>  /* implemented in guestdbg.c */
>  void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
> 


-- 

Thanks,

David / dhildenb
