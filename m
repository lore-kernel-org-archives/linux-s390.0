Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727226AbgDGTUi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 15:20:38 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v7 08/15] s390/vfio_ap: add qlink from ap_matrix_mdev struct to vfio_ap_queue struct
Date: Tue,  7 Apr 2020 15:20:08 -0400
Message-Id: <20200407192015.19887-9-akrowiak@linux.ibm.com>
In-Reply-To: <20200407192015.19887-1-akrowiak@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Currently, a vfio_ap_queue struct is created for every queue device probed
which is then added to a hash table of all queues probed by the vfio_ap
device driver. This list could get quite large making retrieval
expensive. In order to make retrieval of a vfio_ap_queue struct more
efficient when we already have a pointer to the ap_matrix_mdev to which the
queue's APQN is assigned, let's go ahead and add a link from the
ap_matrix_mdev struct to the vfio_ap_queue struct.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 29 +++++++++++++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 25b7d978e3fd..6ee1ebe3f207 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -38,6 +38,19 @@ struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
 	return NULL;
 }
 
+struct vfio_ap_queue *vfio_ap_get_mdev_queue(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apqn)
+{
+	struct vfio_ap_queue *q;
+
+	hash_for_each_possible(matrix_mdev->qtable, q, mdev_qnode, apqn) {
+		if (q->apqn == apqn)
+			return q;
+	}
+
+	return NULL;
+}
+
 /**
  * vfio_ap_wait_for_irqclear
  * @apqn: The AP Queue number
@@ -325,6 +338,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_crycb);
+	hash_init(matrix_mdev->qtable);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
 	matrix_mdev->pqap_hook.owner = THIS_MODULE;
@@ -594,7 +608,7 @@ static int vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 			 * filter the APQI.
 			 */
 			apqn = AP_MKQID(apid, apqi);
-			if (!vfio_ap_get_queue(apqn)) {
+			if (!vfio_ap_get_mdev_queue(matrix_mdev, apqn)) {
 				if (filter_apids)
 					clear_bit_inv(apid, shadow_crycb->apm);
 				else
@@ -624,7 +638,6 @@ static bool vfio_ap_mdev_configure_crycb(struct ap_matrix_mdev *matrix_mdev)
 	vfio_ap_matrix_init(&matrix_dev->info, &shadow_crycb);
 	napm = bitmap_weight(matrix_mdev->matrix.apm, AP_DEVICES);
 	naqm = bitmap_weight(matrix_mdev->matrix.aqm, AP_DOMAINS);
-
 	/*
 	 * If there are no APIDs or no APQIs assigned to the matrix mdev,
 	 * then no APQNs shall be assigned to the guest CRYCB.
@@ -636,6 +649,7 @@ static bool vfio_ap_mdev_configure_crycb(struct ap_matrix_mdev *matrix_mdev)
 		 */
 		napm = vfio_ap_mdev_filter_matrix(matrix_mdev, &shadow_crycb,
 						  true);
+
 		/*
 		 * If there are no APQNs that can be assigned to the guest's
 		 * CRYCB after filtering, then try filtering the APQIs.
@@ -697,8 +711,10 @@ static void vfio_ap_mdev_qlinks_for_apid(struct ap_matrix_mdev *matrix_mdev,
 	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
 			     matrix_mdev->matrix.aqm_max + 1) {
 		q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
-		if (q)
+		if (q) {
 			q->matrix_mdev = matrix_mdev;
+			hash_add(matrix_mdev->qtable, &q->mdev_qnode, q->apqn);
+		}
 	}
 }
 
@@ -871,8 +887,10 @@ static void vfio_ap_mdev_qlinks_for_apqi(struct ap_matrix_mdev *matrix_mdev,
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
 			     matrix_mdev->matrix.apm_max + 1) {
 		q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
-		if (q)
+		if (q) {
 			q->matrix_mdev = matrix_mdev;
+			hash_add(matrix_mdev->qtable, &q->mdev_qnode, q->apqn);
+		}
 	}
 }
 
@@ -1536,6 +1554,7 @@ static void vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->matrix.aqm)) {
 			q->matrix_mdev = matrix_mdev;
+			hash_add(matrix_mdev->qtable, &q->mdev_qnode, q->apqn);
 			break;
 		}
 	}
@@ -1573,6 +1592,8 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
 	vfio_ap_mdev_reset_queue(apid, apqi, 1);
 	vfio_ap_irq_disable(q);
 	hash_del(&q->qnode);
+	if (q->matrix_mdev)
+		hash_del(&q->mdev_qnode);
 	kfree(q);
 	mutex_unlock(&matrix_dev->lock);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 87cc270c3212..794c60a767d2 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -89,6 +89,7 @@ struct ap_matrix_mdev {
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
 	struct mdev_device *mdev;
+	DECLARE_HASHTABLE(qtable, 8);
 };
 
 extern int vfio_ap_mdev_register(void);
@@ -101,6 +102,7 @@ struct vfio_ap_queue {
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
 	struct hlist_node qnode;
+	struct hlist_node mdev_qnode;
 };
 
 int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
-- 
2.21.1
