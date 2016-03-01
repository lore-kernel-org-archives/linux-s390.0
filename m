From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] virtio/s390: size of SET_IND payload
Date: Tue,  1 Mar 2016 13:44:53 +0100
Message-ID: <1456836293-49239-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1456836293-49239-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1456836293-49239-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

SET_IND takes as a payload the _address_ of the indicators, meaning
that we have one of the rare cases where kmalloc(sizeof(&...)) is
actually correct. Let's clarify that with a comment.

The count for the ccw, however, was only correct because the
indicators are 64 bit. Let's use the correct value.

Reported-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 46b110a1..8688ad4 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -342,13 +342,14 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		ccw->count = sizeof(*thinint_area);
 		ccw->cda = (__u32)(unsigned long) thinint_area;
 	} else {
+		/* payload is the address of the indicators */
 		indicatorp = kmalloc(sizeof(&vcdev->indicators),
 				     GFP_DMA | GFP_KERNEL);
 		if (!indicatorp)
 			return;
 		*indicatorp = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
-		ccw->count = sizeof(vcdev->indicators);
+		ccw->count = sizeof(&vcdev->indicators);
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 	}
 	/* Deregister indicators from host. */
@@ -656,7 +657,10 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		}
 	}
 	ret = -ENOMEM;
-	/* We need a data area under 2G to communicate. */
+	/*
+	 * We need a data area under 2G to communicate. Our payload is
+	 * the address of the indicators.
+	*/
 	indicatorp = kmalloc(sizeof(&vcdev->indicators), GFP_DMA | GFP_KERNEL);
 	if (!indicatorp)
 		goto out;
@@ -672,7 +676,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		vcdev->indicators = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
 		ccw->flags = 0;
-		ccw->count = sizeof(vcdev->indicators);
+		ccw->count = sizeof(&vcdev->indicators);
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
 		if (ret)
@@ -683,7 +687,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	vcdev->indicators2 = 0;
 	ccw->cmd_code = CCW_CMD_SET_CONF_IND;
 	ccw->flags = 0;
-	ccw->count = sizeof(vcdev->indicators2);
+	ccw->count = sizeof(&vcdev->indicators2);
 	ccw->cda = (__u32)(unsigned long) indicatorp;
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
 	if (ret)
-- 
2.3.9
