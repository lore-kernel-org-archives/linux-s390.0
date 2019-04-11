Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 2/7] s390: vfio-ap: implement in-use callback for vfio_ap driver
Date: Thu, 11 Apr 2019 17:03:19 -0400
In-Reply-To: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1555016604-2008-3-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Let's implement the callback to indicate when an APQN
is in use by the vfio_ap device driver. The callback is
invoked whenever a change to the apmask or aqmask may
result in one or APQNs being removed from the driver. The
vfio_ap device driver will indicate a resource is in use
if any of the removed APQNs are assigned to any of the matrix
mdev devices.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index e9824c35c34f..f340a28c1d65 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -139,6 +139,28 @@ static void vfio_ap_matrix_dev_destroy(void)
 	root_device_unregister(root_device);
 }
 
+static bool vfio_ap_resource_in_use(unsigned long *apm, unsigned long *aqm)
+{
+	bool in_use = false;
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->lock);
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (bitmap_intersects(matrix_mdev->matrix.apm,
+				      apm, AP_DEVICES) &&
+		    bitmap_intersects(matrix_mdev->matrix.aqm,
+				      aqm, AP_DOMAINS)) {
+			in_use = true;
+			break;
+		}
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
@@ -154,6 +176,7 @@ static int __init vfio_ap_init(void)
 	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
 	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
 	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.in_use = vfio_ap_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
-- 
2.7.4
