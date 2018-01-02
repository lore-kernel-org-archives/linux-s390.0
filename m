Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-30-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-30-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2018 11:29:10 +0100
Message-ID: <CAMuHMdU0_p4RHSKL891YCgej_L2KM5cxmhXDLXVUBXgWoUosVA@mail.gmail.com>
Subject: Re: [PATCH 29/67] dma-direct: use node local allocations for coherent memory
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180102102910.Zbn-7Ur0uUSrgy85J9m80hK_ZhTiY_SszrrU0y-HwBw@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, the arch/x86 maintainers <x86@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Missing patch description explaining why this change is desirable.

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -39,7 +39,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>         if (gfpflags_allow_blocking(gfp))
>                 page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
>         if (!page)
> -               page = alloc_pages(gfp, page_order);
> +               page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
>         if (!page)
>                 return NULL;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
