From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v2 13/15] KVM: s390: Configure the guest's CRYCB
Date: Tue, 27 Feb 2018 09:28:11 -0500
Message-ID: <1519741693-17440-14-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Registers a group notifier during the open of the mediated
matrix device to get information on KVM presence through the
VFIO_GROUP_NOTIFY_SET_KVM event. When notified, the pointer
to the kvm structure is saved inside the mediated matrix
device. Once the VFIO AP device driver has access to KVM,
the AP matrix for the guest can be configured.

Guest access to AP adapters, usage domains and control domains
is controlled by three bit masks referenced from the
Crypto Control Block (CRYCB) referenced from the guest's SIE state
description:

  * The AP Mask (APM) controls access to the AP adapters. Each bit
    in the APM represents an adapter number - from most significant
    to least significant bit - from 0 to 255. The bits in the APM
    are set according to the adapter numbers assigned to the mediated
    matrix device via its 'assign_adapter' sysfs attribute file.

  * The AP Queue (AQM) controls access to the AP queues. Each bit
    in the AQM represents an AP queue index - from most significant
    to least significant bit - from 0 to 255. A queue index references
    a specific domain and is synonymous with the domian number. The
    bits in the AQM are set according to the domain numbers assigned
    to the mediated matrix device via its 'assign_domain' sysfs
    attribute file.

  * The AP Domain Mask (ADM) controls access to the AP control domains.
    Each bit in the ADM represents a control domain - from most
    significant to least significant bit - from 0-255. The
    bits in the ADM are set according to the domain numbers assigned
    to the mediated matrix device via its 'assign_control_domain'
    sysfs attribute file.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     |   46 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |    2 +
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 04f7a92..752d171 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -53,6 +53,50 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	return 0;
 }
 
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
+static int vfio_ap_mdev_open(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long events;
+	int ret;
+
+	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
+	events = VFIO_GROUP_NOTIFY_SET_KVM;
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				     &events, &matrix_mdev->group_notifier);
+
+	ret = kvm_ap_configure_matrix(matrix_mdev->kvm,
+				      matrix_mdev->matrix);
+	if (ret)
+		return ret;
+
+	ret = kvm_ap_enable_ie_mode(matrix_mdev->kvm);
+
+	return ret;
+}
+
+static void vfio_ap_mdev_release(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	kvm_ap_deconfigure_matrix(matrix_mdev->kvm);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+}
+
 static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 {
 	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
@@ -757,6 +801,8 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
 	.create			= vfio_ap_mdev_create,
 	.remove			= vfio_ap_mdev_remove,
+	.open			= vfio_ap_mdev_open,
+	.release		= vfio_ap_mdev_release,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a92d5ad..1bd3d42 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -30,6 +30,8 @@ struct ap_matrix {
 
 struct ap_matrix_mdev {
 	struct kvm_ap_matrix *matrix;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 static inline struct ap_matrix *to_ap_matrix(struct device *dev)
-- 
1.7.1
