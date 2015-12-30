From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] virtio/s390: use dev_to_virtio
Date: Wed, 30 Dec 2015 22:05:25 +0800
Message-ID: <912bf59bd3a48f2d4d4994681e898dc084fe29d3.1451484163.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Use dev_to_virtio() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/s390/virtio/virtio_ccw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 1b83159..97231e1 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -945,8 +945,7 @@ static struct virtio_config_ops virtio_ccw_config_ops = {
 
 static void virtio_ccw_release_dev(struct device *_d)
 {
-	struct virtio_device *dev = container_of(_d, struct virtio_device,
-						 dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_ccw_device *vcdev = to_vc_device(dev);
 
 	kfree(vcdev->status);
-- 
2.5.0
