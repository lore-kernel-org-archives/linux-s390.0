From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 17/21] s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
Date: Fri, 29 Jun 2018 17:11:19 -0400
Message-ID: <1530306683-7270-18-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Introduces ioctl access to the VFIO AP Matrix device driver
by implementing the VFIO_DEVICE_GET_INFO ioctl. This ioctl
provides the VFIO AP Matrix device driver information to the
guest machine.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   43 +++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index bc05d40..79ac0d4 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1114,6 +1114,48 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	module_put(THIS_MODULE);
 }
 
+static int vfio_ap_mdev_get_device_info(unsigned long arg)
+{
+	unsigned long minsz;
+	struct vfio_device_info info;
+
+	minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz) {
+		pr_err("%s: Argument size %u less than min size %li",
+		       VFIO_AP_MODULE_NAME, info.argsz, minsz);
+		return -EINVAL;
+	}
+
+	info.flags = VFIO_DEVICE_FLAGS_AP;
+	info.num_regions = 0;
+	info.num_irqs = 0;
+
+	return copy_to_user((void __user *)arg, &info, minsz);
+}
+
+static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
+				    unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	switch (cmd) {
+	case VFIO_DEVICE_GET_INFO:
+		ret = vfio_ap_mdev_get_device_info(arg);
+		break;
+	default:
+		pr_err("%s: ioctl command %d is not a supported command",
+		       VFIO_AP_MODULE_NAME, cmd);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
 static const struct mdev_parent_ops vfio_ap_matrix_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups	= vfio_ap_mdev_type_groups,
@@ -1122,6 +1164,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	.remove			= vfio_ap_mdev_remove,
 	.open			= vfio_ap_mdev_open,
 	.release		= vfio_ap_mdev_release,
+	.ioctl			= vfio_ap_mdev_ioctl,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev)
-- 
1.7.1
