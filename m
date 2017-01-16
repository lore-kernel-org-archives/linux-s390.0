From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 3/5] virtio/s390: support READ_STATUS command for virtio-ccw
Date: Mon, 16 Jan 2017 15:04:31 +0100
Message-ID: <20170116140433.21301-4-cornelia.huck@de.ibm.com>
References: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

As virtio-1 introduced the possibility of the device manipulating the
status byte, revision 2 of the virtio-ccw transport introduced a means
of getting the status byte from the device via READ_STATUS. Let's wire
it up for revisions >= 2 and fall back to returning the stored status
byte if not supported.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 639ed4e6afd1..01e3dcfd7c64 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -145,6 +145,7 @@ static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
 #define CCW_CMD_WRITE_CONF 0x21
 #define CCW_CMD_WRITE_STATUS 0x31
 #define CCW_CMD_READ_VQ_CONF 0x32
+#define CCW_CMD_READ_STATUS 0x72
 #define CCW_CMD_SET_IND_ADAPTER 0x73
 #define CCW_CMD_SET_VIRTIO_REV 0x83
 
@@ -160,6 +161,7 @@ static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
 #define VIRTIO_CCW_DOING_SET_CONF_IND 0x04000000
 #define VIRTIO_CCW_DOING_SET_IND_ADAPTER 0x08000000
 #define VIRTIO_CCW_DOING_SET_VIRTIO_REV 0x10000000
+#define VIRTIO_CCW_DOING_READ_STATUS 0x20000000
 #define VIRTIO_CCW_INTPARM_MASK 0xffff0000
 
 static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
@@ -892,6 +894,28 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+	u8 old_status = *vcdev->status;
+	struct ccw1 *ccw;
+
+	if (vcdev->revision < 1)
+		return *vcdev->status;
+
+	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	if (!ccw)
+		return old_status;
+
+	ccw->cmd_code = CCW_CMD_READ_STATUS;
+	ccw->flags = 0;
+	ccw->count = sizeof(*vcdev->status);
+	ccw->cda = (__u32)(unsigned long)vcdev->status;
+	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_STATUS);
+/*
+ * If the channel program failed (should only happen if the device
+ * was hotunplugged, and then we clean up via the machine check
+ * handler anyway), vcdev->status was not overwritten and we just
+ * return the old status, which is fine.
+*/
+	kfree(ccw);
 
 	return *vcdev->status;
 }
@@ -987,6 +1011,7 @@ static void virtio_ccw_check_activity(struct virtio_ccw_device *vcdev,
 		case VIRTIO_CCW_DOING_READ_CONFIG:
 		case VIRTIO_CCW_DOING_WRITE_CONFIG:
 		case VIRTIO_CCW_DOING_WRITE_STATUS:
+		case VIRTIO_CCW_DOING_READ_STATUS:
 		case VIRTIO_CCW_DOING_SET_VQ:
 		case VIRTIO_CCW_DOING_SET_IND:
 		case VIRTIO_CCW_DOING_SET_CONF_IND:
-- 
2.11.0
