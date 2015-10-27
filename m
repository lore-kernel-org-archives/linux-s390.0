From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/4] s390/dma: Allow per device dma ops
Date: Tue, 27 Oct 2015 23:48:50 +0100
Message-ID: <1445986131-239566-4-git-send-email-borntraeger@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As virtio-ccw now has dma ops, we can no longer default to the PCI ones.
Make use of dev_archdata to keep the dma_ops per device.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/device.h      | 6 +++++-
 arch/s390/include/asm/dma-mapping.h | 2 +-
 arch/s390/pci/pci.c                 | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index b3fd54d..71404f1 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -15,7 +15,7 @@ extern struct dma_map_ops s390_dma_ops;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	return &s390_dma_ops;
+	return dev->archdata.dma_ops;
 }
 
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 7ef12a3..9913915 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -649,6 +649,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 
 	zdev->pdev = pdev;
 	pdev->dev.groups = zpci_attr_groups;
+	pdev->dev.archdata.dma_ops = &s390_dma_ops;
 	zpci_map_resources(pdev);
 
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
-- 
2.4.3
