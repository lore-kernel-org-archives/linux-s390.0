Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v1 1/1] vfio-ccw: Destroy kmem cache region on module exit
Date: Mon,  3 Jun 2019 11:42:47 -0400
Message-Id: <c0f39039d28af39ea2939391bf005e3495d890fd.1559576250.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1559576250.git.alifm@linux.ibm.com>
References: <cover.1559576250.git.alifm@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Free the vfio_ccw_cmd_region on module exit.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---

I guess I missed this earlier while reviewing, but should'nt 
we destroy the vfio_ccw_cmd_region on module exit, as well?

 drivers/s390/cio/vfio_ccw_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 66a66ac..9cee9f2 100644
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
2.7.4
