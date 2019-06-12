Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfFLKQv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:16:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio-ccw: Destroy kmem cache region on module exit
Date: Wed, 12 Jun 2019 12:16:45 +0200
Message-Id: <20190612101645.9439-2-cohuck@redhat.com>
In-Reply-To: <20190612101645.9439-1-cohuck@redhat.com>
References: <20190612101645.9439-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.ibm.com>

Free the vfio_ccw_cmd_region on module exit.

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Message-Id: <c0f39039d28af39ea2939391bf005e3495d890fd.1559576250.git.alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 66a66ac1f3d1..9cee9f20d310 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -299,6 +299,7 @@ static void __exit vfio_ccw_sch_exit(void)
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
 	kmem_cache_destroy(vfio_ccw_io_region);
+	kmem_cache_destroy(vfio_ccw_cmd_region);
 	destroy_workqueue(vfio_ccw_work_q);
 }
 module_init(vfio_ccw_sch_init);
-- 
2.20.1
