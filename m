From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
Date: Mon, 28 Jan 2019 17:50:54 +0100
Message-ID: <20190128175054.67979549@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-8-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:33 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Use this struct analog to the kvm interruption structs
> for kvm emulated floating and local interruptions.
> Further fields will be added with this series as
> required.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

While looking at this I was asking myself what guards against invalid
gisa pointer dereference e.g. when pending_irqs() is called (see below).

AFAIU we set up gisa_int.origin only if we have
css_general_characteristics.aiv. Opinions?

Anyway if it is a problem, it is a pre-existing one (should be fixed
ASAP but does not affect the validity of this patch).

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h |  6 ++++-
>  arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
>  arch/s390/kvm/kvm-s390.c         |  2 +-
>  3 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c259a67c4298..0941571d34eb 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -803,6 +803,10 @@ struct kvm_s390_vsie {
>  	struct page *pages[KVM_MAX_VCPUS];
>  };
>  

[..]

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 942cc7d33766..ee91d1de0036 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>  {
>  	return pending_irqs_no_gisa(vcpu) |
> -		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> +		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<

Unconditional call to gisa_get_ipm(), and get ipm just accesses ->ipm.

> +			IRQ_PEND_IO_ISC_7;
>  }
>  

[..]

>  void kvm_s390_gisa_init(struct kvm *kvm)
>  {
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +
>  	if (!css_general_characteristics.aiv)
>  		return;
> -	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> +	gi->origin = &kvm->arch.sie_page2->gisa;

Should stay NULL if !css_general_characteristics.aiv.

>  	kvm_s390_gisa_clear(kvm);
> -	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> +	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>  }
>  
