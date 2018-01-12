Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/34] riscv: remove the unused dma_capable helper
Date: Fri, 12 Jan 2018 09:42:05 +0100
Message-ID: <20180112084232.2857-8-hch@lst.de>
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180112084205.c_FdmcwfBZIWbcemqyf03qfdE7IQza_3BKbC-0kUpYg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/dma-mapping.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/include/asm/dma-mapping.h b/arch/riscv/include/asm/dma-mapping.h
index 3eec1000196d..73849e2cc761 100644
--- a/arch/riscv/include/asm/dma-mapping.h
+++ b/arch/riscv/include/asm/dma-mapping.h
@@ -27,12 +27,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif	/* __ASM_RISCV_DMA_MAPPING_H */
-- 
2.14.2
