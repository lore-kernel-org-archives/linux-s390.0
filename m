From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/3] vfio: ccw: introduce schib region
Date: Thu, 11 Jan 2018 04:04:19 +0100
Message-ID: <20180111030421.31418-2-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This introduces a new region for vfio-ccw to provide subchannel
information for user space.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 21 ++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     | 79 +++++++++++++++++++++++++++----------
 drivers/s390/cio/vfio_ccw_private.h |  3 ++
 include/uapi/linux/vfio.h           |  1 +
 include/uapi/linux/vfio_ccw.h       |  6 +++
 5 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index c30420c517b1..be081ccabea3 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -172,6 +172,22 @@ static void fsm_irq(struct vfio_ccw_private *private,
 		complete(private->completion);
 }
 
+static void fsm_update_subch(struct vfio_ccw_private *private,
+			     enum vfio_ccw_event event)
+{
+	struct subchannel *sch;
+
+	sch = private->sch;
+	if (cio_update_schib(sch)) {
+		private->schib_region.cc = 3;
+		return;
+	}
+
+	private->schib_region.cc = 0;
+	memcpy(private->schib_region.schib_area, &sch->schib,
+	       sizeof(sch->schib));
+}
+
 /*
  * Device statemachine
  */
@@ -180,25 +196,30 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
+		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_UPDATE_SUBCH]	= fsm_update_subch,
 	},
 };
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 41eeb57d68a3..9528fce2e7d9 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -13,6 +13,11 @@
 
 #include "vfio_ccw_private.h"
 
+#define VFIO_CCW_OFFSET_SHIFT   40
+#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
+#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
+#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)
+
 static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private;
@@ -168,14 +173,31 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 				  loff_t *ppos)
 {
 	struct vfio_ccw_private *private;
-	struct ccw_io_region *region;
+	void *region;
+	u32 index;
+	loff_t pos;
+
+	index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
+	pos = (*ppos) & VFIO_CCW_OFFSET_MASK;
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if (*ppos + count > sizeof(*region))
+	switch (index) {
+	case VFIO_CCW_CONFIG_REGION_INDEX:
+		if (pos + count > sizeof(struct ccw_io_region))
+			return -EINVAL;
+		region = &private->io_region;
+		break;
+	case VFIO_CCW_SCHIB_REGION_INDEX:
+		if (pos + count > sizeof(struct ccw_schib_region))
+			return -EINVAL;
+		region = &private->schib_region;
+		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_UPDATE_SUBCH);
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	region = &private->io_region;
-	if (copy_to_user(buf, (void *)region + *ppos, count))
+	if (copy_to_user(buf, region + pos, count))
 		return -EFAULT;
 
 	return count;
@@ -187,23 +209,35 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 				   loff_t *ppos)
 {
 	struct vfio_ccw_private *private;
-	struct ccw_io_region *region;
-
-	if (*ppos + count > sizeof(*region))
-		return -EINVAL;
+	u32 index;
+	loff_t pos;
 
+	index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
+	pos = (*ppos) & VFIO_CCW_OFFSET_MASK;
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (private->state != VFIO_CCW_STATE_IDLE)
-		return -EACCES;
 
-	region = &private->io_region;
-	if (copy_from_user((void *)region + *ppos, buf, count))
-		return -EFAULT;
-
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
-		return region->ret_code;
+	switch (index) {
+	case VFIO_CCW_CONFIG_REGION_INDEX:
+	{
+		struct ccw_io_region *region;
+		if (pos + count > sizeof(*region))
+			return -EINVAL;
+		if (private->state != VFIO_CCW_STATE_IDLE)
+			return -EACCES;
+		region = &private->io_region;
+		if (copy_from_user((void *)region + *ppos, buf, count))
+			return -EFAULT;
+		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
+		if (region->ret_code != 0) {
+			private->state = VFIO_CCW_STATE_IDLE;
+			return region->ret_code;
+		}
+		break;
+	}
+	case VFIO_CCW_SCHIB_REGION_INDEX:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
 	}
 
 	return count;
@@ -224,11 +258,16 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 {
 	switch (info->index) {
 	case VFIO_CCW_CONFIG_REGION_INDEX:
-		info->offset = 0;
+		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
 		info->size = sizeof(struct ccw_io_region);
 		info->flags = VFIO_REGION_INFO_FLAG_READ
 			      | VFIO_REGION_INFO_FLAG_WRITE;
 		return 0;
+	case VFIO_CCW_SCHIB_REGION_INDEX:
+		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
+		info->size = sizeof(struct ccw_schib_region);
+		info->flags = VFIO_REGION_INFO_FLAG_READ;
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 78a66d96756b..460c8b90d834 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -28,6 +28,7 @@
  * @mdev: pointer to the mediated device
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
+ * @schib_region: MMIO region of subchannel information
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
@@ -42,6 +43,7 @@ struct vfio_ccw_private {
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
 	struct ccw_io_region	io_region;
+	struct ccw_schib_region	schib_region;
 
 	struct channel_program	cp;
 	struct irb		irb;
@@ -76,6 +78,7 @@ enum vfio_ccw_event {
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
+	VFIO_CCW_EVENT_UPDATE_SUBCH,
 	/* last element! */
 	NR_VFIO_CCW_EVENTS
 };
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e3301dbd27d4..c60244debf71 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -457,6 +457,7 @@ enum {
 
 enum {
 	VFIO_CCW_CONFIG_REGION_INDEX,
+	VFIO_CCW_SCHIB_REGION_INDEX,
 	VFIO_CCW_NUM_REGIONS
 };
 
diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.h
index 2ec5f367ff78..12508ef6e6fc 100644
--- a/include/uapi/linux/vfio_ccw.h
+++ b/include/uapi/linux/vfio_ccw.h
@@ -22,4 +22,10 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __packed;
 
+struct ccw_schib_region {
+	__u8	cc;
+#define SCHIB_AREA_SIZE 52
+	__u8	schib_area[SCHIB_AREA_SIZE];
+} __packed;
+
 #endif
-- 
2.13.5
