Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:37600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfIDIP0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 04:15:26 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] vfio-ccw: fix error return code in vfio_ccw_sch_init()
Date: Wed, 4 Sep 2019 08:33:15 +0000
Message-ID: <20190904083315.105600-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, kernel-janitors@vger.kernel.org

Fix to return negative error code -ENOMEM from the memory alloc failed
error handling case instead of 0, as done elsewhere in this function.

Fixes: 60e05d1cf087 ("vfio-ccw: add some logging")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 45e792f6afd0..e401a3d0aa57 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -317,15 +317,19 @@ static int __init vfio_ccw_sch_init(void)
 					sizeof(struct ccw_io_region), 0,
 					SLAB_ACCOUNT, 0,
 					sizeof(struct ccw_io_region), NULL);
-	if (!vfio_ccw_io_region)
+	if (!vfio_ccw_io_region) {
+		ret = -ENOMEM;
 		goto out_err;
+	}
 
 	vfio_ccw_cmd_region = kmem_cache_create_usercopy("vfio_ccw_cmd_region",
 					sizeof(struct ccw_cmd_region), 0,
 					SLAB_ACCOUNT, 0,
 					sizeof(struct ccw_cmd_region), NULL);
-	if (!vfio_ccw_cmd_region)
+	if (!vfio_ccw_cmd_region) {
+		ret = -ENOMEM;
 		goto out_err;
+	}
 
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
