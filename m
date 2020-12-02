Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgLBXnJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 18:43:09 -0500
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM pointer invalidated
Date: Wed,  2 Dec 2020 18:41:01 -0500
Message-Id: <20201202234101.32169-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com, Tony Krowiak <akrowiak@linux.ibm.com>

The vfio_ap device driver registers a group notifier with VFIO when the
file descriptor for a VFIO mediated device for a KVM guest is opened to
receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
event). When the KVM pointer is set, the vfio_ap driver stashes the pointer
and calls the kvm_get_kvm() function to increment its reference counter.
When the notifier is called to make notification that the KVM pointer has
been set to NULL, the driver should clean up any resources associated with
the KVM pointer and decrement its reference counter. The current
implementation does not take care of this clean up.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e0bde8518745..eeb9c9130756 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1083,6 +1083,17 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void vfio_ap_mdev_put_kvm(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->kvm) {
+		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+		kvm_put_kvm(matrix_mdev->kvm);
+		matrix_mdev->kvm = NULL;
+	}
+}
+
 static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 				       unsigned long action, void *data)
 {
@@ -1095,7 +1106,7 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
 
 	if (!data) {
-		matrix_mdev->kvm = NULL;
+		vfio_ap_mdev_put_kvm(matrix_mdev);
 		return NOTIFY_OK;
 	}
 
@@ -1222,13 +1233,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	mutex_lock(&matrix_dev->lock);
-	if (matrix_mdev->kvm) {
-		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
-		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
-		vfio_ap_mdev_reset_queues(mdev);
-		kvm_put_kvm(matrix_mdev->kvm);
-		matrix_mdev->kvm = NULL;
-	}
+	vfio_ap_mdev_put_kvm(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-- 
2.21.1
