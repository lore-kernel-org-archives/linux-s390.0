From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 8/9] s390x/css: introduce and realize ccw-request callback
Date: Fri, 29 Apr 2016 14:13:22 +0200
Message-ID: <1461932003-23830-9-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Introduce a new callback on ccw device to handle ccw-request.
Realize the callback in vfio-ccw device.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/s390-ccw.h |  1 +
 hw/vfio/ccw.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
index a3cd9df..92d076d 100644
--- a/hw/s390x/s390-ccw.h
+++ b/hw/s390x/s390-ccw.h
@@ -29,6 +29,7 @@ typedef struct S390CCWDevice {
     unsigned int hcssid;
     unsigned int hssid;
     unsigned int hdevno;
+    int (*handle_request) (ORB *, IRB *, SCSW *, void *);
 } S390CCWDevice;
 
 typedef struct S390CCWDeviceClass {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 501a0e8..6b23291 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -20,12 +20,52 @@
 #include "hw/vfio/vfio.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/s390-ccwchain.h"
 
 typedef struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
 } VFIOCCWDevice;
 
+static int vfio_ccw_handle_request(ORB *orb, IRB *irb, SCSW *scsw, void *data)
+{
+    struct vfio_ccw_cmd cmd_data;
+    int ret;
+    TransChainData trans_data;
+    S390CCWDevice *cdev = data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+
+    QEMU_BUILD_BUG_ON(sizeof(cmd_data.orb_area) != sizeof(ORB));
+    QEMU_BUILD_BUG_ON(sizeof(cmd_data.scsw_area) != sizeof(SCSW));
+    QEMU_BUILD_BUG_ON(sizeof(cmd_data.irb_area) != sizeof(IRB));
+
+    trans_data.cpa_gpa = orb->cpa;
+    ret = ccwchain_translate_to_userspace(&trans_data);
+    if (ret) {
+        return ret;
+    }
+    cmd_data.argsz = sizeof(cmd_data);
+    cmd_data.cssid = cdev->hcssid;
+    cmd_data.ssid = cdev->hssid;
+    cmd_data.devno = cdev->hdevno;
+    cmd_data.ccwchain_nr = trans_data.ccwchain_nr;
+    cmd_data.ccwchain_buf = trans_data.ccwchain_buf;
+
+    memcpy(cmd_data.orb_area, orb, sizeof(ORB));
+    memcpy(cmd_data.scsw_area, scsw, sizeof(SCSW));
+
+    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_CCW_CMD_REQUEST, &cmd_data) == -1) {
+        ccwchain_list_free(&trans_data);
+        return -errno;
+    }
+
+    memcpy(irb, cmd_data.irb_area, sizeof(IRB));
+    ccwchain_update_scsw(&(irb->scsw), &trans_data);
+    ccwchain_list_free(&trans_data);
+
+    return 0;
+}
+
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
 {
     vdev->needs_reset = true;
@@ -75,6 +115,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     GError *gerror;
 
     /* Call the class init function for ccw device. */
+    cdev->handle_request = vfio_ccw_handle_request;
+
     if (cdc->realize) {
         cdc->realize(cdev, errp);
         if (*errp) {
-- 
2.6.6
