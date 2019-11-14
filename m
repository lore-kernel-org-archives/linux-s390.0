Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbfKNMrS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 07:47:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAECkKYc109677
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:47:17 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w96f89evx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:47:16 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 14 Nov 2019 12:47:13 -0000
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Date: Thu, 14 Nov 2019 13:46:46 +0100
Message-Id: <20191114124646.74790-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>

Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
a very realistic scenario for guests with encrypted memory, as swiotlb
may run out of space, depending on it's size and the I/O load.

The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
error, despite the fact that swiotlb full is in absence of bugs a
recoverable condition.

Let us change the return code to -ENOMEM, and make the block layer
recover form these failures when virtio-blk encounters the condition
described above.

Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
---

Notes
=====

* When out of descriptors (which might regarded as a similar out of
resources condition) virtio uses -ENOSPC, this however seems wrong,
as ENOSPC is defined as -ENOSPC. Thus I choose -ENOMEM over -ENOSPC.

* In virtio_queue_rq() in virtio_blk.c both -ENOMEM and -ENOSPC are
handled as BLK_STS_DEV_RESOURCE. Returning BLK_STS_RESOURCE however
seems more appropriate for dma mapping failed as we are talking about
a global, and not a device local resource. Both seem to do the trick.

* Mimu tested the patch with virtio-blk and virtio-net (thanks!). We
should look into how other virtio devices behave when DMA mapping fails.
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a8041e451e9e..867c7ebd3f10 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		kfree(desc);
 
 	END_USE(vq);
-	return -EIO;
+	return -ENOMEM;
 }
 
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
@@ -1085,7 +1085,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	kfree(desc);
 
 	END_USE(vq);
-	return -EIO;
+	return -ENOMEM;
 }
 
 static inline int virtqueue_add_packed(struct virtqueue *_vq,
-- 
2.17.1
