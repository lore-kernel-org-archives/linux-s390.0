From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 7/9] vfio/ccw: vfio based ccw passthrough driver
Date: Fri, 29 Apr 2016 14:13:21 +0200
Message-ID: <1461932003-23830-8-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

We use the No-IOMMU mode of VFIO to realize the ccw device
passthrough, implement a vfio based ccw passthrough
driver called "vfio-ccw".

Support qemu parameters in the style of:
"-device vfio-ccw,id=xx,hostid=xx(,guestid=xx)"

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 default-configs/s390x-softmmu.mak |   1 +
 hw/vfio/Makefile.objs             |   1 +
 hw/vfio/ccw.c                     | 188 ++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h     |   1 +
 4 files changed, 191 insertions(+)
 create mode 100644 hw/vfio/ccw.c

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 36e15de..5576b0a 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -4,4 +4,5 @@ CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
+CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index ceddbb8..2daf4ae 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,6 +1,7 @@
 ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
 obj-$(CONFIG_PCI) += pci.o pci-quirks.o
+obj-$(CONFIG_VFIO_CCW) += ccw.o
 obj-$(CONFIG_SOFTMMU) += platform.o
 obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
 obj-$(CONFIG_SOFTMMU) += amd-xgbe.o
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
new file mode 100644
index 0000000..501a0e8
--- /dev/null
+++ b/hw/vfio/ccw.c
@@ -0,0 +1,188 @@
+/*
+ * vfio based ccw device assignment support
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or(at
+ * your option) any version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/vfio/vfio.h"
+#include "hw/vfio/vfio-common.h"
+#include "hw/s390x/s390-ccw.h"
+
+typedef struct VFIOCCWDevice {
+    S390CCWDevice cdev;
+    VFIODevice vdev;
+} VFIOCCWDevice;
+
+static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
+{
+    vdev->needs_reset = true;
+}
+
+static int vfio_ccw_hot_reset_multi(VFIODevice *vdev)
+{
+    VFIOCCWDevice *vcdev = container_of(vdev, VFIOCCWDevice, vdev);
+
+    return ioctl(vcdev->vdev.fd, VFIO_DEVICE_CCW_HOT_RESET);
+}
+
+/*
+ * vfio_eoi would be called by vfio_region_read and vfio_region_write
+ * which are not used by us for now.
+ * Let's leave this empty in case we need to realize it later.
+ */
+static void vfio_ccw_eoi(VFIODevice *vdev)
+{
+    /* Do nothing. */
+}
+
+static VFIODeviceOps vfio_ccw_ops = {
+    .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
+    .vfio_hot_reset_multi = vfio_ccw_hot_reset_multi,
+    .vfio_eoi = vfio_ccw_eoi,
+};
+
+static void vfio_put_device(VFIOCCWDevice *vcdev)
+{
+    g_free(vcdev->vdev.name);
+    vfio_put_base_device(&vcdev->vdev);
+}
+
+static void vfio_ccw_realize(DeviceState *dev, Error **errp)
+{
+    VFIODevice *vbasedev;
+    VFIOGroup *group;
+    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent, dev);
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
+    char *path = NULL;
+    char *tmp_path = NULL;
+    char *iommu_group_path = NULL;
+    struct stat st;
+    int  groupid, ret;
+    GError *gerror;
+
+    /* Call the class init function for ccw device. */
+    if (cdc->realize) {
+        cdc->realize(cdev, errp);
+        if (*errp) {
+            return;
+        }
+    }
+
+    /* Check that host device exists. */
+    path = g_strdup_printf("/sys/bus/ccw/devices/%x.%x.%04x",
+                           cdev->hcssid, cdev->hssid, cdev->hdevno);
+    if (stat(path, &st) < 0) {
+        error_setg(errp, "vfio: no such host device %s", path);
+        goto out_err;
+    }
+
+    vcdev->vdev.ops = &vfio_ccw_ops;
+    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
+    vcdev->vdev.name = g_strdup_printf("%02x.%02x.%04x", cdev->hcssid,
+                                       cdev->hssid, cdev->hdevno);
+
+    tmp_path = g_strconcat(path, "/iommu_group", NULL);
+
+    iommu_group_path = g_file_read_link(tmp_path, &gerror);
+    if (!iommu_group_path) {
+        error_setg(errp, "vfio: error no iommu_group for device");
+        goto out_err;
+    }
+
+    if (sscanf(basename(iommu_group_path), "%d", &groupid) != 1) {
+        error_setg(errp, "vfio: error reading %s:%m", iommu_group_path);
+        goto out_err;
+    }
+
+    group = vfio_get_group(groupid, NULL);
+    if (!group) {
+        error_setg(errp, "vfio: failed to get the group %d", groupid);
+        goto out_err;
+    }
+
+    QLIST_FOREACH(vbasedev, &group->device_list, next) {
+        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
+            error_setg(errp, "vfio: device %s has already been attached",
+                       basename(path));
+            vfio_put_group(group);
+            goto out_err;
+        }
+    }
+
+    ret = vfio_get_device(group, basename(path) , &vcdev->vdev);
+    if (ret) {
+        error_setg(errp, "vfio: failed to get device %s", basename(path));
+        vfio_put_group(group);
+        goto out_err;
+    }
+
+out_err:
+    g_free(path);
+    g_free(tmp_path);
+    g_free(iommu_group_path);
+}
+
+static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
+{
+    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent, dev);
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
+    VFIOGroup *group = vcdev->vdev.group;
+
+    if (cdc->unrealize) {
+        cdc->unrealize(cdev, errp);
+    }
+
+    vfio_put_device(vcdev);
+    vfio_put_group(group);
+}
+
+static Property vfio_ccw_properties[] = {
+    DEFINE_PROP_STRING("hostid", VFIOCCWDevice, cdev.hostid),
+    DEFINE_PROP_STRING("guestid", VFIOCCWDevice, cdev.guestid),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vfio_ccw_vmstate = {
+    .name = "vfio-ccw",
+    .unmigratable = 1,
+};
+
+static void vfio_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = vfio_ccw_properties;
+    dc->vmsd = &vfio_ccw_vmstate;
+    dc->desc = "VFIO-based CCW device assignment";
+    dc->realize = vfio_ccw_realize;
+    dc->unrealize = vfio_ccw_unrealize;
+}
+
+static const TypeInfo vfio_ccw_info = {
+    .name = "vfio-ccw",
+    .parent = TYPE_S390_CCW,
+    .instance_size = sizeof(VFIOCCWDevice),
+    .class_init = vfio_ccw_class_init,
+};
+
+static void register_vfio_ccw_type(void)
+{
+    type_register_static(&vfio_ccw_info);
+}
+
+type_init(register_vfio_ccw_type)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 85c2a74..b751506 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -41,6 +41,7 @@
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
+    VFIO_DEVICE_TYPE_CCW = 2,
 };
 
 typedef struct VFIOMmap {
-- 
2.6.6
