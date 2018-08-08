From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v8 10/22] s390: vfio-ap: sysfs interfaces to configure adapters
Date: Wed,  8 Aug 2018 10:44:20 -0400
Message-ID: <1533739472-7172-11-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces two new sysfs attributes for the VFIO mediated
matrix device for assigning AP adapters to and unassigning
AP adapters from a mediated matrix device. The IDs of the
AP adapters assigned to the mediated matrix device will be
stored in an AP mask (APM).

The bits in the APM, from most significant to least significant
bit, correspond to AP adapter IDs (APID) 0 to 255. On
some systems, the maximum allowable adapter number may be less
than 255 - depending upon the host's AP configuration - and
assignment may be rejected if the input adapter ID exceeds the
limit.

When an adapter is assigned, the bit corresponding to the APID
will be set in the APM. Likewise, when an adapter is
unassigned, the bit corresponding to the APID will be cleared
from the APM.

In order to successfully assign an adapter, the APQNs derived from
the adapter ID being assigned and the queue indexes of all domains
previously assigned:

1. Must be bound to the vfio_ap device driver.

2. Must not be assigned to any other mediated matrix device

If there are no domains assigned to the mdev, then there must
be an AP queue bound to the vfio_ap device driver with an
APQN containing the APID, otherwise all domains
subsequently assigned will fail because there will be no
AP queues bound with an APQN containing the adapter ID.

Assigning or un-assigning an AP adapter will be rejected if
a guest using the mediated matrix device is running.

The relevant sysfs structures are:

/sys/devices/virtual/misc/vfio_ap/
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

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |  273 +++++++++++++++++++++++++++++++++++++
 1 files changed, 273 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2d2b6fe..0a9f61f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -106,9 +106,282 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 	NULL,
 };
 
