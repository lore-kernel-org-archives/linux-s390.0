From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 2/3] vfio: ap: ioctl definitions for AP Queue Interrupt Control
Date: Thu, 22 Nov 2018 18:11:14 +0100
Message-ID: <1542906675-7949-3-git-send-email-pmorel@linux.ibm.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

We define two VFIO ioctl command to setup and clear
the AP Queues interrupt.

Arguments passed by the guest are:
- the apqn, AP queue number
- the Notification by address
- the identifier of the previously associated adapter

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/uapi/linux/vfio.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8131028..9a1b350 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -866,6 +866,31 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/**
+ * VFIO_AP_SET_IRQ - _IOWR(VFIO_TYPE, VFIO_BASE + 21, struct vfio_ap_aqic)
+ *
+ * Setup IRQ for an AP Queue
+ * @cmd contains the AP queue number (apqn)
+ * @status receives the resulting status of the command
+ * @nib is the Notification Indicator byte address
+ * @adapter_id allows to retrieve the associated adapter
+ */
+struct vfio_ap_aqic {
+	__u32   argsz;
+	__u32   flags;
+	/* out */
+	__u32 status;
+	/* in */
+	__u32 adapter_id;
+	__u64 nib;
+	__u16 apqn;
+	__u8 isc;
+	__u8 reserved[5];
+};
+#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
+#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* ***************************************************************** */
 
+
 #endif /* _UAPIVFIO_H */
-- 
2.7.4
