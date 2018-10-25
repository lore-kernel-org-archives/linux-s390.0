From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 25 Oct 2018 17:15:19 +0000
Subject: [PATCH v2 1/2] vfio: ccw: Merge BUSY and BOXED states
Message-Id: <1540487720-11634-2-git-send-email-pmorel@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY have
identical actions for the same events.

Let's merge both into a single state to simplify the code.
We choose to keep VFIO_CCW_STATE_BUSY.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 7 +------
 drivers/s390/cio/vfio_ccw_private.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index f94aa01f9c36..cab17865aafe 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -130,7 +130,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	struct mdev_device *mdev = private->mdev;
 	char *errstr = "request";
 
-	private->state = VFIO_CCW_STATE_BOXED;
+	private->state = VFIO_CCW_STATE_BUSY;
 
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
 
@@ -216,11 +216,6 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 	},
-	[VFIO_CCW_STATE_BOXED] = {
-		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
-		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
-	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 078e46f9623d..08e9a7dc9176 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -63,7 +63,6 @@ enum vfio_ccw_state {
 	VFIO_CCW_STATE_NOT_OPER,
 	VFIO_CCW_STATE_STANDBY,
 	VFIO_CCW_STATE_IDLE,
-	VFIO_CCW_STATE_BOXED,
 	VFIO_CCW_STATE_BUSY,
 	/* last element! */
 	NR_VFIO_CCW_STATES
-- 
2.17.0
