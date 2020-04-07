Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727435AbgDGTUn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 15:20:43 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v7 13/15] s390/vfio-ap: handle host AP config change notification
Date: Tue,  7 Apr 2020 15:20:13 -0400
Message-Id: <20200407192015.19887-14-akrowiak@linux.ibm.com>
In-Reply-To: <20200407192015.19887-1-akrowiak@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Implements the driver callback invoked by the AP bus when the host
AP configuration has changed. Since this callback is invoked prior to
unbinding a device from its device driver, the vfio_ap driver will
respond by unplugging the AP adapters, domains and control domains
removed from the host's AP configuration from the guests using them.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |   5 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 136 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |   7 +-
 3 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 5197a1fe14d4..9f6c5d82dfb5 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -113,9 +113,11 @@ static int vfio_ap_matrix_dev_create(void)
 
 	/* Fill in config info via PQAP(QCI), if available */
 	if (test_facility(12)) {
-		ret = ap_qci(&matrix_dev->info);
+		ret = ap_qci(&matrix_dev->config_info);
 		if (ret)
 			goto matrix_alloc_err;
+		memcpy(&matrix_dev->config_info_prev, &matrix_dev->config_info,
+		       sizeof(struct ap_config_info));
 	}
 
 	mutex_init(&matrix_dev->lock);
@@ -176,6 +178,7 @@ static int __init vfio_ap_init(void)
 	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
 	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
+	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
 	if (ret) {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 88a4aef5193f..f1dd77729dd9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -336,8 +336,9 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	}
 
 	matrix_mdev->mdev = mdev;
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_crycb);
+	vfio_ap_matrix_init(&matrix_dev->config_info, &matrix_mdev->matrix);
+	vfio_ap_matrix_init(&matrix_dev->config_info,
+			    &matrix_mdev->shadow_crycb);
 	hash_init(matrix_mdev->qtable);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
@@ -485,8 +486,8 @@ static int vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 		 * If the APID is not assigned to the host AP configuration,
 		 * we can not assign it to the guest's AP configuration
 		 */
-		if (!test_bit_inv(apid,
-				  (unsigned long *)matrix_dev->info.apm)) {
+		if (!test_bit_inv(apid, (unsigned long *)
+				  matrix_dev->config_info.apm)) {
 			clear_bit_inv(apid, shadow_crycb->apm);
 			continue;
 		}
@@ -499,7 +500,7 @@ static int vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 			 * guest's AP configuration
 			 */
 			if (!test_bit_inv(apqi, (unsigned long *)
-					  matrix_dev->info.aqm)) {
+					  matrix_dev->config_info.aqm)) {
 				clear_bit_inv(apqi, shadow_crycb->aqm);
 				continue;
 			}
@@ -1617,7 +1618,7 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
 void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
 {
 	struct vfio_ap_queue *q;
-	int apid, apqi;
+	unsigned long apid, apqi;
 
 	mutex_lock(&matrix_dev->lock);
 	q = dev_get_drvdata(&queue->ap_dev.device);
@@ -1643,3 +1644,126 @@ bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	return in_use;
 }
