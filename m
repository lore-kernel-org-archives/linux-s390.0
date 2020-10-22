Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2902437AbgJVRMt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Oct 2020 13:12:49 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 12/14] s390/vfio-ap: handle host AP config change notification
Date: Thu, 22 Oct 2020 13:12:07 -0400
Message-Id: <20201022171209.19494-13-akrowiak@linux.ibm.com>
In-Reply-To: <20201022171209.19494-1-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
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
* When a queue is probed, if the APID of the queue being probed is
  contained in the bitmap of adapters added, the queue hot plug operation
  will be skipped until the AP bus notifies the driver that its scan
  operation has completed.

Domains added to host configuration:
* The APQIs of the domains added will be stored in a bitmap contained
  within the struct representing the matrix device which is the parent
  device of all matrix mediated devices.
* When a queue is probed, if the APQI of the queue being probed is
  contained in the bitmap of domains added, the queue hot plug operation
  will be skipped until the AP bus notifies the driver that its scan
  operation has completed.

Control domains added to the host configuration:
* Since control domains are not devices in the linux device model, there is
  no concern with whether they are bound to a device driver.
* The AP architecture will mask off control domains not in the host AP
  configuration from the guest, so there is also no concern about a guest
  changing a domain to which it is not authorized.

Adapters removed from configuration:
* Each adapter removed from the host configuration will be hot unplugged
  from each guest using it.
* Each queue device with the APID identifying an adapter removed from
  the host AP configuration will be unlinked from the matrix mdev to which
  the queue's APQN is assigned.
* When the vfio_ap driver's remove callback is invoked, if the queue
  device is not linked to the matrix mdev, the hot unplug operation will
  be skipped until the vfio_ap driver is notified that the AP bus scan
  has completed.

Adapters removed from configuration:
* Each domain removed from the host configuration will be hot unplugged
  from each guest using it.
* Each queue device with the APQI identifying a domain removed from
  the host AP configuration will be unlinked from the matrix mdev to which
  the queue's APQN is assigned.
* When the vfio_ap driver's remove callback is invoked, if the queue
  device is not linked to the matrix mdev, the hot unplug operation will
  be  until the vfio_ap driver is notified that the AP bus scan
  has completed.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |   3 +
 drivers/s390/crypto/vfio_ap_ops.c     | 223 +++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  11 ++
 3 files changed, 236 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index f06e19754de3..d7aa5543afef 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -90,6 +90,8 @@ static int vfio_ap_matrix_dev_create(void)
 		ret = ap_qci(&matrix_dev->config_info);
 		if (ret)
 			goto matrix_alloc_err;
+		memcpy(&matrix_dev->config_info_prev, &matrix_dev->config_info,
+		       sizeof(struct ap_config_info));
 	}
 
 	mutex_init(&matrix_dev->lock);
@@ -149,6 +151,7 @@ static int __init vfio_ap_init(void)
 	vfio_ap_drv.remove = vfio_ap_mdev_remove_queue;
 	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
