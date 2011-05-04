From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] virtio: avail_event index support
Date: Thu, 5 May 2011 00:02:15 +0300
Message-ID: <920d6df05a935ddcae23c3213cc9d2da0bf1c413.1304542880.git.mst@redhat.com>
References: <cover.1304542880.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1304542880.git.mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Shirley Ma <xma@us.ibm.com>, lguest@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Krishna Kumar <krkumar2@in.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, steved@us.ibm.com, habanero@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Reduce the number of exits utilizing the
avail_event feature.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vhost_net.c |    6 ++++++
 hw/virtio.c    |   26 ++++++++++++++++++++++++--
 hw/virtio.h    |    7 ++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/vhost_net.c b/hw/vhost_net.c
index 18e4653..aeb5a84 100644
--- a/hw/vhost_net.c
+++ b/hw/vhost_net.c
@@ -53,6 +53,9 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
     if (!(net->dev.features & (1ULL << VIRTIO_RING_F_USED_EVENT_IDX))) {
         features &= ~(1ULL << VIRTIO_RING_F_USED_EVENT_IDX);
     }
+    if (!(net->dev.features & (1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX))) {
+        features &= ~(1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX);
+    }
     if (!(net->dev.features & (1 << VIRTIO_NET_F_MRG_RXBUF))) {
         features &= ~(1 << VIRTIO_NET_F_MRG_RXBUF);
     }
@@ -71,6 +74,9 @@ void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
     if (features & (1ULL << VIRTIO_RING_F_USED_EVENT_IDX)) {
         net->dev.acked_features |= (1ULL << VIRTIO_RING_F_USED_EVENT_IDX);
     }
+    if (features & (1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX)) {
+        net->dev.acked_features |= (1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX);
+    }
     if (features & (1 << VIRTIO_NET_F_MRG_RXBUF)) {
         net->dev.acked_features |= (1 << VIRTIO_NET_F_MRG_RXBUF);
     }
diff --git a/hw/virtio.c b/hw/virtio.c
index e459093..6ae5542 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -78,6 +78,9 @@ struct VirtQueue
     /* Last used index value we have signalled on */
     bool signalled_used_valid;
 
+    /* Notification enabled? */
+    bool notification;
+
     int inuse;
 
     uint16_t vector;
@@ -195,12 +198,26 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
     stw_phys(pa, lduw_phys(pa) & ~mask);
 }
 
+static inline void vring_avail_event(VirtQueue *vq, uint16_t val)
+{
+    target_phys_addr_t pa;
+    if (!vq->notification) {
+        return;
+    }
+    pa = vq->vring.used + offsetof(VRingUsed, ring[vq->vring.num]);
+    stw_phys(pa, val);
+}
+
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
-    if (enable)
+    vq->notification = enable;
+    if (vq->vdev->guest_features & (1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX)) {
+        vring_avail_event(vq, vq->last_avail_idx);
+    } else if (enable) {
         vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
-    else
+    } else {
         vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
+    }
 }
 
 int virtio_queue_ready(VirtQueue *vq)
@@ -412,6 +429,9 @@ int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
     max = vq->vring.num;
 
     i = head = virtqueue_get_head(vq, vq->last_avail_idx++);
+    if (vq->vdev->guest_features & (1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX)) {
+        vring_avail_event(vq, vq->last_avail_idx);
+    }
 
     if (vring_desc_flags(desc_pa, i) & VRING_DESC_F_INDIRECT) {
         if (vring_desc_len(desc_pa, i) % sizeof(VRingDesc)) {
@@ -497,6 +517,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].vector = VIRTIO_NO_VECTOR;
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
+        vdev->vq[i].notification = true;
     }
 }
 
@@ -784,6 +805,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f)
         vdev->vq[i].pa = qemu_get_be64(f);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
         vdev->vq[i].signalled_used_valid = false;
+        vdev->vq[i].notification = true;
 
         if (vdev->vq[i].pa) {
             uint16_t nheads;
diff --git a/hw/virtio.h b/hw/virtio.h
index d765946..8c0923a 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -54,6 +54,9 @@
 
 /* Enables feature bits 32 to 63 (only really required for virtio_pci). */
 #define VIRTIO_F_FEATURES_HI		31
+/* The Host publishes the avail index for which it expects a kick
+ * at the end of the used ring. Guest should ignore the used->flags field. */
+#define VIRTIO_RING_F_AVAIL_EVENT_IDX	32
 
 /* from Linux's linux/virtio_ring.h */
 
@@ -218,7 +221,9 @@ void virtio_serial_exit(VirtIODevice *vdev);
 	DEFINE_PROP_BIT64("indirect_desc", _state, _field, \
 			  VIRTIO_RING_F_INDIRECT_DESC, true), \
 	DEFINE_PROP_BIT64("used_event", _state, _field, \
-			  VIRTIO_RING_F_USED_EVENT_IDX, true)
+			  VIRTIO_RING_F_USED_EVENT_IDX, true), \
+	DEFINE_PROP_BIT64("avail_event", _state, _field, \
+			  VIRTIO_RING_F_AVAIL_EVENT_IDX, true)
 
 target_phys_addr_t virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 target_phys_addr_t virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
-- 
1.7.5.53.gc233e
