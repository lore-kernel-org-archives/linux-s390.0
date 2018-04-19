From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH 08/10] vfio: ccw: Handling reset and shutdown with states
Date: Thu, 19 Apr 2018 16:48:11 +0200
Message-ID: <1524149293-12658-9-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Two new events, VFIO_CCW_EVENT_ONLINE and VFIO_CCW_EVENT_OFFLINE
allow to handle the enabling and disabling of a Sub Channel and
the shutdown, quiesce and reset operations are changed accordingly.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 47 ++++++--------------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 66 +++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     | 15 +++------
 drivers/s390/cio/vfio_ccw_private.h |  3 ++
 4 files changed, 83 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index f6e7def1..7175c64 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -30,41 +30,13 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	DECLARE_COMPLETION_ONSTACK(completion);
-	int iretry, ret = 0;
-
-	spin_lock_irq(sch->lock);
-	if (!sch->schib.pmcw.ena)
-		goto out_unlock;
-	ret = cio_disable_subchannel(sch);
-	if (ret != -EBUSY)
-		goto out_unlock;
-
-	do {
-		iretry = 255;
-
-		ret = cio_cancel_halt_clear(sch, &iretry);
-		while (ret == -EBUSY) {
-			/*
-			 * Flush all I/O and wait for
-			 * cancel/halt/clear completion.
-			 */
-			private->completion = &completion;
-			spin_unlock_irq(sch->lock);
-
-			wait_for_completion_timeout(&completion, 3*HZ);
-
-			spin_lock_irq(sch->lock);
-			private->completion = NULL;
-			flush_workqueue(vfio_ccw_work_q);
-			ret = cio_cancel_halt_clear(sch, &iretry);
-		};
-
-		ret = cio_disable_subchannel(sch);
-	} while (ret == -EBUSY);
-out_unlock:
-	private->state = VFIO_CCW_STATE_NOT_OPER;
-	spin_unlock_irq(sch->lock);
-	return ret;
+
+	private->completion = &completion;
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_OFFLINE);
+	wait_for_completion(&completion);
+	if (private->state != VFIO_CCW_STATE_STANDBY)
+		return -EFAULT;
+	return 0;
 }
 
 static void vfio_ccw_sch_io_todo(struct work_struct *work)
@@ -97,8 +69,6 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
 
 	WARN_ON(work_pending(&private->io_work));
 	queue_work(vfio_ccw_work_q, &private->io_work);
-	if (private->completion)
-		complete(private->completion);
 }
 
 static int vfio_ccw_sch_probe(struct subchannel *sch)
@@ -132,6 +102,9 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	ret = -EFAULT;
 	if (private->state != VFIO_CCW_STATE_STANDBY)
 		goto out_unreg;
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_ONLINE);
+	if (private->state != VFIO_CCW_STATE_IDLE)
+		goto out_unreg;
 
 	return 0;
 
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index e8fe1e6..444424e 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -68,6 +68,53 @@ static int fsm_notoper(struct vfio_ccw_private *private)
 	return VFIO_CCW_STATE_NOT_OPER;
 }
 
+static int fsm_online(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch = private->sch;
+	int ret = VFIO_CCW_STATE_IDLE;
+
+	spin_lock_irq(sch->lock);
+	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+		ret = VFIO_CCW_STATE_NOT_OPER;
+	spin_unlock_irq(sch->lock);
+
+	return ret;
+}
+static int fsm_offline(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch = private->sch;
+	int ret = VFIO_CCW_STATE_STANDBY;
+
+	spin_lock_irq(sch->lock);
+	if (cio_disable_subchannel(sch))
+		ret = VFIO_CCW_STATE_NOT_OPER;
+	spin_unlock_irq(sch->lock);
+	if (private->completion)
+		complete(private->completion);
+
+	return ret;
+}
+static int fsm_quiescing(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch = private->sch;
+	int ret = VFIO_CCW_STATE_STANDBY;
+	int iretry = 255;
+
+	spin_lock_irq(sch->lock);
+	ret = cio_cancel_halt_clear(sch, &iretry);
+	if (ret == -EBUSY)
+		ret = VFIO_CCW_STATE_QUIESCING;
+	else if (private->completion)
+		complete(private->completion);
+	spin_unlock_irq(sch->lock);
+	return ret;
+}
+static int fsm_quiescing_done(struct vfio_ccw_private *private)
+{
+	if (private->completion)
+		complete(private->completion);
+	return VFIO_CCW_STATE_STANDBY;
+}
 /*
  * No operation action.
  */
@@ -189,6 +236,8 @@ static int fsm_init(struct vfio_ccw_private *private)
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	[VFIO_CCW_STATE_NOT_OPER] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_init,
+		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
+		[VFIO_CCW_EVENT_OFFLINE]	= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
@@ -196,6 +245,8 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
+		[VFIO_CCW_EVENT_ONLINE]		= fsm_online,
+		[VFIO_CCW_EVENT_OFFLINE]	= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
@@ -203,6 +254,8 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
+		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
+		[VFIO_CCW_EVENT_OFFLINE]	= fsm_offline,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
@@ -210,6 +263,8 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	},
 	[VFIO_CCW_STATE_BOXED] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
+		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
+		[VFIO_CCW_EVENT_OFFLINE]	= fsm_quiescing,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
@@ -217,9 +272,20 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
+		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
+		[VFIO_CCW_EVENT_OFFLINE]	= fsm_quiescing,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
+	[VFIO_CCW_STATE_QUIESCING] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
+		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
+		[VFIO_CCW_EVENT_OFFLINE]	= fsm_nop,
+		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
+		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
+		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_quiescing_done,
+		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
+	},
 };
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 78d1925..f0f4071 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -21,21 +21,14 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
 	sch = private->sch;
-	/*
-	 * TODO:
-	 * In the cureent stage, some things like "no I/O running" and "no
-	 * interrupt pending" are clear, but we are not sure what other state
-	 * we need to care about.
-	 * There are still a lot more instructions need to be handled. We
-	 * should come back here later.
-	 */
+
 	ret = vfio_ccw_sch_quiesce(sch);
 	if (ret)
 		return ret;
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_ONLINE);
 
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	if (!ret)
-		private->state = VFIO_CCW_STATE_IDLE;
+	if (!(private->state == VFIO_CCW_STATE_IDLE))
+		ret = -EFAULT;
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index cacf677..e7ea076 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -68,6 +68,7 @@ enum vfio_ccw_state {
 	VFIO_CCW_STATE_IDLE,
 	VFIO_CCW_STATE_BOXED,
 	VFIO_CCW_STATE_BUSY,
+	VFIO_CCW_STATE_QUIESCING,
 	/* last element! */
 	NR_VFIO_CCW_STATES
 };
@@ -81,6 +82,8 @@ enum vfio_ccw_event {
 	VFIO_CCW_EVENT_SSCH_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
 	VFIO_CCW_EVENT_SCH_EVENT,
+	VFIO_CCW_EVENT_ONLINE,
+	VFIO_CCW_EVENT_OFFLINE,
 	/* last element! */
 	NR_VFIO_CCW_EVENTS
 };
-- 
2.7.4
