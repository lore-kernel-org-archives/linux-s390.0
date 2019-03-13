From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v5 5/7] s390: ap: implement PAPQ AQIC interception in kernel
Date: Wed, 13 Mar 2019 17:05:02 +0100
Message-ID: <1552493104-30510-6-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/s390/crypto/vfio_ap_drv.c     |   2 +
 drivers/s390/crypto/vfio_ap_ops.c     | 204 +++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |   6 +
 4 files changed, 210 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index d0059ea..9a4fd96 100644
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
index df6f21a..796e73d4 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -55,6 +55,8 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 		return -ENOMEM;
 	dev_set_drvdata(&apdev->device, q);
 	q->apqn = to_ap_queue(&apdev->device)->qid;
+	q->a_isc = VFIO_AP_ISC_INVALID;
+	q->p_isc = VFIO_AP_ISC_INVALID;
 	INIT_LIST_HEAD(&q->list);
 	mutex_lock(&matrix_dev->lock);
 	list_add(&q->list, &matrix_dev->free_list);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6b559ca..dc3454f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -66,6 +66,194 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 	return -EBUSY;
 }
 
+/**
+ * vfio_ap_free_irq:
+ * @q: The vfio_ap_queue
+ *
+ * Unpin the guest NIB
+ * Unregister the ISC from the GIB alert
+ * Clear the vfio_ap_queue intern fields
+ */
+static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+{
+	if (!q)
+		return;
+	if (q->a_pfn)
+		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->a_pfn, 1);
+	if (q->a_isc != VFIO_AP_ISC_INVALID)
+		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->a_isc);
+	q->a_pfn = 0;
+	q->p_pfn = 0;
+	q->a_isc = VFIO_AP_ISC_INVALID;
+	q->p_isc = VFIO_AP_ISC_INVALID;
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
+
+	status = ap_aqic(q->apqn, aqic_gisa, NULL);
+	if (!status.response_code)
+		vfio_ap_free_irq(q);
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
+	kvm = q->matrix_mdev->kvm;
+	gisa = kvm->arch.gisa_int.origin;
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
+	case AP_RESPONSE_INVALID_GISA:
+		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
+	default:	/* Fall Through */
+		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
+			status.response_code);
+		vfio_ap_free_irq(q);
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
+	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
+				   struct ap_matrix_mdev, pqap_hook);
+	if (!matrix_mdev)
+		goto out_unlock;
+	q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
+	if (!q)
+		goto out_noqueue;
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
+out_noqueue:
+	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
+out_unlock:
+	mutex_unlock(&matrix_dev->lock);
+	return 0;
+}
+
 static void vfio_ap_matrix_init(struct ap_config_info *info,
 				struct ap_matrix *matrix)
 {
@@ -88,8 +276,11 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	}
 
 	INIT_LIST_HEAD(&matrix_mdev->qlist);
+	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	mdev_set_drvdata(mdev, matrix_mdev);
+	matrix_mdev->pqap_hook.hook = handle_pqap;
+	matrix_mdev->pqap_hook.owner = THIS_MODULE;
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -100,11 +291,17 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_queue *q, *qtmp;
 
 	if (matrix_mdev->kvm)
 		return -EBUSY;
 
 	mutex_lock(&matrix_dev->lock);
+	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
+		q->matrix_mdev = NULL;
+		vfio_ap_mdev_reset_queue(q);
+		list_move(&q->list, &matrix_dev->free_list);
+	}
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->lock);
 
@@ -756,7 +953,7 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 	NULL
 };
 
-/**
+ /*
  * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
  *
  * @nb: The notifier block
@@ -776,9 +973,10 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
 
 	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
 		struct vfio_iommu_type1_dma_unmap *unmap = data;
-		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
+		unsigned long pfn = unmap->iova >> PAGE_SHIFT;
 
-		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
+		if (matrix_mdev->mdev)
+			vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &pfn, 1);
 		return NOTIFY_OK;
 	}
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 4a287c8..968d8aa 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -95,6 +95,12 @@ extern void vfio_ap_mdev_unregister(void);
 struct vfio_ap_queue {
 	struct list_head list;
 	struct ap_matrix_mdev *matrix_mdev;
+	unsigned long a_nib;
+	unsigned long a_pfn;
+	unsigned long p_pfn;
 	int	apqn;
+#define VFIO_AP_ISC_INVALID 0xff
+	unsigned char a_isc;
+	unsigned char p_isc;
 };
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
