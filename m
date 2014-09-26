From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
Date: Fri, 26 Sep 2014 10:04:45 +0800
Message-ID: <5424C9BD.3040506@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-4-git-send-email-wangyijing@huawei.com> <20140925071919.GH12423@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20140925071919.GH12423@ulmo>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.ke
List-ID: <linux-s390.vger.kernel.org>

On 2014/9/25 15:19, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
>> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
>> use irq chip_data to save the msi_chip pointer. They
>> already call irq_set_chip_data() in their own MSI irq map
>> functions. So irq_set_chip_data() in arch_setup_msi_irq()
>> is useless.
> 
> Again, I think this should be the other way around. If drivers do
> something that's already handled by the core, then the duplicate code
> should be dropped from the drivers.

Hi Thierry, this is different thing, because chip_data is specific to IRQ
controller, and in other platform, like in x86, chip_data is used to save irq_cfg.
So we can not call irq_set_chip_data() in core code.

x86 irq piece code

int arch_setup_hwirq(unsigned int irq, int node)
{
	struct irq_cfg *cfg;
	unsigned long flags;
	int ret;

	cfg = alloc_irq_cfg(irq, node);
	if (!cfg)
		return -ENOMEM;

	raw_spin_lock_irqsave(&vector_lock, flags);
	ret = __assign_irq_vector(irq, cfg, apic->target_cpus());
	raw_spin_unlock_irqrestore(&vector_lock, flags);

	if (!ret)
		irq_set_chip_data(irq, cfg);  ------------->Save irq_cfg
	else
		free_irq_cfg(irq, cfg);
	return ret;
}

Thanks!
Yijing.

> 
> Thierry
> 


-- 
Thanks!
Yijing
