From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] s390: virtio: Improve a size determination in
 virtio_ccw_setup_vq()
Date: Tue, 16 May 2017 17:52:46 +0200
Message-ID: <20b190c9-6ca9-4536-645a-10f7753fb53e@users.sourceforge.net>
References: <d02fd34c-da59-0c33-d859-e49ecb4eb1c5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d02fd34c-da59-0c33-d859-e49ecb4eb1c5@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 17:05:01 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/virtio/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 447fe718c0ab..bfb845d7faa7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -495,5 +495,5 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	unsigned long flags;
 
 	/* Allocate queue. */
-	info = kzalloc(sizeof(struct virtio_ccw_vq_info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
-- 
2.13.0
