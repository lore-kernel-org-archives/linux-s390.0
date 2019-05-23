Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v2 6/8] virtio/s390: add indirection to indicators access
Date: Thu, 23 May 2019 18:22:07 +0200
In-Reply-To: <20190523162209.9543-1-mimu@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
Message-Id: <20190523162209.9543-7-mimu@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.ibm.com>

This will come in handy soon when we pull out the indicators from
virtio_ccw_device to a memory area that is shared with the hypervisor
(in particular for protected virtualization guests).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 1da7430f94c8..e96a8cc56ec2 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -68,6 +68,16 @@ struct virtio_ccw_device {
 	void *airq_info;
 };
 
+static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
+{
+	return &vcdev->indicators;
+}
+
+static inline unsigned long *indicators2(struct virtio_ccw_device *vcdev)
+{
+	return &vcdev->indicators2;
+}
+
 struct vq_info_block_legacy {
 	__u64 queue;
 	__u32 align;
@@ -338,17 +348,17 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		ccw->cda = (__u32)(unsigned long) thinint_area;
 	} else {
 		/* payload is the address of the indicators */
-		indicatorp = kmalloc(sizeof(&vcdev->indicators),
+		indicatorp = kmalloc(sizeof(indicators(vcdev)),
 				     GFP_DMA | GFP_KERNEL);
 		if (!indicatorp)
 			return;
 		*indicatorp = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
-		ccw->count = sizeof(&vcdev->indicators);
+		ccw->count = sizeof(indicators(vcdev));
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 	}
 	/* Deregister indicators from host. */
-	vcdev->indicators = 0;
+	*indicators(vcdev) = 0;
 	ccw->flags = 0;
 	ret = ccw_io_helper(vcdev, ccw,
 			    vcdev->is_thinint ?
@@ -657,10 +667,10 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * We need a data area under 2G to communicate. Our payload is
 	 * the address of the indicators.
 	*/
-	indicatorp = kmalloc(sizeof(&vcdev->indicators), GFP_DMA | GFP_KERNEL);
+	indicatorp = kmalloc(sizeof(indicators(vcdev)), GFP_DMA | GFP_KERNEL);
 	if (!indicatorp)
 		goto out;
-	*indicatorp = (unsigned long) &vcdev->indicators;
+	*indicatorp = (unsigned long) indicators(vcdev);
 	if (vcdev->is_thinint) {
 		ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);
 		if (ret)
@@ -669,21 +679,21 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	}
 	if (!vcdev->is_thinint) {
 		/* Register queue indicators with host. */
-		vcdev->indicators = 0;
+		*indicators(vcdev) = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
 		ccw->flags = 0;
-		ccw->count = sizeof(&vcdev->indicators);
+		ccw->count = sizeof(indicators(vcdev));
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
 		if (ret)
 			goto out;
 	}
 	/* Register indicators2 with host for config changes */
-	*indicatorp = (unsigned long) &vcdev->indicators2;
-	vcdev->indicators2 = 0;
+	*indicatorp = (unsigned long) indicators2(vcdev);
+	*indicators2(vcdev) = 0;
 	ccw->cmd_code = CCW_CMD_SET_CONF_IND;
 	ccw->flags = 0;
-	ccw->count = sizeof(&vcdev->indicators2);
+	ccw->count = sizeof(indicators2(vcdev));
 	ccw->cda = (__u32)(unsigned long) indicatorp;
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
 	if (ret)
@@ -1093,17 +1103,17 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-	for_each_set_bit(i, &vcdev->indicators,
-			 sizeof(vcdev->indicators) * BITS_PER_BYTE) {
+	for_each_set_bit(i, indicators(vcdev),
+			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
-		clear_bit(i, &vcdev->indicators);
+		clear_bit(i, indicators(vcdev));
 		barrier();
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-	if (test_bit(0, &vcdev->indicators2)) {
+	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
-		clear_bit(0, &vcdev->indicators2);
+		clear_bit(0, indicators2(vcdev));
 	}
 }
 
-- 
2.13.4
