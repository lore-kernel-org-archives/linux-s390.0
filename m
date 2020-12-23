Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41008 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbgLWBRQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Dec 2020 20:17:16 -0500
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v13 13/15] s390/vfio-ap: handle host AP config change notification
Date: Tue, 22 Dec 2020 20:16:04 -0500
Message-Id: <20201223011606.5265-14-akrowiak@linux.ibm.com>
In-Reply-To: <20201223011606.5265-1-akrowiak@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

The motivation for config change notification is to enable the vfio_ap
device driver to handle hot plug/unplug of AP queues for a KVM guest as a
bulk operation. For example, if a new APID is dynamically assigned to the
host configuration, then a queue device will be created for each APQN that
can be formulated from the new APID and all APQIs already assigned to the
host configuration. Each of these new queue devices will get bound to their
respective driver one at a time, as they are created. In the case of the
vfio_ap driver, if the APQN of the queue device being bound to the driver
is assigned to a matrix mdev in use by a KVM guest, it will be hot plugged
into the guest if possible. Given that the AP architecture allows for 256
adapters and 256 domains, one can see the possibility of the vfio_ap
driver's probe/remove callbacks getting invoked an inordinate number of
times when the host configuration changes. Keep in mind that in order to
plug/unplug an AP queue for a guest, the guest's VCPUs must be suspended,
then the guest's AP configuration must be updated followed by the VCPUs
being resumed. If this is done each time the probe or remove callback is
invoked and there are hundreds or thousands of queues to be probed or
removed, this would be incredibly inefficient and could have a large impact
on guest performance. What the config notification does is allow us to
make the changes to the guest in a single operation.

This patch implements the on_cfg_changed callback which notifies the
AP device drivers that the host AP configuration has changed (i.e.,
adapters, domains and/or control domains are added to or removed from the
host AP configuration).

Adapters added to host configuration:
* The APIDs of the adapters added will be stored in a bitmap contained
  within the struct representing the matrix device which is the parent
  device of all matrix mediated devices.
* When a queue is probed, if the APQN of the queue being probed is
  assigned to an mdev in use by a guest, the queue may get hot plugged
  into the guest; however, if the APID of the adapter is contained in the
  bitmap of adapters added, the queue hot plug operation will be skipped
  until the AP bus notifies the driver that its scan operation has
  completed (another patch).
* When the vfio_ap driver is notified that the AP bus scan has completed,
  the guest's APCB will be refreshed by filtering the mdev's matrix by
  APID.

Domains added to host configuration:
* The APQIs of the domains added will be stored in a bitmap contained
  within the struct representing the matrix device which is the parent
  device of all matrix mediated devices.
* When a queue is probed, if the APQN of the queue being probed is
  assigned to an mdev in use by a guest, the queue may get hot plugged
  into the guest; however, if the APQI of the domain is contained in the
  bitmap of domains added, the queue hot plug operation will be skipped
  until the AP bus notifies the driver that its scan operation has
  completed (another patch).

Control domains added to the host configuration:
* The domain numbers of the domains added will be stored in a bitmap
  contained within the struct representing the matrix device which is the
  parent device of all matrix mediated devices.

When the vfio_ap device driver is notified that the AP bus scan has
completed, the APCB for each matrix mdev to which the adapters, domains
and control domains added are assigned will be refreshed. If a KVM guest is
using the matrix mdev, the APCB will be hot plugged into the guest to
refresh its AP configuration.

Adapters removed from configuration:
* Each queue device with the APID identifying an adapter removed from
  the host AP configuration will be unlinked from the matrix mdev to which
  the queue's APQN is assigned.
* When the vfio_ap driver's remove callback is invoked, if the queue
  device is not linked to the matrix mdev, the refresh of the guest's
  APCB will be skipped.

Domains removed from configuration:
* Each queue device with the APQI identifying a domain removed from
  the host AP configuration will be unlinked from the matrix mdev to which
  the queue's APQN is assigned.
* When the vfio_ap driver's remove callback is invoked, if the queue
  device is not linked to the matrix mdev, the refresh of the guest's
  APCB will be skipped.

If any queues with an APQN assigned to a given matrix mdev have been
unlinked or any control domains assigned to a given matrix mdev have been
removed from the host AP configuration, the APCB of the matrix mdev will
be refreshed. If a KVM guest is using the matrix mdev, the APCB will be hot
plugged into the guest to refresh its AP configuration.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |   3 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 159 +++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  13 ++-
 3 files changed, 158 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8934471b7944..2029d8392416 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -87,7 +87,7 @@ static int vfio_ap_matrix_dev_create(void)
 
 	/* Fill in config info via PQAP(QCI), if available */
 	if (test_facility(12)) {
-		ret = ap_qci(&matrix_dev->info);
+		ret = ap_qci(&matrix_dev->config_info);
 		if (ret)
 			goto matrix_alloc_err;
 	}
