Return-Path: <linux-pci-owner@vger.kernel.org>
Message-ID: <53BFA056.1010507@huawei.com>
Date: Fri, 11 Jul 2014 16:29:10 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/6] s390/MSI: Use standard mask and unmask funtions
References: <1404785285-6408-1-git-send-email-wangyijing@huawei.com> <alpine.LFD.2.11.1407110942310.1620@denkbrett>
In-Reply-To: <alpine.LFD.2.11.1407110942310.1620@denkbrett>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

>> mask status except we know need not to cache it, like in
>> pci_msi_shutdown. So use the standard functions to replace
>> the local is safe.
> 
> Patch applied! (I had to fix another inverted pair in struct irq_chip
> first.)

Thanks very much, I'm very sorry for my carelessness.

Thanks!
Yijing.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/s390/pci/pci.c |   49 ++++++-------------------------------------------
>>  1 files changed, 6 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 9ddc51e..f715031 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -48,13 +48,10 @@
>>  static LIST_HEAD(zpci_list);
>>  static DEFINE_SPINLOCK(zpci_list_lock);
>>
>> -static void zpci_enable_irq(struct irq_data *data);
>> -static void zpci_disable_irq(struct irq_data *data);
>> -
>>  static struct irq_chip zpci_irq_chip = {
>>  	.name = "zPCI",
>> -	.irq_unmask = zpci_enable_irq,
>> -	.irq_mask = zpci_disable_irq,
>> +	.irq_unmask = mask_msi_irq,
>> +	.irq_mask = unmask_msi_irq,
>>  };
>>
>>  static DECLARE_BITMAP(zpci_domain, ZPCI_NR_DEVICES);
>> @@ -244,43 +241,6 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
>>  	return rc;
>>  }
>>
>> -static int zpci_msi_set_mask_bits(struct msi_desc *msi, u32 mask, u32 flag)
>> -{
>> -	int offset, pos;
>> -	u32 mask_bits;
>> -
>> -	if (msi->msi_attrib.is_msix) {
>> -		offset = msi->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
>> -			PCI_MSIX_ENTRY_VECTOR_CTRL;
>> -		msi->masked = readl(msi->mask_base + offset);
>> -		writel(flag, msi->mask_base + offset);
>> -	} else if (msi->msi_attrib.maskbit) {
>> -		pos = (long) msi->mask_base;
>> -		pci_read_config_dword(msi->dev, pos, &mask_bits);
>> -		mask_bits &= ~(mask);
>> -		mask_bits |= flag & mask;
>> -		pci_write_config_dword(msi->dev, pos, mask_bits);
>> -	} else
>> -		return 0;
>> -
>> -	msi->msi_attrib.maskbit = !!flag;
>> -	return 1;
>> -}
>> -
>> -static void zpci_enable_irq(struct irq_data *data)
>> -{
>> -	struct msi_desc *msi = irq_get_msi_desc(data->irq);
>> -
>> -	zpci_msi_set_mask_bits(msi, 1, 0);
>> -}
>> -
>> -static void zpci_disable_irq(struct irq_data *data)
>> -{
>> -	struct msi_desc *msi = irq_get_msi_desc(data->irq);
>> -
>> -	zpci_msi_set_mask_bits(msi, 1, 1);
>> -}
>> -
>>  void pcibios_fixup_bus(struct pci_bus *bus)
>>  {
>>  }
>> @@ -487,7 +447,10 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>>
>>  	/* Release MSI interrupts */
>>  	list_for_each_entry(msi, &pdev->msi_list, list) {
>> -		zpci_msi_set_mask_bits(msi, 1, 1);
>> +		if (msi->msi_attrib.is_msix)
>> +			default_msix_mask_irq(msi, 1);
>> +		else
>> +			default_msi_mask_irq(msi, 1, 1);
>>  		irq_set_msi_desc(msi->irq, NULL);
>>  		irq_free_desc(msi->irq);
>>  		msi->msg.address_lo = 0;
>> -- 
>> 1.7.1
>>
>>
>>
> 
> 
> .
> 


-- 
Thanks!
Yijing
