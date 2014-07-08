Return-Path: <linux-pci-owner@vger.kernel.org>
Message-ID: <53BB4A67.4010104@huawei.com>
Date: Tue, 8 Jul 2014 09:33:27 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] s390/MSI: Use standard mask and unmask funtions
References: <1404461764-6520-1-git-send-email-wangyijing@huawei.com> <alpine.LFD.2.11.1407041623560.1624@denkbrett>
In-Reply-To: <alpine.LFD.2.11.1407041623560.1624@denkbrett>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>, Xinwei Hu <huxinwei@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On 2014/7/4 22:28, Sebastian Ott wrote:
> On Fri, 4 Jul 2014, Yijing Wang wrote:
>> MSI irqchip in s390 has its own mask and unmask MSI irq
>> functions, zpci_enable_irq() and zpci_disable_irq().
>> They mask and unmask MSI irq in standard ways, no arch
>> special. MSI driver provides two global standard functions
>> mask_msi_irq() and unmask_msi_irq(). Local zpci_enable_irq()
>> and zpci_disable_irq() are almost the same as the standard
>> two. the difference is local mask/unmask functions
>> read the mask status before mask and unmask everytime.
>> Then change the value and rewrite to hardware. In standard
>> functions, save the mask status after mask and unmask msi
>> irq, and use the cached status to change the mask status.
>> When we mask or unmask a MSI irq, we always cache its
>> mask status except we know need not to cache it, like in
>> pci_msi_shutdown. So use the standard functions to replace
>> the local is safe.
> 
> Thanks, for doing that!
> At first glance the last hunk looks funny.

Thanks for your review.

> 
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/s390/pci/pci.c |   49 ++++++-------------------------------------------

>>  }
>> @@ -487,7 +447,10 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>>
>>  	/* Release MSI interrupts */
>>  	list_for_each_entry(msi, &pdev->msi_list, list) {
>> -		zpci_msi_set_mask_bits(msi, 1, 1);
>> +		if (msi->msi_attrib.is_msix)
>> +			default_msi_mask_irq(msi, 1, 1);
>> +		else
>> +			default_msix_mask_irq(msi, 1);
> 
> This one looks inverted.

Oh, my mistake, will update and resend.


Thanks!
Yijing.

> 
>>  		irq_set_msi_desc(msi->irq, NULL);
>>  		irq_free_desc(msi->irq);
>>  		msi->msg.address_lo = 0;
> 
> Regards,
> Sebastian
> 
> 
> .
> 


-- 
Thanks!
Yijing
