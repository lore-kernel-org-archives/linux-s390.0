Return-Path: <linux-pci-owner@vger.kernel.org>
Date: Thu, 3 Jul 2014 17:57:06 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 5/5] s390/MSI: Fix msi mask issue
Message-ID: <20140703235706.GC25980@google.com>
References: <1403166674-6836-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403166674-6836-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>, Xinwei Hu <huxinwei@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 19, 2014 at 04:31:14PM +0800, Yijing Wang wrote:
> Maskbit in msi_attrib indicates MSI whether
> support mask-pending bit. It is read only,
> should save mask state in masked.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/s390/pci/pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index bdf0257..4651d6b 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -263,7 +263,7 @@ static int zpci_msi_set_mask_bits(struct msi_desc *msi, u32 mask, u32 flag)
>  	} else
>  		return 0;
>  
> -	msi->msi_attrib.maskbit = !!flag;
> +	msi->masked = !!flag;

This doesn't look right.  For MSI-X, you just overwrote the previous update
of msi->masked:

    if (msi->msi_attrib.is_msix) {
	...
	msi->masked = readl(msi->mask_base + offset);

Maybe the update values end up being the same, but why do it twice?

Also, the MSI mask bits are 32-bit field that can individually mask any
subset of the 32 possible MSI vectors, and you collapsed this down to a
single bit, so msi->masked no longer contains that information.

Maybe none of this matters because all the zpci_msi_set_mask_bits() uses
seem to be for a single bit, but the name says "mask_*bits*" and the
msi->masked field is generic and covers multiple MSI vectors in general.

>  	return 1;
>  }
>  
> -- 
> 1.7.1
> 
> 