@@ -148,6 +148,7 @@ static int __init vfio_ap_init(void)
 	vfio_ap_drv.probe = vfio_ap_mdev_probe_queue;
 	vfio_ap_drv.remove = vfio_ap_mdev_remove_queue;
 	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
+	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
 	vfio_ap_drv.ids = ap_queue_ids;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6bc2e80cc565..8bbbd1dc7546 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -310,13 +310,8 @@ static void vfio_ap_mdev_commit_shadow_apcb(struct ap_matrix_mdev *matrix_mdev)
 static void vfio_ap_mdev_filter_apcb(struct ap_matrix_mdev *matrix_mdev,
 				     struct ap_matrix *shadow_apcb)
 {
-	int ret;
 	unsigned long apid, apqi, apqn;
 
-	ret = ap_qci(&matrix_dev->info);
-	if (ret)
-		return;
-
 	memcpy(shadow_apcb, &matrix_mdev->matrix, sizeof(struct ap_matrix));
 
 	/*
@@ -325,11 +320,11 @@ static void vfio_ap_mdev_filter_apcb(struct ap_matrix_mdev *matrix_mdev,
 	 * AP configuration.
 	 */
 	bitmap_and(shadow_apcb->apm, matrix_mdev->matrix.apm,
-		   (unsigned long *)matrix_dev->info.apm, AP_DEVICES);
+		   (unsigned long *)matrix_dev->config_info.apm, AP_DEVICES);
 	bitmap_and(shadow_apcb->aqm, matrix_mdev->matrix.aqm,
-		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
+		   (unsigned long *)matrix_dev->config_info.aqm, AP_DOMAINS);
 	bitmap_and(shadow_apcb->adm, matrix_mdev->matrix.adm,
-		   (unsigned long *)matrix_dev->info.adm, AP_DOMAINS);
+		   (unsigned long *)matrix_dev->config_info.adm, AP_DOMAINS);
 
 	/* If there are no APQNs assigned, then filtering them be unnecessary */
 	if (bitmap_empty(shadow_apcb->apm, AP_DEVICES)) {
@@ -403,8 +398,9 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	}
 
 	matrix_mdev->mdev = mdev;
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	vfio_ap_matrix_init(&matrix_dev->config_info, &matrix_mdev->matrix);
+	vfio_ap_matrix_init(&matrix_dev->config_info,
+			    &matrix_mdev->shadow_apcb);
 	hash_init(matrix_mdev->qtable);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
