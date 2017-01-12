From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 08/12] vfio/ccw: get io region info
Date: Thu, 12 Jan 2017 08:25:09 +0100
Message-ID: <20170112072513.98411-9-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

vfio-ccw provides an MMIO region for I/O operations. We fetch its
information via ioctls here, then we can use it performing I/O
instructions and retrieving I/O results later on.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 881010b..93394c2 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -21,11 +21,15 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/ccw-device.h"
+#include "standard-headers/asm-s390/vfio_ccw.h"
 
 #define TYPE_VFIO_CCW "vfio-ccw"
 typedef struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
+    uint64_t io_region_size;
+    uint64_t io_region_offset;
+    struct ccw_io_region *io_region;
 } VFIOCCWDevice;
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
@@ -50,6 +54,46 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
+{
+    VFIODevice *vdev = &vcdev->vdev;
+    struct vfio_region_info *info;
+    int ret;
+
+    /* Sanity check device */
+    if (!(vdev->flags & VFIO_DEVICE_FLAGS_CCW)) {
+        error_setg(errp, "vfio: Um, this isn't a vfio-ccw device");
+        return;
+    }
+
+    if (vdev->num_regions != VFIO_CCW_NUM_REGIONS) {
+        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
+                   vdev->num_regions);
+        return;
+    }
+
+    ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
+    if (ret) {
+        error_setg(errp, "vfio: Error getting config info: %d", ret);
+        return;
+    }
+
+    vcdev->io_region_size = info->size;
+    if (sizeof(*vcdev->io_region) != vcdev->io_region_size) {
+        error_setg(errp, "vfio: Unexpected size of the I/O region");
+        return;
+    }
+    vcdev->io_region_offset = info->offset;
+    vcdev->io_region = g_malloc0(info->size);
+
+    g_free(info);
+}
+
+static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
+{
+    g_free(vcdev->io_region);
+}
+
 static void vfio_put_device(VFIOCCWDevice *vcdev)
 {
     g_free(vcdev->vdev.name);
@@ -144,8 +188,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_device_err;
     }
 
+    vfio_ccw_get_region(vcdev, errp);
+    if (*errp) {
+        goto out_region_err;
+    }
+
     return;
 
+out_region_err:
+    vfio_put_device(vcdev);
 out_device_err:
     vfio_ccw_put_group(group, path);
 out_group_err:
@@ -166,6 +217,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
         cdc->unrealize(cdev, errp);
     }
 
+    vfio_ccw_put_region(vcdev);
     vfio_put_device(vcdev);
     vfio_put_group(group);
 }
-- 
2.8.4
