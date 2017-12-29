Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 59/67] unicore32: use generic swiotlb_ops
Date: Fri, 29 Dec 2017 09:19:03 +0100
Message-ID: <20171229081911.2802-60-hch@lst.de>
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20171229081903.Jv-ebyx8VENAOVJF7qX54zpRHrQ3Zkirwm0l3OLOOMU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

These are identical to the unicore32 ops, and would also support CMA
if enabled on unicore32.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/unicore32/include/asm/dma-mapping.h |  9 +-----
 arch/unicore32/mm/Kconfig                |  1 +
 arch/unicore32/mm/Makefile               |  2 --
 arch/unicore32/mm/dma-swiotlb.c          | 48 --------------------------------
 4 files changed, 2 insertions(+), 58 deletions(-)
 delete mode 100644 arch/unicore32/mm/dma-swiotlb.c

diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index f2bfec273aa7..790bc2ef4af2 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -12,18 +12,11 @@
 #ifndef __UNICORE_DMA_MAPPING_H__
 #define __UNICORE_DMA_MAPPING_H__
 
-#ifdef __KERNEL__
-
-#include <linux/mm_types.h>
-#include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
 
-extern const struct dma_map_ops swiotlb_dma_map_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return &swiotlb_dma_map_ops;
+	return &swiotlb_dma_ops;
 }
 
-#endif /* __KERNEL__ */
 #endif
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index c256460cd363..e9154a59d561 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -42,6 +42,7 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 
 config SWIOTLB
 	def_bool y
+	select DMA_DIRECT_OPS
 
 config IOMMU_HELPER
 	def_bool SWIOTLB
diff --git a/arch/unicore32/mm/Makefile b/arch/unicore32/mm/Makefile
index 681c0ef5ec9e..8106260583ab 100644
--- a/arch/unicore32/mm/Makefile
+++ b/arch/unicore32/mm/Makefile
@@ -6,8 +6,6 @@
 obj-y				:= extable.o fault.o init.o pgd.o mmu.o
 obj-y				+= flush.o ioremap.o
 
-obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
-
 obj-$(CONFIG_MODULES)		+= proc-syms.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
deleted file mode 100644
index 525413d6690e..000000000000
--- a/arch/unicore32/mm/dma-swiotlb.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Contains routines needed to support swiotlb for UniCore32.
- *
- * Copyright (C) 2010 Guan Xuetao
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/pci.h>
-#include <linux/cache.h>
-#include <linux/module.h>
-#include <linux/dma-mapping.h>
-#include <linux/swiotlb.h>
-#include <linux/bootmem.h>
-
-#include <asm/dma.h>
-
-static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
-					    dma_addr_t *dma_handle, gfp_t flags,
-					    unsigned long attrs)
-{
-	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
-}
-
-static void unicore_swiotlb_free_coherent(struct device *dev, size_t size,
-					  void *vaddr, dma_addr_t dma_addr,
-					  unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-}
-
-const struct dma_map_ops swiotlb_dma_map_ops = {
-	.alloc = unicore_swiotlb_alloc_coherent,
-	.free = unicore_swiotlb_free_coherent,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.dma_supported = swiotlb_dma_supported,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.mapping_error = swiotlb_dma_mapping_error,
-};
-EXPORT_SYMBOL(swiotlb_dma_map_ops);
-- 
2.14.2
