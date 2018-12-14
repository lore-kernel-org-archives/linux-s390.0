From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 14 Dec 2018 09:25:14 +0100
Message-ID: <20181214082515.14835-2-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

If we want to map memory from the DMA allocator to userspace it must be
zeroed at allocation time to prevent stale data leaks.   We already do
this on most common architectures, but some architectures don't do this
yet, fix them up, either by passing GFP_ZERO when we use the normal page
allocator or doing a manual memset otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/pci_iommu.c    | 2 +-
 arch/arc/mm/dma.c                | 2 +-
 arch/c6x/mm/dma-coherent.c       | 5 ++++-
 arch/m68k/kernel/dma.c           | 2 +-
 arch/microblaze/mm/consistent.c  | 2 +-
 arch/openrisc/kernel/dma.c       | 2 +-
 arch/parisc/kernel/pci-dma.c     | 4 ++--
 arch/s390/pci/pci_dma.c          | 2 +-
 arch/sparc/kernel/ioport.c       | 2 +-
 arch/sparc/mm/io-unit.c          | 2 +-
 arch/sparc/mm/iommu.c            | 2 +-
 arch/xtensa/kernel/pci-dma.c     | 2 +-
 drivers/misc/mic/host/mic_boot.c | 2 +-
 kernel/dma/virt.c                | 2 +-
 14 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index e1716e0d92fd..28a025eda80d 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -443,7 +443,7 @@ static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
 	gfp &= ~GFP_DMA;
 
 try_again:
-	cpu_addr = (void *)__get_free_pages(gfp, order);
+	cpu_addr = (void *)__get_free_pages(gfp | GFP_ZERO, order);
 	if (! cpu_addr) {
 		printk(KERN_INFO "pci_alloc_consistent: "
 		       "get_free_pages failed from %pf\n",
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index db203ff69ccf..b0754581efc6 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -33,7 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 */
 	BUG_ON(gfp & __GFP_HIGHMEM);
 
-	page = alloc_pages(gfp, order);
+	page = alloc_pages(gfp | GFP_ZERO, order);
 	if (!page)
 		return NULL;
 
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
index 01305c787201..75b79571732c 100644
--- a/arch/c6x/mm/dma-coherent.c
+++ b/arch/c6x/mm/dma-coherent.c
@@ -78,6 +78,7 @@ static void __free_dma_pages(u32 addr, int order)
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		gfp_t gfp, unsigned long attrs)
 {
+	void *ret;
 	u32 paddr;
 	int order;
 
@@ -94,7 +95,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (!paddr)
 		return NULL;
 
-	return phys_to_virt(paddr);
+	ret = phys_to_virt(paddr);
+	memset(ret, 0, 1 << order);
+	return ret;
 }
 
 /*
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index e99993c57d6b..dafe99d08a6a 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -32,7 +32,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	page = alloc_pages(flag, order);
+	page = alloc_pages(flag | GFP_ZERO, order);
 	if (!page)
 		return NULL;
 
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index 45e0a1aa9357..79b9f4695a1b 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -81,7 +81,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	vaddr = __get_free_pages(gfp, order);
+	vaddr = __get_free_pages(gfp | GFP_ZERO, order);
 	if (!vaddr)
 		return NULL;
 
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 159336adfa2f..cdd03f63207c 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -89,7 +89,7 @@ arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		.mm = &init_mm
 	};
 
-	page = alloc_pages_exact(size, gfp);
+	page = alloc_pages_exact(size, gfp | GFP_ZERO);
 	if (!page)
 		return NULL;
 
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 04c48f1ef3fb..7fa396714b5a 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -404,7 +404,7 @@ static void *pcxl_dma_alloc(struct device *dev, size_t size,
 	order = get_order(size);
 	size = 1 << (order + PAGE_SHIFT);
 	vaddr = pcxl_alloc_range(size);
-	paddr = __get_free_pages(flag, order);
+	paddr = __get_free_pages(flag | GFP_ZERO, order);
 	flush_kernel_dcache_range(paddr, size);
 	paddr = __pa(paddr);
 	map_uncached_pages(vaddr, size, paddr);
@@ -429,7 +429,7 @@ static void *pcx_dma_alloc(struct device *dev, size_t size,
 	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0)
 		return NULL;
 
-	addr = (void *)__get_free_pages(flag, get_order(size));
+	addr = (void *)__get_free_pages(flag | GFP_ZERO, get_order(size));
 	if (addr)
 		*dma_handle = (dma_addr_t)virt_to_phys(addr);
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 346ba382193a..2578d9567d86 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -404,7 +404,7 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t map;
 
 	size = PAGE_ALIGN(size);
-	page = alloc_pages(flag, get_order(size));
+	page = alloc_pages(flag | GFP_ZERO, get_order(size));
 	if (!page)
 		return NULL;
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index baa235652c27..b3a0c5adeed5 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -325,7 +325,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return NULL;
 
 	size = PAGE_ALIGN(size);
-	va = (void *) __get_free_pages(gfp, get_order(size));
+	va = (void *) __get_free_pages(gfp | GFP_ZERO, get_order(size));
 	if (!va) {
 		printk("%s: no %zd pages\n", __func__, size >> PAGE_SHIFT);
 		return NULL;
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 2088d292c6e5..d1729c8b0bf9 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -225,7 +225,7 @@ static void *iounit_alloc(struct device *dev, size_t len,
 		return NULL;
 
 	len = PAGE_ALIGN(len);
-	va = __get_free_pages(gfp, get_order(len));
+	va = __get_free_pages(gfp | GFP_ZERO, get_order(len));
 	if (!va)
 		return NULL;
 
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 3599485717e7..25c83078ece7 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -347,7 +347,7 @@ static void *sbus_iommu_alloc(struct device *dev, size_t len,
 		return NULL;
 
 	len = PAGE_ALIGN(len);
-	va = __get_free_pages(gfp, get_order(len));
+	va = __get_free_pages(gfp | GFP_ZERO, get_order(len));
 	if (va == 0)
 		return NULL;
 
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 1fc138b6bc0a..e9fbec5f6ec2 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -160,7 +160,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 						 flag & __GFP_NOWARN);
 
 	if (!page)
-		page = alloc_pages(flag, get_order(size));
+		page = alloc_pages(flag | GFP_ZERO, get_order(size));
 
 	if (!page)
 		return NULL;
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index c327985c9523..7e5bd8654fd4 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -149,7 +149,7 @@ static void *__mic_dma_alloc(struct device *dev, size_t size,
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
 	dma_addr_t tmp;
-	void *va = kmalloc(size, gfp);
+	void *va = kmalloc(size, gfp | GFP_ZERO);
 
 	if (va) {
 		tmp = mic_map_single(mdev, va, size);
diff --git a/kernel/dma/virt.c b/kernel/dma/virt.c
index 631ddec4b60a..f80990f882a6 100644
--- a/kernel/dma/virt.c
+++ b/kernel/dma/virt.c
@@ -13,7 +13,7 @@ static void *dma_virt_alloc(struct device *dev, size_t size,
 {
 	void *ret;
 
-	ret = (void *)__get_free_pages(gfp, get_order(size));
+	ret = (void *)__get_free_pages(gfp | GFP_ZERO, get_order(size));
 	if (ret)
 		*dma_handle = (uintptr_t)ret;
 	return ret;
-- 
2.19.2
