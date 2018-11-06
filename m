From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 7/7] s390: kvm: Handle all GISA IPM bits through GISA
Date: Tue, 6 Nov 2018 13:07:15 +0100
Message-ID: <2b2ce60a-81c6-84e0-4233-3c4dade5c614@redhat.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-8-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-8-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 31.10.18 19:12, Pierre Morel wrote:
> Now that we use GISA and GIB we can handle all IPM bits from GISA
> directly from firmware.
> They will be interpreted on SIE entry or during guest run.
> 
> We remove them from the pending_irqs() test.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 6d0193173388..3174d9946523 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -248,8 +248,7 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>  
>  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>  {
> -	return pending_irqs_no_gisa(vcpu) |
> -		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> +	return pending_irqs_no_gisa(vcpu);
>  }
>  
>  static inline int isc_to_irq_type(unsigned long isc)
> 

(only looking at this very patch with no background information, so just
some notes)

1. e.g. kvm_s390_vcpu_has_irq() has to check all possible paths for
pending interrupts. It uses pending_irqs().

2. kvm_s390_deliver_pending_interrupts() delivers interrupts in the
order of priority. It could be that leaving it completely to the
hardware will result in some priority changes that could theoretically
be observed by the guest

(will have to study the GIB patches)

-- 

Thanks,

David / dhildenb
