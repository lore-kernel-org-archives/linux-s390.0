From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v6 9/9] vring: Use the DMA API on Xen
Date: Mon,  1 Feb 2016 10:00:59 -0800
Message-ID: <41aeb1bd026494e277ea5827d99df4a4f41b8b8f.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cf2840c7e500..2a921e5b1809 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -25,6 +25,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kmemleak.h>
 #include <linux/dma-mapping.h>
+#include <xen/xen.h>
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -136,6 +137,17 @@ struct vring_virtqueue {
 
 static bool vring_use_dma_api(const struct vring_virtqueue *vq)
 {
+	/*
+	 * In theory, it's possible to have a buggy QEMU-supposed
+	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
+	 * such a configuration, virtio has never worked and will
+	 * not work without an even larger kludge.  Instead, enable
+	 * the DMA API if we're a Xen guest, which at least allows
+	 * all of the sensible Xen configurations to work correctly.
+	 */
+	if (xen_domain())
+		return true;
+
 	return false;
 }
 
-- 
2.5.0
