Return-Path: <SRS0=x4Eb=TP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <20190506185207.31069-1-tmurphy@arista.com>
 <20190506185207.31069-3-tmurphy@arista.com>
 <20190507064000.GB5173@infradead.org>
In-Reply-To: <20190507064000.GB5173@infradead.org>
From: Tom Murphy <tmurphy@arista.com>
Date: Wed, 15 May 2019 13:46:43 +0100
Message-ID: <CAPL0++5AUyVHexpsE86PfXxmQgDHfxjSSoAAGXM5c7Mdix=OZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iommu/dma-iommu: Handle deferred devices
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Christoph Hellwig <hch@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>, Rob Clark <robdclark@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

like this?

In that case we need to add a call to iommu_dma_alloc_remap.

From 862aeebb601008cf863e3aff4ff8ed7cefebeefa Mon Sep 17 00:00:00 2001
From: Tom Murphy <tmurphy@tmurphy-419tom-0.sjc.aristanetworks.com>
Date: Wed, 15 May 2019 05:43:25 -0700
Subject: [PATCH] iommu/dma-iommu: Handle deferred devices

Handle devices which defer their attach to the iommu in the dma-iommu api

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7f313cfa9..a48ae906d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
+#include <linux/crash_dump.h>

 struct iommu_dma_msi_page {
     struct list_head    list;
@@ -323,6 +324,21 @@ static int iommu_dma_init_domain(struct
iommu_domain *domain, dma_addr_t base,
     return iova_reserve_iommu_regions(dev, domain);
 }

+static int handle_deferred_device(struct device *dev,
+        struct iommu_domain *domain)
+{
+    const struct iommu_ops *ops = domain->ops;
+
+    if (!is_kdump_kernel())
+        return 0;
+
+    if (unlikely(ops->is_attach_deferred &&
+            ops->is_attach_deferred(domain, dev)))
+        return iommu_attach_device(domain, dev);
+
+    return 0;
+}
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
@@ -432,6 +448,9 @@ static dma_addr_t __iommu_dma_map(struct device
*dev, phys_addr_t phys,
     size_t iova_off = 0;
     dma_addr_t iova;

+    if (unlikely(handle_deferred_device(dev, domain)))
+        return DMA_MAPPING_ERROR;
+
     if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
         iova_off = iova_offset(&cookie->iovad, phys);
         size = iova_align(&cookie->iovad, size + iova_off);
@@ -609,6 +628,9 @@ static void *iommu_dma_alloc_remap(struct device
*dev, size_t size,
     dma_addr_t iova;
     void *vaddr;

+    if (unlikely(handle_deferred_device(dev, domain)))
+        return DMA_MAPPING_ERROR;
+
     *dma_handle = DMA_MAPPING_ERROR;

     min_size = alloc_sizes & -alloc_sizes;
@@ -836,7 +858,7 @@ static dma_addr_t iommu_dma_map_page(struct device
*dev, struct page *page,
     bool coherent = dev_is_dma_coherent(dev);
     dma_addr_t dma_handle;

-    dma_handle =__iommu_dma_map(dev, phys, size,
+    dma_handle = __iommu_dma_map(dev, phys, size,
             dma_info_to_prot(dir, coherent, attrs),
             iommu_get_dma_domain(dev));
     if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
@@ -954,6 +976,9 @@ static int iommu_dma_map_sg(struct device *dev,
struct scatterlist *sg,
     unsigned long mask = dma_get_seg_boundary(dev);
     int i;

+    if (unlikely(handle_deferred_device(dev, domain)))
+        return 0;
+
     if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
         iommu_dma_sync_sg_for_device(dev, sg, nents, dir);

-- 
2.20.0

On Tue, May 7, 2019 at 7:40 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 06, 2019 at 07:52:04PM +0100, Tom Murphy wrote:
> > +static int handle_deferred_device(struct device *dev)
> > +{
> > +     struct iommu_domain *domain;
> > +     const struct iommu_ops *ops;
> > +
> > +     if (!is_kdump_kernel())
> > +             return 0;
> > +
> > +     domain = iommu_get_domain_for_dev(dev);
>
> > -     dma_handle =__iommu_dma_map(dev, phys, size,
> > +     if (unlikely(handle_deferred_device(dev)))
> > +             return DMA_MAPPING_ERROR;
> > +
> > +     dma_handle = __iommu_dma_map(dev, phys, size,
>
> __iommu_dma_map already looks up the domain, and as far as I can
> tell all callers need the handle_deferred_device call.  Should we
> just move it to there and pass the domain from the caller?
>
> Also shouldn't the iommu_attach_device call inside
> handle_deferred_device also get an unlikely marker?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
