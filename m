From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH 02/10] vfio: ccw: Transform FSM functions to return state
Date: Thu, 19 Apr 2018 16:48:05 +0200
Message-ID: <1524149293-12658-3-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

We change the FSM functions to return the next state,
and adapt the fsm_func_t function type.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 24 ++++++++++++++++--------
 drivers/s390/cio/vfio_ccw_private.h |  5 +++--
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index af88551..2f3108d 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -60,7 +60,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	}
 }
 
-static void fsm_notoper(struct vfio_ccw_private *private,
+static int fsm_notoper(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
 	struct subchannel *sch = private->sch;
@@ -71,30 +71,34 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	 */
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
+	return private->state;
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
@@ -104,12 +108,13 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
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
@@ -141,7 +146,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 			cp_free(&private->cp);
 			goto err_out;
 		}
-		return;
+		return private->state;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		/* XXX: Handle halt. */
 		io_region->ret_code = -EOPNOTSUPP;
@@ -154,12 +159,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 
 err_out:
 	private->state = VFIO_CCW_STATE_IDLE;
+	return private->state;
 }
 
 /*
  * Got an interrupt for a normal io (state busy).
  */
-static void fsm_irq(struct vfio_ccw_private *private,
+static int fsm_irq(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
 	struct irb *irb = &private->irb;
@@ -172,6 +178,8 @@ static void fsm_irq(struct vfio_ccw_private *private,
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
+
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
