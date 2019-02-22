From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v4 2/7] s390: ap: new vfio_ap_queue structure
Date: Fri, 22 Feb 2019 16:29:55 +0100
Message-ID: <1550849400-27152-3-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The AP interruptions are assigned on a queue basis and
the GISA structure is handled on a VM basis, so that
we need to add a structure we can retrieve from both side
holding the information we need to handle PQAP/AQIC interception
and setup the GISA.

Since we can not add more information to the ap_device
we add a new structure vfio_ap_queue, to hold per queue
information useful to handle interruptions and set it as
driver's data of the standard ap_queue device.

Usually, the device and the mediated device are linked together
but in the vfio_ap driver design we have a bunch of "sub" devices
(the ap_queue devices) belonging to the mediated device.

Linking these structure to the mediated device it is assigned to,
with the help of the vfio_ap_queue structure will help us to
retrieve the AP devices associated with the mediated devices
during the mediated device operations.

------------    -------------
| AP queue |--> | AP_vfio_q |<----
------------    ------^------    |    ---------------
                      |          <--->| matrix_mdev |
------------    ------v------    |    ---------------
| AP queue |--> | AP_vfio_q |-----
------------    -------------

The vfio_ap_queue device will hold the following entries:
- apqn: AP queue number (defined here)
- isc : Interrupt subclass (defined later)
- nib : notification information byte (defined later)
- list: a list_head entry allowing to link this structure to a
	matrix mediated device it is assigned to.

The vfio_ap_queue structure is allocated when the vfio_ap_driver
is probed and added as driver data to the ap_queue device.
It is free on remove.

The structure is linked to the matrix_dev host device at the
probe of the device building some kind of free list for the
matrix mediated devices.

When the vfio_queue is associated to a matrix mediated device,
the vfio_ap_queue device is linked to this matrix mediated device
and unlinked when dissociated.

This patch and the 3 next can be squashed together on the
final release of this series.
until then I separate them to ease the review.

So please do not complain about unused functions or about
squashing the patches together, this will be resolved during
the last iteration.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 27 ++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  9 +++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index e9824c3..eca0ffc 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -40,14 +40,38 @@ static struct ap_device_id ap_queue_ids[] = {
 
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
+	INIT_LIST_HEAD(&q->list);
+	list_add(&q->list, &matrix_dev->free_list);
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
+	list_del(&q->list);
+	kfree(q);
 }
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
@@ -107,6 +131,7 @@ static int vfio_ap_matrix_dev_create(void)
 	matrix_dev->device.bus = &matrix_bus;
 	matrix_dev->device.release = vfio_ap_matrix_dev_release;
 	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
+	INIT_LIST_HEAD(&matrix_dev->free_list);
 
 	ret = device_register(&matrix_dev->device);
 	if (ret)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 76b7f98..2760178 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -39,6 +39,7 @@ struct ap_matrix_dev {
 	atomic_t available_instances;
 	struct ap_config_info info;
 	struct list_head mdev_list;
+	struct list_head free_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
 };
@@ -81,9 +82,17 @@ struct ap_matrix_mdev {
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct kvm *kvm;
+	struct list_head qlist;
 };
 
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+struct vfio_ap_queue {
+	struct list_head list;
+	struct ap_matrix_mdev *matrix_mdev;
+	unsigned long nib;
+	int	apqn;
+	unsigned char isc;
+};
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
