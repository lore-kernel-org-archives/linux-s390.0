From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 14/15] KVM: s390: add and wire function
 gib_alert_irq_handler()
Date: Thu, 3 Jan 2019 16:16:19 +0100
Message-ID: <7dfe72db-97d2-9f33-68f7-acf8ec5ddc5e@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-15-mimu@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-15-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 19/12/2018 20:17, Michael Mueller wrote:
> The patch implements a handler for GIB alert interruptions
> on the host. Its task is to alert guests that interrupts are
> pending for them.
> 
> A GIB alert interrupt statistic counter is added as well:
> 
> $ cat /proc/interrupts
>            CPU0       CPU1
>    ...
>    GAL:      23         37   [I/O] GIB Alert
>    ...
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/include/asm/irq.h |  1 +
>   arch/s390/include/asm/isc.h |  1 +
>   arch/s390/kernel/irq.c      |  1 +
>   arch/s390/kvm/interrupt.c   | 36 ++++++++++++++++++++++++++++++++++--
>   4 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
> index 2f7f27e5493f..afaf5e3c57fd 100644
> --- a/arch/s390/include/asm/irq.h
> +++ b/arch/s390/include/asm/irq.h
> @@ -62,6 +62,7 @@ enum interruption_class {
>   	IRQIO_MSI,
>   	IRQIO_VIR,
>   	IRQIO_VAI,
> +	IRQIO_GAL,
>   	NMI_NMI,
>   	CPU_RST,
>   	NR_ARCH_IRQS
> diff --git a/arch/s390/include/asm/isc.h b/arch/s390/include/asm/isc.h
> index 6cb9e2ed05b6..b2cc1ec78d06 100644
> --- a/arch/s390/include/asm/isc.h
> +++ b/arch/s390/include/asm/isc.h
> @@ -21,6 +21,7 @@
>   /* Adapter interrupts. */
>   #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
>   #define PCI_ISC 2			/* PCI I/O subchannels */
> +#define GAL_ISC 5			/* GIB alert */
>   #define AP_ISC 6			/* adjunct processor (crypto) devices */
>   
>   /* Functions for registration of I/O interruption subclasses */
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index 0e8d68bac82c..0cd5a5f96729 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -88,6 +88,7 @@ static const struct irq_class irqclass_sub_desc[] = {
>   	{.irq = IRQIO_MSI,  .name = "MSI", .desc = "[I/O] MSI Interrupt" },
>   	{.irq = IRQIO_VIR,  .name = "VIR", .desc = "[I/O] Virtual I/O Devices"},
>   	{.irq = IRQIO_VAI,  .name = "VAI", .desc = "[I/O] Virtual I/O Devices AI"},
> +	{.irq = IRQIO_GAL,  .name = "GAL", .desc = "[I/O] GIB Alert"},
>   	{.irq = NMI_NMI,    .name = "NMI", .desc = "[NMI] Machine Check"},
>   	{.irq = CPU_RST,    .name = "RST", .desc = "[CPU] CPU Restart"},
>   };
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 03e7ba4f215a..79b9c262479b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -26,6 +26,7 @@
>   #include <asm/gmap.h>
>   #include <asm/switch_to.h>
>   #include <asm/nmi.h>
> +#include <asm/airq.h>
>   #include "kvm-s390.h"
>   #include "gaccess.h"
>   #include "trace-s390.h"
> @@ -3043,7 +3044,7 @@ static void __floating_airqs_kick(struct kvm *kvm)
>   #define NONE_GISA_ADDR 0x00000001UL
>   #define GISA_ADDR_MASK 0xfffff000UL
>   
> -static void __maybe_unused process_gib_alert_list(void)
> +static void process_gib_alert_list(void)
>   {
>   	u32 final, next_alert, origin = 0UL;
>   	struct kvm_s390_gisa *gisa;
> @@ -3091,7 +3092,10 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>   {
>   	if (!kvm->arch.gisa)
>   		return;
> +	if (set_iam(kvm->arch.gisa, 0) == -EBUSY)
> +		process_gib_alert_list();

We call process_gib_alert_list() from different contexts shouldn't we 
protect the calls?


>   	nullify_gisa(kvm->arch.gisa);
> +	set_iam(kvm->arch.gisa, kvm->arch.iam);
>   	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>   }
>   
> @@ -3111,6 +3115,8 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
>   {
>   	if (!kvm->arch.gisa)
>   		return;
> +	if (set_iam(kvm->arch.gisa, 0) == -EBUSY)
> +		process_gib_alert_list();

idem.

>   	kvm->arch.gisa = NULL;
>   }
>   
> @@ -3159,11 +3165,23 @@ int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
>   }
>   EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
>   
> +static void gib_alert_irq_handler(struct airq_struct *airq)
> +{
> +	inc_irq_stat(IRQIO_GAL);
> +	process_gib_alert_list();

idem.

> +}
> +
> +static struct airq_struct gib_alert_irq = {
> +	.handler = gib_alert_irq_handler,
> +	.lsi_ptr = &gib_alert_irq.lsi_mask,
> +};
> +
>   void kvm_s390_gib_destroy(void)
>   {
>   	if (!gib)
>   		return;
>   	chsc_sgib(0);
> +	unregister_adapter_interrupt(&gib_alert_irq);
>   	free_page((unsigned long)gib);
>   	gib = NULL;
>   }
> @@ -3183,16 +3201,30 @@ int kvm_s390_gib_init(u8 nisc)
>   		goto out;
>   	}
>   
> +	gib_alert_irq.isc = nisc;
> +	if (register_adapter_interrupt(&gib_alert_irq)) {
> +		pr_err("Registering the GIB alert interruption handler failed\n");
> +		rc = -EIO;
> +		goto out_free;
> +	}
> +
>   	gib->nisc = nisc;
>   	if (chsc_sgib((u32)(u64)gib)) {
>   		pr_err("Associating the GIB with the AIV facility failed\n");
>   		free_page((unsigned long)gib);
>   		gib = NULL;
>   		rc = -EIO;
> -		goto out;
> +		goto out_unreg;
>   	}
>   
>   	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
> +	goto out;
> +
> +out_unreg:
> +	unregister_adapter_interrupt(&gib_alert_irq);
> +out_free:
> +	free_page((unsigned long)gib);
> +	gib = NULL;
>   out:
>   	return rc;
>   }
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
