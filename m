Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1495727028-27656-1-git-send-email-logang@deltatee.com>
 <20170526123801.GC14849@osiris>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0dc5ea4a-6567-e0fc-8704-aab119de8cb4@deltatee.com>
Date: Fri, 26 May 2017 10:52:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170526123801.GC14849@osiris>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] s390: provide default ioremap and iounmap declaration
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>



On 26/05/17 06:38 AM, Heiko Carstens wrote:
> On Thu, May 25, 2017 at 09:43:48AM -0600, Logan Gunthorpe wrote:
> I'd rather move the #ifdef CONFIG_PCI than implementing this yet another
> time (see patch below). But I'll leave that up to Sebastian.

I'd be more than happy with this change. Let me know if you want me to
resubmit a patch that looks like that.

Thanks,

Logan

> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index 437e9af96688..904e4b3af95d 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -25,8 +25,6 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>  
>  #define IO_SPACE_LIMIT 0
>  
> -#ifdef CONFIG_PCI
> -
>  #define ioremap_nocache(addr, size)	ioremap(addr, size)
>  #define ioremap_wc			ioremap_nocache
>  #define ioremap_wt			ioremap_nocache
> @@ -49,6 +47,8 @@ static inline void ioport_unmap(void __iomem *p)
>  {
>  }
>  
> +#ifdef CONFIG_PCI
> +
>  /*
>   * s390 needs a private implementation of pci_iomap since ioremap with its
>   * offset parameter isn't sufficient. That's because BAR spaces are not
> 
