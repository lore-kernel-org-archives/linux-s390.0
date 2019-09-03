Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfICQcM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Sep 2019 12:32:12 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 162/167] virtio/s390: fix race on airq_areas[]
Date: Tue,  3 Sep 2019 12:25:14 -0400
Message-Id: <20190903162519.7136-162-sashal@kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org

From: Halil Pasic <pasic@linux.ibm.com>

[ Upstream commit 4f419eb14272e0698e8c55bb5f3f266cc2a21c81 ]

The access to airq_areas was racy ever since the adapter interrupts got
introduced to virtio-ccw, but since commit 39c7dcb15892 ("virtio/s390:
make airq summary indicators DMA") this became an issue in practice as
well. Namely before that commit the airq_info that got overwritten was
still functional. After that commit however the two infos share a
summary_indicator, which aggravates the situation. Which means
auto-online mechanism occasionally hangs the boot with virtio_blk.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 96b14536d935 ("virtio-ccw: virtio-ccw adapter interrupt support.")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/virtio/virtio_ccw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index ec54538f7ae1c..67efdf25657f3 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -132,6 +132,7 @@ struct airq_info {
 	struct airq_iv *aiv;
 };
 static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
+static DEFINE_MUTEX(airq_areas_lock);
 
 #define CCW_CMD_SET_VQ 0x13
 #define CCW_CMD_VDEV_RESET 0x33
@@ -244,9 +245,11 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 	unsigned long bit, flags;
 
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
+		mutex_lock(&airq_areas_lock);
 		if (!airq_areas[i])
 			airq_areas[i] = new_airq_info();
 		info = airq_areas[i];
+		mutex_unlock(&airq_areas_lock);
 		if (!info)
 			return 0;
 		write_lock_irqsave(&info->lock, flags);
-- 
2.20.1
