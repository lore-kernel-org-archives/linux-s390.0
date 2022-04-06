Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3BBC4332F
	for <linux-s390@archiver.kernel.org>; Wed,  6 Apr 2022 12:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiDFMSi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiDFMSB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Apr 2022 08:18:01 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FFC201B9;
        Tue,  5 Apr 2022 20:44:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0V9Jmrek_1649216657;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V9Jmrek_1649216657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 11:44:18 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v9 14/32] virtio_ring: packed: extract the logic of attach vring
Date:   Wed,  6 Apr 2022 11:43:28 +0800
Message-Id: <20220406034346.74409-15-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 881cb3483d12
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Separate the logic of attach vring, the subsequent patch will call it
separately.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 47 +++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5b5976c5742e..80d446fa8d16 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1904,6 +1904,35 @@ static int vring_alloc_state_extra_packed(u32 num,
 	return -ENOMEM;
 }
 
+static void vring_virtqueue_attach_packed(struct vring_virtqueue *vq,
+					  u32 num,
+					  struct vring_packed_desc *ring,
+					  struct vring_packed_desc_event *driver,
+					  struct vring_packed_desc_event *device,
+					  dma_addr_t ring_dma_addr,
+					  dma_addr_t driver_event_dma_addr,
+					  dma_addr_t device_event_dma_addr,
+					  size_t ring_size_in_bytes,
+					  size_t event_size_in_bytes,
+					  struct vring_desc_state_packed *state,
+					  struct vring_desc_extra *extra)
+{
+	vq->packed.ring_dma_addr = ring_dma_addr;
+	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = device_event_dma_addr;
+
+	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = event_size_in_bytes;
+
+	vq->packed.vring.num = num;
+	vq->packed.vring.desc = ring;
+	vq->packed.vring.driver = driver;
+	vq->packed.vring.device = device;
+
+	vq->packed.desc_state = state;
+	vq->packed.desc_extra = extra;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1962,18 +1991,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	vq->packed.ring_dma_addr = ring_dma_addr;
-	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = device_event_dma_addr;
-
-	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = event_size_in_bytes;
-
-	vq->packed.vring.num = num;
-	vq->packed.vring.desc = ring;
-	vq->packed.vring.driver = driver;
-	vq->packed.vring.device = device;
-
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
 	vq->packed.used_wrap_counter = 1;
@@ -1984,8 +2001,10 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (err)
 		goto err_state_extra;
 
-	vq->packed.desc_state = state;
-	vq->packed.desc_extra = extra;
+	vring_virtqueue_attach_packed(vq, num, ring, driver, device,
+				      ring_dma_addr, driver_event_dma_addr,
+				      device_event_dma_addr, ring_size_in_bytes,
+				      event_size_in_bytes, state, extra);
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-- 
2.31.0

