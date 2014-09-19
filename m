From: frank.blaschka@de.ibm.com
Subject: [RFC patch 2/6] iommu: add iommu for s390 platform
Date: Fri, 19 Sep 2014 13:54:31 +0200
Message-ID: <20140919115940.138250030@de.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=006-s390_iommu-3.16.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Add a basic iommu for the s390 platform. The code is pretty
simple since on s390 each PCI device has its own virtual io address
space starting at the same vio address. For this a domain could
hold only one pci device. Also there is no relation between pci
devices so each device belongs to a separate iommu group.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/include/asm/pci.h |    3 
 arch/s390/pci/pci_dma.c     |   21 ++++-
 drivers/iommu/Kconfig       |    9 ++
 drivers/iommu/Makefile      |    1 
 drivers/iommu/s390-iommu.c  |  181 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -177,6 +177,9 @@ struct zpci_dev *get_zdev_by_fid(u32);
 /* DMA */
 int zpci_dma_init(void);
 void zpci_dma_exit(void);
+int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
+		     dma_addr_t dma_addr, size_t size, int flags);
+void dma_purge_rto_entries(struct zpci_dev *zdev);
 
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -139,8 +139,8 @@ static void dma_update_cpu_trans(struct
 		entry_clr_protected(entry);
 }
 
-static int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
-			    dma_addr_t dma_addr, size_t size, int flags)
+int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
+		     dma_addr_t dma_addr, size_t size, int flags)
 {
 	unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	u8 *page_addr = (u8 *) (pa & PAGE_MASK);
@@ -180,6 +180,7 @@ no_refresh:
 	spin_unlock_irqrestore(&zdev->dma_table_lock, irq_flags);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(dma_update_trans);
 
 static void dma_free_seg_table(unsigned long entry)
 {
@@ -210,6 +211,22 @@ static void dma_cleanup_tables(struct zp
 	zdev->dma_table = NULL;
 }
 
+void dma_purge_rto_entries(struct zpci_dev *zdev)
+{
+	unsigned long *table;
+	int rtx;
+
+	if (!zdev || !zdev->dma_table)
+		return;
+	table = zdev->dma_table;
+	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
+		if (reg_entry_isvalid(table[rtx])) {
+			dma_free_seg_table(table[rtx]);
+			invalidate_table_entry(&table[rtx]);
+		}
+}
+EXPORT_SYMBOL_GPL(dma_purge_rto_entries);
+
 static unsigned long __dma_alloc_iommu(struct zpci_dev *zdev,
 				       unsigned long start, int size)
 {
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -302,4 +302,13 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config S390_IOMMU
+        bool "s390 IOMMU Support"
+        depends on S390
+        select IOMMU_API
+        help
+          Support for the IBM s/390 IOMMU
+
+          If unsure, say N here.
+
 endif # IOMMU_SUPPORT
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iom
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
+obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
--- /dev/null
+++ b/drivers/iommu/s390-iommu.c
@@ -0,0 +1,181 @@
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <linux/iommu.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/memblock.h>
+#include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/sizes.h>
+#include <asm/pci_dma.h>
+
+#define S390_IOMMU_PGSIZES SZ_4K
+
+struct s390_domain {
+	struct zpci_dev *zdev;
+};
+
+static int s390_iommu_domain_init(struct iommu_domain *domain)
+{
+	struct s390_domain *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	domain->priv = priv;
+	return 0;
+}
+
+static void s390_iommu_domain_destroy(struct iommu_domain *domain)
+{
+	kfree(domain->priv);
+	domain->priv = NULL;
+}
+
+static int s390_iommu_attach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct s390_domain *priv = domain->priv;
+
+	if (priv->zdev)
+		return -EEXIST;
+
+	priv->zdev = (struct zpci_dev *)to_pci_dev(dev)->sysdata;
+	return 0;
+}
+
+static void s390_iommu_detach_device(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	struct s390_domain *priv = domain->priv;
+
+	dma_purge_rto_entries(priv->zdev);
+	priv->zdev = NULL;
+}
+
+static int s390_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot)
+{
+	struct s390_domain *priv = domain->priv;
+	int flags = 0;
+	int rc;
+
+	if (!priv->zdev)
+		return -ENODEV;
+
+	/* if (read only) flags |= ZPCI_TABLE_PROTECTED; */
+	rc = dma_update_trans(priv->zdev, (unsigned long)paddr, iova, size,
+			      flags);
+
+	return rc;
+}
+
+static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct s390_domain *priv = domain->priv;
+	phys_addr_t phys = 0;
+	unsigned long *sto, *pto, *rto;
+	unsigned int rtx, sx, px;
+
+	if (!priv->zdev)
+		return -ENODEV;
+
+	rtx = calc_rtx(iova);
+	sx = calc_sx(iova);
+	px = calc_px(iova);
+	rto = priv->zdev->dma_table;
+
+	if (reg_entry_isvalid(rto[rtx])) {
+		sto = get_rt_sto(rto[rtx]);
+		if (reg_entry_isvalid(sto[sx])) {
+			pto = get_st_pto(sto[sx]);
+			if ((pto[px] & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)
+				phys = pto[px] & ZPCI_PTE_ADDR_MASK;
+		}
+	}
+
+	return phys;
+}
+
+static size_t s390_iommu_unmap(struct iommu_domain *domain,
+			       unsigned long iova, size_t size)
+{
+	struct s390_domain *priv = domain->priv;
+	int flags = ZPCI_PTE_INVALID;
+	phys_addr_t paddr;
+	int rc;
+
+	if (!priv->zdev)
+		goto out;
+
+	paddr = s390_iommu_iova_to_phys(domain, iova);
+	if (!paddr)
+		goto out;
+
+	rc = dma_update_trans(priv->zdev, (unsigned long)paddr, iova, size,
+			      flags);
+out:
+	return size;
+}
+
+static int s390_iommu_domain_has_cap(struct iommu_domain *domain,
+				     unsigned long cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return 1;
+	case IOMMU_CAP_INTR_REMAP:
+		return 1;
+	}
+
+	return 0;
+}
+
+static int s390_iommu_add_device(struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_alloc();
+	if (IS_ERR(group)) {
+		dev_err(dev, "Failed to allocate IOMMU group\n");
+		return PTR_ERR(group);
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	return ret;
+}
+
+static void s390_iommu_remove_device(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
+static struct iommu_ops s390_iommu_ops = {
+	.domain_init = s390_iommu_domain_init,
+	.domain_destroy = s390_iommu_domain_destroy,
+	.attach_dev = s390_iommu_attach_device,
+	.detach_dev = s390_iommu_detach_device,
+	.map = s390_iommu_map,
+	.unmap = s390_iommu_unmap,
+	.iova_to_phys = s390_iommu_iova_to_phys,
+	.domain_has_cap = s390_iommu_domain_has_cap,
+	.add_device = s390_iommu_add_device,
+	.remove_device = s390_iommu_remove_device,
+	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+};
+
+static int __init s390_iommu_init(void)
+{
+	bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
+	return 0;
+}
+subsys_initcall(s390_iommu_init);
