From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 5/5] virtio/s390: virtio: constify virtio_config_ops structures
Date: Mon, 16 Jan 2017 15:04:33 +0100
Message-ID: <20170116140433.21301-6-cornelia.huck@de.ibm.com>
References: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Bhumika Goyal <bhumirks@gmail.com>

Declare virtio_config_ops structure as const as it is only stored in the
config field of a virtio_device structure. This field is of type const, so
virtio_config_ops structures having this property can be declared const.
Done using Coccinelle:

@r1 disable optional_qualifier@
identifier i;
position p;
@@
static struct virtio_config_ops i@p={...};

@ok1@
identifier r1.i;
position p;
struct virtio_ccw_device x;
@@
x.vdev.config=&i@p

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct virtio_config_ops i;

File size before and after applying the patch remains the same.
text	data	bss	dec	hex   filename
9235	296	32928	42459	a5db  drivers/s390/virtio/virtio_ccw.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1484333336-13443-1-git-send-email-bhumirks@gmail.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 0672c6234ae8..070c4da95f48 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -944,7 +944,7 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 	kfree(ccw);
 }
 
-static struct virtio_config_ops virtio_ccw_config_ops = {
+static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_features = virtio_ccw_get_features,
 	.finalize_features = virtio_ccw_finalize_features,
 	.get = virtio_ccw_get_config,
-- 
2.11.0
