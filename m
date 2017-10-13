From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 11/19] s390/zcrypt: validate domain assignment
Date: Fri, 13 Oct 2017 13:38:56 -0400
Message-ID: <1507916344-3896-12-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Each domain assigned to the mediated matrix device
must be validated to ensure that the domain is accessible
from one of the AP queues bound to the AP matrix device
driver.

Each AP queue bound to the device driver is identified by
an AP Queue Number (APQN). An APQN is comprised of an
adapter ID (APID) and an AP queue index (APQI) which
corresponds to a domain ID. Consequently, each domain
being assigned will be validated as follows:

* If no adapters have been assigned to the mediated
  matrix device:

    * The ID of the domain being assigned must correspond
      to the APQI of at least one of the AP queue devices
      bound to the AP matrix device driver.

* If adapters have been assigned to the mediated matrix
  device:

     * Each APQN that can be derived from the ID of the domain
       being assigned and the ID of each adapter previously
       assigned must match the APQN of an AP queue bound to
       the AP matrix device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_matrix_ops.c |   63 ++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
index f54285c..74d7feb 100644
--- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
+++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
@@ -329,6 +329,65 @@ static ssize_t ap_matrix_adapters_show(struct device *dev,
 }
 static DEVICE_ATTR(adapters, 0644, ap_matrix_adapters_show, NULL);
 
+static int ap_matrix_validate_domain_queues(unsigned long apqi,
+					    unsigned long *apm)
+{
+	unsigned long apid;
+	unsigned long nbits = AP_MATRIX_MAX_MASK_BITS;
+	ap_qid_t qid;
+
+	apid = find_first_bit_inv(apm, nbits);
+	while (apid < nbits) {
+		qid = AP_MKQID(apid, apqi);
+
+		if (find_vapq(matrix, qid)) {
+			apid = find_next_bit_inv(apm, nbits, apid + 1);
+			continue;
+		}
+
+		pr_err("%s: AP queue %02lx.%04lx not bound to driver",
+		       VFIO_AP_MATRIX_MODULE_NAME, apid, apid);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ap_matrix_validate_apqi(unsigned long apqi)
+{
+
+	struct vfio_ap_queue *vapq;
+
+	if (!list_empty(&matrix->queues)) {
+		list_for_each_entry(vapq, &matrix->queues, list)
+			if (AP_QID_QUEUE(vapq->queue->qid) == apqi)
+				return 0;
+	}
+
+	pr_err("%s: AP queue with domain %02lx is not bound to driver",
+	       VFIO_AP_MATRIX_MODULE_NAME, apqi);
+
+	return -ENODEV;
+}
+
+static int ap_matrix_validate_domain(struct ap_matrix_mdev *matrix_mdev,
+				     unsigned long apqi)
+{
+	int ret = 0;
+	unsigned long nbits = AP_MATRIX_MAX_MASK_BITS;
+	unsigned long *apm = (unsigned long *)matrix_mdev->masks.apm;
+	unsigned long apid;
+
+	apid = find_first_bit_inv(apm, nbits);
+	/* If no adapters have yet been assigned */
+	if (apid < nbits)
+		ret = ap_matrix_validate_apqi(apqi);
+	else
+		ret = ap_matrix_validate_domain_queues(apqi, apm);
+
+	return ret;
+}
+
 static ssize_t ap_matrix_domain_assign(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
@@ -342,6 +401,10 @@ static ssize_t ap_matrix_domain_assign(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = ap_matrix_validate_domain(matrix_mdev, apqi);
+	if (ret)
+		return ret;
+
 	set_bit_inv((unsigned long)apqi,
 		    (unsigned long *)matrix_mdev->masks.aqm);
 
-- 
1.7.1
