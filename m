Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v6 04/10] s390: vfio-ap: filter CRYCB bits for unavailable queue devices
Date: Fri, 13 Sep 2019 17:26:52 -0400
Message-Id: <1568410018-10833-5-git-send-email-akrowiak@linux.ibm.com>
In-Reply-To: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Even though APQNs for queues that are not in the AP configuration can be
assigned to a matrix mdev, we do not want to set bits in the guest's CRYCB
for APQNs that do not reference AP queue devices bound to the vfio_ap
device driver. The reason is because we have no idea whether a queue with
a given APQN will have a valid type (i.e., type 10 or newer) for the
vfio_ap device driver if/when it is subsequently added to the AP
configuration. If not, then it will not get bound to the vfio_ap device
driver. This patch filters out such APQNs before setting the bits in the
guest's CRYCB.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 131 ++++++++++++++++++++++++++++------
 drivers/s390/crypto/vfio_ap_private.h |   3 +
 2 files changed, 113 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 18270f286dec..fec07f912916 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -33,6 +33,22 @@ static int match_apqn(struct device *dev, const void *data)
 	return (q->apqn == *(int *)(data)) ? 1 : 0;
 }
 
+static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
+{
+	struct device *dev;
+	struct vfio_ap_queue *q;
+
+	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
+				 &apqn, match_apqn);
+	if (!dev)
+		return NULL;
+
+	q = dev_get_drvdata(dev);
+	put_device(dev);
+
+	return q;
+}
+
 /**
  * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
  * @matrix_mdev: the associated mediated matrix
@@ -49,20 +65,15 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
 					int apqn)
 {
 	struct vfio_ap_queue *q;
-	struct device *dev;
 
 	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
 		return NULL;
 	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
 		return NULL;
 
-	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
-				 &apqn, match_apqn);
-	if (!dev)
-		return NULL;
-	q = dev_get_drvdata(dev);
-	q->matrix_mdev = matrix_mdev;
-	put_device(dev);
+	q = vfio_ap_find_queue(apqn);
+	if (q)
+		q->matrix_mdev = matrix_mdev;
 
 	return q;
 }
@@ -336,6 +347,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
+	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->crycb);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
 	matrix_mdev->pqap_hook.owner = THIS_MODULE;
@@ -469,6 +481,44 @@ static int vfio_ap_mdev_validate_masks(struct ap_matrix_mdev *matrix_mdev,
 	return vfio_ap_mdev_verify_no_sharing(matrix_mdev, mdev_apm, mdev_aqm);
 }
 
+static void vfio_ap_mdev_get_crycb_matrix(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid, apqi;
+	unsigned long masksz = BITS_TO_LONGS(AP_DEVICES) *
+			       sizeof(unsigned long);
+
+	memset(matrix_mdev->crycb.apm, 0, masksz);
+	memset(matrix_mdev->crycb.apm, 0, masksz);
+	memcpy(matrix_mdev->crycb.adm, matrix_mdev->matrix.adm, masksz);
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			if (vfio_ap_find_queue(AP_MKQID(apid, apqi))) {
+				if (!test_bit_inv(apid, matrix_mdev->crycb.apm))
+					set_bit_inv(apid,
+						    matrix_mdev->crycb.apm);
+				if (!test_bit_inv(apqi, matrix_mdev->crycb.aqm))
+					set_bit_inv(apqi,
+						    matrix_mdev->crycb.aqm);
+			}
+		}
+	}
+}
+
+static bool vfio_ap_mdev_has_crycb(struct ap_matrix_mdev *matrix_mdev)
+{
+	return matrix_mdev->kvm && matrix_mdev->kvm->arch.crypto.crycbd;
+}
+
+static void vfio_ap_mdev_update_crycb(struct ap_matrix_mdev *matrix_mdev)
+{
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->crycb.apm,
+				  matrix_mdev->crycb.aqm,
+				  matrix_mdev->crycb.adm);
+}
+
 /**
  * assign_adapter_store
  *
@@ -479,7 +529,11 @@ static int vfio_ap_mdev_validate_masks(struct ap_matrix_mdev *matrix_mdev,
  * @count:	the number of bytes in @buf
  *
  * Parses the APID from @buf and sets the corresponding bit in the mediated
- * matrix device's APM.
+ * matrix device's APM. If a guest is using the matrix mdev, for each new APQN
+ * resulting from the assignment that identifies an AP queue device bound to the
+ * vfio_ap device driver, the bits corresponding to the APID and APQI will be
+ * set in the APM and AQM of the guest's CRYCB respectively, effectively
+ * plugging the queues into the guest.
  *
  * Returns the number of bytes processed if the APID is valid; otherwise,
  * returns one of the following errors:
@@ -529,6 +583,12 @@ static ssize_t assign_adapter_store(struct device *dev,
 		return ret;
 	}
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
+
+	vfio_ap_mdev_get_crycb_matrix(matrix_mdev);
+
+	if (vfio_ap_mdev_has_crycb(matrix_mdev))
+		vfio_ap_mdev_update_crycb(matrix_mdev);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -544,7 +604,9 @@ static DEVICE_ATTR_WO(assign_adapter);
  * @count:	the number of bytes in @buf
  *
  * Parses the APID from @buf and clears the corresponding bit in the mediated
- * matrix device's APM.
+ * matrix device's APM. If a guest is using the matrix mdev, the APID will also
+ * be cleared from the APM in the guest's CRYCB effectively unplugging the
+ * adapter from the guest.
  *
  * Returns the number of bytes processed if the APID is valid; otherwise,
  * returns one of the following errors:
@@ -570,6 +632,11 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	clear_bit_inv((unsigned long)apid, matrix_mdev->crycb.apm);
+
+	if (vfio_ap_mdev_has_crycb(matrix_mdev))
+		vfio_ap_mdev_update_crycb(matrix_mdev);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -586,7 +653,11 @@ static DEVICE_ATTR_WO(unassign_adapter);
  * @count:	the number of bytes in @buf
  *
  * Parses the APQI from @buf and sets the corresponding bit in the mediated
- * matrix device's AQM.
+ * matrix device's AQM. If a guest is using the matrix mdev, for each new APQN
+ * resulting from the assignment that identifies an AP queue device bound to the
+ * vfio_ap device driver, the bits corresponding to its APID and APQI will be
+ * set in the APM and AQM of the guest's CRYCB respectively, effectively
+ * plugging the queues into the guest.
  *
  * Returns the number of bytes processed if the APQI is valid; otherwise returns
  * one of the following errors:
@@ -636,6 +707,11 @@ static ssize_t assign_domain_store(struct device *dev,
 		return ret;
 	}
 	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
+	vfio_ap_mdev_get_crycb_matrix(matrix_mdev);
+
+	if (vfio_ap_mdev_has_crycb(matrix_mdev))
+		vfio_ap_mdev_update_crycb(matrix_mdev);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -653,7 +729,9 @@ static DEVICE_ATTR_WO(assign_domain);
  * @count:	the number of bytes in @buf
  *
  * Parses the APQI from @buf and clears the corresponding bit in the
- * mediated matrix device's AQM.
+ * mediated matrix device's AQM. If a guest is using the matrix mdev, the APQI
+ * will also be cleared from the AQM in the guest's CRYCB effectively unplugging
+ * all queues with the specified APQI from the guest.
  *
  * Returns the number of bytes processed if the APQI is valid; otherwise,
  * returns one of the following errors:
@@ -678,6 +756,11 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	clear_bit_inv((unsigned long)apqi, matrix_mdev->crycb.aqm);
+
+	if (vfio_ap_mdev_has_crycb(matrix_mdev))
+		vfio_ap_mdev_update_crycb(matrix_mdev);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -693,7 +776,9 @@ static DEVICE_ATTR_WO(unassign_domain);
  * @count:	the number of bytes in @buf
  *
  * Parses the domain ID from @buf and sets the corresponding bit in the mediated
- * matrix device's ADM.
+ * matrix device's ADM. If a guest is using the matrix mdev, the domain ID
+ * will also be set in the ADM of the guest's CRYCB giving the guest control
+ * over the domain.
  *
  * Returns the number of bytes processed if the domain ID is valid; otherwise,
  * returns one of the following errors:
@@ -718,6 +803,11 @@ static ssize_t assign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	set_bit_inv(id, matrix_mdev->matrix.adm);
+	set_bit_inv(id, matrix_mdev->crycb.adm);
+
+	if (vfio_ap_mdev_has_crycb(matrix_mdev))
+		vfio_ap_mdev_update_crycb(matrix_mdev);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -733,7 +823,9 @@ static DEVICE_ATTR_WO(assign_control_domain);
  * @count:	the number of bytes in @buf
  *
  * Parses the domain ID from @buf and clears the corresponding bit in the
- * mediated matrix device's ADM.
+ * mediated matrix device's ADM. If a guest is using the matrix mdev, the domain
+ * ID will also be cleared from the ADM of the guest's CRYCB taking control
+ * over the domain away from the guest.
  *
  * Returns the number of bytes processed if the domain ID is valid; otherwise,
  * returns one of the following errors:
@@ -942,13 +1034,10 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (ret)
 		return NOTIFY_DONE;
 
-	/* If there is no CRYCB pointer, then we can't copy the masks */
-	if (!matrix_mdev->kvm->arch.crypto.crycbd)
-		return NOTIFY_DONE;
-
-	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
-				  matrix_mdev->matrix.aqm,
-				  matrix_mdev->matrix.adm);
+	if (vfio_ap_mdev_has_crycb(matrix_mdev)) {
+		vfio_ap_mdev_get_crycb_matrix(matrix_mdev);
+		vfio_ap_mdev_update_crycb(matrix_mdev);
+	}
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5cc3c2ebf151..4a4e2c11fdf2 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -74,6 +74,8 @@ struct ap_matrix {
  * @list:	allows the ap_matrix_mdev struct to be added to a list
  * @matrix:	the adapters, usage domains and control domains assigned to the
  *		mediated matrix device.
+ * @crycb:	the adapters, usage domains and control domains configured for
+ *		a guest
  * @group_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
  * @kvm:	the struct holding guest's state
@@ -81,6 +83,7 @@ struct ap_matrix {
 struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
+	struct ap_matrix crycb;
 	struct notifier_block group_notifier;
 	struct notifier_block iommu_notifier;
 	struct kvm *kvm;
-- 
2.7.4
