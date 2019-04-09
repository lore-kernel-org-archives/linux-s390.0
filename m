Return-Path: <linux-doc-owner@vger.kernel.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 4/6] s390/pci: add support for generic boot option iommu.dma_mode
Date: Tue, 9 Apr 2019 20:53:06 +0800
Message-ID: <20190409125308.18304-5-thunder.leizhen@huawei.com>
In-Reply-To: <20190409125308.18304-1-thunder.leizhen@huawei.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

s390_iommu=strict is equivalent to iommu.dma_mode=strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++---
 arch/s390/pci/pci_dma.c                         | 14 +++++++-------
 drivers/iommu/Kconfig                           |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92d1b3151d003c2..ab8e3c4798c0a2a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1815,9 +1815,9 @@
 			options(such as CONFIG_IOMMU_DEFAULT_PASSTHROUGH) to
 			choose which mode to be used.
 			Note: For historical reasons, ARM64/S390/PPC/X86 have
-			their specific options. Currently, only ARM64 support
-			this boot option, and hope other ARCHs to use this as
-			generic boot option.
+			their specific options. Currently, only ARM64/S390
+			support this boot option, and hope other ARCHs to use
+			this as generic boot option.
 		passthrough
 			Configure DMA to bypass the IOMMU by default.
 		lazy
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9e52d1527f71495..f658ca41547eed5 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/iommu.h>
 #include <linux/iommu-helper.h>
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
@@ -17,7 +18,6 @@
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
-static int s390_iommu_strict;
 
 static int zpci_refresh_global(struct zpci_dev *zdev)
 {
@@ -193,13 +193,13 @@ static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 		if (!zdev->tlb_refresh)
 			return 0;
 	} else {
-		if (!s390_iommu_strict)
+		if (!IOMMU_DMA_MODE_IS_STRICT())
 			return 0;
 	}
 
 	ret = zpci_refresh_trans((u64) zdev->fh << 32, dma_addr,
 				 PAGE_ALIGN(size));
-	if (ret == -ENOMEM && !s390_iommu_strict) {
+	if (ret == -ENOMEM && !IOMMU_DMA_MODE_IS_STRICT()) {
 		/* enable the hypervisor to free some resources */
 		if (zpci_refresh_global(zdev))
 			goto out;
@@ -278,7 +278,7 @@ static dma_addr_t dma_alloc_address(struct device *dev, int size)
 	spin_lock_irqsave(&zdev->iommu_bitmap_lock, flags);
 	offset = __dma_alloc_iommu(dev, zdev->next_bit, size);
 	if (offset == -1) {
-		if (!s390_iommu_strict) {
+		if (!IOMMU_DMA_MODE_IS_STRICT()) {
 			/* global flush before DMA addresses are reused */
 			if (zpci_refresh_global(zdev))
 				goto out_error;
@@ -313,7 +313,7 @@ static void dma_free_address(struct device *dev, dma_addr_t dma_addr, int size)
 	if (!zdev->iommu_bitmap)
 		goto out;
 
-	if (s390_iommu_strict)
+	if (IOMMU_DMA_MODE_IS_STRICT())
 		bitmap_clear(zdev->iommu_bitmap, offset, size);
 	else
 		bitmap_set(zdev->lazy_bitmap, offset, size);
@@ -584,7 +584,7 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
-	if (!s390_iommu_strict) {
+	if (!IOMMU_DMA_MODE_IS_STRICT()) {
 		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
@@ -675,7 +675,7 @@ void zpci_dma_exit(void)
 static int __init s390_iommu_setup(char *str)
 {
 	if (!strncmp(str, "strict", 6))
-		s390_iommu_strict = 1;
+		iommu_default_dma_mode_set(IOMMU_DMA_MODE_STRICT);
 	return 0;
 }
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1986f9767da488b..b7173b106cd816a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DEFAULT_LAZY if S390_IOMMU
 	default IOMMU_DEFAULT_STRICT
 	help
 	  This option allows IOMMU dma mode to be chose at build time, to
-- 
1.8.3
