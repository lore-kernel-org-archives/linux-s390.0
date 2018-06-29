From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 16/21] s390: vfio-ap: sysfs interface to view guest matrix
Date: Fri, 29 Jun 2018 17:11:18 -0400
Message-ID: <1530306683-7270-17-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Provides a sysfs interface to view the AP matrix configured for the
guest that is using the mdev matrix device.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. guest_matrix

To view the matrix configured for the guest,
print the guest_matrix file:

cat guest_matrix

If no guest is using the device, then the output will be an emtpy
string.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 98bd0a1..bc05d40 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -730,6 +730,44 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(matrix);
 
+static unsigned long *kvm_ap_get_crycb_apm(struct ap_matrix_mdev *matrix_mdev);
+
+static unsigned long *kvm_ap_get_crycb_aqm(struct ap_matrix_mdev *matrix_mdev);
+
+static ssize_t guest_matrix_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	char *bufpos = buf;
+	unsigned long apid;
+	unsigned long apqi;
+	unsigned long *apm, *aqm;
+	unsigned long napm = matrix_mdev->matrix.apm_max + 1;
+	unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	if (!matrix_mdev->kvm)
+		return nchars;
+
+	apm = kvm_ap_get_crycb_apm(matrix_mdev);
+	for_each_set_bit_inv(apid, apm, napm) {
+		n = sprintf(bufpos, "%02lx\n", apid);
+		bufpos += n;
+		nchars += n;
+
+		aqm = kvm_ap_get_crycb_aqm(matrix_mdev);
+		for_each_set_bit_inv(apqi, aqm, naqm) {
+			n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
+			bufpos += n;
+			nchars += n;
+		}
+	}
+
+	return nchars;
+}
+DEVICE_ATTR_RO(guest_matrix);
 
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
@@ -740,6 +778,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
+	&dev_attr_guest_matrix.attr,
 	NULL,
 };
 
-- 
1.7.1
