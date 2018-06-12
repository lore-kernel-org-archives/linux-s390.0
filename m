From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 6/8] vfio: ccw: Make FSM functions atomic
Date: Tue, 12 Jun 2018 09:56:48 +0200
Message-ID: <1528790210-19535-7-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

We use mutex around the FSM function call to make the FSM
event handling and state change atomic.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 1 +
 drivers/s390/cio/vfio_ccw_private.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index e5a516a..98951d5 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -116,6 +116,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 		return -ENOMEM;
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
+	mutex_init(&private->state_mutex);
 
 	spin_lock_irq(sch->lock);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 521ba0b..e3dc12c 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -51,6 +51,7 @@ struct vfio_ccw_private {
 	struct eventfd_ctx	*io_trigger;
 	struct work_struct	io_work;
 	struct work_struct	event_work;
+	struct mutex		state_mutex;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
@@ -92,7 +93,9 @@ extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
+	mutex_lock(&private->state_mutex);
 	private->state = vfio_ccw_jumptable[private->state][event](private);
+	mutex_unlock(&private->state_mutex);
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4
