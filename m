Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Jun 2013 16:16:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 3.10-rc8
Message-ID: <20130625161631.1fb404b4@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:
A couple of last-minute fixes: a build regression for !SMP, a
recent memory detection patch caused kdump to break, a regression
in regard to sscanf vs. reboot from FCP, and two fixes in the DMA
mapping code for PCI.

Ben Hutchings (1):
      s390/irq: Only define synchronize_irq() on SMP

Heiko Carstens (1):
      s390/mem_detect: fix memory hole handling

Michael Holzheu (1):
      s390/ipl: Fix FCP WWPN and LUN format strings for read

Sebastian Ott (2):
      s390/dma: fix mapping_error detection
      s390/dma: support debug_dma_mapping_error

 arch/s390/include/asm/dma-mapping.h |    3 ++-
 arch/s390/kernel/ipl.c              |    8 ++++----
 arch/s390/kernel/irq.c              |    2 ++
 arch/s390/mm/mem_detect.c           |    3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 886ac7d..2f8c1ab 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -50,9 +50,10 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
+	debug_dma_mapping_error(dev, dma_addr);
 	if (dma_ops->mapping_error)
 		return dma_ops->mapping_error(dev, dma_addr);
-	return (dma_addr == 0UL);
+	return (dma_addr == DMA_ERROR_CODE);
 }
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index d8a6a38..feb719d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -754,9 +754,9 @@ static struct bin_attribute sys_reipl_fcp_scp_data_attr = {
 	.write = reipl_fcp_scpdata_write,
 };
 
-DEFINE_IPL_ATTR_RW(reipl_fcp, wwpn, "0x%016llx\n", "%016llx\n",
+DEFINE_IPL_ATTR_RW(reipl_fcp, wwpn, "0x%016llx\n", "%llx\n",
 		   reipl_block_fcp->ipl_info.fcp.wwpn);
-DEFINE_IPL_ATTR_RW(reipl_fcp, lun, "0x%016llx\n", "%016llx\n",
+DEFINE_IPL_ATTR_RW(reipl_fcp, lun, "0x%016llx\n", "%llx\n",
 		   reipl_block_fcp->ipl_info.fcp.lun);
 DEFINE_IPL_ATTR_RW(reipl_fcp, bootprog, "%lld\n", "%lld\n",
 		   reipl_block_fcp->ipl_info.fcp.bootprog);
@@ -1323,9 +1323,9 @@ static struct shutdown_action __refdata reipl_action = {
 
 /* FCP dump device attributes */
 
-DEFINE_IPL_ATTR_RW(dump_fcp, wwpn, "0x%016llx\n", "%016llx\n",
+DEFINE_IPL_ATTR_RW(dump_fcp, wwpn, "0x%016llx\n", "%llx\n",
 		   dump_block_fcp->ipl_info.fcp.wwpn);
-DEFINE_IPL_ATTR_RW(dump_fcp, lun, "0x%016llx\n", "%016llx\n",
+DEFINE_IPL_ATTR_RW(dump_fcp, lun, "0x%016llx\n", "%llx\n",
 		   dump_block_fcp->ipl_info.fcp.lun);
 DEFINE_IPL_ATTR_RW(dump_fcp, bootprog, "%lld\n", "%lld\n",
 		   dump_block_fcp->ipl_info.fcp.bootprog);
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 408e866..dd3c199 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -312,6 +312,7 @@ void measurement_alert_subclass_unregister(void)
 }
 EXPORT_SYMBOL(measurement_alert_subclass_unregister);
 
+#ifdef CONFIG_SMP
 void synchronize_irq(unsigned int irq)
 {
 	/*
@@ -320,6 +321,7 @@ void synchronize_irq(unsigned int irq)
 	 */
 }
 EXPORT_SYMBOL_GPL(synchronize_irq);
+#endif
 
 #ifndef CONFIG_PCI
 
diff --git a/arch/s390/mm/mem_detect.c b/arch/s390/mm/mem_detect.c
index 3cbd3b8..cca3882 100644
--- a/arch/s390/mm/mem_detect.c
+++ b/arch/s390/mm/mem_detect.c
@@ -123,7 +123,8 @@ void create_mem_hole(struct mem_chunk mem_chunk[], unsigned long addr,
 			continue;
 		} else if ((addr <= chunk->addr) &&
 			   (addr + size >= chunk->addr + chunk->size)) {
-			memset(chunk, 0 , sizeof(*chunk));
+			memmove(chunk, chunk + 1, (MEMORY_CHUNKS-i-1) * sizeof(*chunk));
+			memset(&mem_chunk[MEMORY_CHUNKS-1], 0, sizeof(*chunk));
 		} else if (addr + size < chunk->addr + chunk->size) {
 			chunk->size =  chunk->addr + chunk->size - addr - size;
 			chunk->addr = addr + size;
