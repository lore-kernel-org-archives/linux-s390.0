From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 19/21] s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
Date: Fri, 29 Jun 2018 17:11:21 -0400
Message-ID: <1530306683-7270-20-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Implements the VFIO_DEVICE_RESET ioctl. This ioctl zeroizes
all of the AP queues assigned to the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e247491..4ff75c7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1161,7 +1161,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 		return -EINVAL;
 	}
 
-	info.flags = VFIO_DEVICE_FLAGS_AP;
+	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
 	info.num_regions = 0;
 	info.num_irqs = 0;
 
@@ -1177,6 +1177,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
+	case VFIO_DEVICE_RESET:
+		ret = vfio_ap_mdev_reset_queues(mdev, true);
+		break;
 	default:
 		pr_err("%s: ioctl command %d is not a supported command",
 		       VFIO_AP_MODULE_NAME, cmd);
-- 
1.7.1
