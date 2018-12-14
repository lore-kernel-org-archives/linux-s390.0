From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 14 Dec 2018 13:36:26 +0100
Message-ID: <CAMuHMdUU36Jg0vNGV2WwkceNNGEnGX4yxwEecT3abKz0AG+epw@mail.gmail.com>
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de>
 <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com> <20181214114719.GA3316@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214114719.GA3316@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, Michal Simek <monstr@monstr.eu>, ashutosh.dixit@intel.com, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christoph,

On Fri, Dec 14, 2018 at 12:47 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Dec 14, 2018 at 10:54:32AM +0100, Geert Uytterhoeven wrote:
> > > -       page = alloc_pages(flag, order);
> > > +       page = alloc_pages(flag | GFP_ZERO, order);
> > >         if (!page)
> > >                 return NULL;
> >
> > There's second implementation below, which calls __get_free_pages() and
> > does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
> > it makes sense to replace the memset() by GFP_ZERO, to increase consistency?
>
> It would, but this patch really tries to be minimally invasive to just
> provide the zeroing everywhere.

Fair enough.

> There is plenty of opportunity
> to improve the m68k dma allocator if I can get enough reviewers/testers:
>
>  - for one the coldfire/nommu case absolutely does not make sense to
>    me as there is not work done at all to make sure the memory is
>    mapped uncached despite the architecture implementing cache
>    flushing for the map interface.  So this whole implementation
>    looks broken to me and will need some major work (I had a previous
>    discussion with Greg on that which needs to be dug out)
>  - the "regular" implementation in this patch should probably be replaced
>    with the generic remapping helpers that have been added for the 4.21
>    merge window:
>
>         http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/0c3b3171ceccb8830c2bb5adff1b4e9b204c1450
>
> Compile tested only patch below:
>
> --
> From ade86dc75b9850daf9111ebf9ce15825a6144f2d Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 14 Dec 2018 12:41:45 +0100
> Subject: m68k: use the generic dma coherent remap allocator
>
> This switche to using common code for the DMA allocations, including
> potential use of the CMA allocator if configure.  Also add a few
> comments where the existing behavior seems to be lacking.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, looks OK to me.
M68k doesn't have many drivers using the DMA framework, as most of them
predated that framework.

> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c

>
> -void arch_dma_free(struct device *dev, size_t size, void *addr,
> -               dma_addr_t handle, unsigned long attrs)
> +pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> +               unsigned long attrs)
>  {
> -       pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
> -       vfree(addr);
> +       /*
> +        * XXX: this doesn't seem to handle the sun3 MMU at all.

Sun-3 selects NO_DMA, and this file is compiled for the HAS_DMA case only.

> +        */
> +       if (CPU_IS_040_OR_060) {
> +               pgprot_val(prot) &= ~_PAGE_CACHE040;
> +               pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
> +       } else {
> +               pgprot_val(prot) |= _PAGE_NOCACHE030;
> +       }
> +       return prot;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
