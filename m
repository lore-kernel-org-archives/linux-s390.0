From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 4/6] vfio: ccw: Rework subchannel state on sch_event
Date: Wed, 28 Nov 2018 13:41:05 +0100
Message-ID: <1543408867-16465-5-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We do not need to change the state when handling events.

If we can not update the SCHIB it is an unrecoverable error
independent of the real sub channel.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1779b46..687ca42 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -198,18 +198,9 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 	if (work_pending(&sch->todo_work))
 		goto out_unlock;
 
-	if (cio_update_schib(sch)) {
-		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
-		rc = 0;
-		goto out_unlock;
-	}
-
-	private = dev_get_drvdata(&sch->dev);
-	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
-		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
-				 VFIO_CCW_STATE_STANDBY;
-	}
 	rc = 0;
+	if (cio_update_schib(sch) && private)
+		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
 
 out_unlock:
 	spin_unlock_irqrestore(sch->lock, flags);
-- 
2.7.4
