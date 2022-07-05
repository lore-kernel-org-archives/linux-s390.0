Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C92ACCA47B
	for <linux-s390@archiver.kernel.org>; Tue,  5 Jul 2022 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiGERIt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiGERIs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jul 2022 13:08:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44E681BE97;
        Tue,  5 Jul 2022 10:08:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605E61576;
        Tue,  5 Jul 2022 10:08:47 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 781B03F66F;
        Tue,  5 Jul 2022 10:08:45 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] iommu/amd: Handle race between registration and device probe
Date:   Tue,  5 Jul 2022 18:08:25 +0100
Message-Id: <e56c8da801ff5757d14a97c4b49c28e43f449c14.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

As for the Intel driver, make sure the AMD driver can cope with seeing
.probe_device calls without having to wait for all known instances to
register first.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: New

 drivers/iommu/amd/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 840831d5d2ad..2f8e8f818a6c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1757,6 +1757,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	devid = get_device_id(dev);
 	iommu = amd_iommu_rlookup_table[devid];
 
+	/* Not registered yet? */
+	if (!iommu->iommu.ops)
+		return ERR_PTR(-ENODEV);
+
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-- 
2.36.1.dirty

