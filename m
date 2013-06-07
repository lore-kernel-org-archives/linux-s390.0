From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 2/2] KVM: s390: virtio-ccw adapter interrupt support.
Date: Fri,  7 Jun 2013 12:37:11 +0200
Message-ID: <1370601431-46381-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1370601431-46381-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1370601431-46381-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Implement the new CCW_CMD_SET_IND_ADAPTER command and try to enable
adapter interrupts for every device on the first startup. If the host
does not support adapter interrupts, fall back to normal I/O interrupts.

virtio-ccw adapter interrupts use the same isc as normal I/O subchannels
and share a summary indicator for all devices sharing the same indicator
area.

Indicator bits for the individual virtqueues may be contained in the same
indicator area for different devices.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/irq.h   |   1 +
 arch/s390/kernel/irq.c        |   1 +
 drivers/s390/kvm/virtio_ccw.c | 296 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 289 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
index 87c17bf..ba75d32 100644
--- a/arch/s390/include/asm/irq.h
+++ b/arch/s390/include/asm/irq.h
@@ -42,6 +42,7 @@ enum interruption_class {
 	IRQIO_PCI,
 	IRQIO_MSI,
 	IRQIO_VIR,
+	IRQIO_VAI,
 	NMI_NMI,
 	CPU_RST,
 	NR_ARCH_IRQS
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index f7fb589..39237cc 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -82,6 +82,7 @@ static const struct irq_class irqclass_sub_desc[NR_ARCH_IRQS] = {
 	[IRQIO_PCI]  = {.name = "PCI", .desc = "[I/O] PCI Interrupt" },
 	[IRQIO_MSI]  = {.name = "MSI", .desc = "[I/O] MSI Interrupt" },
 	[IRQIO_VIR]  = {.name = "VIR", .desc = "[I/O] Virtual I/O Devices"},
+	[IRQIO_VAI]  = {.name = "VAI", .desc = "[I/O] Virtual I/O Devices AI"},
 	[NMI_NMI]    = {.name = "NMI", .desc = "[NMI] Machine Check"},
 	[CPU_RST]    = {.name = "RST", .desc = "[CPU] CPU Restart"},
 };
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index d6c7aba..be15b6b 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -32,6 +32,8 @@
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
 #include <asm/virtio-ccw.h>
+#include <asm/isc.h>
+#include <asm/airq.h>
 
 /*
  * virtio related functions
@@ -58,6 +60,8 @@ struct virtio_ccw_device {
 	unsigned long indicators;
 	unsigned long indicators2;
 	struct vq_config_block *config_block;
+	bool is_thinint;
+	void *airq_info;
 };
 
 struct vq_info_block {
@@ -72,15 +76,42 @@ struct virtio_feature_desc {
 	__u8 index;
 } __packed;
 
+struct virtio_thinint_area {
+	unsigned long summary_indicator;
+	unsigned long indicator;
+	u16 shift;
+	u8 isc;
+} __packed;
+
 struct virtio_ccw_vq_info {
 	struct virtqueue *vq;
 	int num;
 	void *queue;
 	struct vq_info_block *info_block;
+	int bit_nr;
 	struct list_head node;
 	long cookie;
 };
 
+#define VIRTIO_AIRQ_ISC IO_SCH_ISC /* inherit from subchannel */
+
+#define VIRTIO_DEV_CHUNK (PAGE_SIZE/sizeof(unsigned long))
+#define MAX_AIRQ_AREAS 8
+
+static int virtio_ccw_use_airq = 1;
+
+struct airq_vq {
+	unsigned long used;
+	void *map[BITS_PER_LONG];
+};
+struct airq_info {
+	rwlock_t lock;
+	u8 *summary_indicator;
+	unsigned long indicators[VIRTIO_DEV_CHUNK];
+	struct airq_vq airq_vqs[VIRTIO_DEV_CHUNK];
+};
+static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
+
 #define CCW_CMD_SET_VQ 0x13
 #define CCW_CMD_VDEV_RESET 0x33
 #define CCW_CMD_SET_IND 0x43
@@ -91,6 +122,7 @@ struct virtio_ccw_vq_info {
 #define CCW_CMD_WRITE_CONF 0x21
 #define CCW_CMD_WRITE_STATUS 0x31
 #define CCW_CMD_READ_VQ_CONF 0x32
+#define CCW_CMD_SET_IND_ADAPTER 0x63
 
 #define VIRTIO_CCW_DOING_SET_VQ 0x00010000
 #define VIRTIO_CCW_DOING_RESET 0x00040000
@@ -102,6 +134,7 @@ struct virtio_ccw_vq_info {
 #define VIRTIO_CCW_DOING_SET_IND 0x01000000
 #define VIRTIO_CCW_DOING_READ_VQ_CONF 0x02000000
 #define VIRTIO_CCW_DOING_SET_CONF_IND 0x04000000
+#define VIRTIO_CCW_DOING_SET_IND_ADAPTER 0x08000000
 #define VIRTIO_CCW_INTPARM_MASK 0xffff0000
 
 static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
@@ -109,6 +142,141 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
 	return container_of(vdev, struct virtio_ccw_device, vdev);
 }
 
+static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
+{
+	int i, j;
+	struct airq_vq *p;
+	unsigned long flags;
+
+	write_lock_irqsave(&info->lock, flags);
+	for (i = 0; i < VIRTIO_DEV_CHUNK; i++) {
+		p = &info->airq_vqs[i];
+		for_each_set_bit(j, &p->used,
+				 sizeof(p->used) * BITS_PER_BYTE)
+			if (p->map[j] == vq) {
+				p->map[j] = NULL;
+				clear_bit(j, &p->used);
+				break;
+			}
+	}
+	write_unlock_irqrestore(&info->lock, flags);
+}
+
+static void virtio_airq_handler(void *indicator, void *data)
+{
+	int i, bit;
+	unsigned long *indicators;
+	u8 *summary_ind = indicator;
+	struct airq_info *info = data;
+	struct airq_vq *p;
+
+	inc_irq_stat(IRQIO_VAI);
+	*summary_ind = 0;
+	barrier();
+	read_lock(&info->lock);
+	/* Walk through indicators field. */
+	for (i = 0; i < VIRTIO_DEV_CHUNK; i++) {
+		p = &info->airq_vqs[i];
+		if (!p->used)
+			continue;
+		indicators = &info->indicators[i];
+		for_each_set_bit(bit, indicators,
+				 sizeof(*indicators) * BITS_PER_BYTE) {
+			/*
+			 * The bit clear must happen before the
+			 * vring kick.
+			 */
+			clear_bit(bit, indicators);
+			barrier();
+			vring_interrupt(0, p->map[bit]);
+		}
+	}
+	read_unlock(&info->lock);
+}
+
+static struct airq_info *new_airq_info(void)
+{
+	struct airq_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	rwlock_init(&info->lock);
+	isc_register(VIRTIO_AIRQ_ISC);
+	info->summary_indicator =
+		s390_register_adapter_interrupt(virtio_airq_handler,
+						info, VIRTIO_AIRQ_ISC);
+	if (IS_ERR(info->summary_indicator)) {
+		isc_unregister(VIRTIO_AIRQ_ISC);
+		kfree(info);
+		return NULL;
+	}
+	return info;
+}
+
+static void destroy_airq_info(struct airq_info *info)
+{
+	if (!info)
+		return;
+
+	s390_unregister_adapter_interrupt(info->summary_indicator,
+					  VIRTIO_AIRQ_ISC);
+	isc_unregister(VIRTIO_AIRQ_ISC);
+	kfree(info);
+}
+
+static unsigned long get_airq_indicator(struct virtio_ccw_device *vcdev,
+					struct virtqueue *vqs[], int nvqs,
+					u16 *shift, void **airq_info)
+{
+	int i, j, k, found = 0, first;
+	struct airq_vq *p;
+	struct virtio_ccw_vq_info *ccw_vq;
+	struct airq_info *info;
+	unsigned long indicator_addr = 0;
+	unsigned long flags;
+
+	for (i = 0; i < MAX_AIRQ_AREAS && !found; i++) {
+		if (!airq_areas[i])
+			airq_areas[i] = new_airq_info();
+		info = airq_areas[i];
+		if (!info)
+			return 0;
+		write_lock_irqsave(&info->lock, flags);
+		for (j = 0; j < VIRTIO_DEV_CHUNK; j++) {
+			p = &info->airq_vqs[j];
+			/* Check for enough vacancies. */
+			if (p->used == ~0UL)
+				continue;
+			first = ffz(p->used);
+			if (find_next_bit(&p->used, BITS_PER_LONG,
+					  first) < first + nvqs)
+				continue;
+			for (k = first; k < first + nvqs; k++) {
+				ccw_vq = vqs[k - first]->priv;
+				p->map[k] = vqs[k - first];
+				set_bit(k, &p->used);
+				ccw_vq->bit_nr = k;
+			}
+			*shift = first;
+			*airq_info = info;
+			indicator_addr = (unsigned long)&info->indicators[j];
+			found = 1;
+			break;
+		}
+		write_unlock_irqrestore(&info->lock, flags);
+	}
+	return indicator_addr;
+}
+
+static void virtio_ccw_drop_indicators(struct virtio_ccw_device *vcdev)
+{
+	struct virtio_ccw_vq_info *info;
+
+	list_for_each_entry(info, &vcdev->virtqueues, node)
+		drop_airq_indicator(info->vq, vcdev->airq_info);
+}
+
 static int doing_io(struct virtio_ccw_device *vcdev, __u32 flag)
 {
 	unsigned long flags;
@@ -145,6 +313,51 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
 	return ret ? ret : vcdev->err;
 }
 
+static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
+				      struct ccw1 *ccw)
+{
+	int ret;
+	unsigned long *indicatorp = NULL;
+	struct virtio_thinint_area *thinint_area = NULL;
+	struct airq_info *airq_info = vcdev->airq_info;
+
+	if (vcdev->is_thinint) {
+		thinint_area = kzalloc(sizeof(*thinint_area),
+				       GFP_DMA | GFP_KERNEL);
+		if (!thinint_area)
+			return;
+		thinint_area->summary_indicator =
+			(unsigned long)(void *)airq_info->summary_indicator;
+		thinint_area->isc = VIRTIO_AIRQ_ISC;
+		ccw->cmd_code = CCW_CMD_SET_IND_ADAPTER;
+		ccw->count = sizeof(*thinint_area);
+		ccw->cda = (__u32)(unsigned long) thinint_area;
+	} else {
+		indicatorp = kmalloc(sizeof(&vcdev->indicators),
+				     GFP_DMA | GFP_KERNEL);
+		if (!indicatorp)
+			return;
+		*indicatorp = 0;
+		ccw->cmd_code = CCW_CMD_SET_IND;
+		ccw->count = sizeof(vcdev->indicators);
+		ccw->cda = (__u32)(unsigned long) indicatorp;
+	}
+	/* Deregister indicators from host. */
+	vcdev->indicators = 0;
+	ccw->flags = 0;
+	ret = ccw_io_helper(vcdev, ccw,
+			    vcdev->is_thinint ?
+			    VIRTIO_CCW_DOING_SET_IND_ADAPTER :
+			    VIRTIO_CCW_DOING_SET_IND);
+	if (ret && (ret != -ENODEV))
+		dev_info(&vcdev->cdev->dev,
+			 "Failed to deregister indicators (%d)\n", ret);
+	else if (vcdev->is_thinint)
+		virtio_ccw_drop_indicators(vcdev);
+	kfree(indicatorp);
+	kfree(thinint_area);
+}
+
 static inline long do_kvm_notify(struct subchannel_id schid,
 				 unsigned long queue_index,
 				 long cookie)
@@ -229,11 +442,13 @@ static void virtio_ccw_del_vqs(struct virtio_device *vdev)
 {
 	struct virtqueue *vq, *n;
 	struct ccw1 *ccw;
+	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
 		return;
 
+	virtio_ccw_drop_indicator(vcdev, ccw);
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		virtio_ccw_del_vq(vq, ccw);
@@ -323,6 +538,53 @@ out_err:
 	return ERR_PTR(err);
 }
 
+static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
+					   struct virtqueue *vqs[], int nvqs,
+					   struct ccw1 *ccw)
+{
+	int ret;
+	struct virtio_thinint_area *thinint_area = NULL;
+	struct airq_info *info;
+
+	thinint_area = kzalloc(sizeof(*thinint_area), GFP_DMA | GFP_KERNEL);
+	if (!thinint_area) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* Try to get an indicator. */
+	thinint_area->indicator =
+		get_airq_indicator(vcdev, vqs, nvqs,
+				   &thinint_area->shift,
+				   &vcdev->airq_info);
+	if (!thinint_area->indicator) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	info = vcdev->airq_info;
+	thinint_area->summary_indicator =
+		(unsigned long)(void *)info->summary_indicator;
+	thinint_area->isc = VIRTIO_AIRQ_ISC;
+	ccw->cmd_code = CCW_CMD_SET_IND_ADAPTER;
+	ccw->flags = CCW_FLAG_SLI;
+	ccw->count = sizeof(*thinint_area);
+	ccw->cda = (__u32)(unsigned long)thinint_area;
+	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND_ADAPTER);
+	if (ret) {
+		dev_warn(&vcdev->cdev->dev,
+			 "enabling adapter interrupts = %d\n", ret);
+		if (ret == -EOPNOTSUPP)
+			/*
+			 * The host does not support adapter interrupts
+			 * for virtio-ccw, stop trying.
+			 */
+			virtio_ccw_use_airq = 0;
+		virtio_ccw_drop_indicators(vcdev);
+	}
+out:
+	kfree(thinint_area);
+	return ret;
+}
+
 static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			       struct virtqueue *vqs[],
 			       vq_callback_t *callbacks[],
