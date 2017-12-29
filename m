Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-28-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-28-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Dec 2017 15:12:25 +0100
Message-ID: <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
Subject: Re: [PATCH 27/67] dma-direct: add dma address sanity checks
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20171229141225.onEsA1-AAuENtYGlz_EOt48N2vGosNNVx1vqR6V8zF4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Hi Christoph,

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Roughly based on the x86 pci-nommu implementation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -9,6 +9,24 @@
>  #include <linux/scatterlist.h>
>  #include <linux/pfn.h>
>
> +#define DIRECT_MAPPING_ERROR           0
> +
> +static bool
> +check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> +               const char *caller)
> +{
> +       if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> +               if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
> +                       dev_err(dev,
> +                               "%s: overflow %llx+%zu of device mask %llx\n",

Please use "%pad" to format dma_addr_t ...

> +                               caller, (long long)dma_addr, size,

... and use &dma_addr.

> +                               (long long)*dev->dma_mask);

This cast is not needed, as u64 is unsigned long long in kernelspace on
all architectures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
