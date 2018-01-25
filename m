From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 04/12] KVM: s390: implement GISA IPM related primitives
Date: Thu, 25 Jan 2018 18:27:06 +0100
Message-ID: <31118207-4e8d-9200-ca97-d7618e0827cc@redhat.com>
References: <20180125170608.38276-1-borntraeger@de.ibm.com>
 <20180125170608.38276-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125170608.38276-2-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 18:06, Christian Borntraeger wrote:
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
>  arch/s390/kvm/interrupt.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b7b2865..ec50d42 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -203,6 +203,34 @@ static inline u8 int_word_to_isc(u32 int_word)
>  	return (int_word & 0x38000000) >> 27;
>  }
>  
> +/*
> + * To use atomic bitmap functions, we have to provide a bitmap address
> + * that is u64 aligned. However, the ipm might be u32 aligned.
> + * Therefore, we logically start the bitmap at the very beginning of the
> + * struct and fixup the bit number.
> + */
> +#define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
> +
> +static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +}
> +
> +static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
> +{
> +	return READ_ONCE(gisa->ipm);
> +}
> +
> +static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +}
> +
> +static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +}
> +
>  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->kvm->arch.float_int.pending_irqs |
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
