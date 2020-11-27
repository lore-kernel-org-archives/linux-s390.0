Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgK0I54 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 03:57:56 -0500
Date: Fri, 27 Nov 2020 09:56:33 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
Message-ID: <20201127095633.60f8a544.pasic@linux.ibm.com>
In-Reply-To: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 18:00:37 +0100
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> The directed MSIs are delivered to CPUs whose address is
> written to the MSI message data. The current code assumes
> that a CPU logical number (as it is seen by the kernel)
> is also that CPU address.
> 
> The above assumption is not correct, as the CPU address
> is rather the value returned by STAP instruction. That
> value does not necessarily match the kernel logical CPU
> number.
> 
> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 743f257cf2cb..75217fb63d7b 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>  {
>  	struct msi_desc *entry = irq_get_msi_desc(data->irq);
>  	struct msi_msg msg = entry->msg;
> +	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
>  
>  	msg.address_lo &= 0xff0000ff;
> -	msg.address_lo |= (cpumask_first(dest) << 8);
> +	msg.address_lo |= (cpu_addr << 8);
>  	pci_write_msi_msg(data->irq, &msg);
>  
>  	return IRQ_SET_MASK_OK;
> @@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	unsigned long bit;
>  	struct msi_desc *msi;
>  	struct msi_msg msg;
> +	int cpu_addr;
>  	int rc, irq;
>  
>  	zdev->aisb = -1UL;
> @@ -287,9 +289,15 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  					 handle_percpu_irq);
>  		msg.data = hwirq - bit;
>  		if (irq_delivery == DIRECTED) {
> +			if (msi->affinity)
> +				cpu = cpumask_first(&msi->affinity->mask);
> +			else
> +				cpu = 0;
> +			cpu_addr = smp_cpu_get_cpu_address(cpu);
> +

I thin style wise, I would prefer keeping the ternary operator instead
of rewriting it as an if-then-else, i.e.:
                        cpu_addr = smp_cpu_get_cpu_address(msi->affinity ?      
                                cpumask_first(&msi->affinity->mask) : 0);
but either way:

Reviewed-by: Halil Pasic <pasic@linux.ibm.com> 

>  			msg.address_lo = zdev->msi_addr & 0xff0000ff;
> -			msg.address_lo |= msi->affinity ?
> -				(cpumask_first(&msi->affinity->mask) << 8) : 0;
> +			msg.address_lo |= (cpu_addr << 8);
> +
>  			for_each_possible_cpu(cpu) {
>  				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
>  			}
