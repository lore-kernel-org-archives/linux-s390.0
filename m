From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 26 Jul 2018 19:54:26 +0000
Subject: [PATCH v7 19/22] s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
Message-Id: <20180726195429.31960-20-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Implements the VFIO_DEVICE_RESET ioctl. This ioctl zeroizes
all of the AP queues assigned to the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 461a74515d3d..6e2e598fb9d1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -915,7 +915,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 		return -EINVAL;
 	}
 
-	info.flags = VFIO_DEVICE_FLAGS_AP;
+	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
 	info.num_regions = 0;
 	info.num_irqs = 0;
 
@@ -931,6 +931,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
+	case VFIO_DEVICE_RESET:
+		ret = vfio_ap_mdev_reset_queues(mdev, true);
+		break;
 	default:
 		pr_warn("%s: ioctl command %d is not a supported command\n",
 			VFIO_AP_MODULE_NAME, cmd);
-- 
2.17.0