+struct vfio_ap_queue_reserved {
+	unsigned long *apid;
+	unsigned long *apqi;
+	bool reserved;
+};
+
+/**
+ * vfio_ap_has_queue
+ *
+ * @dev: an AP queue device
+ * @data: a struct vfio_ap_queue_reserved reference
+ *
+ * Flags whether the AP queue device (@dev) has a queue ID containing the APQN,
+ * apid or apqi specified in @data:
+ *
+ * - If @data contains both an apid and apqi value, then @data will be flagged
+ *   as reserved if the APID and APQI fields for the AP queue device matches
+ *
+ * - If @data contains only an apid value, @data will be flagged as
+ *   reserved if the APID field in the AP queue device matches
+ *
+ * - If @data contains only an apqi value, @data will be flagged as
+ *   reserved if the APQI field in the AP queue device matches
+ *
+ * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
+ * @data does not contain either an apid or apqi.
+ */
+static int vfio_ap_has_queue(struct device *dev, void *data)
+{
+	struct vfio_ap_queue_reserved *qres = data;
+	struct ap_queue *ap_queue = to_ap_queue(dev);
+	ap_qid_t qid;
+	unsigned long id;
+
+	if (qres->apid && qres->apqi) {
+		qid = AP_MKQID(*qres->apid, *qres->apqi);
+		if (qid == ap_queue->qid)
+			qres->reserved = true;
+	} else if (qres->apid && !qres->apqi) {
+		id = AP_QID_CARD(ap_queue->qid);
+		if (id == *qres->apid)
+			qres->reserved = true;
+	} else if (!qres->apid && qres->apqi) {
+		id = AP_QID_QUEUE(ap_queue->qid);
+		if (id == *qres->apqi)
+			qres->reserved = true;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * vfio_ap_verify_queue_reserved
+ *
+ * @matrix_dev: a mediated matrix device
+ * @apid: an AP adapter ID
+ * @apqi: an AP queue index
+ *
+ * Verifies that the AP queue with @apid/@apqi is reserved by the VFIO AP device
+ * driver according to the following rules:
+ *
+ * - If both @apid and @apqi are not NULL, then there must be an AP queue
+ *   device bound to the vfio_ap driver with the APQN identified by @apid and
+ *   @apqi
+ *
+ * - If only @apid is not NULL, then there must be an AP queue device bound
+ *   to the vfio_ap driver with an APQN containing @apid
+ *
+ * - If only @apqi is not NULL, then there must be an AP queue device bound
+ *   to the vfio_ap driver with an APQN containing @apqi
+ *
+ * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
+ */
+static int vfio_ap_verify_queue_reserved(unsigned long *apid,
+					 unsigned long *apqi)
+{
+	int ret;
+	struct vfio_ap_queue_reserved qres;
+
+	qres.apid = apid;
+	qres.apqi = apqi;
+	qres.reserved = false;
+
+	ret = driver_for_each_device(matrix_dev.misc_dev.this_device->driver,
+				     NULL, &qres, vfio_ap_has_queue);
+	if (ret)
+		return ret;
+
+	if (qres.reserved)
+		return 0;
+
+	return -EADDRNOTAVAIL;
+}
+
+static int
+vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apid)
+{
+	int ret;
+	unsigned long apqi;
+	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
+
+	if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
+		return vfio_ap_verify_queue_reserved(&apid, NULL);
+
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
+		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * vfio_ap_mdev_verify_no_sharing
+ *
+ * Verifies that the APQNs derived from the cross product of the AP adapter IDs
+ * and AP queue indexes comprising the AP matrix are not configured for another
+ * activated mediated device. AP queue sharing is not allowed.
+ *
+ * @kvm: the KVM guest
+ * @matrix: the AP matrix
+ *
+ * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
+ */
+static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
+{
+	int nbits;
+	struct ap_matrix_mdev *lstdev;
+	unsigned long apm[BITS_TO_LONGS(matrix_mdev->matrix.apm_max + 1)];
+	unsigned long aqm[BITS_TO_LONGS(matrix_mdev->matrix.aqm_max + 1)];
+
+	list_for_each_entry(lstdev, &matrix_dev.mdev_list, list) {
+		if (matrix_mdev == lstdev)
+			continue;
+
+		memset(apm, 0, sizeof(apm));
+		memset(aqm, 0, sizeof(aqm));
+
+		/*
+		 * We work on full longs, as we can only exclude the leftover
+		 * bits in non-inverse order. The leftover is all zeros.
+		 */
+		nbits = sizeof(apm) * BITS_PER_BYTE;
+		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
+				lstdev->matrix.apm, nbits))
+			continue;
+
+		nbits = sizeof(aqm) * BITS_PER_BYTE;
+		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
+				lstdev->matrix.aqm, nbits))
+			continue;
+
+		return -EADDRINUSE;
+	}
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
+ * Parses the APID from @buf and assigns it to the mediated matrix device.
+ *
+ * Returns the number of bytes processed if the APID is valid; otherwise returns
+ * an error.
+ */
+static ssize_t assign_adapter_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret = 0;
+	unsigned long apid;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long max_apid = matrix_mdev->matrix.apm_max;
+
+	ret = kstrtoul(buf, 0, &apid);
+	if (ret)
+		return ret;
+	if (apid > max_apid)
+		return -EINVAL;
+
+	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
+	 * number (APID). The bits in the mask, from most significant to least
+	 * significant bit, correspond to APIDs 0-255.
+	 */
+	mutex_lock(&matrix_dev.lock);
+
+	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
+	if (ret)
+		goto done;
+
+	set_bit_inv(apid, matrix_mdev->matrix.apm);
+
+	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
+	if (ret)
+		goto share_err;
+
+	ret = count;
+	goto done;
+
+share_err:
+	clear_bit_inv(apid, matrix_mdev->matrix.apm);
+done:
+	mutex_unlock(&matrix_dev.lock);
+
+	return ret;
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
+
+	ret = kstrtoul(buf, 0, &apid);
+	if (ret)
+		return ret;
+
+	if (apid > matrix_mdev->matrix.apm_max)
+		return -EINVAL;
+
+	mutex_lock(&matrix_dev.lock);
+	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	mutex_unlock(&matrix_dev.lock);
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
-- 
1.7.1
