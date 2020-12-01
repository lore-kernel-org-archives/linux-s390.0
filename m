Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8168 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLAGYu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 01:24:50 -0500
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] s390: cio: fix use-after-free in ccw_device_destroy_console
Date: Tue, 1 Dec 2020 14:31:50 +0800
Message-ID: <20201201063150.82128-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>

put_device calls release function which do kfree() inside.
So following use of sch&cdev would cause use-after-free bugs.

Fix these by simply adjusting the position of put_device.

Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 This patch is indeed a v2 of older one. Considering that the
 patch's name has changed, I think a normal prefix 'PATCH' is
 better.

 drivers/s390/cio/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index b29fe8d50..33280ca18 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
 	struct io_subchannel_private *io_priv = to_io_private(sch);
 
 	set_io_private(sch, NULL);
-	put_device(&sch->dev);
-	put_device(&cdev->dev);
 	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
 			  io_priv->dma_area, io_priv->dma_area_dma);
+	put_device(&sch->dev);
+	put_device(&cdev->dev);
 	kfree(io_priv);
 }
 
-- 
2.23.0
