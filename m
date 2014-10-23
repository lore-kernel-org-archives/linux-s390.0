From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 09/27] arm/PCI: Clean unused pcibios_add_bus() and
 pcibios_remove_bus()
Date: Thu, 23 Oct 2014 14:39:35 +0800
Message-ID: <5448A2A7.9090407@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com> <1413342435-7876-10-git-send-email-wangyijing@huawei.com> <20141023053858.GD11770@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20141023053858.GD11770@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@til>
List-ID: <linux-s390.vger.kernel.org>

>>  /*
>>   * Swizzle the device pin each time we cross a bridge.  If a platform does
>>   * not provide a swizzle function, we perform the standard PCI swizzling.
>> @@ -478,8 +464,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>>  		sys->swizzle = hw->swizzle;
>>  		sys->map_irq = hw->map_irq;
>>  		sys->align_resource = hw->align_resource;
>> -		sys->add_bus = hw->add_bus;
>> -		sys->remove_bus = hw->remove_bus;
>>  		INIT_LIST_HEAD(&sys->resources);
>>  
>>  		if (hw->private_data)
> 
> What do the core changes below have to do with the ARM changes above?
> They should be a separate patch unless they can't be separated.

Hm, it's not the thing have to do, because the changes below is only used by arm arch, so I put it here
together. It's ok to split the core changes out to another one.

> 
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index f11108c..56e54ad 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -32,12 +32,10 @@ int pci_msi_ignore_mask;
>>  
>>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  {
>> -	struct msi_chip *chip = dev->bus->msi;
>> +	struct msi_chip *chip;
>>  	int err;
>>  
>> -	if (!chip)
>> -		chip = pci_msi_chip(dev->bus);
>> -
>> +	chip = pci_msi_chip(dev->bus);
>>  	if (!chip || !chip->setup_irq)
>>  		return -EINVAL;
>>  
>> @@ -51,10 +49,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  void __weak arch_teardown_msi_irq(unsigned int irq)
>>  {
>>  	struct msi_desc *entry = irq_get_msi_desc(irq);
>> -	struct msi_chip *chip = entry->dev->bus->msi;
>> -
>> -	if (!chip)
>> -		chip = pci_msi_chip(entry->dev->bus);
>> +	struct msi_chip *chip = pci_msi_chip(entry->dev->bus);
>>  
>>  	if (!chip || !chip->teardown_irq)
>>  		return;
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
