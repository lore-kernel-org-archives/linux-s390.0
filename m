From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v5 2/7] s390: ap: new vfio_ap_queue structure
Date: Wed, 13 Mar 2019 17:04:59 +0100
Message-ID: <1552493104-30510-3-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
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
during assign_adapter or assign_domain,
the vfio_ap_queue device is linked to this matrix mediated device
and unlinked when dissociated.

Queuing the devices on a list of free devices and testing the
matrix_mdev pointer to the associated matrix allow us to know
if the queue is associated to the matrix device and associated
or not to a mediated device.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |  31 ++-
 drivers/s390/crypto/vfio_ap_ops.c     | 390 +++++++++++++++++-----------------
 drivers/s390/crypto/vfio_ap_private.h |   7 +
 3 files changed, 234 insertions(+), 194 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index e9824c3..df6f21a 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -40,14 +40,42 @@ static struct ap_device_id ap_queue_ids[] = {
 
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
+	mutex_lock(&matrix_dev->lock);
+	list_add(&q->list, &matrix_dev->free_list);
+	mutex_unlock(&matrix_dev->lock);
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
+	mutex_lock(&matrix_dev->lock);
+	list_del(&q->list);
+	mutex_unlock(&matrix_dev->lock);
+	kfree(q);
 }
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
@@ -107,6 +135,7 @@ static int vfio_ap_matrix_dev_create(void)
 	matrix_dev->device.bus = &matrix_bus;
 	matrix_dev->device.release = vfio_ap_matrix_dev_release;
 	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
+	INIT_LIST_HEAD(&matrix_dev->free_list);
 
 	ret = device_register(&matrix_dev->device);
 	if (ret)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 900b9cf..485595c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -24,6 +24,48 @@
 #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
 #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
 
+/**
+ * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
+ * @apqn: The queue APQN
+ *
+ * Retrieve a queue with a specific APQN from the list of the
+ * devices associated with a list.
+ *
+ * Returns the pointer to the associated vfio_ap_queue
+ */
+struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
+{
+	struct vfio_ap_queue *q;
+
+	list_for_each_entry(q, l, list)
+		if (q->apqn == apqn)
+			return q;
+	return NULL;
+}
+
+static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
+{
+	struct ap_queue_status status;
+	int retry = 1;
+
+	do {
+		status = ap_zapq(q->apqn);
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			return 0;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			/* things are really broken, give up */
+			return -EIO;
+		}
+	} while (retry--);
+
+	return -EBUSY;
+}
+
 static void vfio_ap_matrix_init(struct ap_config_info *info,
 				struct ap_matrix *matrix)
 {
@@ -45,6 +87,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&matrix_mdev->qlist);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	mutex_lock(&matrix_dev->lock);
@@ -113,162 +156,178 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
 	NULL,
 };
 
-struct vfio_ap_queue_reserved {
-	unsigned long *apid;
-	unsigned long *apqi;
-	bool reserved;
-};
+static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_queue *q;
+
+	q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
+	if (!q)
+		return;
+	q->matrix_mdev = NULL;
+	vfio_ap_mdev_reset_queue(q);
+	list_move(&q->list, &matrix_dev->free_list);
+}
 
 /**
- * vfio_ap_has_queue
- *
- * @dev: an AP queue device
- * @data: a struct vfio_ap_queue_reserved reference
- *
- * Flags whether the AP queue device (@dev) has a queue ID containing the APQN,
- * apid or apqi specified in @data:
- *
- * - If @data contains both an apid and apqi value, then @data will be flagged
- *   as reserved if the APID and APQI fields for the AP queue device matches
+ * vfio_ap_put_all_domains:
  *
- * - If @data contains only an apid value, @data will be flagged as
- *   reserved if the APID field in the AP queue device matches
+ * @matrix_mdev: the matrix mediated device for which we want to associate
+ *		 all available queues with a given apqi.
+ * @apid:	 The apid which associated with all defined APQI of the
+ *		 mediated device will define a AP queue.
  *
- * - If @data contains only an apqi value, @data will be flagged as
- *   reserved if the APQI field in the AP queue device matches
- *
- * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
- * @data does not contain either an apid or apqi.
+ * We remove the queue from the list of queues associated with the
+ * mediated device and put them back to the free list of the matrix
+ * device and clear the matrix_mdev pointer.
  */
