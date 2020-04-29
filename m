Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:39570 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgD2Nhj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:39 -0400
From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 02/34] iommu: Add def_domain_type() callback in iommu_ops
Date: Wed, 29 Apr 2020 15:36:40 +0200
Message-Id: <20200429133712.31431-3-joro@8bytes.org>
In-Reply-To: <20200429133712.31431-1-joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Daniel Drake <drake@endlessm.com>, jonathan.derrick@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>, Joerg Roedel <jroedel@suse.de>

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Some devices are reqired to use a specific type (identity or dma)
of default domain when they are used with a vendor iommu. When the
system level default domain type is different from it, the vendor
iommu driver has to request a new default domain with
iommu_request_dma_domain_for_dev() and iommu_request_dm_for_dev()
in the add_dev() callback. Unfortunately, these two helpers only
work when the group hasn't been assigned to any other devices,
hence, some vendor iommu driver has to use a private domain if
it fails to request a new default one.

This adds def_domain_type() callback in the iommu_ops, so that
any special requirement of default domain for a device could be
aware by the iommu generic layer.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
[ jroedel@suse.de: Added iommu_get_def_domain_type() function and use
                   it to allocate the default domain ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 20 +++++++++++++++++---
 include/linux/iommu.h |  6 ++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfe011760ed1..5877abd9b693 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1361,21 +1361,35 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+static int iommu_get_def_domain_type(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	unsigned int type = 0;
+
+	if (ops->def_domain_type)
+		type = ops->def_domain_type(dev);
+
+	return (type == 0) ? iommu_def_domain_type : type;
+}
+
 static int iommu_alloc_default_domain(struct device *dev,
 				      struct iommu_group *group)
 {
 	struct iommu_domain *dom;
+	unsigned int type;
 
 	if (group->default_domain)
 		return 0;
 
-	dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-	if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+	type = iommu_get_def_domain_type(dev);
+
+	dom = __iommu_domain_alloc(dev->bus, type);
+	if (!dom && type != IOMMU_DOMAIN_DMA) {
 		dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 		if (dom) {
 			dev_warn(dev,
 				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-				 iommu_def_domain_type);
+				 type);
 		}
 	}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ef8b0bda695..1f027b07e499 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -248,6 +248,10 @@ struct iommu_iotlb_gather {
  * @cache_invalidate: invalidate translation caches
  * @sva_bind_gpasid: bind guest pasid and mm
  * @sva_unbind_gpasid: unbind guest pasid and mm
+ * @def_domain_type: device default domain type, return value:
+ *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
+ *		- IOMMU_DOMAIN_DMA: must use a dma domain
+ *		- 0: use the default setting
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
@@ -318,6 +322,8 @@ struct iommu_ops {
 
 	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
+	int (*def_domain_type)(struct device *dev);
+
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
-- 
2.17.1
