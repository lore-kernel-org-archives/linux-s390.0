Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 03/14] s390/vfio-ap: manage link between queue struct and matrix mdev
Date: Thu, 22 Oct 2020 13:11:58 -0400
Message-Id: <20201022171209.19494-4-akrowiak@linux.ibm.com>
In-Reply-To: <20201022171209.19494-1-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Let's create links between each queue device bound to the vfio_ap device
driver and the matrix mdev to which the queue is assigned. The idea is to
facilitate efficient retrieval of the objects representing the queue
devices and matrix mdevs as well as to verify that a queue assigned to
a matrix mdev is bound to the driver.

The links will be created as follows:

   * When the queue device is probed, if its APQN is assigned to a matrix
     mdev, the structures representing the queue device and the matrix mdev
     will be linked.

   * When an adapter or domain is assigned to a matrix mdev, for each new
     APQN assigned that references a queue device bound to the vfio_ap
     device driver, the structures representing the queue device and the
     matrix mdev will be linked.

The links will be removed as follows:

   * When the queue device is removed, if its APQN is assigned to a matrix
     mdev, the structures representing the queue device and the matrix mdev
     will be unlinked.

   * When an adapter or domain is unassigned from a matrix mdev, for each
     APQN unassigned that references a queue device bound to the vfio_ap
     device driver, the structures representing the queue device and the
     matrix mdev will be unlinked.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 146 +++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |   3 +
 2 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 049b97d7444c..1357f8f8b7e4 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -28,7 +28,6 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
 
 /**
  * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
- * @matrix_mdev: the associated mediated matrix
  * @apqn: The queue APQN
  *
  * Retrieve a queue with a specific APQN from the AP queue devices attached to
@@ -36,18 +35,11 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
  *
  * Returns the pointer to the vfio_ap_queue with the specified APQN, or NULL.
  */
-static struct vfio_ap_queue *vfio_ap_get_queue(
-					struct ap_matrix_mdev *matrix_mdev,
-					unsigned long apqn)
+static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
 {
 	struct ap_queue *queue;
 	struct vfio_ap_queue *q = NULL;
 
-	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
-		return NULL;
-	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
-		return NULL;
-
 	queue = ap_get_qdev(apqn);
 	if (!queue)
 		return NULL;
@@ -60,6 +52,19 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
 	return q;
 }
 
+static struct vfio_ap_queue *
+vfio_ap_mdev_get_queue(struct ap_matrix_mdev *matrix_mdev, unsigned long apqn)
+{
+	struct vfio_ap_queue *q;
+
+	hash_for_each_possible(matrix_mdev->qtable, q, mdev_qnode, apqn) {
+		if (q && (q->apqn == apqn))
+			return q;
+	}
+
+	return NULL;
+}
+
 /**
  * vfio_ap_wait_for_irqclear
  * @apqn: The AP Queue number
@@ -171,7 +176,6 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		  status.response_code);
 end_free:
 	vfio_ap_free_aqic_resources(q);
-	q->matrix_mdev = NULL;
 	return status;
 }
 
@@ -284,14 +288,14 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 
 	if (!vcpu->kvm->arch.crypto.pqap_hook)
 		goto out_unlock;
+
 	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
 				   struct ap_matrix_mdev, pqap_hook);
 
-	q = vfio_ap_get_queue(matrix_mdev, apqn);
+	q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
 	if (!q)
 		goto out_unlock;
 
-	q->matrix_mdev = matrix_mdev;
 	status = vcpu->run->s.regs.gprs[1];
 
 	/* If IR bit(16) is set we enable the interrupt */
@@ -331,6 +335,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
+	hash_init(matrix_mdev->qtable);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
 	matrix_mdev->pqap_hook.owner = THIS_MODULE;
