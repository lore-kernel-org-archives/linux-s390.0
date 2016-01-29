From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 04/10] vring: Introduce vring_use_dma_api()
Date: Thu, 28 Jan 2016 18:31:17 -0800
Message-ID: <cab70812b0a46a5a5b36e6de4110c5c66a6f6916.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>
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
index e12e385f7ac3..4b8dab4960bb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -25,6 +25,30 @@
 #include <linux/hrtimer.h>
 #include <linux/kmemleak.h>
 
+/*
+ * The interaction between virtio and a possible IOMMU is a mess.
+ *
+ * On most systems with virtio, physical addresses match bus addresses,
+ * and it doesn't particularly matter whether we use the DMI API.
+ *
+ * On some sytems, including Xen and any system with a physical device
+ * that speaks virtio behind a physical IOMMU, we must use the DMA API
+ * for virtio DMA to work at all.
+ *
+ * On other systems, including SPARC and PPC64, virtio-pci devices are
+ * enumerated as though they are behind an IOMMU, but the virtio host
+ * ignores the IOMMU, so we must either pretend that the IOMMU isn't
+ * there or somehow map everything as the identity.
+ *
+ * For the time being, we preseve historic behavior and bypass the DMA
+ * API.
+ */
+
+static bool vring_use_dma_api(void)
+{
+	return false;
+}
+
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
 #define BAD_RING(_vq, fmt, args...)				\
-- 
2.5.0