+	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
 	if (ret) {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c4ea80ec8599..075096adbfd3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1530,8 +1530,13 @@ static void vfio_ap_queue_link_mdev(struct vfio_ap_queue *q)
 
 static void vfio_ap_mdev_hot_plug_queue(struct vfio_ap_queue *q)
 {
+	unsigned long apid = AP_QID_CARD(q->apqn);
+	unsigned long apqi = AP_QID_QUEUE(q->apqn);
 
-	if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
+	if ((q->matrix_mdev == NULL) ||
+	    !vfio_ap_mdev_has_crycb(q->matrix_mdev) ||
+	    test_bit_inv(apid, matrix_dev->ap_add) ||
+	    test_bit_inv(apqi, matrix_dev->aq_add))
 		return;
 
 	if (vfio_ap_mdev_filter_guest_matrix(q->matrix_mdev, true))
@@ -1616,3 +1621,219 @@ bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	return in_use;
 }
+
+/**
+ * vfio_ap_mdev_unassign_apids
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @apid_rem: The bitmap specifying the APIDs of the adapters removed from
+ *	      the host's AP configuration
+ *
+ * Unassigns each APID specified in @apid_rem that is assigned to the
+ * shadow APCB. Returns true if at least one APID is unassigned; otherwise,
+ * returns false.
+ */
+static bool vfio_ap_mdev_unassign_apids(struct ap_matrix_mdev *matrix_mdev,
+					unsigned long *apid_rem)
+{
+	DECLARE_BITMAP(shadow_apm, AP_DEVICES);
+
+	/*
+	 * Get the result of filtering the APIDs removed from the host AP
+	 * configuration out of the shadow APCB
+	 */
+	bitmap_andnot(shadow_apm, matrix_mdev->shadow_apcb.apm, apid_rem,
+		      AP_DEVICES);
+
+	/*
+	 * If filtering removed any APIDs from the shadow APCB, then let's go
+	 * ahead and update the shadow APCB accordingly
+	 */
+	if (!bitmap_equal(matrix_mdev->shadow_apcb.apm, shadow_apm,
+			  AP_DEVICES)) {
+		memcpy(matrix_mdev->shadow_apcb.apm, shadow_apm,
+		       sizeof(struct ap_matrix));
+
+		/*
+		 * If all APIDs have been filtered from the shadow APCB, then
+		 * let's also filter all of the APQIs. You need both APIDs and
+		 * APQIs to identify the APQNs of the queues to assign to a
+		 * guest.
+		 */
+		if (bitmap_empty(matrix_mdev->shadow_apcb.apm, AP_DEVICES))
+			bitmap_clear(matrix_mdev->shadow_apcb.aqm, 0,
+				     AP_DOMAINS);
+
+		return true;
+	}
+
+	return false;
+}
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
+ */
+static void vfio_ap_mdev_unlink_apids(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long *apid_rem)
+{
+	int bkt, apid;
+	struct vfio_ap_queue *q;
+
+	hash_for_each(matrix_mdev->qtable, bkt, q, mdev_qnode) {
+		apid = AP_QID_CARD(q->apqn);
+		if (test_bit_inv(apid, apid_rem)) {
+			q->matrix_mdev = NULL;
+			hash_del(&q->mdev_qnode);
+		}
+	}
+}
+
+/**
+ * vfio_ap_mdev_unassign_apqis
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @apqi_rem: The bitmap specifying the APQIs of the domains removed from
+ *	      the host's AP configuration
+ *
+ * Unassigns each APQI specified in @apqi_rem that is assigned to the
+ * shadow APCB. Returns true if at least one APQI is unassigned; otherwise,
+ * returns false.
+ */
+static bool vfio_ap_mdev_unassign_apqis(struct ap_matrix_mdev *matrix_mdev,
+					unsigned long *apqi_rem)
+{
+	DECLARE_BITMAP(shadow_aqm, AP_DOMAINS);
+
+	/*
+	 * Get the result of filtering the APQIs removed from the host AP
+	 * configuration out of the shadow APCB
+	 */
+	bitmap_andnot(shadow_aqm, matrix_mdev->shadow_apcb.aqm, apqi_rem,
+		      AP_DOMAINS);
+
+	/*
+	 * If filtering removed any APQIs from the shadow APCB, then let's go
+	 * ahead and update the shadow APCB accordingly
+	 */
+	if (!bitmap_equal(matrix_mdev->shadow_apcb.aqm, shadow_aqm,
+			  AP_DOMAINS)) {
+		memcpy(matrix_mdev->shadow_apcb.aqm, shadow_aqm,
+		       sizeof(struct ap_matrix));
+
+		/*
+		 * If all APQIs have been filtered from the shadow APCB, then
+		 * let's also filter all of the APIDs. You need both APIDs and
+		 * APQIs to identify the APQNs of the queues to assign to a
+		 * guest.
+		 */
+		if (bitmap_empty(matrix_mdev->shadow_apcb.aqm, AP_DOMAINS))
+			bitmap_clear(matrix_mdev->shadow_apcb.apm, 0,
+				     AP_DEVICES);
+
+		return true;
+	}
+
+	return false;
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
+ */
+static void vfio_ap_mdev_unlink_apqis(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long *apqi_rem)
+{
+	int bkt, apqi;
+	struct vfio_ap_queue *q;
+
+	hash_for_each(matrix_mdev->qtable, bkt, q, mdev_qnode) {
+		apqi = AP_QID_QUEUE(q->apqn);
+		if (test_bit_inv(apqi, apqi_rem)) {
+			q->matrix_mdev = NULL;
+			hash_del(&q->mdev_qnode);
+		}
+	}
+}
+
+static void vfio_ap_mdev_on_cfg_remove(void)
+{
+	bool unassigned = false;
+	int ap_remove, aq_remove;
+	struct ap_matrix_mdev *matrix_mdev;
+	DECLARE_BITMAP(apid_rem, AP_DEVICES);
+	DECLARE_BITMAP(apqi_rem, AP_DOMAINS);
+	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+
+	ap_remove = bitmap_andnot(apid_rem, prev_apm, cur_apm, AP_DEVICES);
+	aq_remove = bitmap_andnot(apqi_rem, prev_aqm, cur_aqm, AP_DOMAINS);
+
+	if (!ap_remove && !aq_remove)
+		return;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (!vfio_ap_mdev_has_crycb(matrix_mdev))
+			continue;
+
+		if (ap_remove) {
+			if (vfio_ap_mdev_unassign_apids(matrix_mdev, apid_rem))
+				unassigned = true;
+			vfio_ap_mdev_unlink_apids(matrix_mdev, apid_rem);
+		}
+
+		if (aq_remove) {
+			if (vfio_ap_mdev_unassign_apqis(matrix_mdev, apqi_rem))
+				unassigned = true;
+			vfio_ap_mdev_unlink_apqis(matrix_mdev, apqi_rem);
+		}
+	}
+}
+
+void vfio_ap_mdev_on_cfg_add(void)
+{
+	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+
+	bitmap_andnot(matrix_dev->ap_add, cur_apm, prev_apm, AP_DEVICES);
+	bitmap_andnot(matrix_dev->aq_add, cur_aqm, prev_aqm, AP_DOMAINS);
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
index 5065f0367ea2..64f1f5b820f6 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -36,14 +36,21 @@
  *		driver, be it using @mdev_list or writing the state of a
  *		single ap_matrix_mdev device. It's quite coarse but we don't
  *		expect much contention.
+ ** @ap_add:	a bitmap specifying the APIDs added to the host AP configuration
+ *		as notified by the AP bus via the on_cfg_chg callback.
+ * @aq_add:	a bitmap specifying the APQIs added to the host AP configuration
+ *		as notified by the AP bus via the on_cfg_chg callback.
  */
 struct ap_matrix_dev {
 	struct device device;
 	atomic_t available_instances;
 	struct ap_config_info config_info;
+	struct ap_config_info config_info_prev;
 	struct list_head mdev_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
+	DECLARE_BITMAP(ap_add, AP_DEVICES);
+	DECLARE_BITMAP(aq_add, AP_DEVICES);
 };
 
 extern struct ap_matrix_dev *matrix_dev;
@@ -90,6 +97,8 @@ struct ap_matrix_mdev {
 	struct kvm_s390_module_hook pqap_hook;
 	struct mdev_device *mdev;
 	DECLARE_HASHTABLE(qtable, 8);
+	DECLARE_BITMAP(ap_add, AP_DEVICES);
+	DECLARE_BITMAP(aq_add, AP_DEVICES);
 };
 
 extern int vfio_ap_mdev_register(void);
@@ -108,5 +117,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *queue);
 void vfio_ap_mdev_remove_queue(struct ap_device *queue);
 
 bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
