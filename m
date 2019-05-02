Return-Path: <SRS0=sFCg=TC=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v8 2/4] vfio: ap: register IOMMU VFIO notifier
Date: Thu,  2 May 2019 19:34:09 +0200
In-Reply-To: <1556818451-1806-1-git-send-email-pmorel@linux.ibm.com>
References: <1556818451-1806-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1556818451-1806-3-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

To be able to use the VFIO interface to facilitate the
mediated device memory pinning/unpinning we need to register
a notifier for IOMMU.

While we will start to pin one guest page for the interrupt indicator
byte, this is still ok with ballooning as this page will never be
used by the guest virtio-balloon driver.
So the pinned page will never be freed. And even a broken guest does
so, that would not impact the host as the original page is still
in control by vfio.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 43 ++++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 900b9cf..e8e87bf 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -759,6 +759,35 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	return 0;
 }
 
+/*
+ * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
+ *
+ * @nb: The notifier block
+ * @action: Action to be taken
+ * @data: data associated with the request
+ *
+ * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
+ * pinned before). Other requests are ignored.
+ *
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
 static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 				       unsigned long action, void *data)
 {
@@ -858,7 +887,17 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 		return ret;
 	}
 
-	return 0;
+	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
+	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &matrix_mdev->iommu_notifier);
+	if (!ret)
+		return ret;
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static void vfio_ap_mdev_release(struct mdev_device *mdev)
@@ -869,6 +908,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 
 	vfio_ap_mdev_reset_queues(mdev);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &matrix_mdev->iommu_notifier);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	matrix_mdev->kvm = NULL;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a910be1..18dcc4d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -81,8 +81,10 @@ struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
+	struct notifier_block iommu_notifier;
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
+	struct mdev_device *mdev;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
2.7.4
