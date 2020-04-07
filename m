Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH 17/34] iommu/arm-smmu: Store device instead of group in arm_smmu_s2cr
Date: Tue,  7 Apr 2020 20:37:25 +0200
Message-Id: <20200407183742.4344-18-joro@8bytes.org>
In-Reply-To: <20200407183742.4344-1-joro@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

From: Joerg Roedel <jroedel@suse.de>

This is required to convert the arm-smmu driver to the
probe/release_device() interface.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a6a5796e9c41..3493501d8b2c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
 struct arm_smmu_s2cr {
-	struct iommu_group		*group;
+	struct device			*dev;
 	int				count;
 	enum arm_smmu_s2cr_type		type;
 	enum arm_smmu_s2cr_privcfg	privcfg;
@@ -1100,7 +1100,7 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	/* It worked! Now, poke the actual hardware */
 	for_each_cfg_sme(cfg, fwspec, i, idx) {
 		arm_smmu_write_sme(smmu, idx);
-		smmu->s2crs[idx].group = group;
+		smmu->s2crs[idx].dev = dev;
 	}
 
 	mutex_unlock(&smmu->stream_map_mutex);
@@ -1495,11 +1495,15 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	int i, idx;
 
 	for_each_cfg_sme(cfg, fwspec, i, idx) {
-		if (group && smmu->s2crs[idx].group &&
-		    group != smmu->s2crs[idx].group)
+		struct iommu_group *idx_grp = NULL;
+
+		if (smmu->s2crs[idx].dev)
+			idx_grp = smmu->s2crs[idx].dev->iommu_group;
+
+		if (group && idx_grp && group != idx_grp)
 			return ERR_PTR(-EINVAL);
 
-		group = smmu->s2crs[idx].group;
+		group = idx_grp;
 	}
 
 	if (group)
-- 
2.17.1
