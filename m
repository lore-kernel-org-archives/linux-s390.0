From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/5] vfio: linux-headers update for vfio-ccw
Date: Thu, 11 Jan 2018 04:04:55 +0100
Message-ID: <20180111030459.33757-2-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is a placeholder for a linux-headers update.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 linux-headers/linux/vfio.h     | 2 ++
 linux-headers/linux/vfio_ccw.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4312e961ff..24d85be022 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -457,11 +457,13 @@ enum {
 
 enum {
 	VFIO_CCW_CONFIG_REGION_INDEX,
+	VFIO_CCW_SCHIB_REGION_INDEX,
 	VFIO_CCW_NUM_REGIONS
 };
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CHP_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index 5bf96c3812..4944dd946e 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -22,4 +22,10 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __attribute__((packed));
 
+struct ccw_schib_region {
+        __u8	cc;
+#define SCHIB_AREA_SIZE 52
+        __u8	schib_area[SCHIB_AREA_SIZE];
+} __attribute__((packed));
+
 #endif
-- 
2.13.5
