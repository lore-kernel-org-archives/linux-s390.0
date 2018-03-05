From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 2/2] vfio-ccw: fence off transport mode
Date: Mon,  5 Mar 2018 13:31:16 +0100
Message-ID: <20180305123116.4301-3-cohuck@redhat.com>
References: <20180305123116.4301-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305123116.4301-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

vfio-ccw only supports command mode for channel programs, not transport
mode. User space is supposed to already take care of that and pass us
command-mode ORBs only, but better make sure and return an error to
the caller instead of trying to process tcws as ccws.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index c30420c517b1..ff6963ad6e39 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -124,6 +124,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
 		orb = (union orb *)io_region->orb_area;
 
+		/* Don't try to build a cp if transport mode is specified. */
+		if (orb->tm.b) {
+			io_region->ret_code = -EOPNOTSUPP;
+			goto err_out;
+		}
 		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
 					      orb);
 		if (io_region->ret_code)
-- 
2.13.6
