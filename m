From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] vfio: ccw: only free cp on final interrupt
Date: Mon, 11 Mar 2019 11:20:25 +0100
Message-ID: <20190311102025.23941-1-cohuck@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When we get an interrupt for a channel program, it is not
necessarily the final interrupt; for example, the issuing
guest may request an intermediate interrupt by specifying
the program-controlled-interrupt flag on a ccw.

We must not switch the state to idle if the interrupt is not
yet final; even more importantly, we must not free the translated
channel program if the interrupt is not yet final, or the host
can crash during cp rewind.

Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Previously part of "vfio-ccw: rework ssch state handling". Please review,
I plan to send a pull req asap.

---
 drivers/s390/cio/vfio_ccw_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index a10cec0e86eb..0b3b9de45c60 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -72,20 +72,24 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
 	struct irb *irb;
+	bool is_final;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	irb = &private->irb;
 
+	is_final = !(scsw_actl(&irb->scsw) &
+		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		cp_free(&private->cp);
+		if (is_final)
+			cp_free(&private->cp);
 	}
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
-	if (private->mdev)
+	if (private->mdev && is_final)
 		private->state = VFIO_CCW_STATE_IDLE;
 }
 
-- 
2.17.2
