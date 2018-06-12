From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 3/8] vfio: ccw: new VFIO_CCW_EVENT_SCHIB_CHANGED event
Date: Tue, 12 Jun 2018 09:56:45 +0200
Message-ID: <1528790210-19535-4-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

The Sub channel event callback is threaded using workqueues.
The work uses the FSM introducing the VFIO_CCW_EVENT_SCHIB_CHANGED
event.
The update of the SCHIB is now done inside the FSM function.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 33 ++++++++++++---------------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  3 +++
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 095a2d9..e5a516a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -75,6 +75,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 }
 
+static void vfio_ccw_sch_event_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private = container_of(work, struct vfio_ccw_private, event_work);
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SCHIB_CHANGED);
+}
+
 /*
  * Css driver callbacks
  */
@@ -122,6 +130,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 		goto out_disable;
 
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
+	INIT_WORK(&private->event_work, vfio_ccw_sch_event_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -168,28 +177,10 @@ static void vfio_ccw_sch_shutdown(struct subchannel *sch)
 static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(sch->lock, flags);
-	if (!device_is_registered(&sch->dev))
-		goto out_unlock;
 
-	if (work_pending(&sch->todo_work))
-		goto out_unlock;
-
-	if (cio_update_schib(sch)) {
-		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
-		goto out_unlock;
-	}
-
-	private = dev_get_drvdata(&sch->dev);
-	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
-		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
-				 VFIO_CCW_STATE_STANDBY;
-	}
-
-out_unlock:
-	spin_unlock_irqrestore(sch->lock, flags);
+	if (work_pending(&private->event_work))
+		return -EAGAIN;
+	queue_work(vfio_ccw_work_q, &private->event_work);
 
 	return 0;
 }
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 1a0585f..94bf151 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -191,6 +191,24 @@ static int fsm_irq(struct vfio_ccw_private *private,
 }
 
 /*
+ * Got a sub-channel event .
+ */
+static int fsm_sch_event(struct vfio_ccw_private *private,
+			 enum vfio_ccw_event event)
+{
+	unsigned long flags;
+	int ret = private->state;
+	struct subchannel *sch = private->sch;
+
+	spin_lock_irqsave(sch->lock, flags);
+	if (cio_update_schib(sch))
+		ret = VFIO_CCW_STATE_NOT_OPER;
+	spin_unlock_irqrestore(sch->lock, flags);
+
+	return ret;
+}
+
+/*
  * Device statemachine
  */
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
@@ -198,25 +216,30 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 };
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index f526b18..a2be0c9 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -33,6 +33,7 @@
  * @scsw: scsw info
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @io_work: work for deferral process of I/O handling
+ * @event_work: work for deferral process of sub-channel event
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -49,6 +50,7 @@ struct vfio_ccw_private {
 
 	struct eventfd_ctx	*io_trigger;
 	struct work_struct	io_work;
+	struct work_struct	event_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
@@ -76,6 +78,7 @@ enum vfio_ccw_event {
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
+	VFIO_CCW_EVENT_SCHIB_CHANGED,
 	/* last element! */
 	NR_VFIO_CCW_EVENTS
 };
-- 
2.7.4
