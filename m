From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/3] s390/virtio: handle find on invalid queue gracefully
Date: Mon, 21 Jan 2019 13:19:43 +0100
Message-ID: <20190121121944.12309-3-cohuck@redhat.com>
References: <20190121121944.12309-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190121121944.12309-1-cohuck@redhat.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.ibm.com>

A queue with a capacity of zero is clearly not a valid virtio queue.
Some emulators report zero queue size if queried with an invalid queue
index. Instead of crashing in this case let us just return -ENOENT. To
make that work properly, let us fix the notifier cleanup logic as well.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190107123147.97038-1-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index ae1d56da671d..1a738fe9f26b 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -272,6 +272,8 @@ static void virtio_ccw_drop_indicators(struct virtio_ccw_device *vcdev)
 {
 	struct virtio_ccw_vq_info *info;
 
+	if (!vcdev->airq_info)
+		return;
 	list_for_each_entry(info, &vcdev->virtqueues, node)
 		drop_airq_indicator(info->vq, vcdev->airq_info);
 }
@@ -413,7 +415,7 @@ static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
 	if (ret)
 		return ret;
-	return vcdev->config_block->num;
+	return vcdev->config_block->num ?: -ENOENT;
 }
 
 static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
-- 
2.17.2
