Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH 8/8] DO NOT MERGE: iommu: disable list appending in dma-iommu
Date: Sat, 21 Dec 2019 15:04:00 +0000
Message-Id: <20191221150402.13868-9-murphyt7@tcd.ie>
In-Reply-To: <20191221150402.13868-1-murphyt7@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <murphyt7@tcd.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marc Zyngier <maz@kernel.org>, Eric Auger <eric.auger@redhat.com>, Julien Grall <julien.grall@arm.com>, Thomas Gleixner <tglx@linutronix.de>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org

ops __finalise_sg

Disable combining sg segments in the dma-iommu api.
Combining the sg segments exposes a bug in the intel i915 driver which
causes visual artifacts and the screen to freeze. This is most likely
because of how the i915 handles the returned list. It probably doesn't
respect the returned value specifying the number of elements in the list
and instead depends on the previous behaviour of the intel iommu driver
which would return the same number of elements in the output list as in
the input list.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cf778db7d84d..d7547b912c87 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -853,8 +853,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 {
 	struct scatterlist *s, *cur = sg;
 	unsigned long seg_mask = dma_get_seg_boundary(dev);
-	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
-	int i, count = 0;
+	int i;
 
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
@@ -862,39 +861,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
 
+		if (i > 0)
+			cur = sg_next(cur);
+
 		s->offset += s_iova_off;
 		s->length = s_length;
-		sg_dma_address(s) = DMA_MAPPING_ERROR;
-		sg_dma_len(s) = 0;
-
-		/*
-		 * Now fill in the real DMA data. If...
-		 * - there is a valid output segment to append to
-		 * - and this segment starts on an IOVA page boundary
-		 * - but doesn't fall at a segment boundary
-		 * - and wouldn't make the resulting output segment too long
-		 */
-		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
-		    (max_len - cur_len >= s_length)) {
-			/* ...then concatenate it with the previous one */
-			cur_len += s_length;
-		} else {
-			/* Otherwise start the next output segment */
-			if (i > 0)
-				cur = sg_next(cur);
-			cur_len = s_length;
-			count++;
-
-			sg_dma_address(cur) = dma_addr + s_iova_off;
-		}
-
-		sg_dma_len(cur) = cur_len;
+		sg_dma_address(cur) = dma_addr + s_iova_off;
+		sg_dma_len(cur) = s_length;
 		dma_addr += s_iova_len;
-
-		if (s_length + s_iova_off < s_iova_len)
-			cur_len = 0;
 	}
-	return count;
+	return nents;
 }
 
 /*
-- 
2.20.1
