Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v7 3/4] s390: ap: implement PAPQ AQIC interception in kernel
Date: Fri, 26 Apr 2019 15:01:27 +0200
In-Reply-To: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

We register the AP PQAP instruction hook during the open
of the mediated device. And unregister it on release.

In the AP PQAP instruction hook, if we receive a demand to
enable IRQs,
- we retrieve the vfio_ap_queue based on the APQN we receive
  in REG1,
- we retrieve the page of the guest address, (NIB), from
  register REG2
- we the mediated device to use the VFIO pinning infratrsucture
  to pin the page of the guest address,
- we retrieve the pointer to KVM to register the guest ISC
  and retrieve the host ISC
- finaly we activate GISA

If we receive a demand to disable IRQs,
- we deactivate GISA
- unregister from the GIB
- unping the NIB

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.h          |   1 +
 drivers/s390/crypto/vfio_ap_drv.c     |  30 +++-
 drivers/s390/crypto/vfio_ap_ops.c     | 293 +++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  11 ++
 4 files changed, 328 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 15a98a6..60e70f3 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -43,6 +43,7 @@ static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
 #define AP_RESPONSE_BUSY		0x05
 #define AP_RESPONSE_INVALID_ADDRESS	0x06
 #define AP_RESPONSE_OTHERWISE_CHANGED	0x07
+#define AP_RESPONSE_INVALID_GISA	0x08
 #define AP_RESPONSE_Q_FULL		0x10
 #define AP_RESPONSE_NO_PENDING_REPLY	0x10
 #define AP_RESPONSE_INDEX_TOO_BIG	0x11
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index e9824c3..ecaa4ab 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2018
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  */
 
 #include <linux/module.h>
@@ -40,14 +41,41 @@ static struct ap_device_id ap_queue_ids[] = {
 
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
+	q->a_isc = VFIO_AP_ISC_INVALID;
+	q->p_isc = VFIO_AP_ISC_INVALID;
 	return 0;
 }
 
+/**
+ * vfio_ap_queue_dev_remove:
+ *
+ * Takes the matrix lock to avoid actions on this device while removing
+ * Free the associated vfio_ap_queue structure
+ */
 static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 {
-	/* Nothing to do yet */
+	struct vfio_ap_queue *q;
+
+	mutex_lock(&matrix_dev->lock);
+	q = dev_get_drvdata(&apdev->device);
+	kfree(q);
+	dev_set_drvdata(&apdev->device, NULL);
+	mutex_unlock(&matrix_dev->lock);
 }
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e8e87bf..c22b996 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -24,6 +24,252 @@
 #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
 #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
 
