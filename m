Return-Path: <linux-pci-owner@vger.kernel.org>
Date: Fri, 4 Jul 2014 16:28:32 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] s390/MSI: Use standard mask and unmask funtions
In-Reply-To: <1404461764-6520-1-git-send-email-wangyijing@huawei.com>
Message-ID: <alpine.LFD.2.11.1407041623560.1624@denkbrett>
References: <1404461764-6520-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>, Xinwei Hu <huxinwei@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 4 Jul 2014, Yijing Wang wrote:
> MSI irqchip in s390 has its own mask and unmask MSI irq
> functions, zpci_enable_irq() and zpci_disable_irq().
> They mask and unmask MSI irq in standard ways, no arch
> special. MSI driver provides two global standard functions
> mask_msi_irq() and unmask_msi_irq(). Local zpci_enable_irq()
> and zpci_disable_irq() are almost the same as the standard
> two. the difference is local mask/unmask functions
> read the mask status before mask and unmask everytime.
> Then change the value and rewrite to hardware. In standard
> functions, save the mask status after mask and unmask msi
> irq, and use the cached status to change the mask status.
> When we mask or unmask a MSI irq, we always cache its
> mask status except we know need not to cache it, like in
> pci_msi_shutdown. So use the standard functions to replace
> the local is safe.

Thanks, for doing that!
At first glance the last hunk looks funny.

> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/s390/pci/pci.c |   49 ++++++-------------------------------------------
>  1 files changed, 6 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 9ddc51e..01fa289 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -48,13 +48,10 @@
>  static LIST_HEAD(zpci_list);
>  static DEFINE_SPINLOCK(zpci_list_lock);
> 
> -static void zpci_enable_irq(struct irq_data *data);
> -static void zpci_disable_irq(struct irq_data *data);
> -
>  static struct irq_chip zpci_irq_chip = {
>  	.name = "zPCI",
> -	.irq_unmask = zpci_enable_irq,
> -	.irq_mask = zpci_disable_irq,
> +	.irq_unmask = mask_msi_irq,
> +	.irq_mask = unmask_msi_irq,
>  };
> 
>  static DECLARE_BITMAP(zpci_domain, ZPCI_NR_DEVICES);
> @@ -244,43 +241,6 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
>  	return rc;
>  }
> 
> -static int zpci_msi_set_mask_bits(struct msi_desc *msi, u32 mask, u32 flag)
> -{
> -	int offset, pos;
> -	u32 mask_bits;
> -
> -	if (msi->msi_attrib.is_msix) {
> -		offset = msi->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
> -			PCI_MSIX_ENTRY_VECTOR_CTRL;
> -		msi->masked = readl(msi->mask_base + offset);
> -		writel(flag, msi->mask_base + offset);
> -	} else if (msi->msi_attrib.maskbit) {
> -		pos = (long) msi->mask_base;
> -		pci_read_config_dword(msi->dev, pos, &mask_bits);
> -		mask_bits &= ~(mask);
> -		mask_bits |= flag & mask;
> -		pci_write_config_dword(msi->dev, pos, mask_bits);
> -	} else
> -		return 0;
> -
> -	msi->msi_attrib.maskbit = !!flag;
> -	return 1;
> -}
> -
> -static void zpci_enable_irq(struct irq_data *data)
> -{
> -	struct msi_desc *msi = irq_get_msi_desc(data->irq);
> -
> -	zpci_msi_set_mask_bits(msi, 1, 0);
> -}
> -
> -static void zpci_disable_irq(struct irq_data *data)
> -{
> -	struct msi_desc *msi = irq_get_msi_desc(data->irq);
> -
> -	zpci_msi_set_mask_bits(msi, 1, 1);
> -}
> -
>  void pcibios_fixup_bus(struct pci_bus *bus)
>  {
>  }
> @@ -487,7 +447,10 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
> 
>  	/* Release MSI interrupts */
>  	list_for_each_entry(msi, &pdev->msi_list, list) {
> -		zpci_msi_set_mask_bits(msi, 1, 1);
> +		if (msi->msi_attrib.is_msix)
> +			default_msi_mask_irq(msi, 1, 1);
> +		else
> +			default_msix_mask_irq(msi, 1);

This one looks inverted.

>  		irq_set_msi_desc(msi->irq, NULL);
>  		irq_free_desc(msi->irq);
>  		msi->msg.address_lo = 0;

Regards,
Sebastian
