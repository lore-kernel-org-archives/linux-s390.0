From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 6/6] vfio: ccw: serialize the write system calls
Date: Wed, 28 Nov 2018 13:41:07 +0100
Message-ID: <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When the user program is QEMU we rely on the QEMU lock to serialize
the calls to the driver.

In the general case we need to make sure that two data transfer are
not started at the same time.
It would in the current implementation resul in a overwriting of the
IO region.

We also need to make sure a clear or a halt started after a data
transfer do not win the race agains the data transfer.
Which would result in the data transfer being started after the
halt/clear.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index eb5b49d..b316966 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -267,22 +267,31 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 {
 	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
 	struct vfio_ccw_private *private;
+	static atomic_t serialize  = ATOMIC_INIT(0);
+	int ret = -EINVAL;
+
+	if (!atomic_add_unless(&serialize, 1, 1))
+		return -EBUSY;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
 
 	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
-		return -EINVAL;
+		goto end;
 
 	switch (index) {
 	case VFIO_CCW_CONFIG_REGION_INDEX:
-		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
+		ret = vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
+		break;
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
-		return private->region[index].ops->write(private, buf, count,
+		ret = private->region[index].ops->write(private, buf, count,
 							 ppos);
+		break;
 	}
 
-	return -EINVAL;
+end:
+	atomic_dec(&serialize);
+	return ret;
 }
 
 static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info,
-- 
2.7.4
