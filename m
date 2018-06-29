From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open callback
Date: Fri, 29 Jun 2018 17:11:16 -0400
Message-ID: <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Implements the open callback on the mediated matrix device.
The function registers a group notifier to receive notification
of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
the vfio_ap device driver will get access to the guest's
kvm structure. The open callback must ensure that only one
mediated device shall be opened per guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     |  128 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |    2 +
 2 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index bc7398d..58be495 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -11,6 +11,10 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/bitops.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <asm/kvm.h>
 
 #include "vfio_ap_private.h"
 
@@ -748,12 +752,136 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	NULL
 };
 
+/**
+ * Verify that the AP instructions are available on the guest and are to be
+ * interpreted by the firmware. The former is indicated via the
+ * KVM_S390_VM_CPU_FEAT_AP CPU model feature and the latter by apie crypto
+ * flag.
+ */
+static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
+{
+	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat) &&
+	    kvm->arch.crypto.apie)
+		return 0;
+
+	pr_err("%s: interpretation of AP instructions not available",
+	       VFIO_AP_MODULE_NAME);
+
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
+		matrix_mdev = container_of(nb, struct ap_matrix_mdev,
+					   group_notifier);
+		matrix_mdev->kvm = data;
+	}
+
+	return NOTIFY_OK;
+}
+
+/**
+ * vfio_ap_mdev_open_once
+ *
+ * @matrix_mdev: a mediated matrix device
+ *
+ * Return 0 if no other mediated matrix device has been opened for the
+ * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
+ */
+static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev)
+{
+	int ret = 0;
+	struct ap_matrix_mdev *lstdev;
+
+	spin_lock_bh(&mdev_list_lock);
+
+	list_for_each_entry(lstdev, &mdev_list, list) {
+		if ((lstdev->kvm == matrix_mdev->kvm) &&
+		    (lstdev != matrix_mdev)) {
+			ret = -EPERM;
+			break;
+		}
+	}
+
+	if (ret) {
+		pr_err("%s: mdev %s open failed for guest %s",
+		       VFIO_AP_MODULE_NAME, matrix_mdev->name,
+		       matrix_mdev->kvm->arch.dbf->name);
+		pr_err("%s: mdev %s already opened for guest %s",
+		       VFIO_AP_MODULE_NAME, lstdev->name,
+		       lstdev->kvm->arch.dbf->name);
+	}
+
+	spin_unlock_bh(&mdev_list_lock);
+	return ret;
+}
+
+static int vfio_ap_mdev_open(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_dev *matrix_dev =
+		to_ap_matrix_dev(mdev_parent_dev(mdev));
+	unsigned long events;
+	int ret;
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
+					     &matrix_mdev->matrix);
+	if (ret)
+		goto out_err;
+
+	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
+	events = VFIO_GROUP_NOTIFY_SET_KVM;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				     &events, &matrix_mdev->group_notifier);
+	if (ret)
+		goto out_err;
+
+	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
+	if (ret)
+		goto out_kvm_err;
+
+	ret = vfio_ap_mdev_open_once(matrix_mdev);
+	if (ret)
+		goto out_kvm_err;
+
+	return 0;
+
+out_kvm_err:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+	matrix_mdev->kvm = NULL;
+out_err:
+	module_put(THIS_MODULE);
+
+	return ret;
+}
+
+static void vfio_ap_mdev_release(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+	matrix_mdev->kvm = NULL;
+	module_put(THIS_MODULE);
+}
+
 static const struct mdev_parent_ops vfio_ap_matrix_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups	= vfio_ap_mdev_type_groups,
 	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
 	.create			= vfio_ap_mdev_create,
 	.remove			= vfio_ap_mdev_remove,
+	.open			= vfio_ap_mdev_open,
+	.release		= vfio_ap_mdev_release,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index ae771f5..7792b45 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -56,6 +56,8 @@ struct ap_matrix_mdev {
 	const char *name;
 	struct list_head list;
 	struct ap_matrix matrix;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
-- 
1.7.1
