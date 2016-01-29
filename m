From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 02/10] alpha/dma: use common noop dma ops
Date: Thu, 28 Jan 2016 18:31:15 -0800
Message-ID: <e7bf04abe8495e1e0964fbb318791bad96f84b7b.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
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

Some of the alpha pci noop dma ops are identical to the common ones.
Use them.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
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
