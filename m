Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728849AbgGTPEO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 11:04:14 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v9 11/15] s390/vfio-ap: allow hot plug/unplug of AP resources using mdev device
Date: Mon, 20 Jul 2020 11:03:40 -0400
Message-Id: <20200720150344.24488-12-akrowiak@linux.ibm.com>
In-Reply-To: <20200720150344.24488-1-akrowiak@linux.ibm.com>
References: <20200720150344.24488-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Let's hot plug/unplug adapters, domains and control domains assigned to or
unassigned from an AP matrix mdev device while it is in use by a guest per
the following:

* When the APID of an adapter is assigned to a matrix mdev in use by a KVM
  guest, the adapter will be hot plugged into the KVM guest as long as each
  APQN derived from the Cartesian product of the APID being assigned and
  the APQIs already assigned to the guest's CRYCB references a queue device
  bound to the vfio_ap device driver.

* When the APID of an adapter is unassigned from a matrix mdev in use by a
  KVM guest, the adapter will be hot unplugged from the KVM guest.

* When the APQI of a domain is assigned to a matrix mdev in use by a KVM
  guest, the domain will be hot plugged into the KVM guest as long as each
  APQN derived from the Cartesian product of the APQI being assigned and
  the APIDs already assigned to the guest's CRYCB references a queue device
  bound to the vfio_ap device driver.

* When the APQI of a domain is unassigned from a matrix mdev in use by a
  KVM guest, the domain will be hot unplugged from the KVM guest

* When the domain number of a control domain is assigned to a matrix mdev
  in use by a KVM guest, the control domain will be hot plugged into the
  KVM guest.

* When the domain number of a control domain is unassigned from a matrix
  mdev in use by a KVM guest, the control domain will be hot unplugged
  from the KVM guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 196 ++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cf3321eb239b..2b01a8eb6ee7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -731,6 +731,56 @@ static void vfio_ap_mdev_link_queues(struct ap_matrix_mdev *matrix_mdev,
 	}
 }
 
+static bool vfio_ap_mdev_assign_apqis_4_apid(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apid)
+{
+	DECLARE_BITMAP(aqm, AP_DOMAINS);
+	unsigned long apqi, apqn;
+
+	bitmap_copy(aqm, matrix_mdev->matrix.aqm, AP_DOMAINS);
+
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
+		if (!test_bit_inv(apqi,
+				  (unsigned long *) matrix_dev->info.aqm))
+			clear_bit_inv(apqi, aqm);
+
+		apqn = AP_MKQID(apid, apqi);
+		if (!vfio_ap_get_mdev_queue(matrix_mdev, apqn))
+			clear_bit_inv(apqi, aqm);
+	}
+
+	if (bitmap_empty(aqm, AP_DOMAINS))
+		return false;
+
+	set_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+	bitmap_copy(matrix_mdev->shadow_apcb.aqm, aqm, AP_DOMAINS);
+
+	return true;
+}
+
+static bool vfio_ap_mdev_assign_guest_apid(struct ap_matrix_mdev *matrix_mdev,
+					   unsigned long apid)
+{
+	unsigned long apqi, apqn;
+
+	if (!vfio_ap_mdev_has_crycb(matrix_mdev) ||
+	    !test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm))
+		return false;
+
+	if (bitmap_empty(matrix_mdev->shadow_apcb.aqm, AP_DOMAINS))
+		return vfio_ap_mdev_assign_apqis_4_apid(matrix_mdev, apid);
+
+	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS) {
+		apqn = AP_MKQID(apid, apqi);
+		if (!vfio_ap_get_mdev_queue(matrix_mdev, apqn))
+			return false;
+	}
+
+	set_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+
+	return true;
+}
+
 /**
  * assign_adapter_store
  *
@@ -792,12 +842,42 @@ static ssize_t assign_adapter_store(struct device *dev,
 	}
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APID, apid);
+	if (vfio_ap_mdev_assign_guest_apid(matrix_mdev, apid))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
 }
 static DEVICE_ATTR_WO(assign_adapter);
 
+static bool vfio_ap_mdev_unassign_guest_apid(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apid)
+{
+	if (vfio_ap_mdev_has_crycb(matrix_mdev)) {
+		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
+			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+
+			/*
+			 * If there are no APIDs assigned to the guest, then
+			 * the guest will not have access to any queues, so
+			 * let's also go ahead and unassign the APQIs. Keeping
+			 * them around may yield unpredictable results during
+			 * a probe that is not related to a host AP
+			 * configuration change (i.e., an AP adapter is
+			 * configured online).
+			 */
+			if (bitmap_empty(matrix_mdev->shadow_apcb.apm,
+					 AP_DEVICES))
+				bitmap_clear(matrix_mdev->shadow_apcb.aqm, 0,
+					     AP_DOMAINS);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * unassign_adapter_store
  *
@@ -834,12 +914,64 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
 	vfio_ap_mdev_link_queues(matrix_mdev, UNLINK_APID, apid);
