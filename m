From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 13 Nov 2018 12:47:52 +0000
Subject: [PULL 1/4] s390/cio: make vfio_ccw_io_region static
Message-Id: <20181113124755.4798-2-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.ibm.com>

Fix the following sparse warning:
drivers/s390/cio/vfio_ccw_drv.c:25:19: warning: symbol 'vfio_ccw_io_region'
was not declared. Should it be static?

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Message-Id: <alpine.LFD.2.21.1810151328570.1636@schleppi.aag-de.ibmmobiledemo.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index f47d16b5810b..edbf542d82af 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -22,7 +22,7 @@
 #include "vfio_ccw_private.h"
 
 struct workqueue_struct *vfio_ccw_work_q;
-struct kmem_cache *vfio_ccw_io_region;
+static struct kmem_cache *vfio_ccw_io_region;
 
 /*
  * Helpers
-- 
2.17.2
