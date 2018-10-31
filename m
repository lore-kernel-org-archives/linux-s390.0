From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl calls
Date: Wed, 31 Oct 2018 19:12:54 +0100
Message-ID: <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
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
 drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 272ef427dcc0..f68102163bf4 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -895,12 +895,107 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	return copy_to_user((void __user *)arg, &info, minsz);
 }
 
+static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
+			   struct vfio_ap_aqic *parm)
+{
+	struct aqic_gisa aqic_gisa = reg2aqic(0);
+	struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
+	struct ap_status ap_status = reg2status(0);
+	unsigned long p;
+	int ret = -1;
+	int apqn;
+	uint32_t gd;
+
+	apqn = (int)(parm->cmd & 0xffff);
+
+	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
+	if (gd & 0x01)
+		aqic_gisa.f = 1;
+	aqic_gisa.gisc = matrix_mdev->gisc;
+	aqic_gisa.isc = GAL_ISC;
+	aqic_gisa.ir = 1;
+	aqic_gisa.gisao = gisa->next_alert >> 4;
+
+	p = (unsigned long) page_address(matrix_mdev->map->page);
+	p += (matrix_mdev->map->guest_addr & 0x0fff);
+
+	ret = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), p);
+	parm->status = ret;
+
+	ap_status = reg2status(ret);
+	return (ap_status.rc) ? -EIO : 0;
+}
+
+static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
+			   struct vfio_ap_aqic *parm)
+{
+	struct aqic_gisa aqic_gisa = reg2aqic(0);
+	struct ap_status ap_status = reg2status(0);
+	int apqn;
+	int retval;
+	uint32_t gd;
+
+	apqn = (int)(parm->cmd & 0xffff);
+
+	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
+	if (gd & 0x01)
+		aqic_gisa.f = 1;
+	aqic_gisa.ir = 0;
+
+	retval = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), 0);
+	parm->status = retval;
+
+	ap_status = reg2status(retval);
+	return (ap_status.rc) ? -EIO : 0;
+}
+
 static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 				    unsigned int cmd, unsigned long arg)
 {
 	int ret;
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct s390_io_adapter *adapter;
+	struct vfio_ap_aqic parm;
+	struct s390_map_info *map;
+	int apqn, found = 0;
 
 	switch (cmd) {
+	case VFIO_AP_SET_IRQ:
+		if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+			return -EFAULT;
+		apqn = (int)(parm.cmd & 0xffff);
+		parm.status &= 0x00000000ffffffffUL;
+		matrix_mdev->gisc = parm.status & 0x07;
+		/* find the adapter */
+		adapter = matrix_mdev->kvm->arch.adapters[parm.adapter_id];
+		if (!adapter)
+			return -ENOENT;
+		down_write(&adapter->maps_lock);
+		list_for_each_entry(map, &adapter->maps, list) {
+			if (map->guest_addr == parm.nib) {
+				found = 1;
+				break;
+			}
+		}
+		up_write(&adapter->maps_lock);
+
+		if (!found)
+			return -EINVAL;
+
+		matrix_mdev->map = map;
+		ret = ap_ioctl_setirq(matrix_mdev, &parm);
+		parm.status &= 0x00000000ffffffffUL;
+		if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
+			return -EFAULT;
+
+		break;
+	case VFIO_AP_CLEAR_IRQ:
+		if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
+			return -EFAULT;
+		ret = ap_ioctl_clrirq(matrix_mdev, &parm);
+		if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
+			return -EFAULT;
+		break;
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
-- 
2.17.0
