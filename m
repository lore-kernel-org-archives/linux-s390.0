Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 13/14] s390/vfio-ap: handle AP bus scan completed notification
Date: Thu, 22 Oct 2020 13:12:08 -0400
Message-Id: <20201022171209.19494-14-akrowiak@linux.ibm.com>
In-Reply-To: <20201022171209.19494-1-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
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
an adapter or domain can be plugged in only if each APQN with the APID of
the adapter or the APQI of the domain references a queue device bound
to the vfio_ap device driver. Consequently, not all newly added adapters
and domains will necessarily get hot plugged.

The same filtering operation used when the guest is started will again be
used to filter the APQNs assigned to the guest when the vfio_ap driver is
notified the AP bus scan has completed for those matrix mediated devices
to which the newly added APID(s) and/or APQI(s) are assigned.

To recap the filtering process employed:

For each APQN formulated from the Cartesian
product of the APIDs and APQIs assigned to the matrix mdev, if the APQN
does not reference a queue device bound to the vfio_ap device driver, the
APID will not be hot plugged into the guest. If any APIDs are left after
filtering, all of the queues referenced by the APQNs formulated by the
remaining APIDs and the APQIs assigned to the matrix mdev will be hot
plugged into the guest.

Control domains will not be filtered and will always be hot plugged.

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

    KVM guest matrix after filtering:
       Adapters  Domains  -> Queues
       04        0004        04.0004
                 0047        04.0047
                 0054        04.0054

       Adapter 05 is filtered because queue 05.0054 is not bound.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |  1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 26 ++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 3 files changed, 29 insertions(+)

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
index 075096adbfd3..824f936364ba 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1837,3 +1837,29 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 	vfio_ap_mdev_on_cfg_add();
 	mutex_unlock(&matrix_dev->lock);
 }
+
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->lock);
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (!vfio_ap_mdev_has_crycb(matrix_mdev))
+			continue;
+
+		if (!bitmap_intersects(matrix_mdev->matrix.apm,
+				       matrix_dev->ap_add, AP_DEVICES) &&
+		    !bitmap_intersects(matrix_mdev->matrix.aqm,
+				       matrix_dev->aq_add, AP_DOMAINS))
+			continue;
+
+		if (vfio_ap_mdev_filter_guest_matrix(matrix_mdev,
+						     true))
+			vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
+	}
+
+	bitmap_clear(matrix_dev->ap_add, 0, AP_DEVICES);
+	bitmap_clear(matrix_dev->aq_add, 0, AP_DOMAINS);
+	mutex_unlock(&matrix_dev->lock);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 64f1f5b820f6..d82d1e62cb2f 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -119,5 +119,7 @@ void vfio_ap_mdev_remove_queue(struct ap_device *queue);
 bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
 void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 			    struct ap_config_info *old_config_info);
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
