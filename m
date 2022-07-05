Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A6C43334
	for <linux-s390@archiver.kernel.org>; Tue,  5 Jul 2022 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiGERI4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiGERIz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jul 2022 13:08:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8233A1D330;
        Tue,  5 Jul 2022 10:08:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A061570;
        Tue,  5 Jul 2022 10:08:52 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C29783F66F;
        Tue,  5 Jul 2022 10:08:50 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/15] iommu/amd: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:28 +0100
Message-Id: <349787b2ce27eb7ca5d39cec4e652997dd0bbccf.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary, and
garbage-collect the last remnants of amd_iommu_init_api().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change

 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      |  9 +--------
 drivers/iommu/amd/iommu.c     | 21 ---------------------
 3 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..384393ce57fb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -18,7 +18,6 @@ extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
-extern int amd_iommu_init_api(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1d08f87e734b..9bd63511173f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1969,20 +1969,13 @@ static int __init amd_iommu_init_pci(void)
 	/*
 	 * Order is important here to make sure any unity map requirements are
 	 * fulfilled. The unity mappings are created and written to the device
-	 * table during the amd_iommu_init_api() call.
+	 * table during the iommu_init_pci() call.
 	 *
 	 * After that we call init_device_table_dma() to make sure any
 	 * uninitialized DTE will block DMA, and in the end we flush the caches
 	 * of all IOMMUs to make sure the changes to the device table are
 	 * active.
 	 */
-	ret = amd_iommu_init_api();
-	if (ret) {
-		pr_err("IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n",
-		       ret);
-		goto out;
-	}
-
 	init_device_table_dma();
 
 	for_each_iommu(iommu)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2f8e8f818a6c..e67141bb255f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -11,8 +11,6 @@
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
-#include <linux/amba/bus.h>
-#include <linux/platform_device.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -1842,25 +1840,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_domain_flush_complete(domain);
 }
 
-int __init amd_iommu_init_api(void)
-{
-	int err;
-
-	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
-	if (err)
-		return err;
-#ifdef CONFIG_ARM_AMBA
-	err = bus_set_iommu(&amba_bustype, &amd_iommu_ops);
-	if (err)
-		return err;
-#endif
-	err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
-	if (err)
-		return err;
-
-	return 0;
-}
-
 /*****************************************************************************
  *
  * The following functions belong to the exported interface of AMD IOMMU
-- 
2.36.1.dirty

