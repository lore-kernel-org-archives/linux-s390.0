From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 6/9] s390x/css: device and bus support for s390-ccw passthrough
Date: Fri, 29 Apr 2016 14:13:20 +0200
Message-ID: <1461932003-23830-7-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

In order to support ccw device pass-through, we introduce a s390
ccw device called "s390-ccw" to hold the real device info. As the
existing virtual-css-bridge and virtual-css-bus are designed to
support virtio_ccw devices for S390x virtio machine. We want to put
passthroughed devices on a different bus, so we implement a css bridge
called "s390-ccw-bridge", and a css bus called "s390-ccw-bus", which
is the groundwork of the passed-through vfio_ccw devices.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/Makefile.objs     |   2 +-
 hw/s390x/css.h             |   3 +
 hw/s390x/s390-ccw-bus.c    | 114 +++++++++++++++++++++++++++++
 hw/s390x/s390-ccw-bus.h    |  30 ++++++++
 hw/s390x/s390-ccw.c        | 177 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-ccw.h        |  40 ++++++++++
 hw/s390x/s390-virtio-ccw.c |   3 +
 hw/s390x/virtio-ccw.h      |   2 -
 8 files changed, 368 insertions(+), 3 deletions(-)
 create mode 100644 hw/s390x/s390-ccw-bus.c
 create mode 100644 hw/s390x/s390-ccw-bus.h
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 35b5d27..214802f 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -11,4 +11,4 @@ obj-y += virtio-ccw.o
 obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
-obj-y += s390-ccwchain.o
+obj-y += s390-ccwchain.o s390-ccw-bus.o s390-ccw.o
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index bd45951..c280226 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -15,6 +15,7 @@
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
 #include "ioinst.h"
+#include "hw/hw.h"
 
 /* Channel subsystem constants. */
 #define MAX_SCHID 65535
@@ -24,6 +25,8 @@
 
 #define MAX_CIWS 62
 
