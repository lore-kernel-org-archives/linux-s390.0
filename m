From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 09/19] s390/zcrypt: validate adapter assignment
Date: Fri, 13 Oct 2017 13:38:54 -0400
Message-ID: <1507916344-3896-10-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Each adapter assigned to the mediated matrix device
must be validated to ensure that the adapter is accessible
from one of the AP queues bound to the AP matrix device
driver. Each AP queue bound to the matrix device is
identified by its AP Queue Number (APQN). An APQN is
comprised of an adapter ID (APID) and an AP queue index
(APQI) which corresponds to a domain ID. Consequently,
each adapter being assigned will be validated as follows:

* If no domains have been assigned to the mediated
  matrix device:

    * The ID of the adapter being assigned must correspond
      to the APID of at least one of the AP queue devices
      bound to the AP matrix device driver.

* If domains have been assigned to the mediated
  matrix device:

    * Each APQN that can be derived from the ID of the adapter
      being assigned and the ID of each domain previously
      assigned must match the APQN of an AP queue bound to
      the AP matrix device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_matrix_ops.c |   63 ++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
index e4b1236..2e63d1b 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
+++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
@@ -191,6 +191,65 @@ static int ap_matrix_parse_id(const char *buf, unsigned int *id)
 	return ret;
 }
 
+static int ap_matrix_validate_adapter_queues(unsigned long apid,
+					     unsigned long *aqm)
+{
+	unsigned long apqi;
+	unsigned long nbits = AP_MATRIX_MAX_MASK_BITS;
+	ap_qid_t qid;
+
+	apqi = find_first_bit_inv(aqm, nbits);
+	while (apqi < nbits) {
+		qid = AP_MKQID(apid, apqi);
+
+		if (find_vapq(matrix, qid)) {
+			apqi = find_next_bit_inv(aqm, nbits, apqi + 1);
+			continue;
+		}
+
+		pr_err("%s: AP queue %02lx.%04lx not bound to driver",
+		       VFIO_AP_MATRIX_MODULE_NAME, apid, apqi);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ap_matrix_validate_apid(unsigned long apid)
+{
+
+	struct vfio_ap_queue *vapq;
+
+	if (!list_empty(&matrix->queues)) {
+		list_for_each_entry(vapq, &matrix->queues, list)
+			if (AP_QID_CARD(vapq->queue->qid) == apid)
+				return 0;
+	}
+
+	pr_err("%s: AP queue with adapter %02lx is not bound to driver",
+	       VFIO_AP_MATRIX_MODULE_NAME, apid);
+
+	return -ENODEV;
+}
+
+static int ap_matrix_validate_adapter(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long apid)
+{
+	int ret = 0;
+	unsigned long nbits = AP_MATRIX_MAX_MASK_BITS;
+	unsigned long *aqm = (unsigned long *)matrix_mdev->masks.aqm;
+	unsigned long apqi;
+
+	apqi = find_first_bit_inv(aqm, nbits);
+	/* If no queues have yet been assigned */
+	if (apqi < nbits)
+		ret = ap_matrix_validate_adapter_queues(apid, aqm);
+	else
+		ret = ap_matrix_validate_apid(apid);
+
+	return ret;
+}
+
 static ssize_t ap_matrix_adapters_assign(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
@@ -204,6 +263,10 @@ static ssize_t ap_matrix_adapters_assign(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = ap_matrix_validate_adapter(matrix_mdev, apid);
+	if (ret)
+		return ret;
+
 	set_bit_inv((unsigned long)apid,
 		    (unsigned long *)matrix_mdev->masks.apm);
 
-- 
1.7.1
