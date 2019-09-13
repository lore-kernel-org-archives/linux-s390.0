Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387637AbfIMV1M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Sep 2019 17:27:12 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v6 08/10] s390: vfio-ap: implement in-use callback for vfio_ap driver
Date: Fri, 13 Sep 2019 17:26:56 -0400
Message-Id: <1568410018-10833-9-git-send-email-akrowiak@linux.ibm.com>
In-Reply-To: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

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
 drivers/s390/crypto/vfio_ap_drv.c     |  2 ++
 drivers/s390/crypto/vfio_ap_ops.c     | 11 +++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 9e61d4c6e6b5..477218e39289 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -173,7 +173,9 @@ static int __init vfio_ap_init(void)
 	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
 	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
 	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
+	vfio_ap_drv.driver.suppress_bind_attrs = true;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
 	if (ret) {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index f3332424670f..d06fd9f0db23 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1431,3 +1431,14 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
 	vfio_ap_irq_disable(q);
 	kfree(q);
 }
+
+bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
+{
+	bool in_use;
+
+	mutex_lock(&matrix_dev->lock);
+	in_use = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm) ? true : false;
+	mutex_unlock(&matrix_dev->lock);
+
+	return in_use;
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 4a4e2c11fdf2..21546bb90240 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -104,4 +104,6 @@ struct vfio_ap_queue {
 int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
 void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
 
+bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
