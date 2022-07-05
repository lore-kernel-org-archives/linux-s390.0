Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D615C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Jul 2022 17:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGERJJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiGERI6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jul 2022 13:08:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A30D1D330;
        Tue,  5 Jul 2022 10:08:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282D51596;
        Tue,  5 Jul 2022 10:08:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 490453F66F;
        Tue,  5 Jul 2022 10:08:54 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] iommu/arm-smmu-v3: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:30 +0100
Message-Id: <d329c45c3e67432d1d10e4a96f8e8eb5424b3eb7.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the probe failure path accordingly.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 +--------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88817a3376ef..8b7936095bec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -28,8 +28,6 @@
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 
-#include <linux/amba/bus.h>
-
 #include "arm-smmu-v3.h"
 #include "../../iommu-sva-lib.h"
 
@@ -3698,43 +3696,6 @@ static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
 		return SZ_128K;
 }
 
-static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
-{
-	int err;
-
-#ifdef CONFIG_PCI
-	if (pci_bus_type.iommu_ops != ops) {
-		err = bus_set_iommu(&pci_bus_type, ops);
-		if (err)
-			return err;
-	}
-#endif
-#ifdef CONFIG_ARM_AMBA
-	if (amba_bustype.iommu_ops != ops) {
-		err = bus_set_iommu(&amba_bustype, ops);
-		if (err)
-			goto err_reset_pci_ops;
-	}
-#endif
-	if (platform_bus_type.iommu_ops != ops) {
-		err = bus_set_iommu(&platform_bus_type, ops);
-		if (err)
-			goto err_reset_amba_ops;
-	}
-
-	return 0;
-
-err_reset_amba_ops:
-#ifdef CONFIG_ARM_AMBA
-	bus_set_iommu(&amba_bustype, NULL);
-#endif
-err_reset_pci_ops: __maybe_unused;
-#ifdef CONFIG_PCI
-	bus_set_iommu(&pci_bus_type, NULL);
-#endif
-	return err;
-}
-
 static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 				      resource_size_t size)
 {
@@ -3840,27 +3801,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_sysfs_remove;
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ret;
 	}
 
-	ret = arm_smmu_set_bus_ops(&arm_smmu_ops);
-	if (ret)
-		goto err_unregister_device;
-
 	return 0;
-
-err_unregister_device:
-	iommu_device_unregister(&smmu->iommu);
-err_sysfs_remove:
-	iommu_device_sysfs_remove(&smmu->iommu);
-	return ret;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	arm_smmu_set_bus_ops(NULL);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
-- 
2.36.1.dirty

