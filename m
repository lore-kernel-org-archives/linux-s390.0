From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v4 10/15] s390: vfio-ap: sysfs interfaces to configure domains
Date: Sun, 15 Apr 2018 17:22:20 -0400
Message-ID: <1523827345-11600-11-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Provides the sysfs interfaces for assigning AP domains to
and unassigning AP domains from a mediated matrix device.

An AP domain ID corresponds to an AP queue index (APQI). For
each domain assigned to the mediated matrix device, its
corresponging APQI is stored in an AP queue mask (AQM).
The bits in the AQM, from most significant to least
significant bit, correspond to AP domain numbers 0 to 255.
When a domain is assigned, the bit corresponding to its
APQI will be set in the AQM. Likewise, when a domain is
unassigned, the bit corresponding to its APQI will be
cleared from the AQM.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. assign_domain
.................. unassign_domain

To assign a domain to the $uuid mediated matrix device,
write the domain's ID to the assign_domain file. To
unassign a domain, write the domain's ID to the
unassign_domain file. The ID is specified using
conventional semantics: If it begins with 0x, the number
will be parsed as a hexadecimal (case insensitive) number;
otherwise, it will be parsed as a decimal number.

For example, to assign domain 173 (0xad) to the mediated matrix
device $uuid:

	echo 173 > assign_domain

	or

	echo 0xad > assign_domain

To unassign domain 173 (0xad):

	echo 173 > unassign_domain

	or

	echo 0xad > unassign_domain

The assignment will be rejected:

* If the domain ID exceeds the maximum value for an AP domain:

  * If the AP Extended Addressing (APXA) facility is installed,
    the max value is 255

  * Else the max value is 15

* If no AP adapters have yet been assigned and there are
  no AP queues reserved by the VFIO AP driver that have an APQN
  with an APQI matching that of the AP domain number being
  assigned.

* If any of the APQNs that can be derived from the intersection
  of the APQI being assigned and the AP adapter ID (APID) of
  each of the AP adapters previously assigned can not be matched
  with an APQN of an AP queue device reserved by the VFIO AP
  driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h    |    1 +
 drivers/s390/crypto/vfio_ap_ops.c |  221 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 221 insertions(+), 1 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 5ebb171..8ee196e 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -18,6 +18,7 @@
 
 #define KVM_AP_MASK_BYTES(n)	DIV_ROUND_UP(n, BITS_PER_BYTE)
 #define KVM_AP_MAX_APM_INDEX(matrix)	(matrix->apm_max - 1)
