Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgL0TVd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 27 Dec 2020 14:21:33 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 27 Dec 2020 11:20:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch 02/30] genirq: Move status flag checks to core
Message-ID: <20201227192049.GA195845@roeck-us.net>
References: <20201210192536.118432146@linutronix.de>
 <20201210194042.703779349@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210194042.703779349@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Will Deacon <will@kernel.org>, Michal Simek <michal.simek@xilinx.com>, linux-s390@vger.kernel.org, afzal mohammed <afzal.mohd.ma@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Jiang <dave.jiang@intel.com>, xen-devel@lists.xenproject.org, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Wambui Karuga <wambui.karugax@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Juergen Gross <jgross@suse.com>, David Airlie <airlied@linux.ie>, linux-gpio@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-parisc@vger.kernel.org, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>

On Thu, Dec 10, 2020 at 08:25:38PM +0100, Thomas Gleixner wrote:
> These checks are used by modules and prevent the removal of the export of
> irq_to_desc(). Move the accessor into the core.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Yes, but that means that irq_check_status_bit() may be called from modules,
but it is not exported, resulting in build errors such as the following.

arm64:allmodconfig:

ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Guenter

> ---
>  include/linux/irqdesc.h |   17 +++++------------
>  kernel/irq/manage.c     |   17 +++++++++++++++++
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -223,28 +223,21 @@ irq_set_chip_handler_name_locked(struct
>  	data->chip = chip;
>  }
>  
> +bool irq_check_status_bit(unsigned int irq, unsigned int bitmask);
> +
>  static inline bool irq_balancing_disabled(unsigned int irq)
>  {
> -	struct irq_desc *desc;
> -
> -	desc = irq_to_desc(irq);
> -	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
> +	return irq_check_status_bit(irq, IRQ_NO_BALANCING_MASK);
>  }
>  
>  static inline bool irq_is_percpu(unsigned int irq)
>  {
> -	struct irq_desc *desc;
> -
> -	desc = irq_to_desc(irq);
> -	return desc->status_use_accessors & IRQ_PER_CPU;
> +	return irq_check_status_bit(irq, IRQ_PER_CPU);
>  }
>  
>  static inline bool irq_is_percpu_devid(unsigned int irq)
>  {
> -	struct irq_desc *desc;
> -
> -	desc = irq_to_desc(irq);
> -	return desc->status_use_accessors & IRQ_PER_CPU_DEVID;
> +	return irq_check_status_bit(irq, IRQ_PER_CPU_DEVID);
>  }
>  
>  static inline void
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2769,3 +2769,23 @@ bool irq_has_action(unsigned int irq)
>  	return res;
>  }
>  EXPORT_SYMBOL_GPL(irq_has_action);
> +
> +/**
> + * irq_check_status_bit - Check whether bits in the irq descriptor status are set
> + * @irq:	The linux irq number
> + * @bitmask:	The bitmask to evaluate
> + *
> + * Returns: True if one of the bits in @bitmask is set
> + */
> +bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
> +{
> +	struct irq_desc *desc;
> +	bool res = false;
> +
> +	rcu_read_lock();
> +	desc = irq_to_desc(irq);
> +	if (desc)
> +		res = !!(desc->status_use_accessors & bitmask);
> +	rcu_read_unlock();
> +	return res;
> +}
