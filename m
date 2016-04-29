From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 5/8] vfio: ccw: realize VFIO_DEVICE_CCW_HOT_RESET ioctl
Date: Fri, 29 Apr 2016 14:11:52 +0200
Message-ID: <1461931915-22397-6-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Introduce VFIO_DEVICE_CCW_HOT_RESET ioctl for vfio-ccw to make it
possible to hot-reset the device.

We try to achieve a hot reset by first offlining the device and then
onlining it again: this should clear all state at the subchannel.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/vfio/ccw/vfio_ccw.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h   |  8 ++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/ccw/vfio_ccw.c b/drivers/vfio/ccw/vfio_ccw.c
index 7331aed..9700448 100644
--- a/drivers/vfio/ccw/vfio_ccw.c
+++ b/drivers/vfio/ccw/vfio_ccw.c
@@ -22,10 +22,12 @@
  * struct vfio_ccw_device
  * @cdev: ccw device
  * @going_away: if an offline procedure was already ongoing
+ * @hot_reset: if hot-reset is ongoing
  */
 struct vfio_ccw_device {
 	struct ccw_device	*cdev;
 	bool			going_away;
+	bool			hot_reset;
 };
 
 enum vfio_ccw_device_type {
@@ -58,6 +60,7 @@ static void vfio_ccw_release(void *device_data)
 static long vfio_ccw_ioctl(void *device_data, unsigned int cmd,
 			   unsigned long arg)
 {
+	struct vfio_ccw_device *vcdev = device_data;
 	unsigned long minsz;
 
 	if (cmd == VFIO_DEVICE_GET_INFO) {
@@ -76,6 +79,34 @@ static long vfio_ccw_ioctl(void *device_data, unsigned int cmd,
 		info.num_irqs = 0;
 
 		return copy_to_user((void __user *)arg, &info, minsz);
+
+	} else if (cmd == VFIO_DEVICE_CCW_HOT_RESET) {
+		unsigned long flags;
+		int ret;
+
+		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
+		if (!vcdev->cdev->online) {
+			spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev),
+					       flags);
+			return -EINVAL;
+		}
+
+		if (vcdev->hot_reset) {
+			spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev),
+					       flags);
+			return -EBUSY;
+		}
+		vcdev->hot_reset = true;
+		spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
+
+		ret = ccw_device_set_offline(vcdev->cdev);
+		if (!ret)
+			ret = ccw_device_set_online(vcdev->cdev);
+
+		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
+		vcdev->hot_reset = false;
+		spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
+		return ret;
 	}
 
 	return -ENOTTY;
@@ -108,7 +139,7 @@ static int vfio_ccw_set_offline(struct ccw_device *cdev)
 
 	vdev = vfio_device_data(device);
 	vfio_device_put(device);
-	if (!vdev || vdev->going_away)
+	if (!vdev || vdev->hot_reset || vdev->going_away)
 		return 0;
 
 	vdev->going_away = true;
@@ -128,9 +159,26 @@ void vfio_ccw_remove(struct ccw_device *cdev)
 
 static int vfio_ccw_set_online(struct ccw_device *cdev)
 {
+	struct vfio_device *device = vfio_device_get_from_dev(&cdev->dev);
 	struct vfio_ccw_device *vdev;
 	int ret;
 
+	if (!device)
+		goto create_device;
+
+	vdev = vfio_device_data(device);
+	vfio_device_put(device);
+	if (!vdev)
+		goto create_device;
+
+	/*
+	 * During hot reset, we just want to disable/enable the
+	 * subchannel and need not setup anything again.
+	 */
+	if (vdev->hot_reset)
+		return 0;
+
+create_device:
 	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
 	if (!vdev)
 		return -ENOMEM;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index aaedfcd..889a316 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -687,6 +687,14 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/**
+ * VFIO_DEVICE_CCW_HOT_RESET - _IOW(VFIO_TYPE, VFIO_BASE + 21)
+ *
+ * Hot reset the channel I/O device. All state of the subchannel will be
+ * cleared.
+ */
+#define VFIO_DEVICE_CCW_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 21)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.6.6
