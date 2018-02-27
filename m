From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v2 09/15] s390: vfio-ap: sysfs interfaces to configure adapters
Date: Tue, 27 Feb 2018 09:28:07 -0500
Message-ID: <1519741693-17440-10-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provides the sysfs interfaces for assigning AP adapters to
and unassigning AP adapters from a mediated matrix device.

The IDs of the AP adapters assigned to the mediated matrix
device are stored in an AP mask (APM). The bits in the APM,
from most significant to least significant bit, correspond to
AP adapter numbers 0 to 255. When an adapter is assigned, the
bit corresponding adapter ID will be set in the APM. Likewise,
when an adapter is unassigned, the bit corresponding to the
adapter ID will be cleared from the APM.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. assign_adapter
.................. unassign_adapter

To assign an adapter to the $uuid mediated matrix device's APM,
write the adapter ID (APID) to the assign_adapter file. To
unassign an adapter, write the APID to the unassign_adapter
file. The APID is specified using conventional semantics: If
it begins with 0x the number will be parsed as a hexadecimal
(case insensitive) number; otherwise, it will be parsed as a
decimal number.

For example, to assign adapter 173 (0xad) to the mediated matrix
device $uuid:

	echo 173 > assign_adapter

	or

	echo 0xad > assign_adapter

To unassign adapter 173 (0xad):

	echo 173 > unassign_adapter

	or

	echo 0xad > unassign_adapter

The assignment will be rejected:

* If the APID exceeds the maximum value for an AP adapter:
  * If the AP Extended Addressing (APXA) facility is
    installed, the max value is 255
  * Else the max value is 64

* If no AP domains have yet been assigned and there are
  no AP queues bound to the VFIO AP driver that have an APQN
  with an APID matching that of the AP adapter being assigned.

* If any of the APQNs that can be derived from the intersection
  of the APID being assigned and the AP queue index (APQI) of
  each of the AP domains previously assigned can not be matched
  with an APQN of an AP queue device reserved by the VFIO AP
  driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h        |    1 +
 drivers/s390/crypto/vfio_ap_ops.c     |  296 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |    1 +
 3 files changed, 298 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 6bd6bfb..f660aaf 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 
 #define KVM_AP_MASK_BYTES(n)(n / BITS_PER_BYTE)
