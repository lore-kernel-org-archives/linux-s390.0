Return-Path: <SRS0=Fa9J=TO=vger.kernel.org=kvm-owner@kernel.org>
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/7] s390/cio: Set vfio-ccw FSM state before ioeventfd
Date: Wed, 15 May 2019 01:42:43 +0200
In-Reply-To: <20190514234248.36203-1-farman@linux.ibm.com>
References: <20190514234248.36203-1-farman@linux.ibm.com>
Message-Id: <20190514234248.36203-3-farman@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Otherwise, the guest can believe it's okay to start another I/O
and bump into the non-idle state.  This results in a cc=2 (with
the asynchronous CSCH/HSCH code) returned to the guest, which is
unfortunate since everything is otherwise working normally.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 0b3b9de45c60..ddd21b6149fd 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -86,11 +86,11 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	}
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 
-	if (private->io_trigger)
-		eventfd_signal(private->io_trigger, 1);
-
 	if (private->mdev && is_final)
 		private->state = VFIO_CCW_STATE_IDLE;
+
+	if (private->io_trigger)
+		eventfd_signal(private->io_trigger, 1);
 }
 
 /*
-- 
2.17.1
