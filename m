Return-Path: <linux-pci-owner@vger.kernel.org>
Message-ID: <53B60921.7090501@huawei.com>
Date: Fri, 4 Jul 2014 09:53:37 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] s390/MSI: Fix msi mask issue
References: <1403166674-6836-1-git-send-email-wangyijing@huawei.com> <20140703235706.GC25980@google.com>
In-Reply-To: <20140703235706.GC25980@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>, Xinwei Hu <huxinwei@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

>> @@ -263,7 +263,7 @@ static int zpci_msi_set_mask_bits(struct msi_desc *msi, u32 mask, u32 flag)
>>  	} else
>>  		return 0;
>>  
>> -	msi->msi_attrib.maskbit = !!flag;
>> +	msi->masked = !!flag;
> 
> This doesn't look right.  For MSI-X, you just overwrote the previous update
> of msi->masked:
> 
>     if (msi->msi_attrib.is_msix) {
> 	...
> 	msi->masked = readl(msi->mask_base + offset);
> 
> Maybe the update values end up being the same, but why do it twice?

Hi Bjorn, this code is some difficult to understand. I guess it's for save
MSI mask status, for MSI-X, do this twice, maybe this line should move up int to
MSI if ()...

Because I don't have the platform to test, so I do not want to change the code logic,
what I am sure is save the flag status in msi->msi_attrib.maskbit  is wrong.
So I change this like:
	msi->masked = !!flag;

Sebastian may know why do it like this.

Besides, I think we can use MSI code driver interface mask_msi_irq() and unmask_msi_irq()
to replace zpci_enable_irq() and zpci_disable_irq().

> 
> Also, the MSI mask bits are 32-bit field that can individually mask any
> subset of the 32 possible MSI vectors, and you collapsed this down to a
> single bit, so msi->masked no longer contains that information.
> 
> Maybe none of this matters because all the zpci_msi_set_mask_bits() uses
> seem to be for a single bit, but the name says "mask_*bits*" and the
> msi->masked field is generic and covers multiple MSI vectors in general.

Yes, it always uses single bit here, as you said, this code has some problems for
multiple MSI, although it may does not use it.

I will try to send a new patch fix the original problem.

Thanks!
Yijing.
> 
>>  	return 1;
>>  }
>>  
>> -- 
>> 1.7.1
>>
>>
> 
> .
> 


-- 
Thanks!
Yijing
