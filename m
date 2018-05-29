From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/6] vfio: ccw: fix error return in vfio_ccw_sch_event
Date: Tue, 29 May 2018 14:35:07 +0200
Message-ID: <20180529123512.14393-2-cohuck@redhat.com>
References: <20180529123512.14393-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529123512.14393-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

If the device has not been registered, or there is work pending,
we should reschedule a sch_event call again.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180502072559.50691-1-bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0b2894..770fa9cfc310 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -177,6 +177,7 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	unsigned long flags;
+	int rc = -EAGAIN;
 
 	spin_lock_irqsave(sch->lock, flags);
 	if (!device_is_registered(&sch->dev))
@@ -187,6 +188,7 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 
 	if (cio_update_schib(sch)) {
 		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
+		rc = 0;
 		goto out_unlock;
 	}
 
@@ -195,11 +197,12 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
 				 VFIO_CCW_STATE_STANDBY;
 	}
+	rc = 0;
 
 out_unlock:
 	spin_unlock_irqrestore(sch->lock, flags);
 
-	return 0;
+	return rc;
 }
 
 static struct css_device_id vfio_ccw_sch_ids[] = {
-- 
2.14.3
