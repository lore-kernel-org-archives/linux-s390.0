Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36948 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgDIOJm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 10:09:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200409140940euoutp01f8f93b34ce71ca1c30e2ed94c10ff845~ELAe-58xm2412424124euoutp011
        for <linux-s390@vger.kernel.org>; Thu,  9 Apr 2020 14:09:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Rework intialization
Date: Thu,  9 Apr 2020 16:09:28 +0200
Message-Id: <20200409140928.1403-1-m.szyprowski@samsung.com>
In-Reply-To: <40af831b-d00c-0cf9-0a06-e60c048a9ab8@samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <40af831b-d00c-0cf9-0a06-e60c048a9ab8@samsung.com>
        <CGME20200409140939eucas1p190daac74c0d5dda4627314c49c1a5b50@eucas1p1.samsung.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

Fix initialization after driver conversion to
probe_device()/release_device(). Prepared on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 80 +++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index f865c90..53c784f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -565,6 +565,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 }
 
 static const struct iommu_ops exynos_iommu_ops;
+static int exynos_iommu_initialize_owner(struct device *sysmmu);
 
 static int exynos_sysmmu_probe(struct platform_device *pdev)
 {
@@ -573,6 +574,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	struct sysmmu_drvdata *data;
 	struct resource *res;
 
+	dev_info(dev, "%s %d\n", __func__, __LINE__);
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -649,6 +652,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	exynos_iommu_initialize_owner(dev);
+
 	return 0;
 }
 
@@ -1225,24 +1230,8 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 
 static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
-
-	if (!has_sysmmu(dev))
-		return ERR_PTR(-ENODEV);
-
-	list_for_each_entry(data, &owner->controllers, owner_node) {
-		/*
-		 * SYSMMU will be runtime activated via device link
-		 * (dependency) to its master device, so there are no
-		 * direct calls to pm_runtime_get/put in this driver.
-		 */
-		data->link = device_link_add(dev, data->sysmmu,
-					     DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME);
-	}
-
-	return &owner->iommu;
+	/* this is called too early on ARM 32bit to do anything usefull */
+	return ERR_PTR(-ENODEV);
 }
 
 static void exynos_iommu_release_device(struct device *dev)
@@ -1268,7 +1257,8 @@ static void exynos_iommu_release_device(struct device *dev)
 		device_link_del(data->link);
 }
 
-static int exynos_iommu_device_init(struct exynos_iommu_owner *owner)
+static int exynos_iommu_device_init(struct device *dev,
+				    struct exynos_iommu_owner *owner)
 {
 	static u32 counter = 0;
 	int ret;
@@ -1287,6 +1277,12 @@ static int exynos_iommu_device_init(struct exynos_iommu_owner *owner)
 
 	iommu_device_set_ops(&owner->iommu, &exynos_iommu_ops);
 
+	/*
+	 * the above iommu_device_set_ops is not enough, initializing fwspec
+	 * is also required
+	 */
+	iommu_fwspec_init(dev, &dev->of_node->fwnode, &exynos_iommu_ops);
+
 	return 0;
 }
 
@@ -1308,7 +1304,7 @@ static int exynos_owner_init(struct device *dev)
 	if (!owner)
 		return -ENOMEM;
 
-	ret = exynos_iommu_device_init(owner);
+	ret = exynos_iommu_device_init(dev, owner);
 	if (ret)
 		goto out_free_owner;
 
@@ -1330,34 +1326,51 @@ static int exynos_owner_init(struct device *dev)
 	return ret;
 }
 
-static int exynos_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *spec)
+static int exynos_iommu_dev_match_owner(struct device *dev, const void *data)
+{
+	const struct device *sysmmu = data;
+	struct device_node *np;
+	int idx = 0;
+
+	do {
+		np = of_parse_phandle(dev->of_node, "iommus", idx++);
+		if (np == sysmmu->of_node)
+			return true;
+	} while (np);
+
+	return false;
+}
+
+static int exynos_iommu_initialize_owner(struct device *sysmmu)
 {
-	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
-	struct sysmmu_drvdata *data, *entry;
+	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
 	struct exynos_iommu_owner *owner;
+	struct device *dev;
 	int ret;
 
-	if (!sysmmu)
+	dev = bus_find_device(&platform_bus_type, NULL, sysmmu,
+			      exynos_iommu_dev_match_owner);
+	if (!dev)
 		return -ENODEV;
 
-	data = platform_get_drvdata(sysmmu);
-	if (!data)
-		return -ENODEV;
+	dev_info(sysmmu, "found master device %s\n", dev_name(dev));
 
 	ret = exynos_owner_init(dev);
 	if (ret)
 		return ret;
 
 	owner = dev->archdata.iommu;
-
-	list_for_each_entry(entry, &owner->controllers, owner_node)
-		if (entry == data)
-			return 0;
-
 	list_add_tail(&data->owner_node, &owner->controllers);
 	data->master = dev;
 
+	/*
+	 * SYSMMU will be runtime activated via device link
+	 * (dependency) to its master device, so there are no
+	 * direct calls to pm_runtime_get/put in this driver.
+	 */
+	data->link = device_link_add(dev, data->sysmmu,
+				     DL_FLAG_STATELESS |
+				     DL_FLAG_PM_RUNTIME);
 	return 0;
 }
 
@@ -1373,7 +1386,6 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	.probe_device = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-	.of_xlate = exynos_iommu_of_xlate,
 };
 
 static int __init exynos_iommu_init(void)
-- 
1.9.1
