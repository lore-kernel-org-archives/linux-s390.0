Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 03/10] virtio/s390: enable packed ring
Date: Fri, 26 Apr 2019 20:32:38 +0200
In-Reply-To: <20190426183245.37939-1-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
Message-Id: <20190426183245.37939-4-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Nothing precludes to accepting  VIRTIO_F_RING_PACKED any more.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 42832a164546..6d989c360f38 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -773,10 +773,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 static void ccw_transport_features(struct virtio_device *vdev)
 {
 	/*
-	 * There shouldn't be anything that precludes supporting packed.
-	 * TODO: Remove the limitation after having another look into this.
+	 * Currently nothing to do here.
 	 */
-	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
 }
 
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
-- 
2.16.4
