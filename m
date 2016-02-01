From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v6 3/9] s390/dma: Allow per device dma ops
Date: Mon,  1 Feb 2016 10:00:53 -0800
Message-ID: <454ab46cd61644851aa437c73e6c8c7da79bfb30.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

As virtio-ccw will have dma ops, we can no longer default to the
zPCI ones. Make use of dev_archdata to keep the dma_ops per device.
The pci devices now use that to override the default, and the
default is changed to use the noop ops for everything that does not
specify a device specific one.
To compile without PCI support we will enable HAS_DMA all the time,
via the default config in lib/Kconfig.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 arch/s390/Kconfig                   | 6 ++----
 arch/s390/include/asm/device.h      | 6 +++++-
 arch/s390/include/asm/dma-mapping.h | 6 ++++--
 arch/s390/pci/pci.c                 | 1 +
 arch/s390/pci/pci_dma.c             | 4 ++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3be9c832dec1..5b22a26337b2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -124,6 +124,8 @@ config S390
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DMA_ATTRS
+	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FTRACE_MCOUNT_RECORD
@@ -619,10 +621,6 @@ config HAS_IOMEM
 config IOMMU_HELPER
 	def_bool PCI
 
-config HAS_DMA
-	def_bool PCI
-	select HAVE_DMA_API_DEBUG
-
 config NEED_SG_DMA_LENGTH
 	def_bool PCI
 
diff --git a/arch/s390/include/asm/device.h b/arch/s390/include/asm/device.h
index d8f9872b0e2d..4a9f35e0973f 100644
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
index e64bfcb9702f..3249b7464889 100644
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
index 11d4f277e9f6..f5931135b9ae 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -649,6 +649,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 
 	zdev->pdev = pdev;
 	pdev->dev.groups = zpci_attr_groups;
+	pdev->dev.archdata.dma_ops = &s390_pci_dma_ops;
 	zpci_map_resources(pdev);
 
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 4638b93c7632..a79173ec54b9 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -544,7 +544,7 @@ static int __init dma_debug_do_init(void)
 }
 fs_initcall(dma_debug_do_init);
 
-struct dma_map_ops s390_dma_ops = {
+struct dma_map_ops s390_pci_dma_ops = {
 	.alloc		= s390_dma_alloc,
 	.free		= s390_dma_free,
 	.map_sg		= s390_dma_map_sg,
@@ -555,7 +555,7 @@ struct dma_map_ops s390_dma_ops = {
 	.is_phys	= 0,
 	/* dma_supported is unconditionally true without a callback */
 };
-EXPORT_SYMBOL_GPL(s390_dma_ops);
+EXPORT_SYMBOL_GPL(s390_pci_dma_ops);
 
 static int __init s390_iommu_setup(char *str)
 {
-- 
2.5.0
