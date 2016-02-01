From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v6 4/9] vring: Introduce vring_use_dma_api()
Date: Mon,  1 Feb 2016 10:00:54 -0800
Message-ID: <336edab2e5b4825abe899e10aa4368770362daf9.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
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
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is a kludge, but no one has come up with a a better idea yet.
We'll introduce DMA API support guarded by vring_use_dma_api().
Eventually we may be able to return true on more and more systems,
and hopefully we can get rid of vring_use_dma_api() entirely some
day.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e12e385f7ac3..b78aeeb3f6be 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -104,6 +104,30 @@ struct vring_virtqueue {
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+/*
+ * The interaction between virtio and a possible IOMMU is a mess.
+ *
+ * On most systems with virtio, physical addresses match bus addresses,
+ * and it doesn't particularly matter whether we use the DMA API.
+ *
+ * On some systems, including Xen and any system with a physical device
+ * that speaks virtio behind a physical IOMMU, we must use the DMA API
+ * for virtio DMA to work at all.
+ *
+ * On other systems, including SPARC and PPC64, virtio-pci devices are
+ * enumerated as though they are behind an IOMMU, but the virtio host
+ * ignores the IOMMU, so we must either pretend that the IOMMU isn't
+ * there or somehow map everything as the identity.
+ *
+ * For the time being, we preserve historic behavior and bypass the DMA
+ * API.
+ */
+
+static bool vring_use_dma_api(const struct vring_virtqueue *vq)
+{
+	return false;
+}
+
 static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 					 unsigned int total_sg, gfp_t gfp)
 {
-- 
2.5.0
