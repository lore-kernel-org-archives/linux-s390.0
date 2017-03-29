From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/6] virtio: add context flag to find vqs
Date: Wed, 29 Mar 2017 23:48:51 +0300
Message-ID: <1490820507-8005-3-git-send-email-mst@redhat.com>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1490820507-8005-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, John Fastabend <john.fastabend@gmail.com>, Sudeep Dutt <sudeep.dutt@intel.com>, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Allows maintaining extra context per vq.  For ease of use, passing in
NULL is legal and disables the feature for all vqs.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/misc/mic/vop/vop_main.c    |  9 ++++++---
 drivers/s390/virtio/kvm_virtio.c   |  6 ++++--
 drivers/s390/virtio/virtio_ccw.c   |  7 ++++---
 drivers/virtio/virtio_mmio.c       |  8 +++++---
 drivers/virtio/virtio_pci_common.c | 18 +++++++++++-------
 drivers/virtio/virtio_pci_common.h |  4 +++-
 drivers/virtio/virtio_pci_legacy.c |  4 +++-
 drivers/virtio/virtio_pci_modern.c | 12 ++++++++----
 drivers/virtio/virtio_ring.c       |  7 +++++--
 include/linux/virtio_config.h      | 18 +++++++++++++++---
 include/linux/virtio_ring.h        |  3 +++
 11 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index c2e29d7..a341938 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -278,7 +278,7 @@ static void vop_del_vqs(struct virtio_device *dev)
 static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 				     unsigned index,
 				     void (*callback)(struct virtqueue *vq),
-				     const char *name)
+				     const char *name, bool ctx)
 {
 	struct _vop_vdev *vdev = to_vopvdev(dev);
 	struct vop_device *vpdev = vdev->vpdev;
@@ -314,6 +314,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 				le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN,
 				dev,
 				false,
+				ctx,
 				(void __force *)va, vop_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -374,7 +375,8 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
-			const char * const names[], struct irq_affinity *desc)
+			const char * const names[], const bool *ctx,
+			struct irq_affinity *desc)
 {
 	struct _vop_vdev *vdev = to_vopvdev(dev);
 	struct vop_device *vpdev = vdev->vpdev;
@@ -388,7 +390,8 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 	for (i = 0; i < nvqs; ++i) {
 		dev_dbg(_vop_dev(vdev), "%s: %d: %s\n",
 			__func__, i, names[i]);
-		vqs[i] = vop_find_vq(dev, i, callbacks[i], names[i]);
+		vqs[i] = vop_find_vq(dev, i, callbacks[i], names[i],
+				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error;
diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
index 2ce0b3e..81b33aa 100644
--- a/drivers/s390/virtio/kvm_virtio.c
+++ b/drivers/s390/virtio/kvm_virtio.c
@@ -189,7 +189,7 @@ static bool kvm_notify(struct virtqueue *vq)
 static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
 				     unsigned index,
 				     void (*callback)(struct virtqueue *vq),
-				     const char *name)
+				     const char *name, bool ctx)
 {
 	struct kvm_device *kdev = to_kvmdev(vdev);
 	struct kvm_vqconfig *config;
@@ -256,6 +256,7 @@ static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
 			const char * const names[],
+			const bool *ctx,
 			struct irq_affinity *desc)
 {
 	struct kvm_device *kdev = to_kvmdev(vdev);
@@ -266,7 +267,8 @@ static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return -ENOENT;
 
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = kvm_find_vq(vdev, i, callbacks[i], names[i]);
+		vqs[i] = kvm_find_vq(vdev, i, callbacks[i], names[i],
+				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i]))
 			goto error;
 	}
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 0ed209f..2a76ea7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -484,7 +484,7 @@ static void virtio_ccw_del_vqs(struct virtio_device *vdev)
 
 static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 					     int i, vq_callback_t *callback,
-					     const char *name,
+					     const char *name, bool ctx,
 					     struct ccw1 *ccw)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -522,7 +522,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	}
 
 	vq = vring_new_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN, vdev,
-				 true, info->queue, virtio_ccw_kvm_notify,
+				 true, ctx, info->queue, virtio_ccw_kvm_notify,
 				 callback, name);
 	if (!vq) {
 		/* For now, we fail if we can't get the requested size. */
@@ -629,6 +629,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			       struct virtqueue *vqs[],
 			       vq_callback_t *callbacks[],
 			       const char * const names[],
+			       const bool *ctx,
 			       struct irq_affinity *desc)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -642,7 +643,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 
 	for (i = 0; i < nvqs; ++i) {
 		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i], names[i],
-					     ccw);
+					     ctx ? ctx[i] : false, ccw);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
 			vqs[i] = NULL;
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 78343b8..74dc717 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -351,7 +351,7 @@ static void vm_del_vqs(struct virtio_device *vdev)
 
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
-				  const char *name)
+				  const char *name, bool ctx)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtio_mmio_vq_info *info;
@@ -388,7 +388,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 
 	/* Create the vring */
 	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
-				 true, true, vm_notify, callback, name);
+				 true, true, ctx, vm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
@@ -447,6 +447,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
 		       const char * const names[],
+		       const bool *ctx,
 		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
@@ -459,7 +460,8 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return err;
 
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i]);
+		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
+				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
 			return PTR_ERR(vqs[i]);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 5905349..18e74c8 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -143,7 +143,8 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], struct irq_affinity *desc)
