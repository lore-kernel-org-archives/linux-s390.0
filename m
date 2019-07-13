Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
Date: Sat, 13 Jul 2019 01:45:53 -0300
Message-Id: <20190713044554.28719-3-bauerman@linux.ibm.com>
In-Reply-To: <20190713044554.28719-1-bauerman@linux.ibm.com>
References: <20190713044554.28719-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Secure Memory Encryption is an x86-specific feature, so it shouldn't appear
in generic kernel code.

In DMA mapping code, Christoph Hellwig mentioned that "There is no reason
why we should have a special debug printk just for one specific reason why
there is a requirement for a large DMA mask.", so we just remove
dma_check_mask().

In SWIOTLB code, there's no need to mention which memory encryption feature
is active, so just use a more generic warning. Besides, other architectures
will have different names for similar technology.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 include/linux/mem_encrypt.h         | 14 +-------------
 kernel/dma/mapping.c                |  8 --------
 kernel/dma/swiotlb.c                |  3 +--
 5 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 3eb018508190..ff813a56bc30 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,9 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 0c196c47d621..848ce43b9040 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -92,6 +92,16 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
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
index 470bd53a89df..0c5b0ff9eb29 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -18,23 +18,11 @@
 
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 
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
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770..b53fc7ec4914 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -291,12 +291,6 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 }
 EXPORT_SYMBOL(dma_free_attrs);
 
-static inline void dma_check_mask(struct device *dev, u64 mask)
-{
-	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
-		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
-}
-
 int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -321,7 +315,6 @@ int dma_set_mask(struct device *dev, u64 mask)
 		return -EIO;
 
 	arch_dma_set_mask(dev, mask);
-	dma_check_mask(dev, mask);
 	*dev->dma_mask = mask;
 	return 0;
 }
@@ -333,7 +326,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 	if (!dma_supported(dev, mask))
 		return -EIO;
 
-	dma_check_mask(dev, mask);
 	dev->coherent_dma_mask = mask;
 	return 0;
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 62fa5a82a065..e52401f94e91 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -459,8 +459,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
-		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
-			     sme_active() ? "SME" : "SEV");
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
 	mask = dma_get_seg_boundary(hwdev);
 
