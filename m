From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v3 13/14] s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
Date: Wed, 14 Mar 2018 14:25:53 -0400
Message-ID: <1521051954-25715-14-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Introduces ioctl access to the VFIO AP Matrix device driver
by implementing the VFIO_DEVICE_GET_INFO ioctl. This ioctl
provides the VFIO AP Matrix device driver information to the
guest machine.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   43 +++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c7911da..7223a1c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -101,6 +101,48 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 				 &matrix_mdev->group_notifier);
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
+		       VFIO_AP_MATRIX_MODULE_NAME, info.argsz, minsz);
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
+		       VFIO_AP_MATRIX_MODULE_NAME, cmd);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
 static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 {
 	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
@@ -807,6 +849,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	.remove			= vfio_ap_mdev_remove,
 	.open			= vfio_ap_mdev_open,
 	.release		= vfio_ap_mdev_release,
+	.ioctl			= vfio_ap_mdev_ioctl,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
-- 
1.7.1
