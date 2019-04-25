Return-Path: <SRS0=V8Ip=S3=vger.kernel.org=kvm-owner@kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 9/9] vfio-ccw: Prevent quiesce function going into an infinite loop
Date: Thu, 25 Apr 2019 11:15:59 +0200
Message-Id: <20190425091559.15490-10-cohuck@redhat.com>
In-Reply-To: <20190425091559.15490-1-cohuck@redhat.com>
References: <20190425091559.15490-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.ibm.com>

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
Message-Id: <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index d72aa8c760c5..ee8767f5845a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -43,26 +43,30 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
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
 
-			wait_for_completion_timeout(&completion, 3*HZ);
+		if (ret == -EIO) {
+			pr_err("vfio_ccw: could not quiesce subchannel 0.%x.%04x!\n",
+			       sch->schid.ssid, sch->schid.sch_no);
+			break;
+		}
+
+		/*
+		 * Flush all I/O and wait for
+		 * cancel/halt/clear completion.
+		 */
+		private->completion = &completion;
+		spin_unlock_irq(sch->lock);
 
-			private->completion = NULL;
-			flush_workqueue(vfio_ccw_work_q);
-			spin_lock_irq(sch->lock);
-			ret = cio_cancel_halt_clear(sch, &iretry);
-		};
+		if (ret == -EBUSY)
+			wait_for_completion_timeout(&completion, 3*HZ);
 
+		private->completion = NULL;
+		flush_workqueue(vfio_ccw_work_q);
+		spin_lock_irq(sch->lock);
 		ret = cio_disable_subchannel(sch);
 	} while (ret == -EBUSY);
 out_unlock:
-- 
2.17.2
