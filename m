Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 26 May 2017 14:38:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: provide default ioremap and iounmap declaration
References: <1495727028-27656-1-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495727028-27656-1-git-send-email-logang@deltatee.com>
Message-Id: <20170526123801.GC14849@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 25, 2017 at 09:43:48AM -0600, Logan Gunthorpe wrote:
> Add a default ioremap function which was not provided in all
> circumstances. (Only when CONFIG_PCI was set).
> 
> I have designs to use them in scatterlist.c where they'd likely never
> be called without CONFIG_PCI set, but it is needed to compile. Thus,
> if the function is ever hit it returns NULL.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> ---
> 
> Thanks to Al Viro for pointing out this corner case in s390.
> 
>  arch/s390/include/asm/io.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index 437e9af..f4140d4 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -73,6 +73,17 @@ static inline void ioport_unmap(void __iomem *p)
>  #define __raw_writel	zpci_write_u32
>  #define __raw_writeq	zpci_write_u64
> 
> +#else
> +
> +static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
> +{
> +	return NULL;
> +}
> +
> +static inline void iounmap(void __iomem *addr)
> +{
> +}
> +
>  #endif /* CONFIG_PCI */

I'd rather move the #ifdef CONFIG_PCI than implementing this yet another
time (see patch below). But I'll leave that up to Sebastian.

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 437e9af96688..904e4b3af95d 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -25,8 +25,6 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
 
-#ifdef CONFIG_PCI
-
 #define ioremap_nocache(addr, size)	ioremap(addr, size)
 #define ioremap_wc			ioremap_nocache
 #define ioremap_wt			ioremap_nocache
@@ -49,6 +47,8 @@ static inline void ioport_unmap(void __iomem *p)
 {
 }
 
+#ifdef CONFIG_PCI
+
 /*
  * s390 needs a private implementation of pci_iomap since ioremap with its
  * offset parameter isn't sufficient. That's because BAR spaces are not
