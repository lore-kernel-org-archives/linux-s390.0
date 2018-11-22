From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl calls
Date: Thu, 22 Nov 2018 18:11:15 +0100
Message-ID: <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is the implementation of the VFIO ioctl calls to handle
the AQIC interception and use GISA to handle interrupts.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 272ef42..f6e942f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -895,12 +895,121 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	return copy_to_user((void __user *)arg, &info, minsz);
 }
 
+static unsigned long vfio_ap_get_nib(struct kvm *kvm, struct vfio_ap_aqic *parm)
+{
+	struct s390_io_adapter *adapter;
+	struct s390_map_info *map;
+	unsigned long nib;
+	int found = 0;
+
+	/* find the adapter */
+	if (parm->adapter_id > MAX_S390_IO_ADAPTERS)
+		return 0;
+
+	adapter = kvm->arch.adapters[parm->adapter_id];
+	if (!adapter)
+		return 0;
+
+	down_write(&adapter->maps_lock);
+	list_for_each_entry(map, &adapter->maps, list) {
+		if (map->guest_addr == parm->nib) {
+			found = 1;
+			break;
+		}
+	}
+	up_write(&adapter->maps_lock);
+
+	if (!found)
+		return 0;
+
+	nib = (unsigned long) page_address(map->page);
+	nib += (map->guest_addr & 0x0fff);
+
+	return nib;
+}
+
+static int vfio_ap_ioctl_setirq(struct mdev_device *mdev, unsigned long arg)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_aqic parm;
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct kvm *kvm = matrix_mdev->kvm;
+	struct kvm_s390_gisa *gisa = kvm->arch.gisa;
+	struct ap_queue_status ap_status;
+	unsigned long nib;
+
+	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+		return -EFAULT;
+
+	if (parm.isc > MAX_ISC)
+		return -EINVAL;
+
+	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
+		aqic_gisa.gf = 1;
+
+	nib = vfio_ap_get_nib(kvm, &parm);
+	if (!nib)
+		return -ENODEV;
+
+	aqic_gisa.gisc = parm.isc;
+	aqic_gisa.isc = kvm_s390_gisc_register(kvm, parm.isc);
+	aqic_gisa.ir = 1;
+	aqic_gisa.gisa = gisa->next_alert >> 4;
+
+	ap_status = ap_aqic(parm.apqn, aqic_gisa, (void *)nib);
+	parm.status = *(uint32_t *)(&ap_status);
+
+	if (copy_to_user((void __user *)arg, &parm, sizeof(parm))) {
+		kvm_s390_gisc_unregister(kvm, parm.isc);
+		return -EFAULT;
+	}
+
+	if (ap_status.response_code) {
+		kvm_s390_gisc_unregister(kvm, parm.isc);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int vfio_ap_ioctl_clrirq(struct mdev_device *mdev, unsigned long arg)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_aqic parm;
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct ap_queue_status ap_status;
+	struct kvm *kvm = matrix_mdev->kvm;
+
+	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+		return -EFAULT;
+
+	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
+		aqic_gisa.gf = 1;
+	aqic_gisa.ir = 0;
+
+	ap_status = ap_aqic(parm.apqn, aqic_gisa, NULL);
+	parm.status = *(uint32_t *)(&ap_status);
+
+	kvm_s390_gisc_unregister(kvm, parm.isc);
+
+	if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
+		return -EFAULT;
+
+	return (ap_status.response_code) ? -EIO : 0;
+}
+
 static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 				    unsigned int cmd, unsigned long arg)
 {
 	int ret;
 
 	switch (cmd) {
+	case VFIO_AP_SET_IRQ:
+		ret = vfio_ap_ioctl_setirq(mdev, arg);
+		break;
+	case VFIO_AP_CLEAR_IRQ:
+		ret = vfio_ap_ioctl_clrirq(mdev, arg);
+		break;
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
@@ -911,7 +1020,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-
 	return ret;
 }
 
-- 
2.7.4
