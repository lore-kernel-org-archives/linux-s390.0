Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 08/14] s390/vfio-ap: hot plug/unplug queues on bind/unbind of queue device
Date: Thu, 22 Oct 2020 13:12:03 -0400
Message-Id: <20201022171209.19494-9-akrowiak@linux.ibm.com>
In-Reply-To: <20201022171209.19494-1-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

In response to the probe or remove of a queue device, if a KVM guest is
using the matrix mdev to which the APQN of the queue device is assigned,
the vfio_ap device driver must respond accordingly. In an ideal world, the
queue device being probed would be hot plugged into the guest. Likewise,
the queue corresponding to the queue device being removed would
be hot unplugged from the guest. Unfortunately, the AP architecture
precludes plugging or unplugging individual queues. We must also
consider the fact that the linux device model precludes us from passing a
queue device through to a KVM guest that is not bound to the driver
facilitating the pass-through. Consequently, we are left with the choice of
plugging/unplugging the adapter or the domain. In the latter case, this
would result in taking access to the domain away for each adapter the
guest is using. In either case, the operation will alter a KVM guest's
access to one or more queues, so let's plug/unplug the adapter on
bind/unbind of the queue device since this corresponds to the hardware
entity that may be physically plugged/unplugged - i.e., a domain is not
a piece of hardware.

Example:
=======
Queue devices bound to vfio_ap device driver:
   04.0004
   04.0047
   04.0054

   05.0005
   05.0047

Adapters and domains assigned to matrix mdev:
   Adapters  Domains  -> Queues
   04        0004        04.0004
   05        0047        04.0047
             0054        04.0054
                         05.0004
                         05.0047
                         05.0054

KVM guest matrix at is startup:
   Adapters  Domains  -> Queues
   04        0004        04.0004
             0047        04.0047
             0054        04.0054

   Adapter 05 is filtered because queue 05.0054 is not bound.

KVM guest matrix after queue 05.0054 is bound to the vfio_ap driver:
   Adapters  Domains  -> Queues
   04        0004        04.0004
   05        0047        04.0047
             0054        04.0054
                         05.0004
                         05.0047
                         05.0054

   All queues assigned to the matrix mdev are now bound.

KVM guest matrix after queue 04.0004 is unbound:

   Adapters  Domains  -> Queues
   05        0004        05.0004
             0047        05.0047
             0054        05.0054

   Adapter 04 is filtered because 04.0004 is no longer bound.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 158 +++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 7bad70d7bcef..5b34bc8fca31 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -312,6 +312,13 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void vfio_ap_matrix_clear_masks(struct ap_matrix *matrix)
+{
+	bitmap_clear(matrix->apm, 0, AP_DEVICES);
+	bitmap_clear(matrix->aqm, 0, AP_DOMAINS);
+	bitmap_clear(matrix->adm, 0, AP_DOMAINS);
+}
+
 static void vfio_ap_matrix_init(struct ap_config_info *info,
 				struct ap_matrix *matrix)
 {
@@ -601,6 +608,104 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev,
 	return 0;
 }
 
