From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 3/9] s390: ap: new vfio_ap_queue structure
Date: Thu, 14 Feb 2019 14:51:03 +0100
Message-ID: <1550152269-6317-4-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The AP interruptions are assigned on a queue basis
and we need some information neloging to the queue
to handle interuptions.

We add a new structure vfio_ap_queue, to hold per
queue information useful to handle interruptions.

- apqn: AP queue number (defined here)
- isc : Interrupt subclass (defined later)
- nib : notification information byte (defined later)

The vfio_ap_queue structure is allocated when the vfio_ap_driver
is probed and added as driver data to the ap_queue device.
It is free on remove.

The structure is linked to the matrix_dev host device.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 23 ++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 1fd5fe6..03153e6 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -46,14 +46,35 @@ static struct ap_device_id ap_queue_ids[] = {
 
 MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
 
+/**
+ * vfio_ap_queue_dev_probe:
+ *
+ * Allocate a vfio_ap_queue structure and associate it
+ * with the device as driver_data.
+ */
 static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 {
+	struct vfio_ap_queue *q;
+
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+	dev_set_drvdata(&apdev->device, q);
+	q->apqn = to_ap_queue(&apdev->device)->qid;
 	return 0;
 }
 
+/**
+ * vfio_ap_queue_dev_remove:
+ *
+ * Free the associated vfio_ap_queue structure
+ */
 static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 {
-	/* Nothing to do yet */
+	struct vfio_ap_queue *q;
+
+	q = dev_get_drvdata(&apdev->device);
+	kfree(q);
 }
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 76b7f98..8836f01 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -86,4 +86,7 @@ struct ap_matrix_mdev {
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+struct vfio_ap_queue {
+	int	apqn;
+};
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