@@ -559,6 +564,87 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+enum qlink_type {
+	LINK_APID,
+	LINK_APQI,
+	UNLINK_APID,
+	UNLINK_APQI,
+};
+
+static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
+				    unsigned long apid, unsigned long apqi)
+{
+	struct vfio_ap_queue *q;
+
+	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+	if (q) {
+		q->matrix_mdev = matrix_mdev;
+		hash_add(matrix_mdev->qtable,
+			 &q->mdev_qnode, q->apqn);
+	}
+}
+
+static void vfio_ap_mdev_unlink_queue(unsigned long apid, unsigned long apqi)
+{
+	struct vfio_ap_queue *q;
+
+	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+	if (q) {
+		q->matrix_mdev = NULL;
+		hash_del(&q->mdev_qnode);
+	}
+}
+
+/**
+ * vfio_ap_mdev_link_queues
+ *
+ * @matrix_mdev: The matrix mdev to link.
+ * @type:	 The type of @qlink_id.
+ * @qlink_id:	 The APID or APQI of the queues to link.
+ *
+ * Sets or clears the links between the queues with the specified @qlink_id
+ * and the @matrix_mdev:
+ *     @type == LINK_APID: Set the links between the @matrix_mdev and the
+ *                         queues with the specified @qlink_id (APID)
+ *     @type == LINK_APQI: Set the links between the @matrix_mdev and the
+ *                         queues with the specified @qlink_id (APQI)
+ *     @type == UNLINK_APID: Clear the links between the @matrix_mdev and the
+ *                           queues with the specified @qlink_id (APID)
+ *     @type == UNLINK_APQI: Clear the links between the @matrix_mdev and the
+ *                           queues with the specified @qlink_id (APQI)
+ */
+static void vfio_ap_mdev_link_queues(struct ap_matrix_mdev *matrix_mdev,
+				     enum qlink_type type,
+				     unsigned long qlink_id)
+{
+	unsigned long id;
+
+	switch (type) {
+	case LINK_APID:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1)
+			vfio_ap_mdev_link_queue(matrix_mdev, qlink_id, id);
+		break;
+	case UNLINK_APID:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1)
+			vfio_ap_mdev_unlink_queue(qlink_id, id);
+		break;
+	case LINK_APQI:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
+				     matrix_mdev->matrix.apm_max + 1)
+			vfio_ap_mdev_link_queue(matrix_mdev, id, qlink_id);
+		break;
+	case UNLINK_APQI:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
+				     matrix_mdev->matrix.apm_max + 1)
+			vfio_ap_mdev_link_queue(matrix_mdev, id, qlink_id);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 /**
  * assign_adapter_store
  *
@@ -628,6 +714,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APID, apid);
 	ret = count;
 	goto done;
 
@@ -679,6 +766,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	vfio_ap_mdev_link_queues(matrix_mdev, UNLINK_APID, apid);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -769,6 +857,7 @@ static ssize_t assign_domain_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APQI, apqi);
 	ret = count;
 	goto done;
 
@@ -821,6 +910,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	vfio_ap_mdev_link_queues(matrix_mdev, UNLINK_APQI, apqi);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -1159,8 +1249,8 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 			 */
 			if (ret)
 				rc = ret;
-			q = vfio_ap_get_queue(matrix_mdev,
-					      AP_MKQID(apid, apqi));
+			q = vfio_ap_mdev_get_queue(matrix_mdev,
+						   AP_MKQID(apid, apqi));
 			if (q)
 				vfio_ap_free_aqic_resources(q);
 		}
@@ -1288,6 +1378,29 @@ void vfio_ap_mdev_unregister(void)
 	mdev_unregister_device(&matrix_dev->device);
 }
 
+/**
+ * vfio_ap_queue_link_mdev
+ *
+ * @q: The queue to link with the matrix mdev.
+ *
+ * Links @q with the matrix mdev to which the queue's APQN is assigned.
+ */
+static void vfio_ap_queue_link_mdev(struct vfio_ap_queue *q)
+{
+	unsigned long apid = AP_QID_CARD(q->apqn);
+	unsigned long apqi = AP_QID_QUEUE(q->apqn);
+	struct ap_matrix_mdev *matrix_mdev;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->matrix.aqm)) {
+			q->matrix_mdev = matrix_mdev;
+			hash_add(matrix_mdev->qtable, &q->mdev_qnode, q->apqn);
+			break;
+		}
+	}
+}
+
 int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
 	struct vfio_ap_queue *q;
@@ -1299,9 +1412,12 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	if (!q)
 		return -ENOMEM;
 
+	mutex_lock(&matrix_dev->lock);
 	dev_set_drvdata(&queue->ap_dev.device, q);
 	q->apqn = queue->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
+	vfio_ap_queue_link_mdev(q);
+	mutex_unlock(&matrix_dev->lock);
 
 	return 0;
 }
@@ -1321,6 +1437,8 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	apqi = AP_QID_QUEUE(q->apqn);
 	vfio_ap_mdev_reset_queue(apid, apqi, 1);
 	vfio_ap_free_aqic_resources(q);
+	if (q->matrix_mdev)
+		hash_del(&q->mdev_qnode);
 	kfree(q);
 	mutex_unlock(&matrix_dev->lock);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index d9003de4fbad..4e5cc72fc0db 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/kvm_host.h>
+#include <linux/hashtable.h>
 
 #include "ap_bus.h"
 
@@ -86,6 +87,7 @@ struct ap_matrix_mdev {
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
 	struct mdev_device *mdev;
+	DECLARE_HASHTABLE(qtable, 8);
 };
 
 extern int vfio_ap_mdev_register(void);
@@ -97,6 +99,7 @@ struct vfio_ap_queue {
 	int	apqn;
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
+	struct hlist_node mdev_qnode;
 };
 
 int vfio_ap_mdev_probe_queue(struct ap_device *queue);
-- 
2.21.1
