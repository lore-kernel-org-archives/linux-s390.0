From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 26 Jul 2018 19:54:19 +0000
Subject: [PATCH v7 12/22] s390: vfio-ap: sysfs interfaces to configure control domains
Message-Id: <20180726195429.31960-13-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Provides the sysfs interfaces for assigning AP control domains
to and unassigning AP control domains from a mediated matrix device.

The IDs of the AP control domains assigned to the mediated matrix
device are stored in an AP domain mask (ADM). The bits in the ADM,
from most significant to least significant bit, correspond to
AP domain numbers 0 to 255. When a control domain is assigned,
the bit corresponding its domain ID will be set in the ADM.
Likewise, when a domain is unassigned, the bit corresponding
to its domain ID will be cleared in the ADM.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. assign_control_domain
.................. unassign_control_domain

To assign a control domain to the $uuid mediated matrix device's
ADM, write its domain number to the assign_control_domain file.
To unassign a domain, write its domain number to the
unassign_control_domain file. The domain number is specified
using conventional semantics: If it begins with 0x the number
will be parsed as a hexadecimal (case insensitive) number;
if it begins with 0, it is parsed as an octal number;
otherwise, it will be parsed as a decimal number.

For example, to assign control domain 173 (0xad) to the mediated
matrix device $uuid:

	echo 173 > assign_control_domain

	or

	echo 0255 > assign_control_domain

	or

	echo 0xad > assign_control_domain

To unassign control domain 173 (0xad):

	echo 173 > unassign_control_domain

	or

	echo 0255 > unassign_control_domain

	or

	echo 0xad > unassign_control_domain

The assignment will be rejected if the APQI exceeds the maximum
value for an AP domain:
  * If the AP Extended Addressing (APXA) facility is installed,
    the max value is 255
  * Else the max value is 15

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 129 ++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 049256d785e2..fafe6ec7fec7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -277,11 +277,140 @@ static ssize_t unassign_domain_store(struct device *dev,
 }
 DEVICE_ATTR_WO(unassign_domain);
 
+
+/**
+ * assign_control_domain_store
+ *
+ * @dev: the matrix device
+ * @attr: a mediated matrix device attribute
+ * @buf: a buffer containing the adapter ID (APID) to be assigned
+ * @count: the number of bytes in @buf
+ *
+ * Parses the domain ID from @buf and assigns it to the mediated matrix device.
+ *
+ * Returns the number of bytes processed if the domain ID is valid; otherwise
+ * returns an error.
+ */
+static ssize_t assign_control_domain_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long id;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long maxid = matrix_mdev->matrix.adm_max;
+
+	ret = kstrtoul(buf, 0, &id);
+	if (ret || (id > maxid)) {
+		pr_warn("%s: %s: control domain id '%s' not a value from 0 to %02lu(%#04lx)\n",
+		       VFIO_AP_MODULE_NAME, __func__, buf, maxid, maxid);
+
+		if (!ret)
+			ret = -EINVAL;
+
+		return ret;
+	}
+
+	/* Set the bit in the ADM (bitmask) corresponding to the AP control
+	 * domain number (id). The bits in the mask, from most significant to
+	 * least significant, correspond to IDs 0 up to the one less than the
+	 * number of control domains that can be assigned.
+	 */
+	mutex_lock(&matrix_dev.lock);
+	set_bit_inv(id, matrix_mdev->matrix.adm);
+	ret = count;
+
+	mutex_unlock(&matrix_dev.lock);
+
+	return ret;
+}
+DEVICE_ATTR_WO(assign_control_domain);
+
+/**
+ * unassign_control_domain_store
+ *
+ * @dev: the matrix device
+ * @attr: a mediated matrix device attribute
+ * @buf: a buffer containing the adapter ID (APID) to be assigned
+ * @count: the number of bytes in @buf
+ *
+ * Parses the domain ID from @buf and unassigns it from the mediated matrix
+ * device.
+ *
+ * Returns the number of bytes processed if the domain ID is valid; otherwise
+ * returns an error.
+ */
+static ssize_t unassign_control_domain_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	int ret;
+	unsigned long domid;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
+
+	ret = kstrtoul(buf, 0, &domid);
+	if (ret || (domid > max_domid)) {
+		pr_warn("%s: %s: control domain id '%s' not a value from 0 to %02lu(%#04lx)\n",
+		       VFIO_AP_MODULE_NAME, __func__, buf,
+		       max_domid, max_domid);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	mutex_lock(&matrix_dev.lock);
+	if (!test_bit_inv(domid, matrix_mdev->matrix.adm)) {
+		pr_warn("%s: %s: control domain id %02lu(%#04lx) is not assigned\n",
+		       VFIO_AP_MODULE_NAME, __func__, domid, domid);
+
+		ret = -ENODEV;
+		goto done;
+	}
+
+	clear_bit_inv(domid, matrix_mdev->matrix.adm);
+	ret = count;
+
+done:
+	mutex_unlock(&matrix_dev.lock);
+
+	return ret;
+}
+DEVICE_ATTR_WO(unassign_control_domain);
+
+static ssize_t control_domains_show(struct device *dev,
+				    struct device_attribute *dev_attr,
+				    char *buf)
+{
+	unsigned long id;
+	int nchars = 0;
+	int n;
+	char *bufpos = buf;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long max_domid = matrix_mdev->matrix.adm_max;
+
+	mutex_lock(&matrix_dev.lock);
+	for_each_set_bit_inv(id, matrix_mdev->matrix.adm, max_domid + 1) {
+		n = sprintf(bufpos, "%04lx\n", id);
+		bufpos += n;
+		nchars += n;
+	}
+	mutex_unlock(&matrix_dev.lock);
+
+	return nchars;
+}
+DEVICE_ATTR_RO(control_domains);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
 	&dev_attr_assign_domain.attr,
 	&dev_attr_unassign_domain.attr,
+	&dev_attr_assign_control_domain.attr,
+	&dev_attr_unassign_control_domain.attr,
+	&dev_attr_control_domains.attr,
 	NULL,
 };
 
-- 
2.17.0
