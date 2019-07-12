Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfGLFlo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 01:41:44 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
Date: Fri, 12 Jul 2019 02:36:30 -0300
Message-Id: <20190712053631.9814-3-bauerman@linux.ibm.com>
In-Reply-To: <20190712053631.9814-1-bauerman@linux.ibm.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Secure Memory Encryption is an x86-specific feature, so it shouldn't appear
in generic kernel code.

Introduce ARCH_HAS_DMA_CHECK_MASK so that x86 can define its own
dma_check_mask() for the SME check.

In SWIOTLB code, there's no need to mention which memory encryption
feature is active. Also, other architectures will have different names so
this gets unwieldy quickly.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/dma-mapping.h |  7 +++++++
 arch/x86/include/asm/mem_encrypt.h | 10 ++++++++++
 include/linux/mem_encrypt.h        | 14 +-------------
 kernel/dma/Kconfig                 |  3 +++
 kernel/dma/mapping.c               |  4 ++--
 kernel/dma/swiotlb.c               |  3 +--
 7 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f4d28da8fe3..dbabe42e7f1c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -61,6 +61,7 @@ config X86
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_CHECK_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FILTER_PGPROT
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 6b15a24930e0..55e710ba95a5 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/swiotlb.h>
 #include <linux/dma-contiguous.h>
+#include <linux/mem_encrypt.h>
 
 extern int iommu_merge;
 extern int panic_on_overflow;
@@ -23,4 +24,10 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
+static inline void dma_check_mask(struct device *dev, u64 mask)
+{
+	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
+		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
+}
+
 #endif
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 616f8e637bc3..e4c9e1a57d25 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -95,6 +95,16 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
+static inline bool mem_encrypt_active(void)
+{
+	return sme_me_mask;
+}
+
+static inline u64 sme_get_me_mask(void)
+{
+	return sme_me_mask;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index b310a9c18113..f2e399fb626b 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -21,23 +21,11 @@
 
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * The __sme_set() and __sme_clr() macros are useful for adding or removing
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9decbba255fc..34b44bfba372 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -17,6 +17,9 @@ config ARCH_DMA_ADDR_T_64BIT
 config ARCH_HAS_DMA_COHERENCE_H
 	bool
 
+config ARCH_HAS_DMA_CHECK_MASK
+	bool
+
 config ARCH_HAS_DMA_SET_MASK
 	bool
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770..ed46f88378d4 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -291,11 +291,11 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 }
 EXPORT_SYMBOL(dma_free_attrs);
 
+#ifndef CONFIG_ARCH_HAS_DMA_CHECK_MASK
 static inline void dma_check_mask(struct device *dev, u64 mask)
 {
-	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
-		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
 }
+#endif
 
 int dma_supported(struct device *dev, u64 mask)
 {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 13f0cb080a4d..67482ad6aab2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -459,8 +459,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
-		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
-			     sme_active() ? "SME" : "SEV");
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
 	mask = dma_get_seg_boundary(hwdev);
 
