From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/3] dma: Provide simple noop dma ops
Date: Tue,  3 Nov 2015 12:54:37 +0100
Message-ID: <1446551679-33492-2-git-send-email-borntraeger@de.ibm.com>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
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
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

We are going to require dma_ops for several common drivers, even for
systems that do have an identity mapping. Lets provide some minimal
no-op dma_ops that can be used for that purpose.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/dma-mapping.h |  2 ++
 lib/Makefile                |  1 +
 lib/dma-noop.c              | 75 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 lib/dma-noop.c

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..7912f54 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -66,6 +66,8 @@ struct dma_map_ops {
 	int is_phys;
 };
 
+extern struct dma_map_ops dma_noop_ops;
+
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
 #define DMA_MASK_NONE	0x0ULL
diff --git a/lib/Makefile b/lib/Makefile
index 13a7c6a..92d6135 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -18,6 +18,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 obj-$(CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS) += usercopy.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
+lib-$(CONFIG_HAS_DMA) += dma-noop.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
diff --git a/lib/dma-noop.c b/lib/dma-noop.c
new file mode 100644
index 0000000..7214564
--- /dev/null
+++ b/lib/dma-noop.c
@@ -0,0 +1,75 @@
+/*
+ *	lib/dma-noop.c
+ *
+ * Simple DMA noop-ops that map 1:1 with memory
+ */
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+
+static void *dma_noop_alloc(struct device *dev, size_t size,
+			    dma_addr_t *dma_handle, gfp_t gfp,
+			    struct dma_attrs *attrs)
+{
+	void *ret;
+
+	ret = (void *)__get_free_pages(gfp, get_order(size));
+	if (ret)
+		*dma_handle = virt_to_phys(ret);
+	return ret;
+}
+
+static void dma_noop_free(struct device *dev, size_t size,
+			  void *cpu_addr, dma_addr_t dma_addr,
+			  struct dma_attrs *attrs)
+{
+	free_pages((unsigned long)cpu_addr, get_order(size));
+}
+
+static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
+				      unsigned long offset, size_t size,
+				      enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	return page_to_phys(page) + offset;
+}
+
+static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+			     enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i) {
+		void *va;
+
+		BUG_ON(!sg_page(sg));
+		va = sg_virt(sg);
+		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va);
+		sg_dma_len(sg) = sg->length;
+	}
+
+	return nents;
+}
+
+static int dma_noop_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+static int dma_noop_supported(struct device *dev, u64 mask)
+{
+	return 1;
+}
+
+struct dma_map_ops dma_noop_ops = {
+	.alloc			= dma_noop_alloc,
+	.free			= dma_noop_free,
+	.map_page		= dma_noop_map_page,
+	.map_sg			= dma_noop_map_sg,
+	.mapping_error		= dma_noop_mapping_error,
+	.dma_supported		= dma_noop_supported,
+};
+
+EXPORT_SYMBOL(dma_noop_ops);
-- 
2.4.3
