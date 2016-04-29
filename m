From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 4/8] vfio: ccw: realize VFIO_DEVICE_GET_INFO ioctl
Date: Fri, 29 Apr 2016 14:11:51 +0200
Message-ID: <1461931915-22397-5-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Introduce device information about vfio-ccw: VFIO_DEVICE_FLAGS_CCW.
Realize VFIO_DEVICE_GET_INFO ioctl for vfio-ccw.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/vfio/ccw/vfio_ccw.c | 20 ++++++++++++++++++++
 include/uapi/linux/vfio.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/vfio/ccw/vfio_ccw.c b/drivers/vfio/ccw/vfio_ccw.c
index 8b0acae..7331aed 100644
--- a/drivers/vfio/ccw/vfio_ccw.c
+++ b/drivers/vfio/ccw/vfio_ccw.c
@@ -58,6 +58,26 @@ static void vfio_ccw_release(void *device_data)
 static long vfio_ccw_ioctl(void *device_data, unsigned int cmd,
 			   unsigned long arg)
 {
+	unsigned long minsz;
+
+	if (cmd == VFIO_DEVICE_GET_INFO) {
+		struct vfio_device_info info;
+
+		minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		info.flags = VFIO_DEVICE_FLAGS_CCW;
+		info.num_regions = 0;
+		info.num_irqs = 0;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+	}
+
 	return -ENOTTY;
 }
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 255a211..aaedfcd 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -198,6 +198,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
-- 
2.6.6
