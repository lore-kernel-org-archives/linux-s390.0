From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 14/19] KVM: s390: Connect the AP mediated matrix device to KVM
Date: Fri, 13 Oct 2017 13:38:59 -0400
Message-ID: <1507916344-3896-15-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Registers a group notifier during the open of the mediated
device to get information on KVM presence through the
VFIO_GROUP_NOTIFY_SET_KVM event.

When notified, save the pointer to KVM inside mediated matrix device
structure.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_matrix_ops.c |   43 ++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
index 10a006c..fd36074 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
+++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
@@ -12,6 +12,9 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/kvm_host.h>
+#include <linux/eventfd.h>
+#include <linux/notifier.h>
 
 #include "vfio_ap_matrix_private.h"
 
@@ -24,6 +27,8 @@ struct ap_matrix_mdev {
 	struct mdev_device *mdev;
 	struct list_head node;
 	struct ap_config_masks masks;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 struct ap_matrix	*matrix;
@@ -97,6 +102,41 @@ static int ap_matrix_mdev_remove(struct mdev_device *mdev)
 	return 0;
 }
 
+static int ap_matrix_mdev_group_notifier(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
+
+	if (action == VFIO_GROUP_NOTIFY_SET_KVM)
+		matrix_mdev->kvm = data;
+
+	return NOTIFY_OK;
+}
+
+static int ap_matrix_mdev_open(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long events;
+	int ret;
+
+	matrix_mdev->group_notifier.notifier_call =
+		ap_matrix_mdev_group_notifier;
+	events = VFIO_GROUP_NOTIFY_SET_KVM;
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				     &events, &matrix_mdev->group_notifier);
+	return ret;
+}
+
+static void ap_matrix_mdev_release(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+}
+
 static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 {
 	return sprintf(buf, "%s\n", AP_MATRIX_MDEV_NAME_HWVIRT);
@@ -609,6 +649,9 @@ static DEVICE_ATTR(control_domains, 0644, ap_matrix_control_domains_show,
 	.mdev_attr_groups	= ap_matrix_mdev_attr_groups,
 	.create                 = ap_matrix_mdev_create,
 	.remove                 = ap_matrix_mdev_remove,
+	.open                   = ap_matrix_mdev_open,
+	.release                = ap_matrix_mdev_release,
+
 };
 
 int ap_matrix_mdev_register(struct ap_matrix *ap_matrix)
-- 
1.7.1
