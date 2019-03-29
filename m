From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/1] iommu: Add config option to set lazy mode as default
Date: Fri, 29 Mar 2019 10:54:23 +0800
Message-ID: <20190329025423.15484-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, S390 <linux-s390@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

This allows the default behaviour to be controlled by a kernel config
option instead of changing the command line for the kernel to include
"iommu.strict=0" on ARM64 where this is desired.

This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/s390/pci/pci_dma.c        |  4 ++++
 drivers/iommu/Kconfig          | 15 +++++++++++++++
 drivers/iommu/amd_iommu_init.c |  6 +++++-
 drivers/iommu/intel-iommu.c    |  4 ++++
 drivers/iommu/iommu.c          |  5 +++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9e52d1527f71495..d05e8c3820793c5 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -17,7 +17,11 @@
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
+#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
 static int s390_iommu_strict;
+#else
+static int s390_iommu_strict = 1;
+#endif
 
 static int zpci_refresh_global(struct zpci_dev *zdev)
 {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816c64..ed5206a2d316599 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -85,6 +85,21 @@ config IOMMU_DEFAULT_PASSTHROUGH
 
 	  If unsure, say N here.
 
+config IOMMU_DMA_DEFAULT_LAZY_MODE
+	bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
+	depends on IOMMU_API
+	default y
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused. Removing the need to pass in kernel parameters through
+	  command line. For example, iommu.strict=0 on ARM64. If this is
+	  enabled, you can still disable with kernel parameters, such as
+	  iommu.strict=1 depending on the architecture.
+
+	  If unsure, say N here.
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f773792d77fd533..a30805c2f77199c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -166,7 +166,11 @@ struct ivmd_header {
 					   to handle */
 LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
 					   we find in ACPI */
-bool amd_iommu_unmap_flush;		/* if true, flush on every unmap */
+#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
+bool amd_iommu_unmap_flush;
+#else
+bool amd_iommu_unmap_flush = true;	/* flush on every unmap */
+#endif
 
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713d728ceef..560191a9342b2b8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -362,7 +362,11 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 
 static int dmar_map_gfx = 1;
 static int dmar_forcedac;
+#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
 static int intel_iommu_strict;
+#else
+static int intel_iommu_strict = 1;
+#endif
 static int intel_iommu_superpage = 1;
 static int intel_iommu_sm;
 static int iommu_identity_mapping;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716369..5acb98e79b5b32d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,7 +43,12 @@
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
+
+#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
+static bool iommu_dma_strict __read_mostly;
+#else
 static bool iommu_dma_strict __read_mostly = true;
+#endif
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
-- 
1.8.3
