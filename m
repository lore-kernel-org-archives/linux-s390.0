From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH 10/10] vfio: ccw: Let user wait when busy on IO
Date: Thu, 19 Apr 2018 16:48:13 +0200
Message-ID: <1524149293-12658-11-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

In the current implementation, we do not want to start a new SSCH
command before the last one ends.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     |  3 +++
 drivers/s390/cio/vfio_ccw_ops.c     | 21 ++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_private.h |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index b77b8ad..4140292 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -195,6 +195,9 @@ static int fsm_irq(struct vfio_ccw_private *private)
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
+	if (private->io_completion)
+		complete(private->io_completion);
+
 	return VFIO_CCW_STATE_IDLE;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f0f4071..346532d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -171,6 +171,8 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	struct vfio_ccw_private *private;
 	struct ccw_io_region *region;
 	union scsw *scsw;
+	int max_retries = 5;
+	DECLARE_COMPLETION_ONSTACK(completion);
 
 	if (*ppos + count > sizeof(*region))
 		return -EINVAL;
@@ -185,7 +187,24 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) != SCSW_FCTL_START_FUNC)
 		return -EINVAL;
 
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
+	do {
+		switch (private->state) {
+		case VFIO_CCW_STATE_BUSY:
+			private->io_completion = &completion;
+			wait_for_completion(&completion);
+			break;
+		case VFIO_CCW_STATE_IDLE:
+			if (!vfio_ccw_fsm_event(private,
+						VFIO_CCW_EVENT_SSCH_REQ))
+				return count;
+			break;
+		default:
+			return -EBUSY;
+		}
+	} while (max_retries--);
+
+	if (max_retries <= 0)
+		return -EBUSY;
 	if (region->ret_code != 0)
 		return region->ret_code;
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index dbef727..7cca078 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -39,6 +39,7 @@ struct vfio_ccw_private {
 	struct subchannel	*sch;
 	int			state;
 	struct completion	*completion;
+	struct completion	*io_completion;
 	atomic_t		avail;
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
@@ -93,12 +94,13 @@ enum vfio_ccw_event {
 typedef int (fsm_func_t)(struct vfio_ccw_private *);
 extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 
-static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
+static inline int vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
 	mutex_lock(&private->state_mutex);
 	private->state = vfio_ccw_jumptable[private->state][event](private);
 	mutex_unlock(&private->state_mutex);
+	return private->io_region.ret_code;
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4
