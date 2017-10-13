From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 10/19] s390/zcrypt: sysfs interfaces supporting AP domain assignment
Date: Fri, 13 Oct 2017 13:38:55 -0400
Message-ID: <1507916344-3896-11-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provides the sysfs interfaces for assigning an AP usage domain
to and unassigning a usage domain from a mediated matrix device.

The relevant sysfs structures are:

/sys/devices/ap_matrix
... [matrix]
...... [mdev_supported_types]
......... [ap_matrix-passthrough]
............ [devices]
...............[$uuid]
.................. assign_domain
.................. domains
.................. unassign_domain

To assign a domain to the $uuid mediated matrix device, write
its domain ID (hex value) to the assign_domain file. To
unassign a domain, write its domain ID (hex value) to the
unassign_domain file. To view a list of domains which have
been assigned, print the contents of the domains file

For example, to assign domain 0x04 to the $uuid mediated
matrix device:

	echo 4 > assign_domain

To unassign domain 0x04:

	echo 4 > unassign_domain

To see the list of domains assigned:

	cat domains

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_matrix_ops.c |   80 ++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
index 2e63d1b..f54285c 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
+++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
@@ -329,10 +329,90 @@ static ssize_t ap_matrix_adapters_show(struct device *dev,
 }
 static DEVICE_ATTR(adapters, 0644, ap_matrix_adapters_show, NULL);
 
+static ssize_t ap_matrix_domain_assign(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	int ret;
+	unsigned int apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	ret = ap_matrix_parse_id(buf, &apqi);
+	if (ret)
+		return ret;
+
+	set_bit_inv((unsigned long)apqi,
+		    (unsigned long *)matrix_mdev->masks.aqm);
+
+	return count;
+}
+static DEVICE_ATTR(assign_domain, 0644, NULL, ap_matrix_domain_assign);
+
+static ssize_t ap_matrix_domain_unassign(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int ret;
+	unsigned int apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	ret = ap_matrix_parse_id(buf, &apqi);
+	if (ret)
+		return ret;
+
+	clear_bit_inv((unsigned long)apqi,
+		      (unsigned long *)matrix_mdev->masks.aqm);
+
+	return count;
+}
+static DEVICE_ATTR(unassign_domain, 0644, NULL, ap_matrix_domain_unassign);
+
+static ssize_t ap_matrix_domains_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long *aqm = (unsigned long *)matrix_mdev->masks.aqm;
+	unsigned long id;
+	unsigned long nbits = 256;
+	char *bufpos = buf;
+	int nchars = 0;
+	int n;
+
+	id = find_first_bit_inv(aqm, nbits);
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
+		id = find_next_bit_inv(aqm, nbits, id + 1);
+	}
+
+	n = sprintf(bufpos, "\n");
+	bufpos += n;
+	nchars += n;
+
+	return nchars;
+}
+
+static DEVICE_ATTR(domains, 0644, ap_matrix_domains_show,
+		   NULL);
+
 static struct attribute *ap_matrix_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
 	&dev_attr_adapters.attr,
+	&dev_attr_assign_domain.attr,
+	&dev_attr_unassign_domain.attr,
+	&dev_attr_domains.attr,
 	NULL
 };
 
-- 
1.7.1