+		const char * const names[], const bool *ctx,
+		struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
@@ -225,7 +226,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = VIRTIO_MSI_NO_VECTOR;
 
 		vqs[i] = vp_dev->setup_vq(vp_dev, i, callbacks[i], names[i],
-				msix_vec);
+					  ctx ? ctx[i] : false,
+					  msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_remove_vqs;
@@ -282,7 +284,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 
 static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[])
+		const char * const names[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i, err;
@@ -298,7 +300,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 			continue;
 		}
 		vqs[i] = vp_dev->setup_vq(vp_dev, i, callbacks[i], names[i],
-				VIRTIO_MSI_NO_VECTOR);
+					  ctx ? ctx[i] : false,
+					  VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_remove_vqs;
@@ -316,14 +319,15 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], struct irq_affinity *desc)
+		const char * const names[], const bool *ctx,
+		struct irq_affinity *desc)
 {
 	int err;
 
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 	if (!err)
 		return 0;
-	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names);
+	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
 }
 
 const char *vp_bus_name(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index ac8c9d7..8149dd3 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -77,6 +77,7 @@ struct virtio_pci_device {
 				      unsigned idx,
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name,
+				      bool ctx,
 				      u16 msix_vec);
 	void (*del_vq)(struct virtqueue *vq);
 
@@ -98,7 +99,8 @@ void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], struct irq_affinity *desc);
+		const char * const names[], const bool *ctx,
+		struct irq_affinity *desc);
 const char *vp_bus_name(struct virtio_device *vdev);
 
 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index f7362c5..a976452 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -115,6 +115,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
+				  bool ctx,
 				  u16 msix_vec)
 {
 	struct virtqueue *vq;
@@ -132,7 +133,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	/* create the vring */
 	vq = vring_create_virtqueue(index, num,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
-				    true, false, vp_notify, callback, name);
+				    true, false, ctx,
+				    vp_notify, callback, name);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7bc3004..709f7e2 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -296,6 +296,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
+				  bool ctx,
 				  u16 msix_vec)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
@@ -325,7 +326,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	/* create the vring */
 	vq = vring_create_virtqueue(index, num,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
-				    true, true, vp_notify, callback, name);
+				    true, true, ctx,
+				    vp_notify, callback, name);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
@@ -384,12 +386,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 }
 
 static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], struct irq_affinity *desc)
+			      struct virtqueue *vqs[],
+			      vq_callback_t *callbacks[],
+			      const char * const names[], const bool *ctx,
+			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq;
-	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, desc);
+	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 
 	if (rc)
 		return rc;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 409aeaa..b23b5fa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -916,6 +916,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					struct vring vring,
 					struct virtio_device *vdev,
 					bool weak_barriers,
+					bool context,
 					bool (*notify)(struct virtqueue *),
 					void (*callback)(struct virtqueue *),
 					const char *name)
@@ -1019,6 +1020,7 @@ struct virtqueue *vring_create_virtqueue(
 	struct virtio_device *vdev,
 	bool weak_barriers,
 	bool may_reduce_num,
+	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
 	const char *name)
@@ -1058,7 +1060,7 @@ struct virtqueue *vring_create_virtqueue(
 	queue_size_in_bytes = vring_size(num, vring_align);
 	vring_init(&vring, num, queue, vring_align);
 
-	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers,
+	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				   notify, callback, name);
 	if (!vq) {
 		vring_free_queue(vdev, queue_size_in_bytes, queue,
@@ -1079,6 +1081,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
+				      bool context,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
@@ -1086,7 +1089,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 {
 	struct vring vring;
 	vring_init(&vring, num, pages, vring_align);
-	return __vring_new_virtqueue(index, vring, vdev, weak_barriers,
+	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				     notify, callback, name);
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 47f3d80..0133d8a 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -72,7 +72,8 @@ struct virtio_config_ops {
 	void (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], struct irq_affinity *desc);
+			const char * const names[], const bool *ctx,
+			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
@@ -173,7 +174,8 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 	vq_callback_t *callbacks[] = { c };
 	const char *names[] = { n };
 	struct virtqueue *vq;
-	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL);
+	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL,
+					 NULL);
 	if (err < 0)
 		return ERR_PTR(err);
 	return vq;
@@ -185,7 +187,17 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			const char * const names[],
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
+}
+
+static inline
+int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
+			struct virtqueue *vqs[], vq_callback_t *callbacks[],
+			const char * const names[], const bool *ctx,
+			struct irq_affinity *desc)
+{
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
+				      desc);
 }
 
 /**
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index e8d3693..270cfa8 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -71,6 +71,7 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 					 struct virtio_device *vdev,
 					 bool weak_barriers,
 					 bool may_reduce_num,
+					 bool ctx,
 					 bool (*notify)(struct virtqueue *vq),
 					 void (*callback)(struct virtqueue *vq),
 					 const char *name);
@@ -80,6 +81,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					struct vring vring,
 					struct virtio_device *vdev,
 					bool weak_barriers,
+					bool ctx,
 					bool (*notify)(struct virtqueue *),
 					void (*callback)(struct virtqueue *),
 					const char *name);
@@ -93,6 +95,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
+				      bool ctx,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
-- 
MST
