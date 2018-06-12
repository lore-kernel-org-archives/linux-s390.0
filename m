From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 8/8] vfio: ccw: Suppressing the BOXED state
Date: Tue, 12 Jun 2018 09:56:50 +0200
Message-ID: <1528790210-19535-9-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same.

Let's only keep one: VFIO_CCW_STATE_BUSY

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 9 +--------
 drivers/s390/cio/vfio_ccw_private.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 5f1035c..e588c3c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -120,7 +120,7 @@ static int fsm_io_request(struct vfio_ccw_private *private)
 	struct ccw_io_region *io_region = &private->io_region;
 	struct mdev_device *mdev = private->mdev;
 
-	private->state = VFIO_CCW_STATE_BOXED;
+	private->state = VFIO_CCW_STATE_BUSY;
 
 	orb = (union orb *)io_region->orb_area;
 
@@ -227,13 +227,6 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
-	[VFIO_CCW_STATE_BOXED] = {
-		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
-		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
-		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
-		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
-	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index f9e7570..42cc3b7 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -66,7 +66,6 @@ enum vfio_ccw_state {
 	VFIO_CCW_STATE_NOT_OPER,
 	VFIO_CCW_STATE_STANDBY,
 	VFIO_CCW_STATE_IDLE,
-	VFIO_CCW_STATE_BOXED,
 	VFIO_CCW_STATE_BUSY,
 	/* last element! */
 	NR_VFIO_CCW_STATES
-- 
2.7.4