-static int vfio_ap_has_queue(struct device *dev, void *data)
+static void vfio_ap_put_all_domains(struct ap_matrix_mdev *matrix_mdev,
+				    int apid)
 {
-	struct vfio_ap_queue_reserved *qres = data;
-	struct ap_queue *ap_queue = to_ap_queue(dev);
-	ap_qid_t qid;
-	unsigned long id;
+	int apqi, apqn;
 
-	if (qres->apid && qres->apqi) {
-		qid = AP_MKQID(*qres->apid, *qres->apqi);
-		if (qid == ap_queue->qid)
-			qres->reserved = true;
-	} else if (qres->apid && !qres->apqi) {
-		id = AP_QID_CARD(ap_queue->qid);
-		if (id == *qres->apid)
-			qres->reserved = true;
-	} else if (!qres->apid && qres->apqi) {
-		id = AP_QID_QUEUE(ap_queue->qid);
-		if (id == *qres->apqi)
-			qres->reserved = true;
-	} else {
-		return -EINVAL;
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
+		apqn = AP_MKQID(apid, apqi);
+		vfio_ap_free_queue(apqn, matrix_mdev);
 	}
-
-	return 0;
 }
 
 /**
- * vfio_ap_verify_queue_reserved
- *
- * @matrix_dev: a mediated matrix device
- * @apid: an AP adapter ID
- * @apqi: an AP queue index
- *
- * Verifies that the AP queue with @apid/@apqi is reserved by the VFIO AP device
- * driver according to the following rules:
- *
- * - If both @apid and @apqi are not NULL, then there must be an AP queue
- *   device bound to the vfio_ap driver with the APQN identified by @apid and
- *   @apqi
+ * vfio_ap_put_all_cards:
  *
- * - If only @apid is not NULL, then there must be an AP queue device bound
- *   to the vfio_ap driver with an APQN containing @apid
+ * @matrix_mdev: the matrix mediated device for which we want to associate
+ *		 all available queues with a given apqi.
+ * @apqi:	 The apqi which associated with all defined APID of the
+ *		 mediated device will define a AP queue.
  *
- * - If only @apqi is not NULL, then there must be an AP queue device bound
- *   to the vfio_ap driver with an APQN containing @apqi
- *
- * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
+ * We remove the queue from the list of queues associated with the
+ * mediated device and put them back to the free list of the matrix
+ * device and clear the matrix_mdev pointer.
  */
-static int vfio_ap_verify_queue_reserved(unsigned long *apid,
-					 unsigned long *apqi)
+static void vfio_ap_put_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)
 {
-	int ret;
-	struct vfio_ap_queue_reserved qres;
+	int apid, apqn;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		apqn = AP_MKQID(apid, apqi);
+		vfio_ap_free_queue(apqn, matrix_mdev);
+	}
+}
 
-	qres.apid = apid;
-	qres.apqi = apqi;
-	qres.reserved = false;
+static void move_and_set(struct list_head *src, struct list_head *dst,
+			 struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_queue *q, *qtmp;
 
-	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
-				     &qres, vfio_ap_has_queue);
-	if (ret)
-		return ret;
+	list_for_each_entry_safe(q, qtmp, src, list) {
+		list_move(&q->list, dst);
+		q->matrix_mdev = matrix_mdev;
+	}
+}
 
-	if (qres.reserved)
-		return 0;
+static int vfio_ap_queue_match(struct device *dev, void *data)
+{
+	struct ap_queue *ap;
 
-	return -EADDRNOTAVAIL;
+	ap = to_ap_queue(dev);
+	return ap->qid == *(int *)data;
 }
 
-static int
-vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
-					     unsigned long apid)
+static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
 {
-	int ret;
-	unsigned long apqi;
-	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
+	struct device *dev;
 
-	if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
-		return vfio_ap_verify_queue_reserved(&apid, NULL);
+	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
+				 &apqn, vfio_ap_queue_match);
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
 
