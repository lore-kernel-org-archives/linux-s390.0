Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:34942 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502877AbgDNNQB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Apr 2020 09:16:01 -0400
From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 05/33] iommu/amd: Remove dma_mask check from check_device()
Date: Tue, 14 Apr 2020 15:15:14 +0200
Message-Id: <20200414131542.25608-6-joro@8bytes.org>
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

From: Joerg Roedel <jroedel@suse.de>

The check was only needed for the DMA-API implementation in the AMD
IOMMU driver, which no longer exists.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 73b4f84cf449..504f2db75eda 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -326,7 +326,7 @@ static bool check_device(struct device *dev)
 {
 	int devid;
 
-	if (!dev || !dev->dma_mask)
+	if (!dev)
 		return false;
 
 	devid = get_device_id(dev);
-- 
2.17.1
