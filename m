Return-Path: <SRS0=fZwd=TA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH v2 2/4] iommu/dma-iommu: Handle deferred devices
Date: Tue, 30 Apr 2019 01:29:49 +0100
Message-Id: <20190430002952.18909-3-tmurphy@arista.com>
In-Reply-To: <20190430002952.18909-1-tmurphy@arista.com>
References: <20190430002952.18909-1-tmurphy@arista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: iommu@lists.linux-foundation.org
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Tom Murphy <tmurphy@arista.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, murphyt7@tcd.ie, Rob Clark <robdclark@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Handle devices which defer their attach to the iommu in the dma-iommu api

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a96c2c8f56b..c18f74ad1e8b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -322,6 +322,17 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
+static int handle_deferred_device(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_ops *ops = domain->ops;
+
+	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
+		return iommu_attach_device(domain, dev);
+
+	return 0;
+}
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
@@ -835,6 +846,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	bool coherent = dev_is_dma_coherent(dev);
 	dma_addr_t dma_handle;
 
+	handle_deferred_device(dev);
+
 	dma_handle =__iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, coherent, attrs),
 			iommu_get_dma_domain(dev));
@@ -849,6 +862,8 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 
+	handle_deferred_device(dev);
+
 	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		phys_addr_t phys = iommu_iova_to_phys(domain, dma_handle);
 
@@ -873,6 +888,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
 	int i, count = 0;
 
+	handle_deferred_device(dev);
+
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
 		unsigned int s_iova_off = sg_dma_address(s);
@@ -1022,6 +1039,8 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
+	handle_deferred_device(dev);
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
@@ -1042,6 +1061,8 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	handle_deferred_device(dev);
+
 	return __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
 			iommu_get_dma_domain(dev));
@@ -1050,12 +1071,15 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	handle_deferred_device(dev);
+
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	handle_deferred_device(dev);
 	gfp |= __GFP_ZERO;
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
@@ -1076,6 +1100,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 {
 	struct page *page;
 
+	handle_deferred_device(dev);
+
 	/*
 	 * cpu_addr can be one of 4 things depending on how it was allocated:
 	 *
@@ -1115,6 +1141,8 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn;
 	int ret;
 
+	handle_deferred_device(dev);
+
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
@@ -1143,6 +1171,8 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
+	handle_deferred_device(dev);
+
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