-	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
-		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
-		if (ret)
-			return ret;
+/**
+ * vfio_ap_get_all_domains:
+ *
+ * @matrix_mdev: the matrix mediated device for which we want to associate
+ *		 all available queues with a given apqi.
+ * @apqi:	 The apqi which associated with all defined APID of the
+ *		 mediated device will define a AP queue.
+ *
+ * We define a local list to put all queues we find on the matrix driver
+ * device list when associating the apqi with all already defined apid for
+ * this matrix mediated device.
+ *
+ * If we can get all the devices we roll them to the mediated device list
+ * If we get errors we unroll them to the free list.
+ */
+static int vfio_ap_get_all_domains(struct ap_matrix_mdev *matrix_mdev, int apid)
+{
+	int apqi, apqn;
+	int ret = 0;
+	struct vfio_ap_queue *q;
+	struct list_head q_list;
+
+	INIT_LIST_HEAD(&q_list);
+
+	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
+		apqn = AP_MKQID(apid, apqi);
+		q = vfio_ap_find_queue(apqn);
+		if (!q) {
+			ret = -EADDRNOTAVAIL;
+			goto rewind;
+		}
+		if (q->matrix_mdev) {
+			ret = -EADDRINUSE;
+			goto rewind;
+		}
+		list_move(&q->list, &q_list);
 	}
-
+	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);
 	return 0;
+rewind:
+	move_and_set(&q_list, &matrix_dev->free_list, NULL);
+	return ret;
 }
-
 /**
- * vfio_ap_mdev_verify_no_sharing
+ * vfio_ap_get_all_cards:
  *
- * Verifies that the APQNs derived from the cross product of the AP adapter IDs
- * and AP queue indexes comprising the AP matrix are not configured for another
- * mediated device. AP queue sharing is not allowed.
+ * @matrix_mdev: the matrix mediated device for which we want to associate
+ *		 all available queues with a given apqi.
+ * @apqi:	 The apqi which associated with all defined APID of the
+ *		 mediated device will define a AP queue.
  *
- * @matrix_mdev: the mediated matrix device
+ * We define a local list to put all queues we find on the matrix device
+ * free list when associating the apqi with all already defined apid for
+ * this matrix mediated device.
  *
- * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
+ * If we can get all the devices we roll them to the mediated device list
+ * If we get errors we unroll them to the free list.
  */
-static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
+static int vfio_ap_get_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)
 {
-	struct ap_matrix_mdev *lstdev;
-	DECLARE_BITMAP(apm, AP_DEVICES);
-	DECLARE_BITMAP(aqm, AP_DOMAINS);
-
-	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
-		if (matrix_mdev == lstdev)
-			continue;
-
-		memset(apm, 0, sizeof(apm));
-		memset(aqm, 0, sizeof(aqm));
-
-		/*
-		 * We work on full longs, as we can only exclude the leftover
-		 * bits in non-inverse order. The leftover is all zeros.
-		 */
-		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
-				lstdev->matrix.apm, AP_DEVICES))
-			continue;
-
-		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
-				lstdev->matrix.aqm, AP_DOMAINS))
-			continue;
-
-		return -EADDRINUSE;
+	int apid, apqn;
+	int ret = 0;
+	struct vfio_ap_queue *q;
+	struct list_head q_list;
+	struct ap_matrix_mdev *tmp = NULL;
+
+	INIT_LIST_HEAD(&q_list);
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		apqn = AP_MKQID(apid, apqi);
+		q = vfio_ap_find_queue(apqn);
+		if (!q) {
+			ret = -EADDRNOTAVAIL;
+			goto rewind;
+		}
+		if (q->matrix_mdev) {
+			ret = -EADDRINUSE;
+			goto rewind;
+		}
+		list_move(&q->list, &q_list);
 	}
-
+	tmp = matrix_mdev;
+	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);
 	return 0;
