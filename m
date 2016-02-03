From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v7 2/9] alpha/dma: use common noop dma ops
Date: Tue,  2 Feb 2016 21:46:33 -0800
Message-ID: <72a5975b085a6b076473b0fc84b71a8642fdf632.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Some of the alpha pci noop dma ops are identical to the common ones.
Use them.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/alpha/kernel/pci-noop.c | 46 ++++----------------------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index 2b1f4a1e9272..8e735b5e56bd 100644
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
2.5.0
