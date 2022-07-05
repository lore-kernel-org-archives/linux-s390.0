Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D28C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Jul 2022 17:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiGERJQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiGERJM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jul 2022 13:09:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB561F2C0;
        Tue,  5 Jul 2022 10:08:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC9841576;
        Tue,  5 Jul 2022 10:08:59 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C44503F66F;
        Tue,  5 Jul 2022 10:08:57 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] iommu/exynos: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:32 +0100
Message-Id: <364a8eb027398bb25a925fbe9bb14fe4dda757cb.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the init failure path accordingly.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change

 drivers/iommu/exynos-iommu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71f2018e23fe..359b255b3924 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1356,16 +1356,7 @@ static int __init exynos_iommu_init(void)
 		goto err_zero_lv2;
 	}
 
-	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
-	if (ret) {
-		pr_err("%s: Failed to register exynos-iommu driver.\n",
-								__func__);
-		goto err_set_iommu;
-	}
-
 	return 0;
-err_set_iommu:
-	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
 err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
-- 
2.36.1.dirty