+#define KVM_AP_MAX_APM_INDEX(matrix)(matrix->apm_max - 1)
 
 /**
  * The AP matrix is comprised of three bit masks identifying the adapters,
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4fda44e..90512a6 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -97,9 +97,305 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 	NULL,
 };
 
+struct vfio_apid_reserved {
+	unsigned long apid;
+	int reserved;
+};
+
+struct vfio_ap_qid_match {
+	qid_t qid;
+	struct device *dev;
+};
+
+/**
+ * vfio_ap_queue_match
+ *
+ * @dev: an AP queue device that has been reserved by the VFIO AP device
+ *	 driver
+ * @data: an AP queue identifier
+ *
+ * Returns 1 (true) if @data matches the AP queue identifier specified for @dev;
+ * otherwise, returns 0 (false);
+ */
+static int vfio_ap_queue_match(struct device *dev, void *data)
+{
+	struct vfio_ap_qid_match *qid_match = data;
+	struct ap_queue *ap_queue;
+
+	ap_queue = to_ap_queue(dev);
+	if (ap_queue->qid == qid_match->qid)
+		qid_match->dev = dev;
+
+	return 0;
+}
+
+/**
+ * vfio_ap_validate_queues_for_apid
+ *
+ * @ap_matrix: the matrix device
+ * @matrix_mdev: the mediated matrix device
+ * @apid: an AP adapter ID (APID)
+ *
+ * Verifies that each APQN that is derived from the intersection of @apid and
+ * each AP queue index (APQI) corresponding to an AP adapter assigned to the
+ * @matrix_mdev matches the APQN of an AP queue reserved by the VFIO AP device
+ * driver.
+ *
+ * Returns 0 if validation succeeds; otherwise, returns an error.
+ */
+static int vfio_ap_validate_queues_for_apid(struct ap_matrix *ap_matrix,
+					    struct ap_matrix_mdev *matrix_mdev,
+					    unsigned long apid)
+{
+	int ret;
+	struct vfio_ap_qid_match qid_match;
+	unsigned long apqi;
+	struct device_driver *drv = ap_matrix->device.driver;
+
+	/**
+	 * Examine each APQN with the specified APID
+	 */
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix->aqm,
+			     matrix_mdev->matrix->apm_max) {
+		qid_match.qid = AP_MKQID(apid, apqi);
+		qid_match.dev = NULL;
+
+		ret = driver_for_each_device(drv, NULL, &qid_match,
+					     vfio_ap_queue_match);
+		if (ret)
+			return ret;
+
+		/*
+		 * If the APQN identifies an AP queue that is reserved by the
+		 * VFIO AP device driver, continue processing.
+		 */
+		if (qid_match.dev)
+			continue;
+
+		pr_err("%s: AP queue %02lx.%04lx not reserved by %s driver",
+		       VFIO_AP_MATRIX_MODULE_NAME, apid, apqi,
+		       VFIO_AP_DRV_NAME);
+
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+struct vfio_ap_apid_reserved {
+	unsigned long apid;
+	bool reserved;
+};
+
+/**
+ * vfio_ap_queue_id_contains_apid
+ *
+ * @dev: an AP queue device
+ * @data: an AP adapter ID (APID)
+ *
+ * Returns 1 (true) if the APID (@data) is contained in the AP queue's (@data)
+ * identifier; otherwise, returns 0;
+ */
+static int vfio_ap_queue_id_contains_apid(struct device *dev, void *data)
+{
+	struct vfio_ap_apid_reserved *apid_res = data;
+	struct ap_queue *ap_queue = to_ap_queue(dev);
+
+	if (apid_res->apid == AP_QID_CARD(ap_queue->qid))
+		apid_res->reserved = true;
+
+	return 0;
+}
+
+/**
+ * vfio_ap_verify_apid_reserved
+ *
+ * @ap_matrix: the AP matrix configured for the mediated matrix device
+ * @apid: the AP adapter ID
+ *
+ * Verifies that at least one AP queue reserved by the VFIO AP device driver
+ * has an APQN containing @apid.
+ *
+ * Returns 0 if the APID is reserved; otherwise, returns -ENODEV.
+ */
+static int vfio_ap_verify_apid_reserved(struct ap_matrix *ap_matrix,
+					unsigned long apid)
+{
+	int ret;
+	struct vfio_ap_apid_reserved apid_res;
+
+	apid_res.apid = apid;
+
+	ret = driver_for_each_device(ap_matrix->device.driver, NULL,
+				     &apid_res,
+				     vfio_ap_queue_id_contains_apid);
+	if (ret)
+		return ret;
+
+	if (apid_res.reserved)
+		return 0;
+
+	pr_err("%s: no APQNs with adapter ID %02lx are reserved by %s driver",
+		VFIO_AP_MATRIX_MODULE_NAME, apid, VFIO_AP_DRV_NAME);
+
+	return -ENODEV;
+}
+
+/**
+ * vfio_ap_validate_apid
+ *
+ * @mdev: the mediated device
+ * @matrix_mdev: the mediated matrix device
+ * @apid: the APID to validate
+ *
+ * Validates the value of @apid:
+ *	* If there are no AP domains assigned, then there must be at least
+ *	  one AP queue device reserved by the VFIO AP device driver with an
+ *	  APQN containing @apid.
+ *
+ *	* Else each APQN that can be derived from the intersection of @apid and
+ *	  the IDs of the AP domains already assigned must identify an AP queue
+ *	  that has been reserved by the VFIO AP device driver.
+ *
+ * Returns 0 if the value of @apid is valid; otherwise, returns an error.
+ */
+static int vfio_ap_validate_apid(struct mdev_device *mdev,
+				 struct ap_matrix_mdev *matrix_mdev,
+				 unsigned long apid)
+{
+	int ret;
+	struct device *dev = mdev_parent_dev(mdev);
+	struct ap_matrix *ap_matrix = to_ap_matrix(dev);
+	unsigned long apqi;
+
+	apqi = find_first_bit_inv(matrix_mdev->matrix->aqm,
+				  matrix_mdev->matrix->aqm_max);
+	if (apqi == matrix_mdev->matrix->aqm_max) {
+		ret = vfio_ap_verify_apid_reserved(ap_matrix, apid);
+	} else {
+		ret = vfio_ap_validate_queues_for_apid(ap_matrix, matrix_mdev,
+						       apid);
+	}
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * assign_adapter_store
+ *
+ * @dev: the matrix device
+ * @attr: a mediated matrix device attribute
+ * @buf: a buffer containing the adapter ID (APID) to be assigned
+ * @count: the number of bytes in @buf
+ *
+ * Parses the APID from @buf and assigns it to the mediated matrix device. The
+ * APID must be a valid value:
+ *	* The APID value must not exceed the maximum allowable AP adapter ID
+ *
+ *	* If there are no AP domains assigned, then there must be at least
+ *	  one AP queue device reserved by the VFIO AP device driver with an
+ *	  APQN containing @apid.
+ *
+ *	* Else each APQN that can be derived from the intersection of @apid and
+ *	  the IDs of the AP domains already assigned must identify an AP queue
+ *	  that has been reserved by the VFIO AP device driver.
+ *
+ * Returns the number of bytes processed if the APID is valid; otherwise returns
+ * an error.
+ */
+static ssize_t assign_adapter_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apid;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	int maxid = KVM_AP_MAX_APM_INDEX(matrix_mdev->matrix);
+
+	ret = kstrtoul(buf, 0, &apid);
+	if (ret || (apid > maxid)) {
+		pr_err("%s: adapter id '%s' not a value from 0 to %02d(%#04x)",
+		       VFIO_AP_MATRIX_MODULE_NAME, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	ret = vfio_ap_validate_apid(mdev, matrix_mdev, apid);
+	if (ret)
+		return ret;
+
+	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
+	 * number (APID). The bits in the mask, from most significant to least
+	 * significant bit, correspond to APIDs 0-255.
+	 */
+	set_bit_inv(apid, matrix_mdev->matrix->apm);
+
+	return count;
+}
+static DEVICE_ATTR_WO(assign_adapter);
+
+/**
+ * unassign_adapter_store
+ *
+ * @dev: the matrix device
+ * @attr: a mediated matrix device attribute
+ * @buf: a buffer containing the adapter ID (APID) to be assigned
+ * @count: the number of bytes in @buf
+ *
+ * Parses the APID from @buf and unassigns it from the mediated matrix device.
+ * The APID must be a valid value
+ *
+ * Returns the number of bytes processed if the APID is valid; otherwise returns
+ * an error.
+ */
+static ssize_t unassign_adapter_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apid;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	int maxid = KVM_AP_MAX_APM_INDEX(matrix_mdev->matrix);
+
+	ret = kstrtoul(buf, 0, &apid);
+	if (ret || (apid > maxid)) {
+		pr_err("%s: adapter id '%s' must be a value from 0 to %02d(%#04x)",
+		       VFIO_AP_MATRIX_MODULE_NAME, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	clear_bit_inv((unsigned long)apid,
+		      (unsigned long *)matrix_mdev->matrix->apm);
+
+	return count;
+}
+DEVICE_ATTR_WO(unassign_adapter);
+
+static struct attribute *vfio_ap_mdev_attrs[] = {
+	&dev_attr_assign_adapter.attr,
+	&dev_attr_unassign_adapter.attr,
+	NULL
+};
+
+static struct attribute_group vfio_ap_mdev_attr_group = {
+	.attrs = vfio_ap_mdev_attrs
+};
+
+static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
+	&vfio_ap_mdev_attr_group,
+	NULL
+};
+
 static const struct mdev_parent_ops vfio_ap_matrix_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups	= vfio_ap_mdev_type_groups,
+	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
 	.create			= vfio_ap_mdev_create,
 	.remove			= vfio_ap_mdev_remove,
 };
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 522564e..a92d5ad 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/mdev.h>
+#include <asm/kvm-ap.h>
 #include "ap_bus.h"
 
 #define VFIO_AP_MODULE_NAME "vfio_ap"
-- 
1.7.1
