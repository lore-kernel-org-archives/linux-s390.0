Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:39747 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfHQHUG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 17 Aug 2019 03:20:06 -0400
Received: by mail-io1-f66.google.com with SMTP id l7so10780228ioj.6
        for <linux-s390@vger.kernel.org>; Sat, 17 Aug 2019 00:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190815110944.3579-1-murphyt7@tcd.ie> <20190817033914.4812-1-hdanton@sina.com>
In-Reply-To: <20190817033914.4812-1-hdanton@sina.com>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Sat, 17 Aug 2019 08:19:33 +0100
Message-ID: <CALQxJut_0bjojiFza9bZF26n0+9Vjq8QFqsxgd5Rxag+Qx609Q@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iommu/dma-iommu: Handle deferred devices
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org

On Sat, 17 Aug 2019 at 04:39, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Thu, 15 Aug 2019 12:09:41 +0100 Tom Murphy wrote:
> >
> > Handle devices which defer their attach to the iommu in the dma-iommu api
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> > ---
> >  drivers/iommu/dma-iommu.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 2712fbc68b28..906b7fa14d3c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/crash_dump.h>
> >
> >  struct iommu_dma_msi_page {
> >       struct list_head        list;
> > @@ -351,6 +352,21 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> >       return iova_reserve_iommu_regions(dev, domain);
> >  }
> >
> > +static int handle_deferred_device(struct device *dev,
> > +     struct iommu_domain *domain)
> > +{
> > +     const struct iommu_ops *ops = domain->ops;
> > +
> > +     if (!is_kdump_kernel())
> > +             return 0;
> > +
> > +     if (unlikely(ops->is_attach_deferred &&
> > +             ops->is_attach_deferred(domain, dev)))
> > +             return iommu_attach_device(domain, dev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
> >   *                    page flags.
> > @@ -463,6 +479,9 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> >       size_t iova_off = iova_offset(iovad, phys);
> >       dma_addr_t iova;
> >
> > +     if (unlikely(handle_deferred_device(dev, domain)))
> > +             return DMA_MAPPING_ERROR;
> > +
> >       size = iova_align(iovad, size + iova_off);
> >
> >       iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>
> iommu_map_atomic() is applied to __iommu_dma_map() in 2/5.
> Is it an atomic context currently given the mutex_lock() in
> iommu_attach_device()?

I don't see your point here. __iommu_dma_map isn't called from
iommu_attach_device, why would we care about a mutex in
iommu_attach_device?

__iommu_dma_map can be called from an atomic context (it isn't always
but it does happen). __iommu_dma_map is called by iommu_dma_alloc
which implements the iommu_dma_ops::alloc function which by design
needs to be callable from an atomic context. Does that answer your
question?

>
