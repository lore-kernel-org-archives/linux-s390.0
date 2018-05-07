From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v5 07/13] s390: vfio-ap: sysfs interfaces to configure adapters
Date: Mon,  7 May 2018 11:11:46 -0400
Message-ID: <1525705912-12815-8-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Provides the sysfs interfaces for assigning AP adapters to
and unassigning AP adapters from a mediated matrix device.

The IDs of the AP adapters assigned to the mediated matrix
device are stored in an AP mask (APM). The bits in the APM,
from most significant to least significant bit, correspond to
AP adapter ID (APID) 0 to 255. When an adapter is assigned, the
bit corresponding the APID will be set in the APM.
Likewise, when an adapter is unassigned, the bit corresponding
to the APID will be cleared from the APM.

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
write the APID to the assign_adapter file. To unassign an adapter,
write the APID to the unassign_adapter file. The APID is specified
using conventional semantics: If it begins with 0x the number will
be parsed as a hexadecimal number; if it begins with a 0 the number
will be parsed as an octal number; otherwise, it will be parsed as a
decimal number.

For example, to assign adapter 173 (0xad) to the mediated matrix
device $uuid:

	echo 173 > assign_adapter

	or

	echo 0xad > assign_adapter

	or

	echo 0255 > assign_adapter

To unassign adapter 173 (0xad):

	echo 173 > unassign_adapter

	or

	echo 0xad > unassign_adapter

	or

	echo 0255 > unassign_adapter

The assignment will be rejected:

* If the APID exceeds the maximum value for an AP adapter:
  * If the AP Extended Addressing (APXA) facility is
    installed, the max value is 255
  * Else the max value is 64

* If no AP domains have yet been assigned and there are
  no AP queues bound to the VFIO AP driver that have an APQN
  with an APID matching that of the AP adapter being assigned.

* If any of the APQNs that can be derived from the cross product
  of the APID being assigned and the AP queue index (APQI) of
  each of the AP domains previously assigned can not be matched
  with an APQN of an AP queue device reserved by the VFIO AP
  driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     |  318 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   34 ++++
 2 files changed, 352 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d7d36fb..914274d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -20,7 +20,16 @@
 static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 {
 	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
+	struct ap_matrix_mdev *matrix_mdev;
 
+	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
+	if (!matrix_mdev)
+		return -ENOMEM;
+
+	matrix_mdev->matrix.apm_max = vfio_ap_max_adapter_id();
+	matrix_mdev->matrix.aqm_max = vfio_ap_max_domain_id();
+	matrix_mdev->matrix.adm_max =  matrix_mdev->matrix.aqm_max;
+	mdev_set_drvdata(mdev, matrix_mdev);
 	ap_matrix->available_instances--;
 
 	return 0;
@@ -29,7 +38,10 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	kfree(matrix_mdev);
+	mdev_set_drvdata(mdev, NULL);
 	ap_matrix->available_instances++;
 
 	return 0;
@@ -79,9 +91,315 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
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
+
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
+	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
+	struct device_driver *drv = ap_matrix->device.driver;
+
+	/**
+	 * Examine each APQN with the specified APID
+	 */
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
+		qid_match.qid = AP_MKQID(apid, apqi);
+		qid_match.dev = NULL;
+
+		ret = driver_for_each_device(drv, NULL, &qid_match,
+					     vfio_ap_queue_match);
+		if (ret) {
+			pr_err("%s: %s: Error %d validating AP queue %02lx.%04lx reservation",
+			       VFIO_AP_MODULE_NAME, __func__, ret, apid, apqi);
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
+		pr_err("%s: %s: AP queue %02lx.%04lx not reserved by %s driver",
+		       VFIO_AP_MODULE_NAME, __func__, apid, apqi,
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
+	apid_res.reserved = false;
+
+	ret = driver_for_each_device(ap_matrix->device.driver, NULL, &apid_res,
+				     vfio_ap_queue_id_contains_apid);
+	if (ret)
+		return ret;
+
+	if (apid_res.reserved)
+		return 0;
+
+	pr_err("%s: %s: no APQNs with adapter ID %02lx are reserved by %s driver",
+		VFIO_AP_MODULE_NAME, __func__, apid, VFIO_AP_DRV_NAME);
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
+	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
+	unsigned long apqi;
+
+	apqi = find_first_bit_inv(matrix_mdev->matrix.aqm, max_apqi + 1);
+	if (apqi > max_apqi) {
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
+	unsigned long max_apid = matrix_mdev->matrix.apm_max;
+
+	ret = kstrtoul(buf, 0, &apid);
+	if (ret || (apid > max_apid)) {
+		pr_err("%s: %s: adapter id '%s' not a value from 0 to %02lu(%#04lx)",
+		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
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
+	set_bit_inv(apid, matrix_mdev->matrix.apm);
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
+	unsigned long max_apid = matrix_mdev->matrix.apm_max;
+
+	ret = kstrtoul(buf, 0, &apid);
+	if (ret || (apid > max_apid)) {
+		pr_err("%s: %s: adapter id '%s' must be a value from 0 to %02lu(%#04lx)",
+		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	if (!test_bit_inv(apid, matrix_mdev->matrix.apm)) {
+		pr_err("%s: %s: adapter id %02lu(%#04lx) not assigned",
+		       VFIO_AP_MODULE_NAME, __func__, apid, apid);
+
+		return -ENODEV;
+	}
+
+	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
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
index afd8dbc..8b6ad66 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mdev.h>
+#include <asm/kvm-ap.h>
 
 #include "ap_bus.h"
 
@@ -29,11 +30,44 @@ struct ap_matrix {
 	int available_instances;
 };
 
+struct ap_matrix_mdev {
+	struct kvm_ap_matrix matrix;
+};
+
 static inline struct ap_matrix *to_ap_matrix(struct device *dev)
 {
 	return container_of(dev, struct ap_matrix, device);
 }
 
+static inline unsigned long vfio_ap_max_adapter_id(void)
+{
+	struct ap_config_info info;
+	/*
+	 * TODO:
+	 * Replace with call to ap_query_configuration() when that function is
+	 * made static in the AP bus code.
+	 */
+	if (kvm_ap_query_configuration(&info))
+		return 15;
+
+	return info.apxa ? info.Na : 63;
+}
+
+static inline unsigned long vfio_ap_max_domain_id(void)
+{
+	struct ap_config_info info;
+
+	/*
+	 * TODO:
+	 * Replace with call to ap_query_configuration() when that function is
+	 * made static in the AP bus code.
+	 */
+	if (kvm_ap_query_configuration(&info))
+		return 15;
+
+	return info.apxa ? info.Nd : 15;
+}
+
 extern int vfio_ap_mdev_register(struct ap_matrix *ap_matrix);
 extern void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix);
 
-- 
1.7.1
