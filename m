From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 1/1] vfio: ccw: fix error return in vfio_ccw_sch_event
Date: Wed,  2 May 2018 09:25:59 +0200
Message-ID: <20180502072559.50691-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If device has not been registered, or there is a pending work,
we should reschedule a sch_event call again.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
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
2.13.5
