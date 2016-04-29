From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 1/9] vfio: linux-headers update for vfio-ccw
Date: Fri, 29 Apr 2016 14:13:15 +0200
Message-ID: <1461932003-23830-2-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This is a placeholder for a linux-headers update.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 linux-headers/linux/vfio.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 759b850..4059e3e 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -198,6 +198,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)	/* vfio-ccw device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -686,6 +687,37 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/**
+ * VFIO_DEVICE_CCW_HOT_RESET - _IOW(VFIO_TYPE, VFIO_BASE + 21)
+ *
+ * Hot reset the channel I/O device. All state of the subchannel will be
+ * cleared.
+ */
+#define VFIO_DEVICE_CCW_HOT_RESET       _IO(VFIO_TYPE, VFIO_BASE + 21)
+
+/**
+ * VFIO_DEVICE_CCW_CMD_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
+ *                                     struct vfio_ccw_cmd)
+ *
+ * Issue a user-space ccw program for translation and performing channel I/O
+ * operations.
+ */
+struct vfio_ccw_cmd {
+        __u32 argsz;
+        __u8 cssid;
+        __u8 ssid;
+        __u16 devno;
+#define ORB_AREA_SIZE 12
+        __u8 orb_area[ORB_AREA_SIZE];
+#define SCSW_AREA_SIZE 12
+        __u8 scsw_area[SCSW_AREA_SIZE];
+#define IRB_AREA_SIZE 96
+        __u8 irb_area[IRB_AREA_SIZE];
+        __u32 ccwchain_nr;
+        __u64 ccwchain_buf;
+} __attribute__((packed));
+#define VFIO_DEVICE_CCW_CMD_REQUEST    _IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* ***************************************************************** */
 
 #endif /* VFIO_H */
-- 
2.6.6
