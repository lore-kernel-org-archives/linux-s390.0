From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 2/2] vfio: ccw: improve error handling for vfio_ccw_mdev_remove
Date: Wed, 12 Apr 2017 11:08:16 +0200
Message-ID: <20170412090816.79108-3-bjsdjshi@linux.vnet.ibm.com>
References: <20170412090816.79108-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170412090816.79108-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, dan.carpenter@oracle.com
List-ID: <linux-s390.vger.kernel.org>

When vfio_ccw_mdev_reset fails during the remove process of the mdev,
the current implementation simply returns.

The failure indicates that the subchannel device is in a NOT_OPER state,
thus the right thing to do should be removing the mdev.

While we are at here, reverse the condition check to make the code more
concise and readable.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 55d0c87..e72abbc 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -126,19 +126,14 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
-	int ret;
-
-	if ((private->state == VFIO_CCW_STATE_NOT_OPER) ||
-	    (private->state == VFIO_CCW_STATE_STANDBY))
-		goto out;
-
-	ret = vfio_ccw_mdev_reset(mdev);
-	if (ret)
-		return ret;
 
-	private->state = VFIO_CCW_STATE_STANDBY;
+	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
+	    (private->state != VFIO_CCW_STATE_STANDBY)) {
+		if (!vfio_ccw_mdev_reset(mdev))
+			private->state = VFIO_CCW_STATE_STANDBY;
+		/* The state will be NOT_OPER on error. */
+	}
 
-out:
 	private->mdev = NULL;
 	atomic_inc(&private->avail);
 
-- 
2.10.2
