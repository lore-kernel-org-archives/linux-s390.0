Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v7 02/15] s390/vfio-ap: manage link between queue struct and matrix mdev
Date: Tue,  7 Apr 2020 15:20:02 -0400
Message-Id: <20200407192015.19887-3-akrowiak@linux.ibm.com>
In-Reply-To: <20200407192015.19887-1-akrowiak@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

A vfio_ap_queue structure is created for each queue device probed. To
ensure that the matrix mdev to which a queue's APQN is assigned is linked
to the queue structure as long as the queue device is bound to the vfio_ap
device driver, let's go ahead and manage these links when the queue device
is probed and removed as well as whenever an adapter or domain is assigned
to or unassigned from the matrix mdev.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 75 ++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 134860934fe7..00699bd72d2b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -148,7 +148,6 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		  status.response_code);
 end_free:
 	vfio_ap_free_aqic_resources(q);
-	q->matrix_mdev = NULL;
 	return status;
 }
 
@@ -250,7 +249,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	struct vfio_ap_queue *q;
 	struct ap_queue_status qstatus = {
 			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
-	struct ap_matrix_mdev *matrix_mdev;
 
 	/* If we do not use the AIV facility just go to userland */
 	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
@@ -261,14 +259,11 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 
 	if (!vcpu->kvm->arch.crypto.pqap_hook)
 		goto out_unlock;
-	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
-				   struct ap_matrix_mdev, pqap_hook);
 
 	q = vfio_ap_get_queue(apqn);
 	if (!q)
 		goto out_unlock;
 
-	q->matrix_mdev = matrix_mdev;
 	status = vcpu->run->s.regs.gprs[1];
 
 	/* If IR bit(16) is set we enable the interrupt */
@@ -536,6 +531,31 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+/**
+ * vfio_ap_mdev_qlinks_for_apid
+ *
+ * @matrix_mdev: a matrix mediated device
+ * @apqi:	 the APID of one or more APQNs assigned to @matrix_mdev
+ *
+ * Set the link to @matrix_mdev for each queue device bound to the vfio_ap
+ * device driver with an APQN assigned to @matrix_mdev with the specified @apid.
+ *
+ * Note: If @matrix_mdev is NULL, the link to @matrix_mdev will be severed.
+ */
+static void vfio_ap_mdev_qlinks_for_apid(struct ap_matrix_mdev *matrix_mdev,
+					 unsigned long apid)
+{
+	unsigned long apqi;
+	struct vfio_ap_queue *q;
+
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+			     matrix_mdev->matrix.aqm_max + 1) {
+		q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+		if (q)
+			q->matrix_mdev = matrix_mdev;
+	}
+}
+
 /**
  * assign_adapter_store
  *
@@ -605,6 +625,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	vfio_ap_mdev_qlinks_for_apid(matrix_mdev, apid);
 	ret = count;
 	goto done;
 
@@ -656,6 +677,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	vfio_ap_mdev_qlinks_for_apid(NULL, apid);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -682,6 +704,31 @@ vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
 	return 0;
 }
 
+/**
+ * vfio_ap_mdev_qlinks_for_apqi
+ *
+ * @matrix_mdev: a matrix mediated device
+ * @apqi:	 the APQI of one or more APQNs assigned to @matrix_mdev
+ *
+ * Set the link to @matrix_mdev for each queue device bound to the vfio_ap
+ * device driver with an APQN assigned to @matrix_mdev with the specified @apqi.
+ *
+ * Note: If @matrix_mdev is NULL, the link to @matrix_mdev will be severed.
+ */
+static void vfio_ap_mdev_qlinks_for_apqi(struct ap_matrix_mdev *matrix_mdev,
+					 unsigned long apqi)
+{
+	unsigned long apid;
+	struct vfio_ap_queue *q;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+		if (q)
+			q->matrix_mdev = matrix_mdev;
+	}
+}
+
 /**
  * assign_domain_store
  *
@@ -746,6 +793,7 @@ static ssize_t assign_domain_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	vfio_ap_mdev_qlinks_for_apqi(matrix_mdev, apqi);
 	ret = count;
 	goto done;
 
@@ -798,6 +846,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	vfio_ap_mdev_qlinks_for_apqi(NULL, apqi);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -1270,6 +1319,21 @@ void vfio_ap_mdev_unregister(void)
 	mdev_unregister_device(&matrix_dev->device);
 }
 
+static void vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
+{
+	unsigned long apid = AP_QID_CARD(q->apqn);
+	unsigned long apqi = AP_QID_QUEUE(q->apqn);
+	struct ap_matrix_mdev *matrix_mdev;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->matrix.aqm)) {
+			q->matrix_mdev = matrix_mdev;
+			break;
+		}
+	}
+}
+
 int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
 {
 	struct vfio_ap_queue *q;
@@ -1282,6 +1346,7 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
 	dev_set_drvdata(&queue->ap_dev.device, q);
 	q->apqn = queue->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
+	vfio_ap_mdev_for_queue(q);
 	hash_add(matrix_dev->qtable, &q->qnode, q->apqn);
 	mutex_unlock(&matrix_dev->lock);
 
-- 
2.21.1
