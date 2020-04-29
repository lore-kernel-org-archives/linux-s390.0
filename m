Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 19/34] iommu/s390: Convert to probe/release_device() call-backs
Date: Wed, 29 Apr 2020 15:36:57 +0200
Message-Id: <20200429133712.31431-20-joro@8bytes.org>
In-Reply-To: <20200429133712.31431-1-joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Daniel Drake <drake@endlessm.com>, jonathan.derrick@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

From: Joerg Roedel <jroedel@suse.de>

Convert the S390 IOMMU driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/s390-iommu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 1137f3ddcb85..610f0828f22d 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -166,21 +166,14 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	}
 }
 
-static int s390_iommu_add_device(struct device *dev)
+static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get_for_dev(dev);
 	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
 
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
-	iommu_device_link(&zdev->iommu_dev, dev);
-
-	return 0;
+	return &zdev->iommu_dev;
 }
 
-static void s390_iommu_remove_device(struct device *dev)
+static void s390_iommu_release_device(struct device *dev)
 {
 	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
 	struct iommu_domain *domain;
@@ -191,7 +184,7 @@ static void s390_iommu_remove_device(struct device *dev)
 	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
 	 * the attach_dev), removing the device via
 	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
-	 * only remove_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
+	 * only release_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
 	 * notifier.
 	 *
 	 * So let's call detach_dev from here if it hasn't been called before.
@@ -201,9 +194,6 @@ static void s390_iommu_remove_device(struct device *dev)
 		if (domain)
 			s390_iommu_detach_device(domain, dev);
 	}
-
-	iommu_device_unlink(&zdev->iommu_dev, dev);
-	iommu_group_remove_device(dev);
 }
 
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
@@ -373,8 +363,8 @@ static const struct iommu_ops s390_iommu_ops = {
 	.map = s390_iommu_map,
 	.unmap = s390_iommu_unmap,
 	.iova_to_phys = s390_iommu_iova_to_phys,
-	.add_device = s390_iommu_add_device,
-	.remove_device = s390_iommu_remove_device,
+	.probe_device = s390_iommu_probe_device,
+	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 };
-- 
2.17.1