+rewind:
+	move_and_set(&q_list, &matrix_dev->free_list, NULL);
+	return ret;
 }
 
 /**
@@ -330,21 +389,15 @@ static ssize_t assign_adapter_store(struct device *dev,
 	 */
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
+	ret = vfio_ap_get_all_domains(matrix_mdev, apid);
 	if (ret)
 		goto done;
 
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 
-	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
-	if (ret)
-		goto share_err;
-
 	ret = count;
 	goto done;
 
-share_err:
-	clear_bit_inv(apid, matrix_mdev->matrix.apm);
 done:
 	mutex_unlock(&matrix_dev->lock);
 
@@ -391,32 +444,13 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	vfio_ap_put_all_domains(matrix_mdev, apid);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
 }
 static DEVICE_ATTR_WO(unassign_adapter);
 
-static int
-vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
-					     unsigned long apqi)
-{
-	int ret;
-	unsigned long apid;
-	unsigned long nbits = matrix_mdev->matrix.apm_max + 1;
-
-	if (find_first_bit_inv(matrix_mdev->matrix.apm, nbits) >= nbits)
-		return vfio_ap_verify_queue_reserved(NULL, &apqi);
-
-	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, nbits) {
-		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * assign_domain_store
  *
@@ -471,21 +505,15 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, apqi);
+	ret = vfio_ap_get_all_cards(matrix_mdev, apqi);
 	if (ret)
 		goto done;
 
 	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
 
-	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
-	if (ret)
-		goto share_err;
-
 	ret = count;
 	goto done;
 
-share_err:
-	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
 done:
 	mutex_unlock(&matrix_dev->lock);
 
@@ -533,6 +561,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	vfio_ap_put_all_cards(matrix_mdev, apqi);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -790,49 +819,22 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
-				    unsigned int retry)
-{
-	struct ap_queue_status status;
-
-	do {
-		status = ap_zapq(AP_MKQID(apid, apqi));
-		switch (status.response_code) {
-		case AP_RESPONSE_NORMAL:
-			return 0;
-		case AP_RESPONSE_RESET_IN_PROGRESS:
-		case AP_RESPONSE_BUSY:
-			msleep(20);
-			break;
-		default:
-			/* things are really broken, give up */
-			return -EIO;
-		}
-	} while (retry--);
-
-	return -EBUSY;
-}
-
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 {
 	int ret;
 	int rc = 0;
-	unsigned long apid, apqi;
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_queue *q;
 
-	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
-			     matrix_mdev->matrix.apm_max + 1) {
-		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
-				     matrix_mdev->matrix.aqm_max + 1) {
-			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
-			/*
-			 * Regardless whether a queue turns out to be busy, or
-			 * is not operational, we need to continue resetting
-			 * the remaining queues.
-			 */
-			if (ret)
-				rc = ret;
-		}
+	list_for_each_entry(q, &matrix_mdev->qlist, list) {
+		ret = vfio_ap_mdev_reset_queue(q);
+		/*
+		 * Regardless whether a queue turns out to be busy, or
+		 * is not operational, we need to continue resetting
+		 * the remaining queues but notice the last error code.
+		 */
+		if (ret)
+			rc = ret;
 	}
 
 	return rc;
@@ -868,10 +870,10 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	if (matrix_mdev->kvm)
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 
+	matrix_mdev->kvm = NULL;
 	vfio_ap_mdev_reset_queues(mdev);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
-	matrix_mdev->kvm = NULL;
 	module_put(THIS_MODULE);
 }
 
@@ -905,7 +907,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
 	case VFIO_DEVICE_RESET:
+		mutex_lock(&matrix_dev->lock);
 		ret = vfio_ap_mdev_reset_queues(mdev);
+		mutex_unlock(&matrix_dev->lock);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a910be1..3e6940c 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -40,6 +40,7 @@ struct ap_matrix_dev {
 	atomic_t available_instances;
 	struct ap_config_info info;
 	struct list_head mdev_list;
+	struct list_head free_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
 };
@@ -83,9 +84,15 @@ struct ap_matrix_mdev {
 	struct notifier_block group_notifier;
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
+	struct list_head qlist;
 };
 
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+struct vfio_ap_queue {
+	struct list_head list;
+	struct ap_matrix_mdev *matrix_mdev;
+	int	apqn;
+};
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
