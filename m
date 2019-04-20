Return-Path: <SRS0=agSP=SW=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 4/8] s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
Date: Sat, 20 Apr 2019 17:49:36 -0400
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1555796980-27920-5-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Let's allow adapters, domains and control domains to be assigned to or
unassigned from an AP matrix mdev device while it is in use by a guest.
When an adapter, domain or control domain is assigned to or unassigned
from an mdev device while a guest is using it, the guest's CRYCB will be
updated thus giving access to the resource assigned, or taking access away
from the resource unassigned for the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 49 ++++++++++++---------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 221491a9ba95..091804317c5e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -219,10 +219,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow assignment of adapter */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -237,10 +233,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 	 */
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
-	if (ret)
-		goto done;
-
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 
 	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
@@ -258,6 +250,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	ret = count;
 	goto done;
 
@@ -296,10 +289,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow un-assignment of adapter */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -312,6 +301,8 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	if (matrix_mdev->shadow_crycb)
 		clear_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
+
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -360,10 +351,6 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
-	/* If the guest is running, disallow assignment of domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -384,15 +371,16 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
-		goto share_err;
+		goto error;
 
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	ret = count;
 	goto done;
 
-share_err:
+error:
 	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -428,10 +416,6 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow un-assignment of domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -445,6 +429,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		clear_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -476,10 +461,6 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow assignment of control domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
 		return ret;
@@ -487,10 +468,12 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	if (id > matrix_mdev->matrix.adm_max)
 		return -ENODEV;
 
-	/* Set the bit in the ADM (bitmask) corresponding to the AP control
-	 * domain number (id). The bits in the mask, from most significant to
-	 * least significant, correspond to IDs 0 up to the one less than the
-	 * number of control domains that can be assigned.
+	/*
+	 * Set the bits in the ADM (bitmask) corresponding to the AP control
+	 * domain numbers in dommask. The bits in the mask, from left to right,
+	 * correspond to IDs 0 up to the one less than the number of control
+	 * domains that can be assigned.
+	 *
 	 */
 	mutex_lock(&matrix_dev->lock);
 	set_bit_inv(id, matrix_mdev->matrix.adm);
@@ -498,6 +481,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(id, matrix_mdev->shadow_crycb->adm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -530,10 +514,6 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
-	/* If the guest is running, disallow un-assignment of control domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
 		return ret;
@@ -546,6 +526,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		clear_bit_inv(domid, matrix_mdev->shadow_crycb->adm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
-- 
2.7.4
