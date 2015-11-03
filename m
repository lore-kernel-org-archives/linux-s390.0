From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/3] alpha/dma: use common noop dma ops
Date: Tue,  3 Nov 2015 12:54:38 +0100
Message-ID: <1446551679-33492-3-git-send-email-borntraeger@de.ibm.com>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some of the alpha pci noop dma ops are identical to the common ones.
Use them.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 arch/alpha/kernel/pci-noop.c | 46 ++++----------------------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index 2b1f4a1..8e735b5e 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -123,44 +123,6 @@ static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-static void alpha_noop_free_coherent(struct device *dev, size_t size,
-				     void *cpu_addr, dma_addr_t dma_addr,
-				     struct dma_attrs *attrs)
-{
-	free_pages((unsigned long)cpu_addr, get_order(size));
-}
-
-static dma_addr_t alpha_noop_map_page(struct device *dev, struct page *page,
-				      unsigned long offset, size_t size,
-				      enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
-{
-	return page_to_pa(page) + offset;
-}
-
-static int alpha_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sgl, sg, nents, i) {
-		void *va;
-
-		BUG_ON(!sg_page(sg));
-		va = sg_virt(sg);
-		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va);
-		sg_dma_len(sg) = sg->length;
-	}
-
-	return nents;
-}
-
-static int alpha_noop_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static int alpha_noop_supported(struct device *dev, u64 mask)
 {
 	return mask < 0x00ffffffUL ? 0 : 1;
@@ -168,10 +130,10 @@ static int alpha_noop_supported(struct device *dev, u64 mask)
 
 struct dma_map_ops alpha_noop_ops = {
 	.alloc			= alpha_noop_alloc_coherent,
-	.free			= alpha_noop_free_coherent,
-	.map_page		= alpha_noop_map_page,
-	.map_sg			= alpha_noop_map_sg,
-	.mapping_error		= alpha_noop_mapping_error,
+	.free			= dma_noop_free_coherent,
+	.map_page		= dma_noop_map_page,
+	.map_sg			= dma_noop_map_sg,
+	.mapping_error		= dma_noop_mapping_error,
 	.dma_supported		= alpha_noop_supported,
 };
 
-- 
2.4.3
