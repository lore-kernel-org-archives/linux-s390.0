From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/1] virtio/s390: handle error values in irb
Date: Thu,  3 Dec 2015 17:24:00 +0100
Message-ID: <1449159840-60270-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1449159840-60270-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449159840-60270-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The common I/O layer may pass an error value as the irb in the device's
interrupt handler (for classic channel I/O). This won't happen in
current virtio-ccw implementations, but it's better to be safe than
sorry.

Let's just return the error conveyed by the irb and clear any possible
pending I/O indications.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 62 ++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b2a1a81..1b83159 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -984,6 +984,36 @@ static struct virtqueue *virtio_ccw_vq_by_ind(struct virtio_ccw_device *vcdev,
 	return vq;
 }
 
+static void virtio_ccw_check_activity(struct virtio_ccw_device *vcdev,
+				      __u32 activity)
+{
+	if (vcdev->curr_io & activity) {
+		switch (activity) {
+		case VIRTIO_CCW_DOING_READ_FEAT:
+		case VIRTIO_CCW_DOING_WRITE_FEAT:
+		case VIRTIO_CCW_DOING_READ_CONFIG:
+		case VIRTIO_CCW_DOING_WRITE_CONFIG:
+		case VIRTIO_CCW_DOING_WRITE_STATUS:
+		case VIRTIO_CCW_DOING_SET_VQ:
+		case VIRTIO_CCW_DOING_SET_IND:
+		case VIRTIO_CCW_DOING_SET_CONF_IND:
+		case VIRTIO_CCW_DOING_RESET:
+		case VIRTIO_CCW_DOING_READ_VQ_CONF:
+		case VIRTIO_CCW_DOING_SET_IND_ADAPTER:
+		case VIRTIO_CCW_DOING_SET_VIRTIO_REV:
+			vcdev->curr_io &= ~activity;
+			wake_up(&vcdev->wait_q);
+			break;
+		default:
+			/* don't know what to do... */
+			dev_warn(&vcdev->cdev->dev,
+				 "Suspicious activity '%08x'\n", activity);
+			WARN_ON(1);
+			break;
+		}
+	}
+}
+
 static void virtio_ccw_int_handler(struct ccw_device *cdev,
 				   unsigned long intparm,
 				   struct irb *irb)
@@ -995,6 +1025,12 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 
 	if (!vcdev)
 		return;
+	if (IS_ERR(irb)) {
+		vcdev->err = PTR_ERR(irb);
+		virtio_ccw_check_activity(vcdev, activity);
+		/* Don't poke around indicators, something's wrong. */
+		return;
+	}
 	/* Check if it's a notification from the host. */
 	if ((intparm == 0) &&
 	    (scsw_stctl(&irb->scsw) ==
@@ -1010,31 +1046,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			/* Map everything else to -EIO. */
 			vcdev->err = -EIO;
 	}
-	if (vcdev->curr_io & activity) {
-		switch (activity) {
-		case VIRTIO_CCW_DOING_READ_FEAT:
-		case VIRTIO_CCW_DOING_WRITE_FEAT:
-		case VIRTIO_CCW_DOING_READ_CONFIG:
-		case VIRTIO_CCW_DOING_WRITE_CONFIG:
-		case VIRTIO_CCW_DOING_WRITE_STATUS:
-		case VIRTIO_CCW_DOING_SET_VQ:
-		case VIRTIO_CCW_DOING_SET_IND:
-		case VIRTIO_CCW_DOING_SET_CONF_IND:
-		case VIRTIO_CCW_DOING_RESET:
-		case VIRTIO_CCW_DOING_READ_VQ_CONF:
-		case VIRTIO_CCW_DOING_SET_IND_ADAPTER:
-		case VIRTIO_CCW_DOING_SET_VIRTIO_REV:
-			vcdev->curr_io &= ~activity;
-			wake_up(&vcdev->wait_q);
-			break;
-		default:
-			/* don't know what to do... */
-			dev_warn(&cdev->dev, "Suspicious activity '%08x'\n",
-				 activity);
-			WARN_ON(1);
-			break;
-		}
-	}
+	virtio_ccw_check_activity(vcdev, activity);
 	for_each_set_bit(i, &vcdev->indicators,
 			 sizeof(vcdev->indicators) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
-- 
2.3.9
