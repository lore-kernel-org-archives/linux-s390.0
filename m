From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] virtio-ccw: wire up ->bus_name callback
Date: Thu,  3 Jan 2019 15:11:45 +0100
Message-ID: <20190103141145.14554-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Return the bus id of the ccw proxy device. This makes 'ethtool -i'
show a more useful value than 'virtio' in the bus-info field.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index fc9dbad476c0..689aec54bfcf 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -967,6 +967,13 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 	kfree(ccw);
 }
 
+static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
+{
+	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+
+	return dev_name(&vcdev->cdev->dev);
+}
+
 static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_features = virtio_ccw_get_features,
 	.finalize_features = virtio_ccw_finalize_features,
@@ -977,6 +984,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.reset = virtio_ccw_reset,
 	.find_vqs = virtio_ccw_find_vqs,
 	.del_vqs = virtio_ccw_del_vqs,
+	.bus_name = virtio_ccw_bus_name,
 };
 
 
-- 
2.17.2