+	if (vfio_ap_mdev_unassign_guest_apid(matrix_mdev, apid))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
 }
 static DEVICE_ATTR_WO(unassign_adapter);
 
+static bool vfio_ap_mdev_assign_apids_4_apqi(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apqi)
+{
+	DECLARE_BITMAP(apm, AP_DEVICES);
+	unsigned long apid, apqn;
+
+	bitmap_copy(apm, matrix_mdev->matrix.apm, AP_DEVICES);
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		if (!test_bit_inv(apid,
+				  (unsigned long *) matrix_dev->info.apm))
+			clear_bit_inv(apqi, apm);
+
+		apqn = AP_MKQID(apid, apqi);
+		if (!vfio_ap_get_mdev_queue(matrix_mdev, apqn))
+			clear_bit_inv(apid, apm);
+	}
+
+	if (bitmap_empty(apm, AP_DEVICES))
+		return false;
+
+	set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
+	bitmap_copy(matrix_mdev->shadow_apcb.apm, apm, AP_DEVICES);
+
+	return true;
+}
+
+static bool vfio_ap_mdev_assign_guest_apqi(struct ap_matrix_mdev *matrix_mdev,
+					   unsigned long apqi)
+{
+	unsigned long apid, apqn;
+
+	if (!vfio_ap_mdev_has_crycb(matrix_mdev) ||
+	    !test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm))
+		return false;
+
+	if (bitmap_empty(matrix_mdev->shadow_apcb.apm, AP_DEVICES))
+		return vfio_ap_mdev_assign_apids_4_apqi(matrix_mdev, apqi);
+
+	for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm, AP_DEVICES) {
+		apqn = AP_MKQID(apid, apqi);
+		if (!vfio_ap_get_mdev_queue(matrix_mdev, apqn))
+			return false;
+	}
+
+	set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
+
+	return true;
+}
+
 /**
  * assign_domain_store
  *
@@ -901,12 +1033,41 @@ static ssize_t assign_domain_store(struct device *dev,
 	}
 	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
 	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APQI, apqi);
+	if (vfio_ap_mdev_assign_guest_apqi(matrix_mdev, apqi))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
 }
 static DEVICE_ATTR_WO(assign_domain);
 
+static bool vfio_ap_mdev_unassign_guest_apqi(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apqi)
+{
+	if (vfio_ap_mdev_has_crycb(matrix_mdev)) {
+		if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
+			clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
+
+			/*
+			 * If there are no APQIs assigned to the guest, then
+			 * the guest will not have access to any queues, so
+			 * let's also go ahead and unassign the APIDs. Keeping
+			 * them around may yield unpredictable results during
+			 * a probe that is not related to a host AP
+			 * configuration change (i.e., an AP adapter is
+			 * configured online).
+			 */
+			if (bitmap_empty(matrix_mdev->shadow_apcb.aqm,
+					 AP_DOMAINS))
+				bitmap_clear(matrix_mdev->shadow_apcb.apm, 0,
+					     AP_DEVICES);
+
+			return true;
+		}
+	}
+
+	return false;
+}
 
 /**
  * unassign_domain_store
@@ -944,12 +1105,28 @@ static ssize_t unassign_domain_store(struct device *dev,
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
 	vfio_ap_mdev_link_queues(matrix_mdev, UNLINK_APQI, apqi);
+	if (vfio_ap_mdev_unassign_guest_apqi(matrix_mdev, apqi))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
 }
 static DEVICE_ATTR_WO(unassign_domain);
 
+static bool vfio_ap_mdev_assign_guest_cdom(struct ap_matrix_mdev *matrix_mdev,
+					   unsigned long domid)
+{
+	if (vfio_ap_mdev_has_crycb(matrix_mdev)) {
+		if (!test_bit_inv(domid, matrix_mdev->shadow_apcb.adm)) {
+			set_bit_inv(domid, matrix_mdev->shadow_apcb.adm);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * assign_control_domain_store
  *
@@ -984,12 +1161,29 @@ static ssize_t assign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	set_bit_inv(id, matrix_mdev->matrix.adm);
+	if (vfio_ap_mdev_assign_guest_cdom(matrix_mdev, id))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
 }
 static DEVICE_ATTR_WO(assign_control_domain);
 
+static bool
+vfio_ap_mdev_unassign_guest_cdom(struct ap_matrix_mdev *matrix_mdev,
+				 unsigned long domid)
+{
+	if (vfio_ap_mdev_has_crycb(matrix_mdev)) {
+		if (test_bit_inv(domid, matrix_mdev->shadow_apcb.adm)) {
+			clear_bit_inv(domid, matrix_mdev->shadow_apcb.adm);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * unassign_control_domain_store
  *
@@ -1024,6 +1218,8 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv(domid, matrix_mdev->matrix.adm);
+	if (vfio_ap_mdev_unassign_guest_cdom(matrix_mdev, domid))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
-- 
2.21.1
