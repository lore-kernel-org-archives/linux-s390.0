Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v12 16/17] s390/vfio-ap: handle AP bus scan completed notification
Date: Tue, 24 Nov 2020 16:40:15 -0500
Message-Id: <20201124214016.3013-17-akrowiak@linux.ibm.com>
In-Reply-To: <20201124214016.3013-1-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Implements the driver callback invoked by the AP bus when the AP bus
scan has completed. Since this callback is invoked after binding the newly
added devices to their respective device drivers, the vfio_ap driver will
attempt to hot plug the adapters, domains and control domains into each
guest using the matrix mdev to which they are assigned. Keep in mind that
an adapter or domain can be plugged in only if:
* Each APQN derived from the newly added APID of the adapter and the APQIs
  already assigned to the guest's APCB references an AP queue device bound
  to the vfio_ap driver
* Each APQN derived from the newly added APQI of the domain and the APIDs
  already assigned to the guest's APCB references an AP queue device bound
  to the vfio_ap driver

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |  1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  2 +
 3 files changed, 57 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index d7aa5543afef..357481e80b0a 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -152,6 +152,7 @@ static int __init vfio_ap_init(void)
 	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
 	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
+	vfio_ap_drv.on_scan_complete = vfio_ap_on_scan_complete;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
 	if (ret) {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 074147fae339..7bfad92dd5e7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1805,3 +1805,57 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 	vfio_ap_mdev_on_cfg_add();
 	mutex_unlock(&matrix_dev->lock);
 }
+
+static bool vfio_ap_assign_new_adapters(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid;
+	bool assigned = false;
+	DECLARE_BITMAP(ap_add, AP_DEVICES);
+
+	if (bitmap_empty(matrix_dev->ap_add, AP_DEVICES) ||
+	    !bitmap_and(ap_add, matrix_dev->ap_add, matrix_mdev->matrix.apm,
+			AP_DEVICES))
+		return false;
+
+	for_each_set_bit_inv(apid, ap_add, AP_DEVICES)
+		assigned |= vfio_ap_assign_apid_to_apcb(matrix_mdev, apid);
+
+	return assigned;
+}
+
+static bool vfio_ap_assign_new_domains(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apqi;
+	bool assigned = false;
+	DECLARE_BITMAP(aq_add, AP_DOMAINS);
+
+	if (bitmap_empty(matrix_dev->aq_add, AP_DOMAINS) ||
+	    !bitmap_and(aq_add, matrix_dev->aq_add, matrix_mdev->matrix.aqm,
+			AP_DOMAINS))
+		return false;
+
+	for_each_set_bit_inv(apqi, aq_add, AP_DOMAINS)
+		assigned |= vfio_ap_assign_apqi_to_apcb(matrix_mdev, apqi);
+
+	return assigned;
+}
+
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info)
+{
+	bool do_hotplug;
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->lock);
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		do_hotplug = vfio_ap_assign_new_adapters(matrix_mdev);
+		do_hotplug |= vfio_ap_assign_new_domains(matrix_mdev);
+
+		if (do_hotplug)
+			vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
+	}
+
+	bitmap_clear(matrix_dev->ap_add, 0, AP_DEVICES);
+	bitmap_clear(matrix_dev->aq_add, 0, AP_DOMAINS);
+	mutex_unlock(&matrix_dev->lock);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 7bd7e35eb2e0..807be361b95d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -120,5 +120,7 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
 
 void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 			    struct ap_config_info *old_config_info);
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
