From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:41 +0000
Subject: [GIT PULL 14/28] s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
Message-Id: <20181002070655.224110-15-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Implements the VFIO_DEVICE_RESET ioctl. This ioctl zeroizes
all of the AP queues assigned to the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <20180925231641.4954-15-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 619900c56cd6..d3d9eb72b0f1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -917,7 +917,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	if (info.argsz < minsz)
 		return -EINVAL;
 
-	info.flags = VFIO_DEVICE_FLAGS_AP;
+	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
 	info.num_regions = 0;
 	info.num_irqs = 0;
 
@@ -933,6 +933,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
+	case VFIO_DEVICE_RESET:
+		ret = vfio_ap_mdev_reset_queues(mdev);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.0
