Return-Path: <SRS0=nFot=SK=vger.kernel.org=kvm-owner@kernel.org>
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v2 2/3] vfio-ccw: Prevent quiesce function going into an infinite loop
Date: Mon,  8 Apr 2019 17:05:32 -0400
In-Reply-To: <cover.1554756534.git.alifm@linux.ibm.com>
References: <cover.1554756534.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1554756534.git.alifm@linux.ibm.com>
References: <cover.1554756534.git.alifm@linux.ibm.com>
Message-Id: <2c17cf29fbce8fc1cfbf60cfd04559d00c8eeac0.1554756534.git.alifm@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, alifm@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The quiesce function calls cio_cancel_halt_clear() and if we
get an -EBUSY we go into a loop where we:
	- wait for any interrupts
	- flush all I/O in the workqueue
	- retry cio_cancel_halt_clear

During the period where we are waiting for interrupts or
flushing all I/O, the channel subsystem could have completed
a halt/clear action and turned off the corresponding activity
control bits in the subchannel status word. This means the next
time we call cio_cancel_halt_clear(), we will again start by
calling cancel subchannel and so we can be stuck between calling
cancel and halt forever.

Rather than calling cio_cancel_halt_clear() immediately after
waiting, let's try to disable the subchannel. If we succeed in
disabling the subchannel then we know nothing else can happen
with the device.

Suggested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 5aca475..4405f2a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -43,26 +43,23 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 	if (ret != -EBUSY)
 		goto out_unlock;
 
+	iretry = 255;
 	do {
-		iretry = 255;
 
 		ret = cio_cancel_halt_clear(sch, &iretry);
-		while (ret == -EBUSY) {
-			/*
-			 * Flush all I/O and wait for
-			 * cancel/halt/clear completion.
-			 */
-			private->completion = &completion;
-			spin_unlock_irq(sch->lock);
-
+		/*
+		 * Flush all I/O and wait for
+		 * cancel/halt/clear completion.
+		 */
+		private->completion = &completion;
+		spin_unlock_irq(sch->lock);
+
+		if (ret == -EBUSY)
 			wait_for_completion_timeout(&completion, 3*HZ);
 
-			private->completion = NULL;
-			flush_workqueue(vfio_ccw_work_q);
-			spin_lock_irq(sch->lock);
-			ret = cio_cancel_halt_clear(sch, &iretry);
-		};
-
+		private->completion = NULL;
+		flush_workqueue(vfio_ccw_work_q);
+		spin_lock_irq(sch->lock);
 		ret = cio_disable_subchannel(sch);
 	} while (ret == -EBUSY);
 out_unlock:
-- 
2.7.4
