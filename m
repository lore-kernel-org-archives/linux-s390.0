Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:35508 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502907AbgDNNQJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Apr 2020 09:16:09 -0400
From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 24/33] iommu/qcom: Convert to probe/release_device() call-backs
Date: Tue, 14 Apr 2020 15:15:33 +0200
Message-Id: <20200414131542.25608-25-joro@8bytes.org>
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

From: Joerg Roedel <jroedel@suse.de>

Convert the QCOM IOMMU driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/qcom_iommu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 0e2a96467767..054e476ebd49 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -524,14 +524,13 @@ static bool qcom_iommu_capable(enum iommu_cap cap)
 	}
 }
 
-static int qcom_iommu_add_device(struct device *dev)
+static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
-	struct iommu_group *group;
 	struct device_link *link;
 
 	if (!qcom_iommu)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * Establish the link between iommu and master, so that the
@@ -542,28 +541,19 @@ static int qcom_iommu_add_device(struct device *dev)
 	if (!link) {
 		dev_err(qcom_iommu->dev, "Unable to create device link between %s and %s\n",
 			dev_name(qcom_iommu->dev), dev_name(dev));
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
-	iommu_device_link(&qcom_iommu->iommu, dev);
-
-	return 0;
+	return &qcom_iommu->iommu;
 }
 
-static void qcom_iommu_remove_device(struct device *dev)
+static void qcom_iommu_release_device(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
 
 	if (!qcom_iommu)
 		return;
 
-	iommu_device_unlink(&qcom_iommu->iommu, dev);
-	iommu_group_remove_device(dev);
 	iommu_fwspec_free(dev);
 }
 
@@ -619,8 +609,8 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 	.iotlb_sync	= qcom_iommu_iotlb_sync,
 	.iova_to_phys	= qcom_iommu_iova_to_phys,
-	.add_device	= qcom_iommu_add_device,
-	.remove_device	= qcom_iommu_remove_device,
+	.probe_device	= qcom_iommu_probe_device,
+	.release_device	= qcom_iommu_release_device,
 	.device_group	= generic_device_group,
 	.of_xlate	= qcom_iommu_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
-- 
2.17.1
