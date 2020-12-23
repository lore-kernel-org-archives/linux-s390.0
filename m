Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v13 11/15] s390/vfio-ap: implement in-use callback for vfio_ap driver
Date: Tue, 22 Dec 2020 20:16:02 -0500
Message-Id: <20201223011606.5265-12-akrowiak@linux.ibm.com>
In-Reply-To: <20201223011606.5265-1-akrowiak@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Let's implement the callback to indicate when an APQN
is in use by the vfio_ap device driver. The callback is
invoked whenever a change to the apmask or aqmask would
result in one or more queue devices being removed from the driver. The
vfio_ap device driver will indicate a resource is in use
if the APQN of any of the queue devices to be removed are assigned to
any of the matrix mdevs under the driver's control.

There is potential for a deadlock condition between the matrix_dev->lock
used to lock the matrix device during assignment of adapters and domains
and the ap_perms_mutex locked by the AP bus when changes are made to the
sysfs apmask/aqmask attributes.

Consider following scenario (courtesy of Halil Pasic):
1) apmask_store() takes ap_perms_mutex
2) assign_adapter_store() takes matrix_dev->lock
3) apmask_store() calls vfio_ap_mdev_resource_in_use() which tries
   to take matrix_dev->lock
4) assign_adapter_store() calls ap_apqn_in_matrix_owned_by_def_drv
   which tries to take ap_perms_mutex

BANG!

To resolve this issue, instead of using the mutex_lock(&matrix_dev->lock)
function to lock the matrix device during assignment of an adapter or
domain to a matrix_mdev as well as during the in_use callback, the
mutex_trylock(&matrix_dev->lock) function will be used. If the lock is not
obtained, then the assignment and in_use functions will terminate with
-EBUSY.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |  1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 21 ++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 73bd073fd5d3..8934471b7944 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -147,6 +147,7 @@ static int __init vfio_ap_init(void)
 	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
 	vfio_ap_drv.probe = vfio_ap_mdev_probe_queue;
 	vfio_ap_drv.remove = vfio_ap_mdev_remove_queue;
+	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 843862c88379..6bc2e80cc565 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -644,7 +644,8 @@ static ssize_t assign_adapter_store(struct device *dev,
 	memset(apm, 0, sizeof(apm));
 	set_bit_inv(apid, apm);
 
-	mutex_lock(&matrix_dev->lock);
+	if (!mutex_trylock(&matrix_dev->lock))
+		return -EBUSY;
 
 	ret = vfio_ap_mdev_validate_masks(matrix_mdev, apm,
 					  matrix_mdev->matrix.aqm);
@@ -777,7 +778,8 @@ static ssize_t assign_domain_store(struct device *dev,
 	memset(aqm, 0, sizeof(aqm));
 	set_bit_inv(apqi, aqm);
 
-	mutex_lock(&matrix_dev->lock);
+	if (!mutex_trylock(&matrix_dev->lock))
+		return -EBUSY;
 
 	ret = vfio_ap_mdev_validate_masks(matrix_mdev, matrix_mdev->matrix.apm,
 					  aqm);
@@ -896,7 +898,8 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	 * least significant, correspond to IDs 0 up to the one less than the
 	 * number of control domains that can be assigned.
 	 */
-	mutex_lock(&matrix_dev->lock);
+	if (!mutex_trylock(&matrix_dev->lock))
+		return -EBUSY;
 	set_bit_inv(id, matrix_mdev->matrix.adm);
 	vfio_ap_mdev_hot_plug_cdom(matrix_mdev, id);
 	mutex_unlock(&matrix_dev->lock);
@@ -1446,3 +1449,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	kfree(q);
 	mutex_unlock(&matrix_dev->lock);
 }
+
+int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
+{
+	int ret;
+
+	if (!mutex_trylock(&matrix_dev->lock))
+		return -EBUSY;
+	ret = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
+	mutex_unlock(&matrix_dev->lock);
+
+	return ret;
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index d2d26ba18602..15b7cd74843b 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -107,4 +107,6 @@ struct vfio_ap_queue {
 int vfio_ap_mdev_probe_queue(struct ap_device *queue);
 void vfio_ap_mdev_remove_queue(struct ap_device *queue);
 
+int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
