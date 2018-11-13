From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 13 Nov 2018 12:47:53 +0000
Subject: [PULL 2/4] vfio: ccw: Register mediated device once all structures are initialized
Message-Id: <20181113124755.4798-3-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

Let's register the mediated device when all the data structures
which could be used are initialized.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <1540487720-11634-3-git-send-email-pmorel@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index edbf542d82af..a10cec0e86eb 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -134,14 +134,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_free;
 
-	ret = vfio_ccw_mdev_reg(sch);
-	if (ret)
-		goto out_disable;
-
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
+	ret = vfio_ccw_mdev_reg(sch);
+	if (ret)
+		goto out_disable;
+
 	return 0;
 
 out_disable:
-- 
2.17.2
