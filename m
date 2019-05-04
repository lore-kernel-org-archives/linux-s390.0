Return-Path: <SRS0=l3iw=TE=vger.kernel.org=kvm-owner@kernel.org>
From: Tom Murphy <tmurphy@arista.com>
Subject: [RFC 2/7] iommu/vt-d: Remove iova handling code from non-dma ops path
Date: Sat,  4 May 2019 14:23:18 +0100
Message-Id: <20190504132327.27041-3-tmurphy@arista.com>
In-Reply-To: <20190504132327.27041-1-tmurphy@arista.com>
References: <20190504132327.27041-1-tmurphy@arista.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

There is no reason to keep track of the iovas in the non-dma ops path.
All this code seems to be pointless and can be removed.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/intel-iommu.c | 94 +++++++++++++------------------------
 1 file changed, 33 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2db1dc47e7e4..77895cd89f29 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1846,11 +1846,6 @@ static int dmar_init_reserved_ranges(void)
 	return 0;
 }
 
-static void domain_reserve_special_ranges(struct dmar_domain *domain)
-{
-	copy_reserved_iova(&reserved_iova_list, &domain->iovad);
-}
-
 static inline int guestwidth_to_adjustwidth(int gaw)
 {
 	int agaw;
@@ -1875,7 +1870,8 @@ static void domain_exit(struct dmar_domain *domain)
 	rcu_read_unlock();
 
 	/* destroy iovas */
-	put_iova_domain(&domain->iovad);
+	if (domain->domain.type == IOMMU_DOMAIN_DMA)
+		put_iova_domain(&domain->iovad);
 
 	freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
 
@@ -2554,19 +2550,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
-				     unsigned long long start,
-				     unsigned long long end)
+				     unsigned long first_vpfn,
+				     unsigned long last_vpfn)
 {
-	unsigned long first_vpfn = start >> VTD_PAGE_SHIFT;
-	unsigned long last_vpfn = end >> VTD_PAGE_SHIFT;
-
-	if (!reserve_iova(&domain->iovad, dma_to_mm_pfn(first_vpfn),
-			  dma_to_mm_pfn(last_vpfn))) {
-		pr_err("Reserving iova failed\n");
-		return -ENOMEM;
-	}
-
-	pr_debug("Mapping reserved region %llx-%llx\n", start, end);
 	/*
 	 * RMRR range might have overlap with physical memory range,
 	 * clear it first
@@ -2613,7 +2599,8 @@ static int __init si_domain_init(int hw)
 
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
-					PFN_PHYS(start_pfn), PFN_PHYS(end_pfn));
+					mm_to_dma_pfn(start_pfn),
+					mm_to_dma_pfn(end_pfn));
 			if (ret)
 				return ret;
 		}
@@ -4181,58 +4168,37 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 				       unsigned long val, void *v)
 {
 	struct memory_notify *mhp = v;
-	unsigned long long start, end;
-	unsigned long start_vpfn, last_vpfn;
+	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
+	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
+			mhp->nr_pages - 1);
 
 	switch (val) {
 	case MEM_GOING_ONLINE:
-		start = mhp->start_pfn << PAGE_SHIFT;
-		end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
-		if (iommu_domain_identity_map(si_domain, start, end)) {
-			pr_warn("Failed to build identity map for [%llx-%llx]\n",
-				start, end);
+		if (iommu_domain_identity_map(si_domain, start_vpfn,
+					last_vpfn)) {
+			pr_warn("Failed to build identity map for [%lx-%lx]\n",
+				start_vpfn, last_vpfn);
 			return NOTIFY_BAD;
 		}
 		break;
 
 	case MEM_OFFLINE:
 	case MEM_CANCEL_ONLINE:
-		start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
-		last_vpfn = mm_to_dma_pfn(mhp->start_pfn + mhp->nr_pages - 1);
-		while (start_vpfn <= last_vpfn) {
-			struct iova *iova;
+		{
 			struct dmar_drhd_unit *drhd;
 			struct intel_iommu *iommu;
 			struct page *freelist;
 
-			iova = find_iova(&si_domain->iovad, start_vpfn);
-			if (iova == NULL) {
-				pr_debug("Failed get IOVA for PFN %lx\n",
-					 start_vpfn);
-				break;
-			}
-
-			iova = split_and_remove_iova(&si_domain->iovad, iova,
-						     start_vpfn, last_vpfn);
-			if (iova == NULL) {
-				pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
-					start_vpfn, last_vpfn);
-				return NOTIFY_BAD;
-			}
-
-			freelist = domain_unmap(si_domain, iova->pfn_lo,
-					       iova->pfn_hi);
+			freelist = domain_unmap(si_domain, start_vpfn,
+					last_vpfn);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
 				iommu_flush_iotlb_psi(iommu, si_domain,
-					iova->pfn_lo, iova_size(iova),
+					start_vpfn, mhp->nr_pages,
 					!freelist, 0);
 			rcu_read_unlock();
 			dma_free_pagelist(freelist);
-
-			start_vpfn = iova->pfn_hi + 1;
-			free_iova_mem(iova);
 		}
 		break;
 	}
@@ -4260,8 +4226,9 @@ static void free_all_cpu_cached_iovas(unsigned int cpu)
 		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
 			domain = get_iommu_domain(iommu, (u16)did);
 
-			if (!domain)
+			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
 				continue;
+
 			free_cpu_cached_iovas(cpu, &domain->iovad);
 		}
 	}
@@ -4602,9 +4569,6 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
-	domain_reserve_special_ranges(domain);
-
 	/* calculate AGAW */
 	domain->gaw = guest_width;
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
@@ -4623,6 +4587,18 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
+static void intel_init_iova_domain(struct dmar_domain *dmar_domain)
+{
+	init_iova_domain(&dmar_domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
+	copy_reserved_iova(&reserved_iova_list, &dmar_domain->iovad);
+
+	if (init_iova_flush_queue(&dmar_domain->iovad, iommu_flush_iova,
+				iova_entry_free)) {
+		pr_warn("iova flush queue initialization failed\n");
+		intel_iommu_strict = 1;
+	}
+}
+
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
@@ -4644,12 +4620,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			return NULL;
 		}
 
-		if (type == IOMMU_DOMAIN_DMA &&
-		    init_iova_flush_queue(&dmar_domain->iovad,
-					  iommu_flush_iova, iova_entry_free)) {
-			pr_warn("iova flush queue initialization failed\n");
-			intel_iommu_strict = 1;
-		}
+		if (type == IOMMU_DOMAIN_DMA)
+			intel_init_iova_domain(dmar_domain);
 
 		domain_update_iommu_cap(dmar_domain);
 		domain = &dmar_domain->domain;
-- 
2.17.1
