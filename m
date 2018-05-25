From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH v2 02/10] vfio: ccw: Transform FSM functions to return state
Date: Fri, 25 May 2018 12:21:10 +0200
Message-ID: <1527243678-3140-3-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

We change the FSM functions to return the next state,
and adapt the fsm_func_t function type.

This will allow to factor FSM state change out of
the action routine.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 23 ++++++++++++++---------
 drivers/s390/cio/vfio_ccw_private.h |  5 +++--
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 24e1e04..756effb 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -65,7 +65,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	return ret;
 }
 
-static void fsm_notoper(struct vfio_ccw_private *private,
+static int fsm_notoper(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
 	struct subchannel *sch = private->sch;
@@ -75,31 +75,34 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	 * Probably we should send the machine check to the guest.
 	 */
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
-	private->state = VFIO_CCW_STATE_NOT_OPER;
+	return VFIO_CCW_STATE_NOT_OPER;
 }
 
 /*
  * No operation action.
  */
-static void fsm_nop(struct vfio_ccw_private *private,
+static int fsm_nop(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
+	return private->state;
 }
 
-static void fsm_io_error(struct vfio_ccw_private *private,
+static int fsm_io_error(struct vfio_ccw_private *private,
 			 enum vfio_ccw_event event)
 {
 	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
 	private->io_region.ret_code = -EIO;
+	return private->state;
 }
 
-static void fsm_io_busy(struct vfio_ccw_private *private,
+static int fsm_io_busy(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
 	private->io_region.ret_code = -EBUSY;
+	return private->state;
 }
 
-static void fsm_disabled_irq(struct vfio_ccw_private *private,
+static int fsm_disabled_irq(struct vfio_ccw_private *private,
 			     enum vfio_ccw_event event)
 {
 	struct subchannel *sch = private->sch;
@@ -109,12 +112,13 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
 	 * successful - should not happen, but we try to disable again.
 	 */
 	cio_disable_subchannel(sch);
+	return private->state;
 }
 
 /*
  * Deal with the ccw command request from the userspace.
  */
-static void fsm_io_request(struct vfio_ccw_private *private,
+static int fsm_io_request(struct vfio_ccw_private *private,
 			   enum vfio_ccw_event event)
 {
 	union orb *orb;
@@ -163,13 +167,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
-	private->state = VFIO_CCW_STATE_IDLE;
+	return VFIO_CCW_STATE_IDLE;
 }
 
 /*
  * Got an interrupt for a normal io (state busy).
  */
-static void fsm_irq(struct vfio_ccw_private *private,
+static int fsm_irq(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
 	struct irb *irb = &private->irb;
@@ -182,6 +186,7 @@ static void fsm_irq(struct vfio_ccw_private *private,
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
+	return private->state;
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 78a66d9..f526b18 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -83,13 +83,14 @@ enum vfio_ccw_event {
 /*
  * Action called through jumptable.
  */
-typedef void (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
+typedef int (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
 extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
-	vfio_ccw_jumptable[private->state][event](private, event);
+	private->state = vfio_ccw_jumptable[private->state][event](private,
+								   event);
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4
