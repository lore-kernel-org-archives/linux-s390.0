Return-Path: <SRS0=hRWP=TF=vger.kernel.org=kvm-owner@kernel.org>
MIME-Version: 1.0
References: <20190504132327.27041-1-tmurphy@arista.com> <20190504132327.27041-7-tmurphy@arista.com>
 <602b77a2-9c68-ad14-b64f-904a7ff27a15@linux.intel.com>
In-Reply-To: <602b77a2-9c68-ad14-b64f-904a7ff27a15@linux.intel.com>
From: Tom Murphy <tmurphy@arista.com>
Date: Sun, 5 May 2019 18:03:02 +0100
Message-ID: <CAPL0++57nyLYP1fq=-6zvNS0z_iCqjWLbQ1MsG5F60ODkmRCQQ@mail.gmail.com>
Subject: Re: [RFC 6/7] iommu/vt-d: convert the intel iommu driver to the
 dma-iommu ops api
Content-Type: text/plain; charset="UTF-8"
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 5, 2019 at 3:44 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 5/4/19 9:23 PM, Tom Murphy wrote:
> > static int intel_iommu_add_device(struct device *dev)
> >   {
> > +     struct dmar_domain *dmar_domain;
> > +     struct iommu_domain *domain;
> >       struct intel_iommu *iommu;
> >       struct iommu_group *group;
> > -     struct iommu_domain *domain;
> > +     dma_addr_t base;
> >       u8 bus, devfn;
> >
> >       iommu = device_to_iommu(dev, &bus, &devfn);
> > @@ -4871,9 +4514,12 @@ static int intel_iommu_add_device(struct device *dev)
> >       if (IS_ERR(group))
> >               return PTR_ERR(group);
> >
> > +     base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> >       domain = iommu_get_domain_for_dev(dev);
> > +     dmar_domain = to_dmar_domain(domain);
> >       if (domain->type == IOMMU_DOMAIN_DMA)
> > -             dev->dma_ops = &intel_dma_ops;
> > +             iommu_setup_dma_ops(dev, base,
> > +                             __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
>
> I didn't find the implementation of iommu_setup_dma_ops() in this
> series. Will the iova resource be initialized in this function?

Ah sorry, I should've mentioned this is based on the
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
branch with the "iommu/vt-d: Delegate DMA domain to generic iommu" and
"iommu/amd: Convert the AMD iommu driver to the dma-iommu api" patch
sets applied.

>
> If so, will this block iommu_group_create_direct_mappings() which
> reserves and maps the reserved iova ranges.

The reserved regions will be reserved by the
iova_reserve_iommu_regions function instead:
( https://github.com/torvalds/linux/blob/6203838dec05352bc357625b1e9ba0a10d3bca35/drivers/iommu/dma-iommu.c#L238
)
iommu_setup_dma_ops calls iommu_dma_init_domain which calls
iova_reserve_iommu_regions.
iommu_group_create_direct_mappings will still execute normally but it
won't be able to call the intel_iommu_apply_resv_region function
because it's been removed in this patchset.
This shouldn't change any behavior and the same regions should be reserved.

>
> >
> >       iommu_group_put(group);
> >       return 0;
> > @@ -5002,19 +4648,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
> >       return ret;
> >   }
> >
> > -static void intel_iommu_apply_resv_region(struct device *dev,
> > -                                       struct iommu_domain *domain,
> > -                                       struct iommu_resv_region *region)
> > -{
> > -     struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > -     unsigned long start, end;
> > -
> > -     start = IOVA_PFN(region->start);
> > -     end   = IOVA_PFN(region->start + region->length - 1);
> > -
> > -     WARN_ON_ONCE(!reserve_iova(&dmar_domain->iovad, start, end));
> > -}
> > -
> >   struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
> >   {
> >       struct intel_iommu *iommu;
> > @@ -5050,13 +4683,13 @@ const struct iommu_ops intel_iommu_ops = {
> >       .detach_dev             = intel_iommu_detach_device,
> >       .map                    = intel_iommu_map,
> >       .unmap                  = intel_iommu_unmap,
> > +     .flush_iotlb_all        = iommu_flush_iova,
> >       .flush_iotlb_range      = intel_iommu_flush_iotlb_range,
> >       .iova_to_phys           = intel_iommu_iova_to_phys,
> >       .add_device             = intel_iommu_add_device,
> >       .remove_device          = intel_iommu_remove_device,
> >       .get_resv_regions       = intel_iommu_get_resv_regions,
> >       .put_resv_regions       = intel_iommu_put_resv_regions,
> > -     .apply_resv_region      = intel_iommu_apply_resv_region,
>
> With this removed, how will iommu_group_create_direct_mappings() work?
>
> Best regards,
> Lu Baolu
