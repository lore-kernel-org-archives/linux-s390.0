From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 8/8] vfio: ccw: realize VFIO_DEVICE_CCW_CMD_REQUEST ioctl
Date: Fri, 29 Apr 2016 14:11:55 +0200
Message-ID: <1461931915-22397-9-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Introduce VFIO_DEVICE_CCW_CMD_REQUEST ioctl for vfio-ccw
to handle the translated ccw commands.

We implement the basic ccw command handling infrastructure
here:
1. Issue the translated ccw commands to the device.
2. Once we get the execution result, update the guest SCSW
   with it.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/vfio/ccw/vfio_ccw.c | 190 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h   |  23 ++++++
 2 files changed, 212 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/ccw/vfio_ccw.c b/drivers/vfio/ccw/vfio_ccw.c
index 9700448..3979544 100644
--- a/drivers/vfio/ccw/vfio_ccw.c
+++ b/drivers/vfio/ccw/vfio_ccw.c
@@ -17,15 +17,30 @@
 #include <linux/vfio.h>
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
+#include <asm/orb.h>
+#include "ccwchain.h"
 
 /**
  * struct vfio_ccw_device
  * @cdev: ccw device
+ * @curr_intparm: record current interrupt parameter,
+ *                used for wait interrupt.
+ * @wait_q: wait for interrupt
+ * @ccwchain_cmd: address map for current ccwchain.
+ * @irb: irb info received from interrupt
+ * @orb: orb for the currently processed ssch request
+ * @scsw: scsw info
  * @going_away: if an offline procedure was already ongoing
  * @hot_reset: if hot-reset is ongoing
  */
 struct vfio_ccw_device {
 	struct ccw_device	*cdev;
+	u32			curr_intparm;
+	wait_queue_head_t	wait_q;
+	struct ccwchain_cmd	ccwchain_cmd;
+	struct irb		irb;
+	union orb		orb;
+	union scsw		scsw;
 	bool			going_away;
 	bool			hot_reset;
 };
