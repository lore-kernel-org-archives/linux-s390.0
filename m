From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 12/19] s390/zcrypt: sysfs support for control domain assignment
Date: Fri, 13 Oct 2017 13:38:57 -0400
Message-ID: <1507916344-3896-13-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provides the sysfs interfaces for assigning an AP control
domain to and unassigning a control domain from a mediated
matrix device. The relevant sysfs structures are:

/sys/devices/ap_matrix
... [matrix]
...... [mdev_supported_types]
......... [ap_matrix-passthrough]
............ [devices]
...............[$uuid]
.................. assign_control_domain
.................. unassign_control_domain
.................. control_domains

To assign a control domain to the $uuid mediated matrix device,
write its domain ID (hex value) to the assign_control_domain file.
To unassign a control domain, write its domain ID to the
unassign_control_domain file. To display the list of control
domains assigned, print the domains file.

For example, to assign control domain 0xff to the $uuid mediated
matrix device:

	echo ff > assign_control_domain

To see the list of control domains assigned:

	cat control_domains

To unassign control domain 0xff:

	echo ff > unassign_control_domain

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_matrix_ops.c |   82 ++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
index 74d7feb..2387916 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
+++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
@@ -469,6 +469,85 @@ static ssize_t ap_matrix_domains_show(struct device *dev,
 static DEVICE_ATTR(domains, 0644, ap_matrix_domains_show,
 		   NULL);
 
+static ssize_t ap_matrix_control_domain_assign(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	int ret;
+	unsigned int id;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	ret = ap_matrix_parse_id(buf, &id);
+	if (ret)
+		return ret;
+
+	set_bit_inv((unsigned long)id,
+		    (unsigned long *)matrix_mdev->masks.adm);
+
+	return count;
+}
+static DEVICE_ATTR(assign_control_domain, 0644, NULL,
+		   ap_matrix_control_domain_assign);
+
+static ssize_t ap_matrix_control_domain_unassign(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	int ret;
+	unsigned int id;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	ret = ap_matrix_parse_id(buf, &id);
+	if (ret)
+		return ret;
+
+	clear_bit_inv((unsigned long)id,
+		      (unsigned long *)matrix_mdev->masks.adm);
+
+	return count;
+}
+static DEVICE_ATTR(unassign_control_domain, 0644, NULL,
+		   ap_matrix_control_domain_unassign);
+
+static ssize_t ap_matrix_control_domains_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long *adm = (unsigned long *)matrix_mdev->masks.adm;
+	unsigned long id;
+	unsigned long nbits = 256;
+	char *bufpos = buf;
+	int nchars = 0;
+	int n;
+
+	id = find_first_bit_inv(adm, nbits);
+	while (id < nbits) {
+		if (nchars) {
+			n = sprintf(bufpos, ",");
+			bufpos += n;
+			nchars += n;
+		}
+
+		n = sprintf(bufpos, "%04lx", id);
+		bufpos += n;
+		nchars += n;
+		id = find_next_bit_inv(adm, nbits, id + 1);
+	}
+
+	n = sprintf(bufpos, "\n");
+	bufpos += n;
+	nchars += n;
+
+	return nchars;
+}
+
+static DEVICE_ATTR(control_domains, 0644, ap_matrix_control_domains_show,
+		   NULL);
+
 static struct attribute *ap_matrix_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -476,6 +555,9 @@ static DEVICE_ATTR(domains, 0644, ap_matrix_domains_show,
 	&dev_attr_assign_domain.attr,
 	&dev_attr_unassign_domain.attr,
 	&dev_attr_domains.attr,
+	&dev_attr_assign_control_domain.attr,
+	&dev_attr_unassign_control_domain.attr,
+	&dev_attr_control_domains.attr,
 	NULL
 };
 
-- 
1.7.1
