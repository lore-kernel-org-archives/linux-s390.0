From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] KVM: s390: abstract conversion between isc and enum
 irq_types
Date: Wed, 8 Nov 2017 10:41:51 +0100
Message-ID: <d6fb91b6-7e5f-02e4-de7d-4bf107128bbd@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
 <20171108084143.78654-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-5-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08.11.2017 09:41, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The abstraction of the conversion between an isc value and an irq_type
> by means of functions isc_to_irq_type() and irq_type_to_isc() allows
> to clarify the respective operations where used.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 23d8fb2..a3da4f3 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -213,6 +213,16 @@ static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>  	       vcpu->arch.local_int.pending_irqs;
>  }
>  
> +static inline int isc_to_irq_type(unsigned long isc)
> +{
> +	return IRQ_PEND_IO_ISC_0 + isc;
> +}
> +
> +static inline int irq_type_to_isc(unsigned long irq_type)
> +{
> +	return irq_type - IRQ_PEND_IO_ISC_0;
> +}
> +

(I would move it directly below is_ioirq()), so all IRQ_PEND_IO_ISC_0
users are at one place).

Let's make the r-b list longer.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