+#define VIRTUAL_CSSID 0xfe
+
 typedef struct CIW {
     uint8_t type;
     uint8_t command;
diff --git a/hw/s390x/s390-ccw-bus.c b/hw/s390x/s390-ccw-bus.c
new file mode 100644
index 0000000..19f81ac
--- /dev/null
+++ b/hw/s390x/s390-ccw-bus.c
@@ -0,0 +1,114 @@
+/*
+ * s390 CCW BUS
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version
+ * 2 or (at your option) any later version. See the COPYING file
+ * in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "css.h"
+#include "s390-ccw-bus.h"
+#include "s390-ccw.h"
+
+static void s390_ccw_unplug(HotplugHandler *hotplug_dev,
+                            DeviceState *dev, Error **errp)
+{
+    S390CCWDevice *vcdev = DO_UPCAST(S390CCWDevice, parent, dev);
+    SubchDev *sch = vcdev->sch;
+
+    /*
+     * We should arrive here only for device_del, since we don't
+     * support direct hot(un)plug of channels.
+     */
+    assert(sch != NULL);
+    /* Subchannel is now disabled and no longer valid. */
+    sch->curr_status.pmcw.flags &= ~(PMCW_FLAGS_MASK_ENA |
+                                     PMCW_FLAGS_MASK_DNV);
+
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid, 1, 0);
+
+    object_unparent(OBJECT(dev));
+}
+
+static void s390_ccw_bus_reset(BusState *qbus)
+{
+    /* This should actually be modelled via the generic css. */
+    css_reset();
+}
+
+static void s390_ccw_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+
+    k->reset = s390_ccw_bus_reset;
+}
+
+static const TypeInfo s390_ccw_bus_info = {
+    .name          = TYPE_S390_CCW_BUS,
+    .parent        = TYPE_BUS,
+    .instance_size = sizeof(S390CCWBus),
+    .class_init    = s390_ccw_bus_class_init,
+};
+
+static int s390_ccw_bridge_init(SysBusDevice *dev)
+{
+    /* Do nothing. */
+    return 0;
+}
+
+static void s390_ccw_bridge_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+
+    hc->unplug = s390_ccw_unplug;
+    k->init = s390_ccw_bridge_init;
+}
+
+static const TypeInfo s390_ccw_bridge_info = {
+    .name          = TYPE_S390_CCW_BRIDGE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SysBusDevice),
+    .class_init    = s390_ccw_bridge_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
+};
+
+/********************* Create s390 CCW Bridge and Bus ************/
+S390CCWBus *s390_ccw_bus_init(void)
+{
+    S390CCWBus *cbus;
+    BusState *bus;
+    DeviceState *dev;
+
+    /* Create bridge device. */
+    dev = qdev_create(NULL, TYPE_S390_CCW_BRIDGE);
+    qdev_init_nofail(dev);
+
+    /* Create bus on bridge device. */
+    bus = qbus_create(TYPE_S390_CCW_BUS, dev, "s390-ccw");
+    cbus = S390_CCW_BUS(bus);
+
+    cbus->map_vir_css = s390_get_map_css();
+
+    /* Enable hotplugging. */
+    qbus_set_hotplug_handler(bus, dev, &error_abort);
+
+    return cbus;
+}
+
+static void s390_ccw_register(void)
+{
+    type_register_static(&s390_ccw_bus_info);
+    type_register_static(&s390_ccw_bridge_info);
+}
+
+type_init(s390_ccw_register)
diff --git a/hw/s390x/s390-ccw-bus.h b/hw/s390x/s390-ccw-bus.h
new file mode 100644
index 0000000..493c8f5
--- /dev/null
+++ b/hw/s390x/s390-ccw-bus.h
@@ -0,0 +1,30 @@
+/*
+ * s390 CCW Bus and Bridge definitions
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_CCW_BUS_H
+#define HW_S390_CCW_BUS_H
+
+/* s390 CCW Bus Type. */
+typedef struct S390CCWBus {
+    BusState parent_obj;
+    bool map_vir_css;
+} S390CCWBus;
+
+#define TYPE_S390_CCW_BUS "s390-ccw-bus"
+#define S390_CCW_BUS(obj) \
+    OBJECT_CHECK(S390CCWBus, (obj), TYPE_S390_CCW_BUS)
+
+/* s390 CCW Bridge Type. */
+#define TYPE_S390_CCW_BRIDGE "s390-ccw-bridge"
+
+S390CCWBus *s390_ccw_bus_init(void);
+#endif
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
new file mode 100644
index 0000000..7b378f9
--- /dev/null
+++ b/hw/s390x/s390-ccw.c
@@ -0,0 +1,177 @@
+/*
+ * s390 CCW Assignment Support
+ *
+ * Copyright 2016 IBM Corp
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
+#include "css.h"
+#include "s390-ccw-bus.h"
+#include "s390-ccw.h"
+
+static void s390_ccw_realize(S390CCWDevice *cdev, Error **errp)
+{
+    unsigned int cssid, ssid, devno, schid;
+    bool found;
+    int ret;
+    BusState *qbus;
+    S390CCWBus *cbus;
+    SubchDev *sch;
+    DeviceState *parent = DEVICE(cdev);
+    char dummy_char;
+    char *symlink_target = NULL;
+    char *path = NULL;
+    char *hschid;
+    GError *gerror;
+
+    /* Store host id. */
+    ret = sscanf(cdev->hostid, "%x.%x.%04x%c",
+                 &cdev->hcssid, &cdev->hssid, &cdev->hdevno, &dummy_char);
+    if (ret != 3) {
+        error_setg(errp, "Malformed hostid parameter '%s'", cdev->hostid);
+        return;
+    }
+
+    /* Store guest id. */
+    if (cdev->guestid) {
+        ret = sscanf(cdev->guestid, "%x.%x.%04x%c",
+                     &cssid, &ssid, &devno, &dummy_char);
+        if (ret != 3) {
+            error_setg(errp, "Malformed guestid parameter '%s'",
+                       cdev->guestid);
+            return;
+        }
+        if (cssid == VIRTUAL_CSSID) {
+            error_setg(errp, "Malformed cssid %x of guestid", cssid);
+            return;
+        }
+
+        ret = css_create_css_image(cssid, false);
+        if (ret == -EINVAL) {
+            error_setg(errp, "Invalid cssid: %x", cssid);
+            return;
+        }
+    } else {
+        cssid = cdev->hcssid;
+        ssid = cdev->hssid;
+        devno = cdev->hdevno;
+    }
+
+    qbus = qdev_get_parent_bus(parent);
+    cbus = S390_CCW_BUS(qbus);
+    if (cbus->map_vir_css) {
+        cssid = VIRTUAL_CSSID;
+    }
+
+    if (cssid > MAX_CSSID || ssid > MAX_SSID) {
+        error_setg(errp, "Invalid cssid or ssid: cssid %x, ssid %x",
+                   cssid, ssid);
+        return;
+    }
+
+    if (css_devno_used(cssid, ssid, devno)) {
+        error_setg(errp, "Device %x.%x.%04x already exists",
+                   cssid, ssid, devno);
+        return;
+    }
+
+    sch = g_new0(SubchDev, 1);
+    sch->driver_data = cdev;
+    sch->cssid = cssid;
+    sch->ssid = ssid;
+    sch->devno = devno;
+
+    cdev->sch = NULL;
+
+    /* Find free subchannel id. */
+    found = false;
+    for (schid = 0; schid <= MAX_SCHID; schid++) {
+        if (!css_find_subch(1, sch->cssid, sch->ssid, schid)) {
+            sch->schid = schid;
+            css_subch_assign(sch->cssid, sch->ssid, sch->schid,
+                             sch->devno, sch);
+            found = true;
+            break;
+        }
+    }
+    if (!found) {
+        error_setg(errp, "No free subchannel found for %x.%x.%04x",
+                   sch->cssid, sch->ssid, sch->devno);
+        goto out_err;
+    }
+
+    /* Build initial schib. */
+    path = g_strdup_printf("/sys/bus/ccw/devices/%s", cdev->hostid);
+    symlink_target = g_file_read_link(path, &gerror);
+    if (!symlink_target) {
+        error_setg(errp, "%s: Failed to readlink from: %s",
+                   __func__, path);
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        goto out_err;
+    }
+    hschid = basename(dirname(symlink_target));
+    ret = css_sch_build_schib(sch, hschid);
+    if (ret) {
+        error_setg(errp, "%s: Failed to build initial schib: %d",
+                   __func__, ret);
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        goto out_err;
+    }
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
+                          parent->hotplugged, 1);
+
+    cdev->sch = sch;
+
+out_err:
+    if (!cdev->sch) {
+        g_free(sch);
+    }
+    g_free(symlink_target);
+    g_free(path);
+}
+
+static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
+{
+    SubchDev *sch = cdev->sch;
+
+    if (sch) {
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        g_free(sch);
+        cdev->sch = NULL;
+    }
+}
+
+static void s390_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_S390_CCW_BUS;
+    cdc->realize = s390_ccw_realize;
+    cdc->unrealize = s390_ccw_unrealize;
+}
+
+static const TypeInfo s390_ccw_info = {
+    .name          = TYPE_S390_CCW,
+    .parent        = TYPE_DEVICE,
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
index 0000000..a3cd9df
--- /dev/null
+++ b/hw/s390x/s390-ccw.h
@@ -0,0 +1,40 @@
+/*
+ * s390 CCW Assignment Support
+ *
+ * Copyright 2016 IBM Corp.
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
+#define TYPE_S390_CCW "s390-ccw"
+#define S390_CCW_DEVICE(obj) \
+    OBJECT_CHECK(S390CCWDevice, (obj), TYPE_S390_CCW)
+#define S390_CCW_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(S390CCWDeviceClass, (klass), TYPE_S390_CCW)
+#define S390_CCW_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(S390CCWDeviceClass, (obj), TYPE_S390_CCW)
+
+typedef struct S390CCWDevice {
+    DeviceState parent;
+    SubchDev *sch;
+    char *hostid;
+    char *guestid;
+    unsigned int hcssid;
+    unsigned int hssid;
+    unsigned int hdevno;
+} S390CCWDevice;
+
+typedef struct S390CCWDeviceClass {
+    DeviceClass parent_class;
+    void (*realize)(S390CCWDevice *dev, Error **errp);
+    void (*unrealize)(S390CCWDevice *dev, Error **errp);
+} S390CCWDeviceClass;
+
+#endif
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c4706b7..1637006 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -23,6 +23,7 @@
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
 #include "s390-pci-bus.h"
+#include "s390-ccw-bus.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/compat.h"
 #include "hw/s390x/s390-virtio-ccw.h"
@@ -117,6 +118,8 @@ static void ccw_init(MachineState *machine)
                       machine->initrd_filename, "s390-ccw.img", true);
     s390_flic_init();
 
+    s390_ccw_bus_init();
+
     dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
                               OBJECT(dev), NULL);
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 66c831b..90b7769 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -26,8 +26,6 @@
 
 #include "css.h"
 
-#define VIRTUAL_CSSID 0xfe
-
 #define VIRTIO_CCW_CU_TYPE 0x3832
 #define VIRTIO_CCW_CHPID_TYPE 0x32
 
-- 
2.6.6
