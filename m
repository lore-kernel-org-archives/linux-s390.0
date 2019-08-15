Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33082 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbfHOLKZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Aug 2019 07:10:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id go14so667178plb.0
        for <linux-s390@vger.kernel.org>; Thu, 15 Aug 2019 04:10:25 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH V5 1/5] iommu/amd: Remove unnecessary locking from AMD iommu driver
Date: Thu, 15 Aug 2019 12:09:39 +0100
Message-Id: <20190815110944.3579-2-murphyt7@tcd.ie>
In-Reply-To: <20190815110944.3579-1-murphyt7@tcd.ie>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org

We can remove the mutex lock from amd_iommu_map and amd_iommu_unmap.
iommu_map doesn’t lock while mapping and so no two calls should touch
the same iova range. The AMD driver already handles the page table page
allocations without locks so we can safely remove the locks.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/amd_iommu.c       | 10 +---------
 drivers/iommu/amd_iommu_types.h |  1 -
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 008da21a2592..1948be7ac8f8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2858,7 +2858,6 @@ static void protection_domain_free(struct protection_domain *domain)
 static int protection_domain_init(struct protection_domain *domain)
 {
 	spin_lock_init(&domain->lock);
-	mutex_init(&domain->api_lock);
 	domain->id = domain_id_alloc();
 	if (!domain->id)
 		return -ENOMEM;
@@ -3045,9 +3044,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	mutex_lock(&domain->api_lock);
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
-	mutex_unlock(&domain->api_lock);
 
 	domain_flush_np_cache(domain, iova, page_size);
 
@@ -3058,16 +3055,11 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			   size_t page_size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	size_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return 0;
 
-	mutex_lock(&domain->api_lock);
-	unmap_size = iommu_unmap_page(domain, iova, page_size);
-	mutex_unlock(&domain->api_lock);
-
-	return unmap_size;
+	return iommu_unmap_page(domain, iova, page_size);
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 9ac229e92b07..b764e1a73dcf 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -468,7 +468,6 @@ struct protection_domain {
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
 	spinlock_t lock;	/* mostly used to lock the page table*/
-	struct mutex api_lock;	/* protect page tables in the iommu-api path */
 	u16 id;			/* the domain id written to the device table */
 	int mode;		/* paging mode (0-6 levels) */
 	u64 *pt_root;		/* page table root pointer */
-- 
2.20.1