@@ -855,7 +851,8 @@ static void vfio_ap_mdev_hot_plug_cdom(struct ap_matrix_mdev *matrix_mdev,
 				       unsigned long domid)
 {
 	if (!test_bit_inv(domid, matrix_mdev->shadow_apcb.adm) &&
-	    test_bit_inv(domid, (unsigned long *) matrix_dev->info.adm)) {
+	    test_bit_inv(domid,
+			 (unsigned long *) matrix_dev->config_info.adm)) {
 		set_bit_inv(domid, matrix_mdev->shadow_apcb.adm);
 		vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 	}
@@ -1436,11 +1433,11 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	mutex_lock(&matrix_dev->lock);
 	q = dev_get_drvdata(&apdev->device);
 	dev_set_drvdata(&apdev->device, NULL);
-	apid = AP_QID_CARD(q->apqn);
-	apqi = AP_QID_QUEUE(q->apqn);
-	vfio_ap_mdev_reset_queue(apid, apqi, 1);
 
 	if (q->matrix_mdev) {
+		apid = AP_QID_CARD(q->apqn);
+		apqi = AP_QID_QUEUE(q->apqn);
+		vfio_ap_mdev_reset_queue(apid, apqi, 1);
 		matrix_mdev = q->matrix_mdev;
 		vfio_ap_mdev_unlink_queue(q);
 		vfio_ap_mdev_refresh_apcb(matrix_mdev);
@@ -1461,3 +1458,137 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	return ret;
 }
+
+/*
+ * vfio_ap_mdev_unlink_apids
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @apid_rem: The bitmap specifying the APIDs of the adapters removed from
+ *	      the host's AP configuration
+ *
+ * Unlinks @matrix_mdev from each queue assigned to @matrix_mdev whose APQN
+ * contains an APID specified in @apid_rem.
+ *
+ * Returns true if one or more AP queue devices were unlinked; otherwise,
+ * returns false.
+ */
+static bool vfio_ap_mdev_unlink_apids(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long *apid_rem)
+{
+	int bkt, apid, apqi;
+	bool q_unlinked = false;
+	struct vfio_ap_queue *q;
+
+	hash_for_each(matrix_mdev->qtable, bkt, q, mdev_qnode) {
+		apid = AP_QID_CARD(q->apqn);
+		if (test_bit_inv(apid, apid_rem)) {
+			apqi = AP_QID_QUEUE(q->apqn);
+			vfio_ap_mdev_reset_queue(apid, apqi, 1);
+			vfio_ap_mdev_unlink_queue(q);
+			q_unlinked = true;
+		}
+	}
+
+	return q_unlinked;
+}
+
+/*
+ * vfio_ap_mdev_unlink_apqis
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @apqi_rem: The bitmap specifying the APQIs of the domains removed from
+ *	      the host's AP configuration
+ *
+ * Unlinks @matrix_mdev from each queue assigned to @matrix_mdev whose APQN
+ * contains an APQI specified in @apqi_rem.
+ *
+ * Returns true if one or more AP queue devices were unlinked; otherwise,
+ * returns false.
+ */
+static bool vfio_ap_mdev_unlink_apqis(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long *apqi_rem)
+{
+	int bkt, apid, apqi;
+	bool q_unlinked = false;
+	struct vfio_ap_queue *q;
+
+	hash_for_each(matrix_mdev->qtable, bkt, q, mdev_qnode) {
+		apqi = AP_QID_QUEUE(q->apqn);
+		if (test_bit_inv(apqi, apqi_rem)) {
+			apid = AP_QID_CARD(q->apqn);
+			vfio_ap_mdev_reset_queue(apid, apqi, 1);
+			vfio_ap_mdev_unlink_queue(q);
+			q_unlinked = true;
+		}
+	}
+
+	return q_unlinked;
+}
+
+static void vfio_ap_mdev_on_cfg_remove(void)
+{
+	bool refresh_apcb = false;
+	int ap_remove, aq_remove;
+	struct ap_matrix_mdev *matrix_mdev;
+	DECLARE_BITMAP(aprem, AP_DEVICES);
+	DECLARE_BITMAP(aqrem, AP_DOMAINS);
+	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+
+	ap_remove = bitmap_andnot(aprem, prev_apm, cur_apm, AP_DEVICES);
+	aq_remove = bitmap_andnot(aqrem, prev_aqm, cur_aqm, AP_DOMAINS);
+
+	if (!ap_remove && !aq_remove)
+		return;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (ap_remove)
+			refresh_apcb = vfio_ap_mdev_unlink_apids(matrix_mdev,
+								 aprem);
+
+		if (aq_remove)
+			refresh_apcb = vfio_ap_mdev_unlink_apqis(matrix_mdev,
+								 aqrem);
+
+		if (refresh_apcb)
+			vfio_ap_mdev_refresh_apcb(matrix_mdev);
+	}
+}
+
+static void vfio_ap_mdev_on_cfg_add(void)
+{
+	unsigned long *cur_apm, *cur_aqm, *cur_adm;
+	unsigned long *prev_apm, *prev_aqm, *prev_adm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	cur_adm = (unsigned long *)matrix_dev->config_info.adm;
+
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+	prev_adm = (unsigned long *)matrix_dev->config_info_prev.adm;
+
+	bitmap_andnot(matrix_dev->ap_add, cur_apm, prev_apm, AP_DEVICES);
+	bitmap_andnot(matrix_dev->aq_add, cur_aqm, prev_aqm, AP_DOMAINS);
+	bitmap_andnot(matrix_dev->ad_add, cur_adm, prev_adm, AP_DOMAINS);
+}
+
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info)
+{
+	mutex_lock(&matrix_dev->lock);
+	memcpy(&matrix_dev->config_info, new_config_info,
+	       sizeof(struct ap_config_info));
+	memcpy(&matrix_dev->config_info_prev, old_config_info,
+	       sizeof(struct ap_config_info));
+
+	vfio_ap_mdev_on_cfg_remove();
+	vfio_ap_mdev_on_cfg_add();
+	mutex_unlock(&matrix_dev->lock);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 15b7cd74843b..b99b68968447 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -29,7 +29,9 @@
  * ap_matrix_dev - the AP matrix device structure
  * @device:	generic device structure associated with the AP matrix device
  * @available_instances: number of mediated matrix devices that can be created
- * @info:	the struct containing the output from the PQAP(QCI) instruction
+ * @config_info: the current host AP configuration information
+ * @config_info_prev: the host AP configuration information from the previous
+ *		      configuration changed notification
  * mdev_list:	the list of mediated matrix devices created
  * lock:	mutex for locking the AP matrix device. This lock will be
  *		taken every time we fiddle with state managed by the vfio_ap
@@ -40,10 +42,14 @@
 struct ap_matrix_dev {
 	struct device device;
 	atomic_t available_instances;
-	struct ap_config_info info;
+	struct ap_config_info config_info;
+	struct ap_config_info config_info_prev;
 	struct list_head mdev_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
+	DECLARE_BITMAP(ap_add, AP_DEVICES);
+	DECLARE_BITMAP(aq_add, AP_DOMAINS);
+	DECLARE_BITMAP(ad_add, AP_DOMAINS);
 };
 
 extern struct ap_matrix_dev *matrix_dev;
@@ -109,4 +115,7 @@ void vfio_ap_mdev_remove_queue(struct ap_device *queue);
 
 int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
 
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
