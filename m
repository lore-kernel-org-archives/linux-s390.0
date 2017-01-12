From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 06/12] s390x/css: device support for s390-ccw passthrough
Date: Thu, 12 Jan 2017 08:25:07 +0100
Message-ID: <20170112072513.98411-7-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

In order to support subchannels pass-through, we introduce a s390
subchannel device called "s390-ccw" to hold the real subchannel info.
The s390-ccw devices inherit from the abstract CcwDevice which connect
to the existing virtual-css-bus.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/Makefile.objs        |   1 +
 hw/s390x/css-bridge.c         |   3 ++
 hw/s390x/s390-ccw.c           | 120 ++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-ccw.h           |  37 +++++++++++++
 include/hw/s390x/css-bridge.h |   1 +
 5 files changed, 162 insertions(+)
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 41ac4ec..72a3d37 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -13,3 +13,4 @@ obj-y += ccw-device.o
 obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
+obj-y += s390-ccw.o
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 9a7f7ee..6523242 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -17,6 +17,7 @@
 #include "hw/s390x/css.h"
 #include "ccw-device.h"
 #include "hw/s390x/css-bridge.h"
+#include "target-s390x/cpu.h"
 
 /*
  * Invoke device-specific unplug handler, disable the subchannel
@@ -104,6 +105,8 @@ VirtualCssBus *virtual_css_bus_init(void)
     bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
     cbus = VIRTUAL_CSS_BUS(bus);
 
+    cbus->map_vir_css = s390_get_map_css();
+
     /* Enable hotplugging */
     qbus_set_hotplug_handler(bus, dev, &error_abort);
 
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
new file mode 100644
index 0000000..6881fc6
--- /dev/null
+++ b/hw/s390x/s390-ccw.c
@@ -0,0 +1,120 @@
+/*
+ * s390 CCW Assignment Support
+ *
+ * Copyright 2017 IBM Corp
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or (at your option) any later version. See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "libgen.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/css-bridge.h"
+#include "s390-ccw.h"
+
+static void s390_ccw_realize(S390CCWDevice *cdev, Error **errp)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
+    DeviceState *parent = DEVICE(ccw_dev);
+    BusState *qbus;
+    VirtualCssBus *cbus;
+    SubchDev *sch;
+    CssDevId bus_id;
+    int ret;
+
+    if (!cdev->hostid.valid) {
+        error_setg(errp, "Invalid hostid");
+        return;
+    }
+
+    qbus = qdev_get_parent_bus(parent);
+    cbus = VIRTUAL_CSS_BUS(qbus);
+    if (ccw_dev->bus_id.valid) {
+        bus_id = ccw_dev->bus_id;
+
+        if (bus_id.cssid == VIRTUAL_CSSID) {
+            error_setg(errp, "Bad guest id: VIRTUAL_CSSID %x forbidden",
+                       bus_id.cssid);
+            return;
+        }
+
+        if (!cbus->map_vir_css) {
+            ret = css_create_css_image(bus_id.cssid, false);
+            if (ret == -EINVAL) {
+                error_setg(errp, "Invalid cssid: %x", bus_id.cssid);
+                return;
+            }
+        }
+    } else {
+        bus_id = cdev->hostid;
+    }
+
+    if (cbus->map_vir_css) {
+        bus_id.cssid = VIRTUAL_CSSID;
+    }
+
+    sch = css_create_sch(bus_id, errp);
+    if (!sch) {
+        return;
+    }
+
+    sch->driver_data = cdev;
+
+    ret = css_sch_build_schib(sch, &cdev->hostid);
+    if (ret) {
+        error_setg(errp, "%s: Failed to build initial schib: %d",
+                   __func__, ret);
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        g_free(sch);
+        return;
+    }
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
+                          parent->hotplugged, 1);
+
+    ccw_dev->sch = sch;
+    return;
+}
+
+static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
+    SubchDev *sch = ccw_dev->sch;
+
+    if (sch) {
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        g_free(sch);
+        ccw_dev->sch = NULL;
+    }
+}
+
+static void s390_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    cdc->realize = s390_ccw_realize;
+    cdc->unrealize = s390_ccw_unrealize;
+}
+
+static const TypeInfo s390_ccw_info = {
+    .name          = TYPE_S390_CCW,
+    .parent        = TYPE_CCW_DEVICE,
+    .instance_size = sizeof(S390CCWDevice),
+    .abstract      = true,
+    .class_size    = sizeof(S390CCWDeviceClass),
+    .class_init    = s390_ccw_class_init,
+};
+
+static void register_s390_ccw_type(void)
+{
+    type_register_static(&s390_ccw_info);
+}
+
+type_init(register_s390_ccw_type)
diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
new file mode 100644
index 0000000..9ced8cb
--- /dev/null
+++ b/hw/s390x/s390-ccw.h
@@ -0,0 +1,37 @@
+/*
+ * s390 CCW Assignment Support
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_CCW_H
+#define HW_S390_CCW_H
+
+#include "hw/s390x/ccw-device.h"
+
+#define TYPE_S390_CCW "s390-ccw"
+#define S390_CCW_DEVICE(obj) \
+    OBJECT_CHECK(S390CCWDevice, (obj), TYPE_S390_CCW)
+#define S390_CCW_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(S390CCWDeviceClass, (klass), TYPE_S390_CCW)
+#define S390_CCW_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(S390CCWDeviceClass, (obj), TYPE_S390_CCW)
+
+typedef struct S390CCWDevice {
+    CcwDevice parent_obj;
+    CssDevId hostid;
+} S390CCWDevice;
+
+typedef struct S390CCWDeviceClass {
+    CCWDeviceClass parent_class;
+    void (*realize)(S390CCWDevice *dev, Error **errp);
+    void (*unrealize)(S390CCWDevice *dev, Error **errp);
+} S390CCWDeviceClass;
+
+#endif
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.h
index 5a0203b..3fa842b 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -28,6 +28,7 @@ typedef struct VirtualCssBridge {
 /* virtual css bus type */
 typedef struct VirtualCssBus {
     BusState parent_obj;
+    bool map_vir_css;
 } VirtualCssBus;
 
 #define TYPE_VIRTUAL_CSS_BUS "virtual-css-bus"
-- 
2.8.4
