Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 22 Oct 2014 18:51:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v2 14/16] KVM: s390: enable virtio-ccw revision 1
Message-ID: <1413992894-22976-15-git-send-email-mst@redhat.com>
References: <1413992894-22976-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413992894-22976-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Now that virtio-ccw has everything needed to support virtio 1.0 in
place, try to enable it if the host supports it.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/s390/kvm/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index a994078..c42eda3 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -103,7 +103,7 @@ struct virtio_rev_info {
 };
 
 /* the highest virtio-ccw revision we support */
-#define VIRTIO_CCW_REV_MAX 0
+#define VIRTIO_CCW_REV_MAX 1
 
 struct virtio_ccw_vq_info {
 	struct virtqueue *vq;
-- 
MST
