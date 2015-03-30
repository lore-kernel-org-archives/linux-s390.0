Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 30 Mar 2015 19:37:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/6] virtio_ccw: support non-legacy balloon devices
Message-ID: <1427737006-23191-4-git-send-email-mst@redhat.com>
References: <1427737006-23191-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427737006-23191-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

virtio_device_is_legacy_only is always false now,
drop the test from virtio ccw.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/s390/kvm/virtio_ccw.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 71d7802..6f1fa17 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -1201,13 +1201,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	vcdev->vdev.id.vendor = cdev->id.cu_type;
 	vcdev->vdev.id.device = cdev->id.cu_model;
 
-	if (virtio_device_is_legacy_only(vcdev->vdev.id)) {
-		vcdev->revision = 0;
-	} else {
-		ret = virtio_ccw_set_transport_rev(vcdev);
-		if (ret)
-			goto out_free;
-	}
+	ret = virtio_ccw_set_transport_rev(vcdev);
+	if (ret)
+		goto out_free;
 
 	ret = register_virtio_device(&vcdev->vdev);
 	if (ret) {
-- 
MST
