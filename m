From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 1/6] vfio: ccw: Register mediated device once all structures are initialized
Date: Wed, 28 Nov 2018 13:41:02 +0100
Message-ID: <1543408867-16465-2-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

There is a risk that the mediated device is used before all the
data are initialized if it is registered too early.

Let's register the mediated device when all the data structures
which could be used are initialized.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 2f2e5d1..bce7fed 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -141,14 +141,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
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
2.7.4
