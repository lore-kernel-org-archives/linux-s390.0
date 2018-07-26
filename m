From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 26 Jul 2018 19:54:20 +0000
Subject: [PATCH v7 13/22] s390: vfio-ap: sysfs interface to view matrix mdev matrix
Message-Id: <20180726195429.31960-14-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Provides a sysfs interface to view the AP matrix configured for the
mediated matrix device.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. matrix

To view the matrix configured for the mediated matrix device,
print the matrix file:

	cat matrix

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index fafe6ec7fec7..9258902d9f70 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -403,6 +403,38 @@ static ssize_t control_domains_show(struct device *dev,
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
+	unsigned long napm = matrix_mdev->matrix.apm_max + 1;
+	unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	mutex_lock(&matrix_dev.lock);
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
+		n = sprintf(bufpos, "%02lx\n", apid);
+		bufpos += n;
+		nchars += n;
+
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
+			n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
+			bufpos += n;
+			nchars += n;
+		}
+	}
+	mutex_unlock(&matrix_dev.lock);
+
+	return nchars;
+}
+DEVICE_ATTR_RO(matrix);
+
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -411,6 +443,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
+	&dev_attr_matrix.attr,
 	NULL,
 };
 
-- 
2.17.0
