From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
Date: Thu, 14 Feb 2019 14:51:06 +0100
Message-ID: <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

To be able to use the VFIO interface to facilitate the
mediated device memory pining/unpining we need to register
a notifier for IOMMU.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 64 +++++++++++++++++++++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1851b24..6eddc2c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -781,6 +781,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 };
 
 /**
+ * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
+ *
+ * @nb: The notifier block
+ * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)
+ * @data: the specific unmap structure for vfio_iommu_type1
+ *
+ * Unpins the guest IOVA. (The NIB guest address we pinned before).
+ * Return NOTIFY_OK after unpining on a UNMAP request.
+ * otherwise, returns NOTIFY_DONE .
+ */
+static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
+
+	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
+		struct vfio_iommu_type1_dma_unmap *unmap = data;
+		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
+
+		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+
+/**
  * vfio_ap_mdev_set_kvm
  *
  * @matrix_mdev: a mediated matrix device
@@ -904,8 +934,7 @@ static void vfio_ap_dissociate_queues(struct ap_matrix_mdev *matrix_mdev)
  * In the case a queue could not be found return -ENODEV.
  * Otherwise return 0.
  */
-static __attribute__((unused))
-	int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
+static int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
 {
 	unsigned long apid, apqi;
 	struct vfio_ap_queue *q;
@@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 
 	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				     &events, &matrix_mdev->group_notifier);
-	if (ret) {
-		module_put(THIS_MODULE);
-		return ret;
-	}
+	if (ret)
+		goto err_group;
+
+	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
+	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &matrix_mdev->iommu_notifier);
+	if (ret)
+		goto err_iommu;
+
+	ret = vfio_ap_associate_queues(matrix_mdev);
+	if (ret)
+		goto err_associate;
 
 	return 0;
+
+err_associate:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &matrix_mdev->iommu_notifier);
+err_iommu:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+err_group:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static void vfio_ap_mdev_release(struct mdev_device *mdev)
@@ -985,6 +1034,9 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	vfio_ap_mdev_reset_queues(mdev);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &matrix_mdev->iommu_notifier);
+	vfio_ap_dissociate_queues(matrix_mdev);
 	matrix_mdev->kvm = NULL;
 	module_put(THIS_MODULE);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 10bc8b5..2781720 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -80,7 +80,9 @@ struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
+	struct notifier_block iommu_notifier;
 	struct kvm *kvm;
+	struct mdev_device *mdev;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
2.7.4
