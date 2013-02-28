From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v5 1/6] virtio_ccw: pass a cookie value to kvm hypercall
Date: Thu, 28 Feb 2013 12:33:16 +0100
Message-ID: <1362051201-56541-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Lookups by channel/vq pair on host during virtio notifications might be
expensive.  Interpret hypercall return value as a cookie which host can
use to do device lookups for the next notification more efficiently.

[CH: Fix line > 80 chars]
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 3217dfe..259a2fb 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -77,6 +77,7 @@ struct virtio_ccw_vq_info {
 	void *queue;
 	struct vq_info_block *info_block;
 	struct list_head node;
+	long cookie;
 };
 
 #define KVM_VIRTIO_CCW_RING_ALIGN 4096
@@ -145,15 +146,18 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
 }
 
 static inline long do_kvm_notify(struct subchannel_id schid,
-				 unsigned long queue_index)
+				 unsigned long queue_index,
+				 long cookie)
 {
 	register unsigned long __nr asm("1") = KVM_S390_VIRTIO_CCW_NOTIFY;
 	register struct subchannel_id __schid asm("2") = schid;
 	register unsigned long __index asm("3") = queue_index;
 	register long __rc asm("2");
+	register long __cookie asm("4") = cookie;
 
 	asm volatile ("diag 2,4,0x500\n"
-		      : "=d" (__rc) : "d" (__nr), "d" (__schid), "d" (__index)
+		      : "=d" (__rc) : "d" (__nr), "d" (__schid), "d" (__index),
+		      "d"(__cookie)
 		      : "memory", "cc");
 	return __rc;
 }
@@ -166,7 +170,8 @@ static void virtio_ccw_kvm_notify(struct virtqueue *vq)
 
 	vcdev = to_vc_device(info->vq->vdev);
 	ccw_device_get_schid(vcdev->cdev, &schid);
-	do_kvm_notify(schid, virtqueue_get_queue_index(vq));
+	info->cookie = do_kvm_notify(schid, virtqueue_get_queue_index(vq),
+				     info->cookie);
 }
 
 static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
-- 
1.7.12.4