@@ -42,6 +57,118 @@ struct ccw_device_id vfio_ccw_ids[] = {
 MODULE_DEVICE_TABLE(ccw, vfio_ccw_ids);
 
 /*
+ * LATER:
+ * This is good for Linux guests; but we may need an interface to
+ * deal with further bits in the orb.
+ */
+static unsigned long flags_from_orb(union orb *orb)
+{
+	unsigned long flags = 0;
+
+	flags |= orb->cmd.pfch ? 0 : DOIO_DENY_PREFETCH;
+	flags |= orb->cmd.spnd ? DOIO_ALLOW_SUSPEND : 0;
+	flags |= orb->cmd.ssic ? (DOIO_SUPPRESS_INTER | DOIO_ALLOW_SUSPEND) : 0;
+
+	return flags;
+}
+
+/* Check if the current intparm has been set. */
+static int doing_io(struct vfio_ccw_device *vcdev, u32 intparm)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
+	ret = (vcdev->curr_intparm == intparm);
+	spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
+	return ret;
+}
+
+int vfio_ccw_io_helper(struct vfio_ccw_device *vcdev)
+{
+	struct ccwchain_cmd *ccwchain_cmd;
+	struct ccw1 *cpa;
+	u32 intparm;
+	unsigned long io_flags, lock_flags;
+	int ret;
+
+	ccwchain_cmd = &vcdev->ccwchain_cmd;
+	cpa = ccwchain_get_cpa(ccwchain_cmd);
+	intparm = (u32)(u64)ccwchain_cmd->k_ccwchain;
+	io_flags = flags_from_orb(&vcdev->orb);
+
+	spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), lock_flags);
+	ret = ccw_device_start(vcdev->cdev, cpa, intparm,
+			       vcdev->orb.cmd.lpm, io_flags);
+	if (!ret)
+		vcdev->curr_intparm = 0;
+	spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), lock_flags);
+
+	if (!ret)
+		wait_event(vcdev->wait_q,
+			   doing_io(vcdev, intparm));
+
+	ccwchain_update_scsw(ccwchain_cmd, &(vcdev->irb.scsw));
+
+	return ret;
+}
+
+/* Deal with the ccw command request from the userspace. */
+int vfio_ccw_cmd_request(struct vfio_ccw_device *vcdev,
+			 struct vfio_ccw_cmd *ccw_cmd)
+{
+	union orb *orb = &vcdev->orb;
+	union scsw *scsw = &vcdev->scsw;
+	struct irb *irb = &vcdev->irb;
+	int ret;
+
+	memcpy(orb, ccw_cmd->orb_area, sizeof(*orb));
+	memcpy(scsw, ccw_cmd->scsw_area, sizeof(*scsw));
+	vcdev->ccwchain_cmd.u_ccwchain = (void *)ccw_cmd->ccwchain_buf;
+	vcdev->ccwchain_cmd.k_ccwchain = NULL;
+	vcdev->ccwchain_cmd.nr = ccw_cmd->ccwchain_nr;
+
+	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
+		/*
+		 * XXX:
+		 * Only support prefetch enable mode now.
+		 * Only support 64bit addressing idal.
+		 */
+		if (!orb->cmd.pfch || !orb->cmd.c64)
+			return -EOPNOTSUPP;
+
+		ret = ccwchain_alloc(&vcdev->ccwchain_cmd);
+		if (ret)
+			return ret;
+
+		ret = ccwchain_prefetch(&vcdev->ccwchain_cmd);
+		if (ret) {
+			ccwchain_free(&vcdev->ccwchain_cmd);
+			return ret;
+		}
+
+		/* Start channel program and wait for I/O interrupt. */
+		ret = vfio_ccw_io_helper(vcdev);
+		if (!ret) {
+			/* Get irb info and copy it to irb_area. */
+			memcpy(ccw_cmd->irb_area, irb, sizeof(*irb));
+		}
+
+		ccwchain_free(&vcdev->ccwchain_cmd);
+	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
+		/* XXX: Handle halt. */
+		ret = -EOPNOTSUPP;
+	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
+		/* XXX: Handle clear. */
+		ret = -EOPNOTSUPP;
+	} else {
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+/*
  * vfio callbacks
  */
 static int vfio_ccw_open(void *device_data)
@@ -107,6 +234,24 @@ static long vfio_ccw_ioctl(void *device_data, unsigned int cmd,
 		vcdev->hot_reset = false;
 		spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
 		return ret;
+
+	} else if (cmd == VFIO_DEVICE_CCW_CMD_REQUEST) {
+		struct vfio_ccw_cmd ccw_cmd;
+		int ret;
+
+		minsz = offsetofend(struct vfio_ccw_cmd, ccwchain_buf);
+
+		if (copy_from_user(&ccw_cmd, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ccw_cmd.argsz < minsz)
+			return -EINVAL;
+
+		ret = vfio_ccw_cmd_request(vcdev, &ccw_cmd);
+		if (ret)
+			return ret;
+
+		return copy_to_user((void __user *)arg, &ccw_cmd, minsz);
 	}
 
 	return -ENOTTY;
@@ -119,6 +264,25 @@ static const struct vfio_device_ops vfio_ccw_ops = {
 	.ioctl		= vfio_ccw_ioctl,
 };
 
+static void vfio_ccw_int_handler(struct ccw_device *cdev,
+				unsigned long intparm,
+				struct irb *irb)
+{
+	struct vfio_device *device = dev_get_drvdata(&cdev->dev);
+	struct vfio_ccw_device *vdev;
+
+	if (!device)
+		return;
+
+	vdev = vfio_device_data(device);
+	if (!vdev)
+		return;
+
+	vdev->curr_intparm = intparm;
+	memcpy(&vdev->irb, irb, sizeof(*irb));
+	wake_up(&vdev->wait_q);
+}
+
 static int vfio_ccw_probe(struct ccw_device *cdev)
 {
 	struct iommu_group *group = vfio_iommu_group_get(&cdev->dev);
@@ -126,6 +290,8 @@ static int vfio_ccw_probe(struct ccw_device *cdev)
 	if (!group)
 		return -EINVAL;
 
+	cdev->handler = vfio_ccw_int_handler;
+
 	return 0;
 }
 
@@ -142,6 +308,9 @@ static int vfio_ccw_set_offline(struct ccw_device *cdev)
 	if (!vdev || vdev->hot_reset || vdev->going_away)
 		return 0;
 
+	/* Put the vfio_device reference we got during the online process. */
+	vfio_device_put(device);
+
 	vdev->going_away = true;
 	vfio_del_group_dev(&cdev->dev);
 	kfree(vdev);
@@ -155,6 +324,8 @@ void vfio_ccw_remove(struct ccw_device *cdev)
 		vfio_ccw_set_offline(cdev);
 
 	vfio_iommu_group_put(cdev->dev.iommu_group, &cdev->dev);
+
+	cdev->handler = NULL;
 }
 
 static int vfio_ccw_set_online(struct ccw_device *cdev)
@@ -186,8 +357,25 @@ create_device:
 	vdev->cdev = cdev;
 
 	ret = vfio_add_group_dev(&cdev->dev, &vfio_ccw_ops, vdev);
-	if (ret)
+	if (ret) {
+		kfree(vdev);
+		return ret;
+	}
+
+	/*
+	 * Get a reference to the vfio_device for this device, and don't put
+	 * it until device offline. Thus we don't need to get/put a reference
+	 * every time we run into the int_handler. And we will get rid of a
+	 * wrong usage of mutex in int_handler.
+	 */
+	device = vfio_device_get_from_dev(&cdev->dev);
+	if (!device) {
+		vfio_del_group_dev(&cdev->dev);
 		kfree(vdev);
+		return -ENODEV;
+	}
+
+	init_waitqueue_head(&vdev->wait_q);
 
 	return ret;
 }
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 889a316..5e8a58e 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -695,6 +695,29 @@ struct vfio_iommu_spapr_tce_remove {
  */
 #define VFIO_DEVICE_CCW_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 21)
 
+/**
+ * VFIO_DEVICE_CCW_CMD_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
+ *                                     struct vfio_ccw_cmd)
+ *
+ * Issue a user-space ccw program for translation and performing channel I/O
+ * operations.
+ */
+struct vfio_ccw_cmd {
+	__u32 argsz;
+	__u8 cssid;
+	__u8 ssid;
+	__u16 devno;
+#define ORB_AREA_SIZE 12
+	__u8 orb_area[ORB_AREA_SIZE];
+#define SCSW_AREA_SIZE 12
+	__u8 scsw_area[SCSW_AREA_SIZE];
+#define IRB_AREA_SIZE 96
+	__u8 irb_area[IRB_AREA_SIZE];
+	__u32 ccwchain_nr;
+	__u64 ccwchain_buf;
+} __attribute__((packed));
+#define VFIO_DEVICE_CCW_CMD_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.6.6
