From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 31 Oct 2018 12:14:00 +0000
Subject: Re: [PATCH 07/10] KVM: s390: add function process_gib_alert_list()
Message-Id: <8d3e8b7d-3c73-8620-0d83-305d430b1a83@linux.ibm.com>
In-Reply-To: <20181025123751.48809-8-mimu@linux.ibm.com>
References: <20181025123751.48809-8-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25/10/2018 14:37, Michael Mueller wrote:
> This function processes a gib alert list. It is required to
> run when either a gib alert interruption has been received or
> a gisa that might be in the alert list is cleared or dropped.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 487cad95e2c9..920c065ce1d3 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2900,6 +2900,44 @@ static void nullify_gisa(struct kvm_s390_gisa *gisa)
>   	gisa->next_alert = (u32)(u64)gisa;
>   }
>   
> +/*
> + * Before processing, the gib alert list needs to be cut-off from
> + * the gib by means of function unlink_gib_alert_list(). If non NULL,
> + * the list is processed from its latest to oldest entry.
> + *
> + * Processing an gisa entry needs to wake-up a vcpu of the kvm this gisa
> + * belongs to. Thus, the pending guest interruption will be processed
> + * in SIE context.
> + *
> + * Whenever a gisa is cleared (e.g. on vm reset) or a gisa is dropped
> + * (e.g. on vm termination) it might be part of the gib alert list.
> + * Thus, these operations need to process the alert list as well.
> + */
> +static void __maybe_unused process_gib_alert_list(
> +	struct kvm_s390_gisa *gisa,
> +	struct kvm_s390_gisa *gisa_to_nullify,
> +	struct kvm_s390_gisa *gisa_to_drop)
> +{
> +	struct kvm_s390_gisa *next_alert;
> +	struct kvm *kvm;
> +

Isn't this function a little bit complex?
I think we can make it clearer.

- The first argument is always AFAIU unlink_gib_alert_list(), then
why not just call this function inside of process_gib_alert_list() ?

- The action to do is related to the KVM/GISA, may be some state inside 
KVM or GISA to differentiate the processing?

All the GISA in this list need to be handled anyway if we are coming 
from an IRQ, a CLEAR_IRQ or a RESET but...


> +	for (; gisa; gisa = next_alert) {
> +		next_alert = (struct kvm_s390_gisa *)(u64)gisa->next_alert;
> +		/* unlink from alert list */
> +		gisa->next_alert = (u32)(u64)gisa;
> +		/* skip if to clear or drop */
> +		if (gisa == gisa_to_nullify ||
> +		    gisa == gisa_to_drop)
> +			continue;

... here:
I am not sure what happens if two guest are being reset at a time,
it seems to me that one is reset and one get kicked.


> +		/* wake-up a vcpu of the kvm this gisa belongs to */
> +		kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
> +		__floating_irq_kick(kvm, KVM_S390_INT_IO(1, 0, 0, 0));

Do we really need to insert a floating interrupt?
Wouldn't a simple kvm_s390_vcpu_wakeup() after choosing the vcpu be enough?


> +	}
> +
> +	if (gisa_to_nullify)
> +		nullify_gisa(gisa_to_nullify);

we already reset the next_alert pointer
if we want to clear the interrupt we just need to clear IPM

> +}
> +
>   void kvm_s390_gisa_clear(struct kvm *kvm)
>   {
>   	if (kvm->arch.gisa) {
> 


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
