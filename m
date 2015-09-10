From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/1] virtio/s390: handle failures of READ_VQ_CONF ccw
Date: Thu, 10 Sep 2015 16:35:08 +0200
Message-ID: <1441895708-70657-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1441895708-70657-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1441895708-70657-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

In virtio_ccw_read_vq_conf() the return value of ccw_io_helper()
was not checked.
If the configuration could not be read properly, we'd wrongly assume a
queue size of 0.

Let's propagate any I/O error to virtio_ccw_setup_vq() so it may
properly fail.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index f8d8fdb..e9fae30 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -400,12 +400,16 @@ static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
 static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
 				   struct ccw1 *ccw, int index)
 {
+	int ret;
+
 	vcdev->config_block->index = index;
 	ccw->cmd_code = CCW_CMD_READ_VQ_CONF;
 	ccw->flags = 0;
 	ccw->count = sizeof(struct vq_config_block);
 	ccw->cda = (__u32)(unsigned long)(vcdev->config_block);
-	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
+	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
+	if (ret)
+		return ret;
 	return vcdev->config_block->num;
 }
 
@@ -503,6 +507,10 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		goto out_err;
 	}
 	info->num = virtio_ccw_read_vq_conf(vcdev, ccw, i);
+	if (info->num < 0) {
+		err = info->num;
+		goto out_err;
+	}
 	size = PAGE_ALIGN(vring_size(info->num, KVM_VIRTIO_CCW_RING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
 	if (info->queue == NULL) {
-- 
2.3.8