@@ -352,15 +614,24 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	if (!indicatorp)
 		goto out;
 	*indicatorp = (unsigned long) &vcdev->indicators;
-	/* Register queue indicators with host. */
-	vcdev->indicators = 0;
-	ccw->cmd_code = CCW_CMD_SET_IND;
-	ccw->flags = 0;
-	ccw->count = sizeof(vcdev->indicators);
-	ccw->cda = (__u32)(unsigned long) indicatorp;
-	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
-	if (ret)
-		goto out;
+	if (vcdev->is_thinint) {
+		ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);
+		if (ret) {
+			/* no error, just fall back to legacy interrupts */
+			vcdev->is_thinint = 0;
+		}
+	}
+	if (!vcdev->is_thinint) {
+		/* Register queue indicators with host. */
+		vcdev->indicators = 0;
+		ccw->cmd_code = CCW_CMD_SET_IND;
+		ccw->flags = 0;
+		ccw->count = sizeof(vcdev->indicators);
+		ccw->cda = (__u32)(unsigned long) indicatorp;
+		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
+		if (ret)
+			goto out;
+	}
 	/* Register indicators2 with host for config changes */
 	*indicatorp = (unsigned long) &vcdev->indicators2;
 	vcdev->indicators2 = 0;
@@ -660,6 +931,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		case VIRTIO_CCW_DOING_SET_CONF_IND:
 		case VIRTIO_CCW_DOING_RESET:
 		case VIRTIO_CCW_DOING_READ_VQ_CONF:
+		case VIRTIO_CCW_DOING_SET_IND_ADAPTER:
 			vcdev->curr_io &= ~activity;
 			wake_up(&vcdev->wait_q);
 			break;
@@ -775,6 +1047,8 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 		goto out_free;
 	}
 
+	vcdev->is_thinint = virtio_ccw_use_airq; /* at least try */
+
 	vcdev->vdev.dev.parent = &cdev->dev;
 	vcdev->vdev.dev.release = virtio_ccw_release_dev;
 	vcdev->vdev.config = &virtio_ccw_config_ops;
@@ -932,6 +1206,10 @@ module_init(virtio_ccw_init);
 
 static void __exit virtio_ccw_exit(void)
 {
+	int i;
+
 	ccw_driver_unregister(&virtio_ccw_driver);
+	for (i = 0; i < MAX_AIRQ_AREAS; i++)
+		destroy_airq_info(airq_areas[i]);
 }
 module_exit(virtio_ccw_exit);
-- 
1.8.1.6
