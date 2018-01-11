From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/5] vfio/ccw: get schib region info
Date: Thu, 11 Jan 2018 04:04:56 +0100
Message-ID: <20180111030459.33757-3-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

vfio-ccw provides an MMIO region for store subchannel
information. We fetch this information via ioctls here,
then we can use it to update schib for virtual subchannels
later on.

While we are at it, also modify the comment and error
message for the config region a bit, to make these unified
with the schib likeness.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 16713f2c52..e673695509 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -32,6 +32,10 @@ typedef struct VFIOCCWDevice {
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
     EventNotifier io_notifier;
+
+    uint64_t schib_region_size;
+    uint64_t schib_region_offset;
+    struct ccw_schib_region *schib_region;
 } VFIOCCWDevice;
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
@@ -268,9 +272,10 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
+    /* Get I/O region info. */
     ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
     if (ret) {
-        error_setg_errno(errp, -ret, "vfio: Error getting config info");
+        error_setg_errno(errp, -ret, "vfio: Error getting config region info");
         return;
     }
 
@@ -283,13 +288,30 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
+    g_free(info);
 
+    /* Get SCHIB region info. */
+    ret = vfio_get_region_info(vdev, VFIO_CCW_SCHIB_REGION_INDEX, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "vfio: Error getting schib region info");
+        return;
+    }
+
+    vcdev->schib_region_size = info->size;
+    if (sizeof(*vcdev->schib_region) != vcdev->schib_region_size) {
+        error_setg(errp, "vfio: Unexpected size of the schib region");
+        g_free(info);
+        return;
+    }
+    vcdev->schib_region_offset = info->offset;
+    vcdev->schib_region = g_malloc0(info->size);
     g_free(info);
 }
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
     g_free(vcdev->io_region);
+    g_free(vcdev->schib_region);
 }
 
 static void vfio_put_device(VFIOCCWDevice *vcdev)
-- 
2.13.5
