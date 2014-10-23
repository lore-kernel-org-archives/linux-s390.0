Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Oct 2014 20:49:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] fixup! KVM: s390 allow virtio_ccw status writes to fail
Message-ID: <1414086476-24772-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Forgot that I need a cross-compiler for s390 changes, so of course
they don't build :(
Will repost later, for now here's a fix.

---
 drivers/s390/kvm/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 6add617..9b5aa0b 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -862,7 +862,7 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	u8 old_status = vcdev->status;
+	u8 old_status = *vcdev->status;
 	struct ccw1 *ccw;
 	int ret;
 
-- 
MST
