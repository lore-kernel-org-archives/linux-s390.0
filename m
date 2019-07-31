Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v5 3/7] s390: vfio-ap: implement in-use callback for vfio_ap driver
Date: Wed, 31 Jul 2019 18:41:13 -0400
In-Reply-To: <1564612877-7598-1-git-send-email-akrowiak@linux.ibm.com>
References: <1564612877-7598-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1564612877-7598-4-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>

Let's implement the callback to indicate when an APQN
is in use by the vfio_ap device driver. The callback is
invoked whenever a change to the apmask or aqmask may
result in one or APQNs being removed from the driver. The
vfio_ap device driver will indicate a resource is in use
if any of the removed APQNs are assigned to any of the matrix
mdev devices.

To ensure that the AP bus apmask/aqmask interfaces are used to control
which AP queues get manually bound to or unbound from the
vfio_ap device driver, the bind/unbind sysfs interfaces will
be disabled for the vfio_ap device driver. The reasons for this are:

* To prevent unbinding an AP queue device from the vfio_ap device
  driver representing a queue that is assigned to an mdev device.

* To enforce the policy that the the AP resources must first be
  unassigned from the mdev device - which will hot unplug them from a
  guest using the mdev device - before changing ownership of APQNs
  from the vfio_ap driver to a zcrypt driver. This ensures that private
  crypto data intended for the guest will never be accessible from the
  host.

* It takes advantage of the AP architecture to prevent dynamic changes
  to the LPAR configuration using the SE or SCLP commands from
  compromising the guest crypto devices. For example:

  * Even if an adapter is configured off, if and when it is configured
    back on, the queue devices associated with the adapter will be bound
    back to the vfio_ap driver and the queues will automatically be
    available to a guest using the mdev to which the APQN of the queue
    device is assigned.

  * If adapters or domains are dynamically unassigned from the LPAR
    in which the linux guest is running, effective masking will
    prevent access to the AP resources by a guest using them.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 9e61d4c6e6b5..d8da520ae1fa 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -158,6 +158,34 @@ static void vfio_ap_matrix_dev_destroy(void)
 	root_device_unregister(root_device);
 }
 
+static bool vfio_ap_resource_in_use(unsigned long *apm, unsigned long *aqm)
+{
+	bool in_use = false;
+	struct ap_matrix_mdev *matrix_mdev;
+	DECLARE_BITMAP(apm_intrsctn, AP_DEVICES);
+	DECLARE_BITMAP(aqm_intrsctn, AP_DOMAINS);
+
+	mutex_lock(&matrix_dev->lock);
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		bitmap_and(apm_intrsctn, apm, matrix_mdev->matrix.apm,
+			   AP_DEVICES);
+		if (find_first_bit_inv(apm_intrsctn, AP_DEVICES) == AP_DEVICES)
+			continue;
+
+		bitmap_and(aqm_intrsctn, aqm, matrix_mdev->matrix.aqm,
+			   AP_DOMAINS);
+		if (find_first_bit_inv(aqm_intrsctn, AP_DEVICES) == AP_DOMAINS)
+			continue;
+
+		in_use = true;
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return in_use;
+}
+
 static int __init vfio_ap_init(void)
 {
 	int ret;
@@ -173,7 +201,9 @@ static int __init vfio_ap_init(void)
 	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
 	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
 	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.in_use = vfio_ap_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
+	vfio_ap_drv.driver.suppress_bind_attrs = true;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
 	if (ret) {
-- 
2.7.4
