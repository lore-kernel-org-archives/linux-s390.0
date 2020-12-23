Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgLWBVH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Dec 2020 20:21:07 -0500
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v5] s390/vfio-ap: clean up vfio_ap resources when KVM pointer invalidated
Date: Tue, 22 Dec 2020 20:20:13 -0500
Message-Id: <20201223012013.5418-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: stable@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>

The vfio_ap device driver registers a group notifier with VFIO when the
file descriptor for a VFIO mediated device for a KVM guest is opened to
receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
event). When the KVM pointer is set, the vfio_ap driver takes the
following actions:
1. Stashes the KVM pointer in the vfio_ap_mdev struct that holds the state
   of the mediated device.
2. Calls the kvm_get_kvm() function to increment its reference counter.
3. Sets the function pointer to the function that handles interception of
   the instruction that enables/disables interrupt processing.
4. Sets the masks in the KVM guest's CRYCB to pass AP resources through to
   the guest.

In order to avoid memory leaks, when the notifier is called to receive
notification that the KVM pointer has been set to NULL, the vfio_ap device
driver should reverse the actions taken when the KVM pointer was set.

Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 49 ++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e0bde8518745..7339043906cf 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1037,19 +1037,14 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 {
 	struct ap_matrix_mdev *m;
 
-	mutex_lock(&matrix_dev->lock);
-
 	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-		if ((m != matrix_mdev) && (m->kvm == kvm)) {
-			mutex_unlock(&matrix_dev->lock);
+		if ((m != matrix_mdev) && (m->kvm == kvm))
 			return -EPERM;
-		}
 	}
 
 	matrix_mdev->kvm = kvm;
 	kvm_get_kvm(kvm);
 	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-	mutex_unlock(&matrix_dev->lock);
 
 	return 0;
 }
@@ -1083,35 +1078,52 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
+{
+	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+	kvm_put_kvm(matrix_mdev->kvm);
+	matrix_mdev->kvm = NULL;
+}
+
 static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 				       unsigned long action, void *data)
 {
-	int ret;
+	int ret, notify_rc = NOTIFY_OK;
 	struct ap_matrix_mdev *matrix_mdev;
 
 	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
 		return NOTIFY_OK;
 
 	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
+	mutex_lock(&matrix_dev->lock);
 
 	if (!data) {
-		matrix_mdev->kvm = NULL;
-		return NOTIFY_OK;
+		if (matrix_mdev->kvm)
+			vfio_ap_mdev_unset_kvm(matrix_mdev);
+		goto notify_done;
 	}
 
 	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
-	if (ret)
-		return NOTIFY_DONE;
+	if (ret) {
+		notify_rc = NOTIFY_DONE;
+		goto notify_done;
+	}
 
 	/* If there is no CRYCB pointer, then we can't copy the masks */
-	if (!matrix_mdev->kvm->arch.crypto.crycbd)
-		return NOTIFY_DONE;
+	if (!matrix_mdev->kvm->arch.crypto.crycbd) {
+		notify_rc = NOTIFY_DONE;
+		goto notify_done;
+	}
 
 	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
 				  matrix_mdev->matrix.aqm,
 				  matrix_mdev->matrix.adm);
 
-	return NOTIFY_OK;
+notify_done:
+	mutex_unlock(&matrix_dev->lock);
+	return notify_rc;
 }
 
 static void vfio_ap_irq_disable_apqn(int apqn)
@@ -1222,13 +1234,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	mutex_lock(&matrix_dev->lock);
-	if (matrix_mdev->kvm) {
-		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
-		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
-		vfio_ap_mdev_reset_queues(mdev);
-		kvm_put_kvm(matrix_mdev->kvm);
-		matrix_mdev->kvm = NULL;
-	}
+	if (matrix_mdev->kvm)
+		vfio_ap_mdev_unset_kvm(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-- 
2.21.1
