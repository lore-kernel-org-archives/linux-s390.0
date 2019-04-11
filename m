Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 3/7] s390: vfio-ap: allow assignment of unavailable AP resources to mdev device
Date: Thu, 11 Apr 2019 17:03:20 -0400
In-Reply-To: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1555016604-2008-4-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The AP architecture does not preclude assignment of AP resources that are
not yet in the AP configuration (i.e., not available or not online).
Let's go ahead and implement this facet of the AP architecture for linux
guests.

Access to AP resources is controlled by bit masks in a guest's SIE
state description (i.e., the control block containing the state of a
guest). When an AP instruction is executed on the guest, the firmware
combines the masks from the guest's SIE state description with the masks
from the host by doing a logical bitwise AND of the masks to create what
are defined as effective masks. The effective masks determine which AP
resources can be accessed by the guest.

Effective masking allows the assignment of AP resources to a guest even
if the underlying device is not in the AP configuration. If the device
subsequently becomes configured, the guest will automatically have access
to the associated AP resources (e.g., AP queues).

The current implementation does not allow assignment of AP resources to
an mdev device if the AP queues identified by the assignment are not
bound to the vfio_ap device driver. This patch allows assignment of AP
resources to the mdev device even if the AP queues are not bound to the
vfio_ap device driver, as long as the AP queues are not reserved by the
AP BUS for use by the zcrypt device drivers. If the queues are subsequently
bound to the vfio_ap device driver while a running guest is using the mdev
device, the guest will automatically gain access to the queues. Effective
masking prevents access to queues until such time as they become available.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 160 +++++---------------------------------
 1 file changed, 18 insertions(+), 142 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 900b9cf20ca5..cb3e4f7671be 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -113,122 +113,6 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
 	NULL,
 };
 
-struct vfio_ap_queue_reserved {
-	unsigned long *apid;
-	unsigned long *apqi;
-	bool reserved;
-};
-
-/**
- * vfio_ap_has_queue
- *
- * @dev: an AP queue device
- * @data: a struct vfio_ap_queue_reserved reference
- *
- * Flags whether the AP queue device (@dev) has a queue ID containing the APQN,
- * apid or apqi specified in @data:
- *
- * - If @data contains both an apid and apqi value, then @data will be flagged
- *   as reserved if the APID and APQI fields for the AP queue device matches
- *
- * - If @data contains only an apid value, @data will be flagged as
- *   reserved if the APID field in the AP queue device matches
- *
- * - If @data contains only an apqi value, @data will be flagged as
- *   reserved if the APQI field in the AP queue device matches
- *
- * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
- * @data does not contain either an apid or apqi.
- */
-static int vfio_ap_has_queue(struct device *dev, void *data)
-{
-	struct vfio_ap_queue_reserved *qres = data;
-	struct ap_queue *ap_queue = to_ap_queue(dev);
-	ap_qid_t qid;
-	unsigned long id;
-
-	if (qres->apid && qres->apqi) {
-		qid = AP_MKQID(*qres->apid, *qres->apqi);
-		if (qid == ap_queue->qid)
-			qres->reserved = true;
-	} else if (qres->apid && !qres->apqi) {
-		id = AP_QID_CARD(ap_queue->qid);
-		if (id == *qres->apid)
-			qres->reserved = true;
-	} else if (!qres->apid && qres->apqi) {
-		id = AP_QID_QUEUE(ap_queue->qid);
-		if (id == *qres->apqi)
-			qres->reserved = true;
-	} else {
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * vfio_ap_verify_queue_reserved
- *
- * @matrix_dev: a mediated matrix device
- * @apid: an AP adapter ID
- * @apqi: an AP queue index
- *
- * Verifies that the AP queue with @apid/@apqi is reserved by the VFIO AP device
- * driver according to the following rules:
- *
- * - If both @apid and @apqi are not NULL, then there must be an AP queue
- *   device bound to the vfio_ap driver with the APQN identified by @apid and
- *   @apqi
- *
- * - If only @apid is not NULL, then there must be an AP queue device bound
- *   to the vfio_ap driver with an APQN containing @apid
- *
- * - If only @apqi is not NULL, then there must be an AP queue device bound
- *   to the vfio_ap driver with an APQN containing @apqi
- *
- * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
- */
-static int vfio_ap_verify_queue_reserved(unsigned long *apid,
-					 unsigned long *apqi)
-{
-	int ret;
-	struct vfio_ap_queue_reserved qres;
-
-	qres.apid = apid;
-	qres.apqi = apqi;
-	qres.reserved = false;
-
-	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
-				     &qres, vfio_ap_has_queue);
-	if (ret)
-		return ret;
-
-	if (qres.reserved)
-		return 0;
-
-	return -EADDRNOTAVAIL;
-}
-
-static int
-vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
-					     unsigned long apid)
-{
-	int ret;
-	unsigned long apqi;
-	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
-
-	if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
-		return vfio_ap_verify_queue_reserved(&apid, NULL);
-
-	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
-		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * vfio_ap_mdev_verify_no_sharing
  *
@@ -336,14 +220,22 @@ static ssize_t assign_adapter_store(struct device *dev,
 
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 
+	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
+						 matrix_mdev->matrix.aqm);
+
+	/* If any APQN is reserved for used by the default drivers */
+	ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
+	if (ret)
+		goto error;
+
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
-		goto share_err;
+		goto error;
 
 	ret = count;
 	goto done;
 
-share_err:
+error:
 	clear_bit_inv(apid, matrix_mdev->matrix.apm);
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -397,26 +289,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(unassign_adapter);
 
-static int
-vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
-					     unsigned long apqi)
-{
-	int ret;
-	unsigned long apid;
-	unsigned long nbits = matrix_mdev->matrix.apm_max + 1;
-
-	if (find_first_bit_inv(matrix_mdev->matrix.apm, nbits) >= nbits)
-		return vfio_ap_verify_queue_reserved(NULL, &apqi);
-
-	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, nbits) {
-		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * assign_domain_store
  *
@@ -471,12 +343,16 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, apqi);
-	if (ret)
-		goto done;
-
 	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
 
+	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
+						 matrix_mdev->matrix.aqm);
+
+	/* If any APQN is owned by the default drivers */
+	ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
+	if (ret)
+		goto error;
+
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
 		goto share_err;
-- 
2.7.4
