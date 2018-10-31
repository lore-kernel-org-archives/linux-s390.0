From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 31 Oct 2018 12:45:58 +0000
Subject: Re: [PATCH 09/10] KVM: s390: add and wire function gib_alert_irq_handler()
Message-Id: <20181031134558.15f1a8f0.cohuck@redhat.com>
In-Reply-To: <e4d9545a-32f9-6e0b-b781-49e5cc2162f1@linux.ibm.com>
References: <e4d9545a-32f9-6e0b-b781-49e5cc2162f1@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Oct 2018 14:37:50 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> The patch implements a handler for GIB alert interruptions
> on the host. Its task is to alert storage backed guests that
> interrupts are pending for them.
> 
> A GIB alert interrupt statistic counter is added as well:
> 
> $ cat /proc/interrupts
>           CPU0       CPU1
>   ...
>   GAL:       0          0   [I/O] GIB Alert
>   ...
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/irq.h |  1 +
>  arch/s390/include/asm/isc.h |  1 +
>  arch/s390/kernel/irq.c      |  1 +
>  arch/s390/kvm/interrupt.c   | 45 +++++++++++++++++++++++++++++++++----
>  arch/s390/kvm/kvm-s390.c    |  5 +++++
>  5 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
> index 2f7f27e5493f..afaf5e3c57fd 100644
> --- a/arch/s390/include/asm/irq.h
> +++ b/arch/s390/include/asm/irq.h
> @@ -62,6 +62,7 @@ enum interruption_class {
>  	IRQIO_MSI,
>  	IRQIO_VIR,
>  	IRQIO_VAI,
> +	IRQIO_GAL,
>  	NMI_NMI,
>  	CPU_RST,
>  	NR_ARCH_IRQS
> diff --git a/arch/s390/include/asm/isc.h b/arch/s390/include/asm/isc.h
> index 6cb9e2ed05b6..b2cc1ec78d06 100644
> --- a/arch/s390/include/asm/isc.h
> +++ b/arch/s390/include/asm/isc.h
> @@ -21,6 +21,7 @@
>  /* Adapter interrupts. */
>  #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
>  #define PCI_ISC 2			/* PCI I/O subchannels */
> +#define GAL_ISC 5			/* GIB alert */

Dumb question: iscs are ordered by priority. What are the semantics
here? Are gib alerts only for ap-style adapter interrupts (at least
currently, it seems to me like that)? Is there a requirement to use a
distinct isc?

>  #define AP_ISC 6			/* adjunct processor (crypto) devices */
>  
>  /* Functions for registration of I/O interruption subclasses */