+
+/**
+ * vfio_ap_mdev_unassign_apids
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @aqm: A bitmap with 256 bits. Each bit in the map represents an APID from 0
+ *	 to 255 (with the leftmost bit corresponding to APID 0).
+ *
+ * Unassigns each APID specified in @aqm that is assigned to the shadow CRYCB
+ * of @matrix_mdev. Returns true if at least one APID is unassigned; otherwise,
+ * returns false.
+ */
+bool vfio_ap_mdev_unassign_apids(struct ap_matrix_mdev *matrix_mdev,
+				 unsigned long *apm_unassign)
+{
+	unsigned long apid;
+	bool unassigned = false;
+
+	/*
+	 * If the matrix mdev is not in use by a KVM guest, return indicating
+	 * that no APIDs have been unassigned.
+	 */
+	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
+		return false;
+
+	for_each_set_bit_inv(apid, apm_unassign, AP_DEVICES) {
+		unassigned |= vfio_ap_mdev_unassign_guest_apid(matrix_mdev,
+							       apid);
+	}
+
+	return unassigned;
+}
+
+/**
+ * vfio_ap_mdev_unassign_apqis
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @aqm: A bitmap with 256 bits. Each bit in the map represents an APQI from 0
+ *	 to 255 (with the leftmost bit corresponding to APQI 0).
+ *
+ * Unassigns each APQI specified in @aqm that is assigned to the shadow CRYCB
+ * of @matrix_mdev. Returns true if at least one APQI is unassigned; otherwise,
+ * returns false.
+ */
+bool vfio_ap_mdev_unassign_apqis(struct ap_matrix_mdev *matrix_mdev,
+				 unsigned long *aqm_unassign)
+{
+	unsigned long apqi;
+	bool unassigned = false;
+
+	/*
+	 * If the matrix mdev is not in use by a KVM guest, return indicating
+	 * that no APQIs have been unassigned.
+	 */
+	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
+		return false;
+
+	for_each_set_bit_inv(apqi, aqm_unassign, AP_DOMAINS) {
+		unassigned |= vfio_ap_mdev_unassign_guest_apqi(matrix_mdev,
+							       apqi);
+	}
+
+	return unassigned;
+}
+
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info)
+{
+	bool unassigned;
+	int ap_remove, aq_remove;
+	struct ap_matrix_mdev *matrix_mdev;
+	DECLARE_BITMAP(apm_unassign, AP_DEVICES);
+	DECLARE_BITMAP(aqm_unassign, AP_DOMAINS);
+
+	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
+
+	if (matrix_dev->flags & AP_MATRIX_CFG_CHG) {
+		WARN_ONCE(1, "AP host configuration change already reported");
+		return;
+	}
+
+	memcpy(&matrix_dev->config_info, new_config_info,
+	       sizeof(struct ap_config_info));
+	memcpy(&matrix_dev->config_info_prev, old_config_info,
+	       sizeof(struct ap_config_info));
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+
+	ap_remove = bitmap_andnot(apm_unassign, prev_apm, cur_apm, AP_DEVICES);
+	aq_remove = bitmap_andnot(aqm_unassign, prev_aqm, cur_aqm, AP_DOMAINS);
+
+	mutex_lock(&matrix_dev->lock);
+	matrix_dev->flags |= AP_MATRIX_CFG_CHG;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (!vfio_ap_mdev_has_crycb(matrix_mdev))
+			continue;
+
+		unassigned = false;
+
+		if (ap_remove)
+			if (bitmap_intersects(matrix_mdev->shadow_crycb.apm,
+					      apm_unassign, AP_DEVICES))
+				if (vfio_ap_mdev_unassign_apids(matrix_mdev,
+								apm_unassign))
+					unassigned = true;
+		if (aq_remove)
+			if (bitmap_intersects(matrix_mdev->shadow_crycb.aqm,
+					      aqm_unassign, AP_DOMAINS))
+				if (vfio_ap_mdev_unassign_apqis(matrix_mdev,
+								aqm_unassign))
+					unassigned = true;
+
+		if (unassigned)
+			vfio_ap_mdev_commit_crycb(matrix_mdev);
+	}
+	mutex_unlock(&matrix_dev->lock);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 794c60a767d2..82abbf03781f 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -40,11 +40,14 @@
 struct ap_matrix_dev {
 	struct device device;
 	atomic_t available_instances;
-	struct ap_config_info info;
+	struct ap_config_info config_info;
+	struct ap_config_info config_info_prev;
 	struct list_head mdev_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
 	DECLARE_HASHTABLE(qtable, 8);
+	#define AP_MATRIX_CFG_CHG (1UL << 0)
+	unsigned long flags;
 };
 
 extern struct ap_matrix_dev *matrix_dev;
@@ -109,5 +112,7 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
 void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
 
 bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
