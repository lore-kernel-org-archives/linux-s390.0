From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
Date: Thu, 20 Dec 2018 12:06:14 +0100
Message-ID: <20181220120614.65acacac.cohuck@redhat.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-6-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-6-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Dec 2018 20:17:46 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Use a single function with parameter irq_flags to differentiate
> between cases.
> 
> New irq flag:
>    IRQ_FLAG_LOCAL: include vcpu local interruptions pending
>    IRQ_FLAG_FLOATING: include vcpu floating interruptions pending
>    IRQ_FLAG_GISA: include GISA interruptions pending in IPM

I presume that means that irqs may be in more than one set? Or are gisa
irqs not considered floating irqs, because they use a different
mechanism?

> 
> New irq masks:
>    IRQ_MASK_ALL: include all types
>    IRQ_MASK_NO_GISA: include all types but GISA
> 
> Examples:
>    pending_irqs(vcpu, IRQ_MASK_ALL)
>    pending_irqs(vcpu, IRQ_MASK_NO_GISA)
> 
> There will be more irq flags with upcoming patches.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 093b568b6356..4ab20d2eb180 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -31,6 +31,13 @@
>  #define PFAULT_DONE 0x0680
>  #define VIRTIO_PARAM 0x0d00
>  
> +#define IRQ_FLAG_LOCAL    0x8000 /* include local interruption pending mask */
> +#define IRQ_FLAG_FLOATING 0x4000 /* include float interruption pending mask */
> +#define IRQ_FLAG_GISA     0x2000 /* include GISA interruption pending mask */
> +
> +#define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
> +#define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
> +
>  /* handle external calls via sigp interpretation facility */
>  static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>  {
> @@ -237,16 +244,18 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
>  	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>  }
>  
> -static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
> +static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)

Any deeper reason why this is a u16? 16 bits should be enough for
everyone? :)

>  {
> -	return vcpu->kvm->arch.float_int.pending_irqs |
> -		vcpu->arch.local_int.pending_irqs;
> -}
> +	unsigned long pending_irqs = 0;
>  
> -static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
> -{
> -	return pending_irqs_no_gisa(vcpu) |
> -		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> +	if (irq_flags & IRQ_FLAG_LOCAL)
> +		pending_irqs |= vcpu->arch.local_int.pending_irqs;
> +	if (irq_flags & IRQ_FLAG_FLOATING)
> +		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
> +	if (irq_flags & IRQ_FLAG_GISA)
> +		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
> +			IRQ_PEND_IO_ISC_7;
> +	return pending_irqs;
>  }
>  
>  static inline int isc_to_irq_type(unsigned long isc)
> @@ -275,7 +284,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long active_mask;
>  
> -	active_mask = pending_irqs(vcpu);
> +	active_mask = pending_irqs(vcpu, IRQ_MASK_ALL);
>  	if (!active_mask)
>  		return 0;
>  
> @@ -343,7 +352,7 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
>  
>  static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>  {
> -	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_IO_MASK))
> +	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_IO_MASK))

I/O interrupts are always floating, so you probably could check for
only floating (excluding gisa) irqs here.

>  		return;
>  	else if (psw_ioint_disabled(vcpu))
>  		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);Store Data
> @@ -353,7 +362,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>  
>  static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
>  {
> -	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_EXT_MASK))
> +	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_EXT_MASK))
>  		return;
>  	if (psw_extint_disabled(vcpu))
>  		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
> @@ -363,7 +372,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
>  
>  static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
>  {
> -	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_MCHK_MASK))
> +	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_MCHK_MASK))
>  		return;
>  	if (psw_mchk_disabled(vcpu))
>  		vcpu->arch.sie_block->ictl |= ICTL_LPSW;