+static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
+
+static int match_apqn(struct device *dev, void *data)
+{
+	struct vfio_ap_queue *q = dev_get_drvdata(dev);
+
+	return (q->apqn == *(int *)(data)) ? 1 : 0;
+}
+
+/**
+ * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
+ * @matrix_mdev: the associated mediated matrix
+ * @apqn: The queue APQN
+ *
+ * Retrieve a queue with a specific APQN from the list of the
+ * devices of the vfio_ap_drv.
+ * Verify that the APID and the APQI are set in the matrix.
+ *
+ * Returns the pointer to the associated vfio_ap_queue
+ */
+struct vfio_ap_queue *vfio_ap_get_queue(struct ap_matrix_mdev *matrix_mdev,
+					int apqn)
+{
+	struct vfio_ap_queue *q;
+	struct device *dev;
+
+	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
+		return NULL;
+	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
+		return NULL;
+
+	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
+				 &apqn, match_apqn);
+	if (!dev)
+		return NULL;
+	q = dev_get_drvdata(dev);
+	q->matrix_mdev = matrix_mdev;
+	put_device(dev);
+
+	return q;
+}
+
+/**
+ * vfio_ap_free_irq_data:
+ * @q: The vfio_ap_queue
+ *
+ * Unpin the guest NIB
+ * Unregister the ISC from the GIB alert
+ * Clear the vfio_ap_queue intern fields
+ *
+ * Important notice:
+ * Before calling this function, interrupt must have been
+ * unregistered by use of ap_zapq/ap_reset or ap_aqic.
+ */
+static void vfio_ap_free_irq_data(struct vfio_ap_queue *q)
+{
+	if (!q)
+		return;
+
+	if (q->a_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev)
+		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->a_isc);
+	if (q->a_pfn && q->matrix_mdev)
+		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->a_pfn, 1);
+
+	q->a_pfn = 0;
+	q->p_pfn = 0;
+	q->a_isc = VFIO_AP_ISC_INVALID;
+	q->p_isc = VFIO_AP_ISC_INVALID;
+	q->matrix_mdev = NULL;
+}
+
+/**
+ * vfio_ap_clrirq: Disable Interruption for a APQN
+ *
+ * @dev: the device associated with the ap_queue
+ * @q:   the vfio_ap_queue holding AQIC parameters
+ *
+ * Issue the host side PQAP/AQIC
+ * On success: unpin the NIB saved in *q and unregister from GIB
+ * interface
+ *
+ * Return the ap_queue_status returned by the ap_aqic()
+ */
+static struct ap_queue_status vfio_ap_clrirq(struct vfio_ap_queue *q)
+{
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct ap_queue_status status;
+	int checks = 10;
+
+	status = ap_aqic(q->apqn, aqic_gisa, NULL);
+	if (!status.response_code) {
+		while (status.irq_enabled && checks--) {
+			msleep(20);
+			status = ap_tapq(q->apqn, NULL);
+		}
+		if (checks >= 0)
+			vfio_ap_free_irq_data(q);
+		else
+			WARN_ONCE("%s: failed disabling IRQ", __func__);
+	}
+
+	return status;
+}
+
+/**
+ * vfio_ap_setirq: Enable Interruption for a APQN
+ *
+ * @dev: the device associated with the ap_queue
+ * @q:   the vfio_ap_queue holding AQIC parameters
+ *
+ * Pin the NIB saved in *q
+ * Register the guest ISC to GIB interface and retrieve the
+ * host ISC to issue the host side PQAP/AQIC
+ *
+ * Response.status may be set to following Response Code in case of error:
+ * - AP_RESPONSE_INVALID_ADDRESS: vfio_pin_pages failed
+ * - AP_RESPONSE_OTHERWISE_CHANGED: Hypervizor GISA internal error
+ *
+ * Otherwise return the ap_queue_status returned by the ap_aqic()
+ */
+static struct ap_queue_status vfio_ap_setirq(struct vfio_ap_queue *q)
+{
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct ap_queue_status status = {};
+	struct kvm_s390_gisa *gisa;
+	struct kvm *kvm;
+	unsigned long h_nib, h_pfn;
+	int ret;
+
+	q->a_pfn = q->a_nib >> PAGE_SHIFT;
+	ret = vfio_pin_pages(mdev_dev(q->matrix_mdev->mdev), &q->a_pfn, 1,
+			     IOMMU_READ | IOMMU_WRITE, &h_pfn);
+	switch (ret) {
+	case 1:
+		break;
+	case -EINVAL:
+	case -E2BIG:
+		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
+		/* Fallthrough */
+	default:
+		return status;
+	}
+
+	kvm = q->matrix_mdev->kvm;
+	gisa = kvm->arch.gisa_int.origin;
+
+	h_nib = (h_pfn << PAGE_SHIFT) | (q->a_nib & ~PAGE_MASK);
+	aqic_gisa.gisc = q->a_isc;
+	aqic_gisa.isc = kvm_s390_gisc_register(kvm, q->a_isc);
+	aqic_gisa.ir = 1;
+	aqic_gisa.gisa = gisa->next_alert >> 4;
+
+	status = ap_aqic(q->apqn, aqic_gisa, (void *)h_nib);
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+		/* See if we did clear older IRQ configuration */
+		if (q->p_pfn)
+			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
+					 &q->p_pfn, 1);
+		if (q->p_isc != VFIO_AP_ISC_INVALID)
+			kvm_s390_gisc_unregister(kvm, q->p_isc);
+		q->p_pfn = q->a_pfn;
+		q->p_isc = q->a_isc;
+		break;
+	case AP_RESPONSE_OTHERWISE_CHANGED:
+		/* We could not modify IRQ setings: clear new configuration */
+		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->a_pfn, 1);
+		kvm_s390_gisc_unregister(kvm, q->a_isc);
+		break;
+	default:	/* Fall Through */
+		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
+			status.response_code);
+		vfio_ap_free_irq_data(q);
+		break;
+	}
+
+	return status;
+}
+
+/**
+ * handle_pqap: PQAP instruction callback
+ *
+ * @vcpu: The vcpu on which we received the PQAP instruction
+ *
+ * Get the general register contents to initialize internal variables.
+ * REG[0]: APQN
+ * REG[1]: IR and ISC
+ * REG[2]: NIB
+ *
+ * Response.status may be set to following Response Code:
+ * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
+ * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
+ * - AP_RESPONSE_NORMAL (0) : in case of successs
+ *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
+ * We take the matrix_dev lock to ensure serialization on queues and
+ * mediated device access.
+ *
+ * Return 0 if we could handle the request inside KVM.
+ * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
+ */
+static int handle_pqap(struct kvm_vcpu *vcpu)
+{
+	uint64_t status;
+	uint16_t apqn;
+	struct vfio_ap_queue *q;
+	struct ap_queue_status qstatus = {
+			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
+	struct ap_matrix_mdev *matrix_mdev;
+
+	/* If we do not use the AIV facility just go to userland */
+	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
+		return -EOPNOTSUPP;
+
+	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
+	mutex_lock(&matrix_dev->lock);
+
+	if (!vcpu->kvm->arch.crypto.pqap_hook)
+		goto out_unlock;
+	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
+				   struct ap_matrix_mdev, pqap_hook);
+
+	q = vfio_ap_get_queue(matrix_mdev, apqn);
+	if (!q)
+		goto out_unlock;
+
+	status = vcpu->run->s.regs.gprs[1];
+
+	/* If IR bit(16) is set we enable the interrupt */
+	if ((status >> (63 - 16)) & 0x01) {
+		q->a_isc = status & 0x07;
+		q->a_nib = vcpu->run->s.regs.gprs[2];
+		qstatus = vfio_ap_setirq(q);
+		if (qstatus.response_code) {
+			q->a_nib = 0;
+			q->a_isc = VFIO_AP_ISC_INVALID;
+		}
+	} else
+		qstatus = vfio_ap_clrirq(q);
+
+out_unlock:
+	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
+	vcpu->run->s.regs.gprs[1] >>= 32;
+	mutex_unlock(&matrix_dev->lock);
+	return 0;
+}
+
 static void vfio_ap_matrix_init(struct ap_config_info *info,
 				struct ap_matrix *matrix)
 {
@@ -45,8 +291,11 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 		return -ENOMEM;
 	}
 