+static bool vfio_ap_mdev_matrixes_equal(struct ap_matrix *matrix1,
+					struct ap_matrix *matrix2)
+{
+	return (bitmap_equal(matrix1->apm, matrix2->apm, AP_DEVICES) &&
+		bitmap_equal(matrix1->aqm, matrix2->aqm, AP_DOMAINS) &&
+		bitmap_equal(matrix1->adm, matrix2->adm, AP_DOMAINS));
+}
+
+/**
+ * vfio_ap_mdev_filter_matrix
+ *
+ * Filters the matrix of adapters, domains, and control domains assigned to
+ * a matrix mdev's AP configuration and stores the result in the shadow copy of
+ * the APCB used to supply a KVM guest's AP configuration.
+ *
+ * @matrix_mdev:  the matrix mdev whose AP configuration is to be filtered
+ *
+ * Returns true if filtering has changed the shadow copy of the APCB used
+ * to supply a KVM guest's AP configuration; otherwise, returns false.
+ */
+static int vfio_ap_mdev_filter_guest_matrix(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct ap_matrix shadow_apcb;
+	unsigned long apid, apqi, apqn;
+
+	memcpy(&shadow_apcb, &matrix_mdev->matrix, sizeof(struct ap_matrix));
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		/*
+		 * If the APID is not assigned to the host AP configuration,
+		 * we can not assign it to the guest's AP configuration
+		 */
+		if (!test_bit_inv(apid,
+				  (unsigned long *)matrix_dev->info.apm)) {
+			clear_bit_inv(apid, shadow_apcb.apm);
+			continue;
+		}
+
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     AP_DOMAINS) {
+			/*
+			 * If the APQI is not assigned to the host AP
+			 * configuration, then it can not be assigned to the
+			 * guest's AP configuration
+			 */
+			if (!test_bit_inv(apqi, (unsigned long *)
+					  matrix_dev->info.aqm)) {
+				clear_bit_inv(apqi, shadow_apcb.aqm);
+				continue;
+			}
+
+			/*
+			 * If the APQN is not bound to the vfio_ap device
+			 * driver, then we can't assign it to the guest's
+			 * AP configuration. The AP architecture won't
+			 * allow filtering of a single APQN, so let's filter
+			 * the APID.
+			 */
+			apqn = AP_MKQID(apid, apqi);
+			if (!vfio_ap_mdev_get_queue(matrix_mdev, apqn)) {
+				clear_bit_inv(apid, shadow_apcb.apm);
+				break;
+			}
+		}
+
+		/*
+		 * If all APIDs have been cleared, then clear the APQIs from the
+		 * shadow APCB and quit filtering.
+		 */
+		if (bitmap_empty(shadow_apcb.apm, AP_DEVICES)) {
+			if (!bitmap_empty(shadow_apcb.aqm, AP_DOMAINS))
+				bitmap_clear(shadow_apcb.aqm, 0, AP_DOMAINS);
+
+			break;
+		}
+
+		/*
+		 * If all APQIs have been cleared, then clear the APIDs from the
+		 * shadow APCB and quit filtering.
+		 */
+		if (bitmap_empty(shadow_apcb.aqm, AP_DOMAINS)) {
+			if (!bitmap_empty(shadow_apcb.apm, AP_DEVICES))
+				bitmap_clear(shadow_apcb.apm, 0, AP_DEVICES);
+
+			break;
+		}
+	}
+
+	if (vfio_ap_mdev_matrixes_equal(&matrix_mdev->shadow_apcb,
+					&shadow_apcb))
+		return false;
+
+	memcpy(&matrix_mdev->shadow_apcb, &shadow_apcb,
+	       sizeof(struct ap_matrix));
+
+	return true;
+}
+
 enum qlink_type {
 	LINK_APID,
 	LINK_APQI,
@@ -1256,9 +1361,8 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
 		return NOTIFY_DONE;
 
-	memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
-	       sizeof(matrix_mdev->shadow_apcb));
-	vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
+	if (vfio_ap_mdev_filter_guest_matrix(matrix_mdev))
+		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 
 	return NOTIFY_OK;
 }
@@ -1369,6 +1473,18 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 		matrix_mdev->kvm = NULL;
 	}
 
+	/*
+	 * The shadow_apcb must be cleared.
+	 *
+	 * The shadow_apcb is committed to the guest only if the masks resulting
+	 * from filtering the matrix_mdev->matrix differs from the masks in the
+	 * shadow_apcb. Consequently, if we don't clear the masks here and a
+	 * guest is subsequently started, the filtering may not result in a
+	 * change to the shadow_apcb which will not get committed to the guest;
+	 * in that case, the guest will be left without any queues.
+	 */
+	vfio_ap_matrix_clear_masks(&matrix_mdev->shadow_apcb);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
@@ -1466,6 +1582,16 @@ static void vfio_ap_queue_link_mdev(struct vfio_ap_queue *q)
 	}
 }
 
+static void vfio_ap_mdev_hot_plug_queue(struct vfio_ap_queue *q)
+{
+
+	if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
+		return;
+
+	if (vfio_ap_mdev_filter_guest_matrix(q->matrix_mdev))
+		vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
+}
+
 int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
 	struct vfio_ap_queue *q;
@@ -1482,11 +1608,36 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	q->apqn = queue->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
 	vfio_ap_queue_link_mdev(q);
+	vfio_ap_mdev_hot_plug_queue(q);
 	mutex_unlock(&matrix_dev->lock);
 
 	return 0;
 }
 
+void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
+{
+	unsigned long apid = AP_QID_CARD(q->apqn);
+
+	if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
+		return;
+
+	/*
+	 * If the APID is assigned to the guest, then let's
+	 * go ahead and unplug the adapter since the
+	 * architecture does not provide a means to unplug
+	 * an individual queue.
+	 */
+	if (test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm)) {
+		clear_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm);
+
+		if (bitmap_empty(q->matrix_mdev->shadow_apcb.apm, AP_DEVICES))
+			bitmap_clear(q->matrix_mdev->shadow_apcb.aqm, 0,
+				     AP_DOMAINS);
+
+		vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
+	}
+}
+
 void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 {
 	struct vfio_ap_queue *q;
@@ -1497,6 +1648,7 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 
 	mutex_lock(&matrix_dev->lock);
 	q = dev_get_drvdata(&queue->ap_dev.device);
+	vfio_ap_mdev_hot_unplug_queue(q);
 	dev_set_drvdata(&queue->ap_dev.device, NULL);
 	apid = AP_QID_CARD(q->apqn);
 	apqi = AP_QID_QUEUE(q->apqn);
-- 
2.21.1
