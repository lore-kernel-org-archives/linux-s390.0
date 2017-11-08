From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/5] KVM: s390: document memory ordering for
 kvm_s390_vcpu_wakeup
Date: Wed, 8 Nov 2017 10:05:20 +0100
Message-ID: <20171108100520.3b62c955.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
        <20171108084143.78654-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Nov 2017 09:41:39 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> swait_active does not enforce any ordering and it can therefore trigger
> some subtle races when the CPU moves the read for the check before a
> previous store and that store is then used on another CPU that is
> preparing the swait.
> 
> On s390 there is a call to swait_active in kvm_s390_vcpu_wakeup. The
> good thing is, on s390 all potential races cannot happen because all
> callers of kvm_s390_vcpu_wakeup do not store (no race) or use an atomic
> operation, which handles memory ordering. Since this is not guaranteed
> by the Linux semantics (but by the implementation on s390) let's add
> smp_mb_after_atomic to make this obvious and document the ordering.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index a832ad0..23d8fb2 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1074,6 +1074,12 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
>  	 * in kvm_vcpu_block without having the waitqueue set (polling)
>  	 */
>  	vcpu->valid_wakeup = true;
> +	/*
> +	 * This is mostly to document, that the read in swait_active could
> +	 * be moved before other stores, leading to subtle races.
> +	 * All current users do not store or use an atomic like update
> +	 */
> +	smp_mb__after_atomic();
>  	if (swait_active(&vcpu->wq)) {
>  		/*
>  		 * The vcpu gave up the cpu voluntarily, mark it as a good

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
