From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 1/1] virtio/s390: implement PM operations for virtio_ccw
Date: Mon, 18 Dec 2017 17:21:23 +0100
Message-ID: <20171218162123.963-2-cohuck@redhat.com>
References: <20171218162123.963-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171218162123.963-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: jasowang@redhat.com, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Suspend/Resume to/from disk currently fails. Let us wire
up the necessary callbacks. This is mostly just forwarding
the requests to the virtio drivers. The only thing that
has to be done in virtio_ccw itself is to re-set the
virtio revision.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20171207141102.70190-2-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[CH: merged <20171218083706.223836-1-borntraeger@de.ibm.com> to fix
!CONFIG_PM configs]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b18fe2014cf2..985184ebda45 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1300,6 +1300,9 @@ static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
 		vcdev->device_lost = true;
 		rc = NOTIFY_DONE;
 		break;
+	case CIO_OPER:
+		rc = NOTIFY_OK;
+		break;
 	default:
 		rc = NOTIFY_DONE;
 		break;
@@ -1312,6 +1315,27 @@ static struct ccw_device_id virtio_ids[] = {
 	{},
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_ccw_freeze(struct ccw_device *cdev)
+{
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+
+	return virtio_device_freeze(&vcdev->vdev);
+}
+
+static int virtio_ccw_restore(struct ccw_device *cdev)
+{
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	int ret;
+
+	ret = virtio_ccw_set_transport_rev(vcdev);
+	if (ret)
+		return ret;
+
+	return virtio_device_restore(&vcdev->vdev);
+}
+#endif
+
 static struct ccw_driver virtio_ccw_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
@@ -1324,6 +1348,11 @@ static struct ccw_driver virtio_ccw_driver = {
 	.set_online = virtio_ccw_online,
 	.notify = virtio_ccw_cio_notify,
 	.int_class = IRQIO_VIR,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_ccw_freeze,
+	.thaw = virtio_ccw_restore,
+	.restore = virtio_ccw_restore,
+#endif
 };
 
 static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
-- 
2.13.6
