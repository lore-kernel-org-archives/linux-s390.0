Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgFEVkU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jun 2020 17:40:20 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v8 07/16] s390/vfio-ap: sysfs attribute to display the guest's matrix
Date: Fri,  5 Jun 2020 17:39:55 -0400
Message-Id: <20200605214004.14270-8-akrowiak@linux.ibm.com>
In-Reply-To: <20200605214004.14270-1-akrowiak@linux.ibm.com>
References: <20200605214004.14270-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

The matrix of adapters and domains configured in a guest's CRYCB may
differ from the matrix of adapters and domains assigned to the matrix mdev,
so this patch introduces a sysfs attribute to display the matrix of a guest
using the matrix mdev. For a matrix mdev denoted by $uuid, the crycb for a
guest using the matrix mdev can be displayed as follows:

   cat /sys/devices/vfio_ap/matrix/$uuid/guest_matrix

If a guest is not using the matrix mdev at the time the crycb is displayed,
an error (ENODEV) will be returned.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 58 +++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b5ed36e2c948..779659074776 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1086,6 +1086,63 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(matrix);
 
+static ssize_t guest_matrix_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	char *bufpos = buf;
+	unsigned long apid;
+	unsigned long apqi;
+	unsigned long apid1;
+	unsigned long apqi1;
+	unsigned long napm_bits = matrix_mdev->shadow_apcb.apm_max + 1;
+	unsigned long naqm_bits = matrix_mdev->shadow_apcb.aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
+		return -ENODEV;
+
+	apid1 = find_first_bit_inv(matrix_mdev->shadow_apcb.apm, napm_bits);
+	apqi1 = find_first_bit_inv(matrix_mdev->shadow_apcb.aqm, naqm_bits);
+
+	mutex_lock(&matrix_dev->lock);
+
+	if ((apid1 < napm_bits) && (apqi1 < naqm_bits)) {
+		for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm,
+				     napm_bits) {
+			for_each_set_bit_inv(apqi,
+					     matrix_mdev->shadow_apcb.aqm,
+					     naqm_bits) {
+				n = sprintf(bufpos, "%02lx.%04lx\n", apid,
+					    apqi);
+				bufpos += n;
+				nchars += n;
+			}
+		}
+	} else if (apid1 < napm_bits) {
+		for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm,
+				     napm_bits) {
+			n = sprintf(bufpos, "%02lx.\n", apid);
+			bufpos += n;
+			nchars += n;
+		}
+	} else if (apqi1 < naqm_bits) {
+		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
+				     naqm_bits) {
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
+static DEVICE_ATTR_RO(guest_matrix);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -1095,6 +1152,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
+	&dev_attr_guest_matrix.attr,
 	NULL,
 };
 
-- 
2.21.1
