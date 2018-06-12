From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 1/8] vfio: ccw: Moving state change out of IRQ context
Date: Tue, 12 Jun 2018 09:56:43 +0200
Message-ID: <1528790210-19535-2-git-send-email-pmorel@linux.ibm.com>
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

Having state changes out of IRQ context allows to protect
critical sections with mutexes.
Next patches in the serie will use this possibility.

We use work queues to thread the interrupts.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 20 +++++++-------------
 drivers/s390/cio/vfio_ccw_fsm.c | 14 ++++++++------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0..57ae1ab 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -70,20 +70,9 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 static void vfio_ccw_sch_io_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
-	struct irb *irb;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
-	irb = &private->irb;
-
-	if (scsw_is_solicited(&irb->scsw)) {
-		cp_update_scsw(&private->cp, &irb->scsw);
-		cp_free(&private->cp);
-	}
-	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
-
-	if (private->io_trigger)
-		eventfd_signal(private->io_trigger, 1);
-
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 	if (private->mdev)
 		private->state = VFIO_CCW_STATE_IDLE;
 }
@@ -94,9 +83,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 static void vfio_ccw_sch_irq(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	struct irb *irb = this_cpu_ptr(&cio_irb);
 
 	inc_irq_stat(IRQIO_CIO);
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
+	memcpy(&private->irb, irb, sizeof(*irb));
+
+	queue_work(vfio_ccw_work_q, &private->io_work);
+	if (private->completion)
+		complete(private->completion);
 }
 
 static int vfio_ccw_sch_probe(struct subchannel *sch)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 3c80064..24e1e04 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -172,14 +172,16 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 static void fsm_irq(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
-	struct irb *irb = this_cpu_ptr(&cio_irb);
+	struct irb *irb = &private->irb;
 
-	memcpy(&private->irb, irb, sizeof(*irb));
-
-	queue_work(vfio_ccw_work_q, &private->io_work);
+	if (scsw_is_solicited(&irb->scsw)) {
+		cp_update_scsw(&private->cp, &irb->scsw);
+		cp_free(&private->cp);
+	}
+	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
 
-	if (private->completion)
-		complete(private->completion);
+	if (private->io_trigger)
+		eventfd_signal(private->io_trigger, 1);
 }
 
 /*
-- 
2.7.4