+	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	mdev_set_drvdata(mdev, matrix_mdev);
+	matrix_mdev->pqap_hook.hook = handle_pqap;
+	matrix_mdev->pqap_hook.owner = THIS_MODULE;
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -62,6 +311,7 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 		return -EBUSY;
 
 	mutex_lock(&matrix_dev->lock);
+	vfio_ap_mdev_reset_queues(mdev);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->lock);
 
@@ -754,6 +1004,8 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	}
 
 	matrix_mdev->kvm = kvm;
+	kvm_get_kvm(kvm);
+	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 	mutex_unlock(&matrix_dev->lock);
 
 	return 0;
@@ -819,15 +1071,37 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
-				    unsigned int retry)
+void vfio_ap_free_irq_data_apqn(int apqn)
+{
+	struct device *dev;
+	struct vfio_ap_queue *q;
+
+	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
+				 &apqn, match_apqn);
+	if (dev) {
+		q = dev_get_drvdata(dev);
+		vfio_ap_free_irq_data(q);
+		put_device(dev);
+	}
+}
+
+int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
+			     unsigned int retry)
 {
 	struct ap_queue_status status;
+	int retry2 = 2;
+	int apqn = AP_MKQID(apid, apqi);
 
 	do {
-		status = ap_zapq(AP_MKQID(apid, apqi));
+		status = ap_zapq(apqn);
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
+			while (!status.queue_empty && retry2--) {
+				msleep(20);
+				status = ap_tapq(apqn, NULL);
+			}
+			WARN_ON_ONCE(retry <= 0);
+			vfio_ap_free_irq_data_apqn(apqn);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
@@ -904,15 +1178,20 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	if (matrix_mdev->kvm)
+	mutex_lock(&matrix_dev->lock);
+	if (matrix_mdev->kvm) {
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+		vfio_ap_mdev_reset_queues(mdev);
+		kvm_put_kvm(matrix_mdev->kvm);
+		matrix_mdev->kvm = NULL;
+	}
+	mutex_unlock(&matrix_dev->lock);
 
-	vfio_ap_mdev_reset_queues(mdev);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &matrix_mdev->iommu_notifier);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
-	matrix_mdev->kvm = NULL;
 	module_put(THIS_MODULE);
 }
 
@@ -941,6 +1220,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 {
 	int ret;
 
+	mutex_lock(&matrix_dev->lock);
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
@@ -952,6 +1232,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 		ret = -EOPNOTSUPP;
 		break;
 	}
+	mutex_unlock(&matrix_dev->lock);
 
 	return ret;
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 18dcc4d..7cc02ff 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -4,6 +4,7 @@
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
  *	      Halil Pasic <pasic@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  *
  * Copyright IBM Corp. 2018
  */
@@ -90,4 +91,14 @@ struct ap_matrix_mdev {
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+struct vfio_ap_queue {
+	struct ap_matrix_mdev *matrix_mdev;
+	unsigned long a_nib;
+	unsigned long a_pfn;
+	unsigned long p_pfn;
+	int	apqn;
+#define VFIO_AP_ISC_INVALID 0xff
+	unsigned char a_isc;
+	unsigned char p_isc;
+};
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
