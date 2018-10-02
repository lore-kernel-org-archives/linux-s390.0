From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:36 +0000
Subject: [GIT PULL 09/28] s390: vfio-ap: sysfs interface to view matrix mdev matrix
Message-Id: <20181002070655.224110-10-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Provides a sysfs interface to view the AP matrix configured for the
mediated matrix device.

The relevant sysfs structures are:

/sys/devices/vfio_ap/matrix/
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. matrix

To view the matrix configured for the mediated matrix device,
print the matrix file:

	cat matrix

Below are examples of the output from the above command:

Example 1: Adapters and domains assigned
	Assignments:
		Adapters 5 and 6
		Domains 4 and 71 (0x47)

	Output
		05.0004
		05.0047
		06.0004
	06.0047

Examples 2: Only adapters assigned
	Assignments:
		Adapters 5 and 6

	Output:
		05.
		06.

Examples 3: Only domains assigned
	Assignments:
		Domains 4 and 71 (0x47)

	Output:
		.0004
		.0047

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <20180925231641.4954-10-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a6c08cd2ed0f..3834624dcc2e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -625,6 +625,56 @@ static ssize_t control_domains_show(struct device *dev,
 }
 DEVICE_ATTR_RO(control_domains);
 
+static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	char *bufpos = buf;
+	unsigned long apid;
+	unsigned long apqi;
+	unsigned long apid1;
+	unsigned long apqi1;
+	unsigned long napm_bits = matrix_mdev->matrix.apm_max + 1;
+	unsigned long naqm_bits = matrix_mdev->matrix.aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	apid1 = find_first_bit_inv(matrix_mdev->matrix.apm, napm_bits);
+	apqi1 = find_first_bit_inv(matrix_mdev->matrix.aqm, naqm_bits);
+
+	mutex_lock(&matrix_dev->lock);
+
+	if ((apid1 < napm_bits) && (apqi1 < naqm_bits)) {
+		for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm_bits) {
+			for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+					     naqm_bits) {
+				n = sprintf(bufpos, "%02lx.%04lx\n", apid,
+					    apqi);
+				bufpos += n;
+				nchars += n;
+			}
+		}
+	} else if (apid1 < napm_bits) {
+		for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm_bits) {
+			n = sprintf(bufpos, "%02lx.\n", apid);
+			bufpos += n;
+			nchars += n;
+		}
+	} else if (apqi1 < naqm_bits) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm_bits) {
+			n = sprintf(bufpos, ".%04lx\n", apqi);
+			bufpos += n;
+			nchars += n;
+		}
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return nchars;
+}
+DEVICE_ATTR_RO(matrix);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -633,6 +683,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
+	&dev_attr_matrix.attr,
 	NULL,
 };
 
-- 
2.17.0
