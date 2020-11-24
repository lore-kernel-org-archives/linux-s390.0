Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v12 13/17] s390/vfio-ap: hot plug/unplug queues on bind/unbind of queue device
Date: Tue, 24 Nov 2020 16:40:12 -0500
Message-Id: <20201124214016.3013-14-akrowiak@linux.ibm.com>
In-Reply-To: <20201124214016.3013-1-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@stny.rr.com>

In response to the probe or remove of a queue device, if a KVM guest is
using the matrix mdev to which the APQN of the queue device is assigned,
the vfio_ap device driver must respond accordingly. In an ideal world, the
queue corresponding to the queue device being probed would be hot plugged
into the guest. Likewise, the queue corresponding to the queue device being
removed would be hot unplugged. Unfortunately, the AP architecture
precludes plugging or unplugging individual queues. The queues to which a
guest is granted access are specified as a matrix of adapter and domain
numbers. The Cartesian product of the adapter and domain numbers assigned
to this matrix comprise the AP queue numbers (APQN) to which the guest will
be granted access; therefore, it becomes obvious that assigning a new
adapter or domain number to the matrix may result in multiple APQNs
getting assigned. Likewise, unassigning an adapter or domain number from
the matrix may result in multiple APQNs getting unassigned. Additionally,
in order to enforce the linux device model requirement that a pass-through
device must be bound to the driver facilitating its passthrough, each new
APQN assigned to the guest's matrix must reference a queue device bound to
the vfio_ap device driver. The following sections articulate the design
for this patch.

Probing a queue device:
----------------------
The goal here is to assign the APQN of the queue being probed to the
guest's matrix if possible by adhering to a set of rules:
* The adapter number (APID) will be assigned to the guest matrix iff:
  1. The adapter is in the host's AP configuration
  2. The APID is not yet assigned to the guest's matrix
  3. Each APQN derived from the APID and the domain numbers (APQI) of
     domains already assigned to the guest's matrix references a queue
     device bound to the vfio_ap device driver
* The domain number (APQI) will be assigned to the guest matrix iff:
  1. The domain is in the host's AP configuration
  2. The APQI is not yet assigned to the guest's matrix
  3. Each APQN derived from the APQI and the APIDs of
     adapters already assigned to the guest's matrix references a queue
     device bound to the vfio_ap device driver

Removing a queue device:
-----------------------
Unassigning the adapter number from the guest's matrix will remove access
to all domains on the adapter from the guest. Unassigning the domain
number from the guest's matrix will remove access to that domain on all
adapters assigned to the guest matrix. If both the adapter and domain are
unassigned from the guest's matrix, That will reduce access to every
adapter for the guest. Since an AP adapter card is the actual hardware
device that gets physically plugged/unplugged, unassigning the adapter
number from the guest's matrix makes the most sense here.

Signed-off-by: Tony Krowiak <akrowiak@stny.rr.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4f96b7861607..1179c6af59c6 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1508,6 +1508,23 @@ static void vfio_ap_queue_link_mdev(struct vfio_ap_queue *q)
 	}
 }
 
+
+static void vfio_ap_mdev_hot_plug_queue(struct vfio_ap_queue *q)
+{
+	bool hot_plug = false;
+	unsigned long apid = (unsigned long)AP_QID_CARD(q->apqn);
+	unsigned long apqi = (unsigned long)AP_QID_QUEUE(q->apqn);
+
+	if (q->matrix_mdev == NULL)
+		return;
+
+	hot_plug |= vfio_ap_assign_apid_to_apcb(q->matrix_mdev, apid);
+	hot_plug |= vfio_ap_assign_apqi_to_apcb(q->matrix_mdev, apqi);
+
+	if (hot_plug)
+		vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
+}
+
 /**
  * vfio_ap_mdev_probe_queue:
  *
@@ -1526,11 +1543,30 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	q->apqn = to_ap_queue(&apdev->device)->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
 	vfio_ap_queue_link_mdev(q);
+	vfio_ap_mdev_hot_plug_queue(q);
 	mutex_unlock(&matrix_dev->lock);
 
 	return 0;
 }
 
+static void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
+{
+	unsigned long apid;
+	unsigned long apqi;
+
+	if (q->matrix_mdev == NULL)
+		return;
+
+	apid = AP_QID_CARD(q->apqn);
+	apqi = AP_QID_QUEUE(q->apqn);
+
+	if (test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm) &&
+	    test_bit_inv(apqi, q->matrix_mdev->shadow_apcb.aqm)) {
+		clear_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm);
+		vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
+	}
+}
+
 /**
  * vfio_ap_mdev_remove_queue:
  *
@@ -1544,6 +1580,7 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 
 	mutex_lock(&matrix_dev->lock);
 	q = dev_get_drvdata(&apdev->device);
+	vfio_ap_mdev_hot_unplug_queue(q);
 	dev_set_drvdata(&apdev->device, NULL);
 	apid = AP_QID_CARD(q->apqn);
 	apqi = AP_QID_QUEUE(q->apqn);
-- 
2.21.1
