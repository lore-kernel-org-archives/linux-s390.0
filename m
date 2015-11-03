From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/3] s390/dma: Allow per device dma ops
Date: Tue,  3 Nov 2015 12:54:39 +0100
Message-ID: <1446551679-33492-4-git-send-email-borntraeger@de.ibm.com>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As virtio-ccw now has dma ops, we can no longer default to the PCI ones.
Make use of dev_archdata to keep the dma_ops per device. The pci devices
now use that to override the default, and the default is changed to use
the noop ops for everything that is not PCI. To compile without PCI
support we also have to enable the DMA api with virtio.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 arch/s390/Kconfig                   | 3 ++-
 arch/s390/include/asm/device.h      | 6 +++++-
 arch/s390/include/asm/dma-mapping.h | 6 ++++--
 arch/s390/pci/pci.c                 | 1 +
 arch/s390/pci/pci_dma.c             | 4 ++--
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1d57000..04f0e02 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -113,6 +113,7 @@ config S390
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select HAS_DMA
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_EARLY_PFN_TO_NID
@@ -124,6 +125,7 @@ config S390
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DMA_ATTRS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FTRACE_MCOUNT_RECORD
@@ -580,7 +582,6 @@ config QDIO
 
 menuconfig PCI
 	bool "PCI support"
-	select HAVE_DMA_ATTRS
 	select PCI_MSI
 	help
 	  Enable PCI support.
diff --git a/arch/s390/include/asm/device.h b/arch/s390/include/asm/device.h
index d8f9872..4a9f35e 100644
--- a/arch/s390/include/asm/device.h
+++ b/arch/s390/include/asm/device.h
@@ -3,5 +3,9 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+struct dev_archdata {
+	struct dma_map_ops *dma_ops;
+};
 
+struct pdev_archdata {
+};
diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index b3fd54d..cb05f5c 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -11,11 +11,13 @@
 
 #define DMA_ERROR_CODE		(~(dma_addr_t) 0x0)
 
-extern struct dma_map_ops s390_dma_ops;
+extern struct dma_map_ops s390_pci_dma_ops;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	return &s390_dma_ops;
+	if (dev && dev->archdata.dma_ops)
+		return dev->archdata.dma_ops;
+	return &dma_noop_ops;
 }
 
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 7ef12a3..fa41605 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -649,6 +649,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 
 	zdev->pdev = pdev;
 	pdev->dev.groups = zpci_attr_groups;
+	pdev->dev.archdata.dma_ops = &s390_pci_dma_ops;
 	zpci_map_resources(pdev);
 
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 37505b8..ea39c3f 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -495,7 +495,7 @@ static int __init dma_debug_do_init(void)
 }
 fs_initcall(dma_debug_do_init);
 
-struct dma_map_ops s390_dma_ops = {
+struct dma_map_ops s390_pci_dma_ops = {
 	.alloc		= s390_dma_alloc,
 	.free		= s390_dma_free,
 	.map_sg		= s390_dma_map_sg,
@@ -506,7 +506,7 @@ struct dma_map_ops s390_dma_ops = {
 	.is_phys	= 0,
 	/* dma_supported is unconditionally true without a callback */
 };
-EXPORT_SYMBOL_GPL(s390_dma_ops);
+EXPORT_SYMBOL_GPL(s390_pci_dma_ops);
 
 static int __init s390_iommu_setup(char *str)
 {
-- 
2.4.3
