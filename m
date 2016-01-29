From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 01/10] dma: Provide simple noop dma ops
Date: Thu, 28 Jan 2016 18:31:14 -0800
Message-ID: <6973e55a7ae955d7aaa94d143e84091c06bdd18f.1454034075.git.luto@kernel.org>
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

We are going to require dma_ops for several common drivers, even for
systems that do have an identity mapping. Lets provide some minimal
no-op dma_ops that can be used for that purpose.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/dma-mapping.h |  2 ++
 lib/Makefile                |  1 +
 lib/dma-noop.c              | 75 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 lib/dma-noop.c

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75857cda38e9..c0b27ff2c784 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -70,6 +70,8 @@ struct dma_map_ops {
 	int is_phys;
 };
 
+extern struct dma_map_ops dma_noop_ops;
+
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
 #define DMA_MASK_NONE	0x0ULL
diff --git a/lib/Makefile b/lib/Makefile
index a7c26a41a738..a572b86a1b1d 100644
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
index 000000000000..72145646857e
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
2.5.0
