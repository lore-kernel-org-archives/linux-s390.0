Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42589 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDVY5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 17:24:57 -0400
MIME-Version: 1.0
References: <20190506185207.31069-1-tmurphy@arista.com> <20190506185207.31069-2-tmurphy@arista.com>
 <33a1e3c1-1906-9e45-d060-e7998424973b@arm.com>
In-Reply-To: <33a1e3c1-1906-9e45-d060-e7998424973b@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 4 Jun 2019 14:24:42 -0700
Message-ID: <CAF6AEGuk8GkbZ_XZJg6Gbpng+BaKjVHQ9M-6nGW0pi+h_Nh3Hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iommu: Add gfp parameter to iommu_ops::map
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tom Murphy <tmurphy@arista.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, murphyt7@tcd.ieJoerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-mediatek@lists.infradead.org, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org

On Tue, Jun 4, 2019 at 11:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/05/2019 19:52, Tom Murphy wrote:
> > Add a gfp_t parameter to the iommu_ops::map function.
> > Remove the needless locking in the AMD iommu driver.
> >
> > The iommu_ops::map function (or the iommu_map function which calls it)
> > was always supposed to be sleepable (according to Joerg's comment in
> > this thread: https://lore.kernel.org/patchwork/patch/977520/ ) and so
> > should probably have had a "might_sleep()" since it was written. However
> > currently the dma-iommu api can call iommu_map in an atomic context,
> > which it shouldn't do. This doesn't cause any problems because any iommu
> > driver which uses the dma-iommu api uses gfp_atomic in it's
> > iommu_ops::map function. But doing this wastes the memory allocators
> > atomic pools.
>
> Hmm, in some cases iommu_ops::unmap may need to allocate as well,
> primarily if it needs to split a hugepage mapping. Should we pass flags
> through there as well, or are we prepared to assume that that case will
> happen rarely enough that it's fair to just assume GFP_ATOMIC? It won't
> happen for DMA ops, but it's conceivable that other users such as GPU
> drivers might make partial unmaps, and I doubt we could totally rule out
> the wackiest ones doing so from non-sleeping contexts.
>

jfyi, today we (well, drm/msm) only unmap entire buffers, so assuming
there isn't any coelescense of adjacent buffers that happen to form a
hugepage on ::map(), we are probably ok on ::unmap()..

we do always only call ::map or ::unmap under sleepable conditions.

btw, would it be simpler to just make gfp_t a domain a attribute?
That seems like it would be less churn, but maybe I'm overlooking
something.

BR,
-R