+#define KVM_AP_MAX_AQM_INDEX(matrix)	(matrix->aqm_max - 1)
 
 /**
  * The AP matrix is comprised of three bit masks identifying the adapters,
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6d32adb..d4f9310 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -380,10 +380,229 @@ static ssize_t unassign_adapter_store(struct device *dev,
 }
 DEVICE_ATTR_WO(unassign_adapter);
 
+/**
+ * vfio_ap_validate_queues_for_apqi
+ *
+ * @ap_matrix: the matrix device
+ * @matrix_mdev: the mediated matrix device
+ * @apqi: an AP queue index (APQI) - corresponds to a domain ID
+ *
+ * Verifies that each APQN that is derived from the intersection of @apqi and
+ * each AP adapter ID (APID) corresponding to an AP domain assigned to the
+ * @matrix_mdev matches the APQN of an AP queue reserved by the VFIO AP device
+ * driver.
+ *
+ * Returns 0 if validation succeeds; otherwise, returns an error.
+ */
+static int vfio_ap_validate_queues_for_apqi(struct ap_matrix *ap_matrix,
+					    struct ap_matrix_mdev *matrix_mdev,
+					    unsigned long apqi)
+{
+	int ret;
+	struct vfio_ap_qid_match qid_match;
+	unsigned long apid;
+	struct device_driver *drv = ap_matrix->device.driver;
+
+	/**
+	 * Examine each APQN with the specified APQI
+	 */
+	for_each_set_bit_inv(apid, matrix_mdev->matrix->apm,
+			     matrix_mdev->matrix->apm_max) {
+		qid_match.qid = AP_MKQID(apid, apqi);
+		qid_match.dev = NULL;
+
+		ret = driver_for_each_device(drv, NULL, &qid_match,
+					     vfio_ap_queue_match);
+		if (ret) {
+			pr_err("%s: Error %d validating AP queue %02lx.%04lx reservation",
+			       VFIO_AP_MODULE_NAME, ret, apid, apqi);
+
+			return ret;
+		}
+
+		/*
+		 * If the APQN identifies an AP queue that is reserved by the
+		 * VFIO AP device driver, continue processing.
+		 */
+		if (qid_match.dev)
+			continue;
+
+		pr_err("%s: AP queue %02lx.%04lx not reserved by %s driver",
+			VFIO_AP_MODULE_NAME, apid, apqi, VFIO_AP_DRV_NAME);
+
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+struct vfio_ap_apqi_reserved {
+	unsigned long apqi;
+	bool reserved;
+};
+
+/**
+ * vfio_ap_queue_id_contains_apqi
+ *
+ * @dev: an AP queue device
+ * @data: an AP queue index (APQI)
+ *
+ * Returns 1 (true) if the APQI (@data) is contained in the AP queue's
+ * identifier; otherwise, returns 0;
+ */
+static int vfio_ap_queue_id_contains_apqi(struct device *dev, void *data)
+{
+	struct vfio_ap_apqi_reserved *apqi_res = data;
+	struct ap_queue *ap_queue = to_ap_queue(dev);
+
+	if (apqi_res->apqi == AP_QID_QUEUE(ap_queue->qid))
+		apqi_res->reserved = true;
+
+	return 0;
+}
+
+/**
+ * vfio_ap_verify_apqi_reserved
+ *
+ * @ap_matrix: the AP matrix configured for the mediated matrix device
+ * @apqi: the AP queue index (APQI) - corresponds to domain ID
+ *
+ * Verifies that at least one AP queue reserved by the VFIO AP device driver
+ * has an APQN containing @apqi.
+ *
+ * Returns 0 if the APQI is reserved; otherwise, returns -ENODEV.
+ */
+static int vfio_ap_verify_apqi_reserved(struct ap_matrix *ap_matrix,
+					unsigned long apqi)
+{
+	int ret;
+	struct vfio_ap_apqi_reserved apqi_res;
+
+	apqi_res.apqi = apqi;
+
+	ret = driver_for_each_device(ap_matrix->device.driver, NULL,
+				     &apqi_res,
+				     vfio_ap_queue_id_contains_apqi);
+	if (ret) {
+		pr_err("%s: Error %d validating AP queue index %04lx reservation",
+		       VFIO_AP_MODULE_NAME, ret, apqi);
+		return ret;
+	}
+
+	if (apqi_res.reserved)
+		return 0;
+
+	pr_err("%s: no APQNs with domain ID %02lx are reserved by %s driver",
+		VFIO_AP_MODULE_NAME, apqi, VFIO_AP_DRV_NAME);
+
+	return -ENODEV;
+}
+
+/**
+ * vfio_ap_validate_apqi
+ *
+ * @matrix_mdev: the mediated matrix device
+ * @apqi: the APQI (domain ID) to validate
+ *
+ * Validates the value of @apqi:
+ *	* If there are no AP adapters assigned, then there must be at least
+ *	  one AP queue device reserved by the VFIO AP device driver with an
+ *	  APQN containing @apqi.
+ *
+ *	* Else each APQN that can be derived from the intersection of @apqi and
+ *	  the IDs of the AP adapters already assigned must identify an AP queue
+ *	  that has been reserved by the VFIO AP device driver.
+ *
+ * Returns 0 if the value of @apqi is valid; otherwise, returns an error.
+ */
+static int vfio_ap_validate_apqi(struct mdev_device *mdev,
+				 struct ap_matrix_mdev *matrix_mdev,
+				 unsigned long apqi)
+{
+	int ret;
+	struct device *dev = mdev_parent_dev(mdev);
+	struct ap_matrix *ap_matrix = to_ap_matrix(dev);
+	unsigned long apid;
+
+	apid = find_first_bit_inv(matrix_mdev->matrix->apm,
+				  matrix_mdev->matrix->apm_max);
+	/* If there are no adapters assigned */
+	if (apid == matrix_mdev->matrix->apm_max) {
+		ret = vfio_ap_verify_apqi_reserved(ap_matrix, apqi);
+	} else {
+		ret = vfio_ap_validate_queues_for_apqi(ap_matrix, matrix_mdev,
+						       apqi);
+	}
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t assign_domain_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	int maxid = KVM_AP_MAX_AQM_INDEX(matrix_mdev->matrix);
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret || (apqi > maxid)) {
+		pr_err("%s: domain id '%s' not a value from 0 to %02d(%#04x)",
+		       VFIO_AP_MODULE_NAME, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	ret = vfio_ap_validate_apqi(mdev, matrix_mdev, apqi);
+	if (ret)
+		return ret;
+
+	/* Set the bit in the AQM (bitmask) corresponding to the AP domain
+	 * number (APQI). The bits in the mask, from most significant to least
+	 * significant, correspond to numbers 0-255.
+	 */
+	set_bit_inv(apqi, matrix_mdev->matrix->aqm);
+
+	return count;
+}
+DEVICE_ATTR_WO(assign_domain);
+
+static ssize_t unassign_domain_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	int maxid = KVM_AP_MAX_AQM_INDEX(matrix_mdev->matrix);
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret || (apqi > maxid)) {
+		pr_err("%s: domain id '%s' not a value from 0 to %02d(%#04x)",
+		       VFIO_AP_MODULE_NAME, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	clear_bit_inv((unsigned long)apqi,
+		      (unsigned long *)matrix_mdev->matrix->aqm);
+
+	return count;
+}
+DEVICE_ATTR_WO(unassign_domain);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
-	NULL
+	&dev_attr_assign_domain.attr,
+	&dev_attr_unassign_domain.attr,
+	NULL,
 };
 
 static struct attribute_group vfio_ap_mdev_attr_group = {
-- 
1.7.1
