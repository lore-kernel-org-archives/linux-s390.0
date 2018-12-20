From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
Date: Thu, 20 Dec 2018 11:09:54 +0100
Message-ID: <5fbd4e59-c177-20de-4be5-6891398a2984@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-6-mimu@linux.ibm.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-6-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 19.12.18 20:17, Michael Mueller wrote:
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


Fix crash under vsie:

                 pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
-       if (irq_flags & IRQ_FLAG_GISA)
+       if (vcpu->kvm->arch.gisa && irq_flags & IRQ_FLAG_GISA)
                 pending_irqs |= get_ipm(vcpu->kvm->arch.gisa, irq_flags)


> +		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
> +			IRQ_PEND_IO_ISC_7;
> +	return pending_irqs;
>   }

-- 
Mit freundlichen Grüßen / Kind regards
Michael Müller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
