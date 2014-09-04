From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 6/6] s390: Add PCI pass-through device support
Date: Thu, 04 Sep 2014 12:52:29 +0200
Message-ID: <20140904105337.440966290@de.ibm.com>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=102-qemu_s390pci.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch adds a new device class handling s390 pci pass-through device
assignment. The approach is very similar to the x86 device assignment.
The device executes the KVM_ASSIGN_PCI_DEVICE ioctl to create a proxy instance
in the kernel KVM and connect this instance to the host pci device.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 hw/s390x/Makefile.objs  |    2 
 hw/s390x/s390-pci-bus.c |   14 +-
 hw/s390x/s390_pci.c     |  321 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390_pci.h     |   31 ++++
 4 files changed, 365 insertions(+), 3 deletions(-)

--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -8,4 +8,4 @@ obj-y += ipl.o
 obj-y += css.o
 obj-y += s390-virtio-ccw.o
 obj-y += virtio-ccw.o
-obj-$(CONFIG_KVM) += s390-pci-bus.o
+obj-$(CONFIG_KVM) += s390-pci-bus.o s390_pci.o
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -16,6 +16,7 @@
 #include <hw/s390x/sclp.h>
 #include "qemu/error-report.h"
 #include "s390-pci-bus.h"
+#include "s390_pci.h"
 
 /* #define DEBUG_S390PCI_BUS */
 #ifdef DEBUG_S390PCI_BUS
@@ -219,8 +220,17 @@ static void s390_pcihost_hot_plug(Hotplu
     pbdev->pdev = pci_dev;
     pbdev->configured = true;
 
-    pbdev->fh = s390_pci_get_pfh(pci_dev);
-    pbdev->is_virt = 1;
+    if (!strcmp(pci_dev->name, "s390-pci")) {
+        S390PCIDevice *sdev = DO_UPCAST(S390PCIDevice, pdev, pci_dev);
+        pbdev->fh = s390_pci_get_fh(sdev->host);
+        if (!pbdev->fh) {
+            g_free(pbdev);
+            return;
+        }
+    } else {
+        pbdev->fh = s390_pci_get_pfh(pci_dev);
+        pbdev->is_virt = 1;
+    }
 
     QTAILQ_INSERT_TAIL(&device_list, pbdev, next);
     if (dev->hotplugged) {
--- /dev/null
+++ b/hw/s390x/s390_pci.c
@@ -0,0 +1,321 @@
+/*
+ * s390 PCI pass-through device assignment
+ *
+ * Copyright 2014 IBM Corp.
+ * Author(s): Frank Blaschka <frank.blaschka@de.ibm.com>
+ *            Hong Bo Li <lihbbj@cn.ibm.com>
+ *            Yi Min Zhao <zyimin@cn.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <hw/pci/pci.h>
+#include <hw/pci/pci_host.h>
+#include <hw/pci/pci_bus.h>
+#include <net/net.h>
+#include <hw/s390x/css.h>
+#include <hw/s390x/sclp.h>
+#include "exec/exec-all.h"
+#include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
+#include "qemu/error-report.h"
+#include "qapi/qmp/qerror.h"
+
+#include "s390_pci.h"
+#include "s390-pci-bus.h"
+
+/* #define DEBUG_S390PCI */
+#ifdef DEBUG_S390PCI
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "s390pci: " fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+#define ASSIGN_FLAG_HOSTIRQ 0x1
+
+uint32_t s390_pci_get_fh(PCIHostDeviceAddress host)
+{
+    char fh_path[128];
+    struct stat st;
+    FILE *fd;
+    uint32_t fh;
+
+    snprintf(fh_path, sizeof(fh_path),
+        "/sys/bus/pci/devices/%04x:%02x:%02x.%x/function_handle",
+        host.domain, host.bus, host.slot, host.function);
+
+    if (stat(fh_path, &st)) {
+        error_report("get function handle faild: no host device specified");
+        return -1;
+    }
+
+    fd = fopen(fh_path, "r");
+    if (fd == NULL) {
+        error_report("%s: %s: %m", __func__, fh_path);
+        return 0;
+    }
+    if (fscanf(fd, "%x", &fh) != 1) {
+        fclose(fd);
+        return 0;
+    }
+    fclose(fd);
+    return fh;
+}
+
+uint32_t s390_pci_get_fid(PCIHostDeviceAddress host)
+{
+    char fid_path[128];
+    struct stat st;
+    FILE *fd;
+    uint32_t fid;
+
+    snprintf(fid_path, sizeof(fid_path),
+        "/sys/bus/pci/devices/%04x:%02x:%02x.%x/function_id",
+        host.domain, host.bus, host.slot, host.function);
+
+    if (stat(fid_path, &st)) {
+        error_report("get function id faild: no host device specified");
+        return -1;
+    }
+
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: %s: %m", __func__, fid_path);
+        return -1;
+    }
+    if (fscanf(fd, "%x", &fid) != 1) {
+        fclose(fd);
+        return -1;
+    }
+    fclose(fd);
+    return fid;
+}
+
+static int get_real_id(const char *devpath, const char *idname, uint16_t *val)
+{
+    FILE *f;
+    char name[128];
+    long id;
+
+    snprintf(name, sizeof(name), "%s%s", devpath, idname);
+    f = fopen(name, "r");
+    if (f == NULL) {
+        error_report("%s: %s: %m", __func__, name);
+        return -1;
+    }
+    if (fscanf(f, "%li\n", &id) == 1) {
+        *val = id;
+    } else {
+        fclose(f);
+        return -1;
+    }
+    fclose(f);
+
+    return 0;
+}
+
+static int get_real_vendor_id(const char *devpath, uint16_t *val)
+{
+    return get_real_id(devpath, "vendor", val);
+}
+
+static int get_real_device_id(const char *devpath, uint16_t *val)
+{
+    return get_real_id(devpath, "device", val);
+}
+
+static void assign_failed_examine(S390PCIDevice *dev)
+{
+    char name[PATH_MAX], dir[PATH_MAX], driver[PATH_MAX] = {}, *ns;
+    uint16_t vendor_id, device_id;
+    int rc;
+
+    snprintf(dir, sizeof(dir), "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/",
+            dev->host.domain, dev->host.bus, dev->host.slot,
+            dev->host.function);
+
+    snprintf(name, sizeof(name), "%sdriver", dir);
+
+    rc = readlink(name, driver, sizeof(driver));
+    if ((rc <= 0) || rc >= sizeof(driver)) {
+        goto fail;
+    }
+
+    driver[rc] = 0;
+    ns = strrchr(driver, '/');
+    if (!ns) {
+        goto fail;
+    }
+
+    ns++;
+
+    if (get_real_vendor_id(dir, &vendor_id) ||
+        get_real_device_id(dir, &device_id)) {
+        goto fail;
+    }
+
+    error_printf("*** The driver '%s' is occupying your device "
+        "%04x:%02x:%02x.%x.\n"
+        "***\n"
+        "*** You can try the following commands to free it:\n"
+        "***\n"
+        "*** $ echo \"%04x %04x\" > /sys/bus/pci/drivers/pci-stub/new_id\n"
+        "*** $ echo \"%04x:%02x:%02x.%x\" > /sys/bus/pci/drivers/%s/unbind\n"
+        "*** $ echo \"%04x:%02x:%02x.%x\" > /sys/bus/pci/drivers/"
+        "pci-stub/bind\n"
+        "*** $ echo \"%04x %04x\" > /sys/bus/pci/drivers/pci-stub/remove_id\n"
+        "***\n",
+        ns, dev->host.domain, dev->host.bus, dev->host.slot,
+        dev->host.function, vendor_id, device_id,
+        dev->host.domain, dev->host.bus, dev->host.slot, dev->host.function,
+        ns, dev->host.domain, dev->host.bus, dev->host.slot,
+        dev->host.function, vendor_id, device_id);
+
+    return;
+
+fail:
+    error_report("Couldn't find out why.");
+}
+
+static int s390_initfn(PCIDevice *pdev)
+{
+    char dir[128], name[128];
+    struct stat st;
+    int cfd;
+    int rc;
+    S390PCIDevice *vdev = DO_UPCAST(S390PCIDevice, pdev, pdev);
+    struct kvm_assigned_pci_dev dev_data = {
+        .segnr = vdev->host.domain,
+        .busnr = vdev->host.bus,
+        .devfn = PCI_DEVFN(vdev->host.slot, vdev->host.function),
+        .flags = 0,
+    };
+
+    if (!kvm_enabled()) {
+        error_report("s390pci-assign: error: requires KVM support");
+        return -1;
+    }
+
+    snprintf(dir, sizeof(dir),
+        "/sys/bus/pci/devices/%04x:%02x:%02x.%x/",
+        vdev->host.domain, vdev->host.bus, vdev->host.slot,
+        vdev->host.function);
+
+    if (stat(dir, &st)) {
+        error_report("s390pci-assign: error: no host device specified");
+        return -1;
+    }
+
+    snprintf(name, sizeof(name), "%sconfig", dir);
+
+    cfd = open(name, O_RDWR);
+    if (cfd == -1) {
+        error_report("%s: %s: %m", __func__, name);
+        return -1;
+    }
+
+    do {
+        rc = read(cfd, pdev->config, pci_config_size(pdev));
+        if (rc >= 0) {
+            break;
+        }
+    } while (errno == EINTR || errno == EAGAIN);
+
+    if (rc < 0) {
+        error_report("%s: read failed, errno = %d", __func__, errno);
+    }
+    close(cfd);
+
+    dev_data.assigned_dev_id =
+        (vdev->host.domain << 16) | (vdev->host.bus << 8) | dev_data.devfn;
+
+    DPRINTF("%04x:%02x:%02x.%x fid 0x%x fh 0x%x dev_id 0x%x\n",
+        vdev->host.domain, vdev->host.bus, vdev->host.slot,
+        vdev->host.function, s390_pci_get_fid(vdev->host),
+        s390_pci_get_fh(vdev->host), dev_data.assigned_dev_id);
+
+    if (vdev->hostirq) {
+        dev_data.flags |= ASSIGN_FLAG_HOSTIRQ;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_ASSIGN_PCI_DEVICE, &dev_data);
+    if (rc) {
+        error_report("Failed to assign device \"0x%x\" : %s",
+                     dev_data.assigned_dev_id, strerror(-rc));
+        switch (rc) {
+        case -EBUSY:
+            assign_failed_examine(vdev);
+            break;
+        default:
+            break;
+        }
+        return rc;
+    }
+
+    vdev->dev_id = dev_data.assigned_dev_id;
+    return rc;
+}
+
+static void s390_exitfn(PCIDevice *pdev)
+{
+    int rc;
+
+    S390PCIDevice *vdev = DO_UPCAST(S390PCIDevice, pdev, pdev);
+    struct kvm_assigned_pci_dev dev_data = {
+        .assigned_dev_id = vdev->dev_id,
+    };
+
+    DPRINTF("%s(%04x:%02x:%02x.%x)\n", __func__, vdev->host.domain,
+            vdev->host.bus, vdev->host.slot, vdev->host.function);
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_DEASSIGN_PCI_DEVICE, &dev_data);
+    assert(rc == 0);
+}
+
+static void s390_pci_reset(DeviceState *dev)
+{
+    return;
+}
+
+static Property s390_pci_dev_properties[] = {
+    DEFINE_PROP_PCI_HOST_DEVADDR("host", S390PCIDevice, host),
+    DEFINE_PROP_UINT32("hostirq", S390PCIDevice, hostirq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription s390_pci_vmstate = {
+    .name = "s390-pci",
+    .unmigratable = 1,
+};
+
+static void s390_pci_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    dc->reset = s390_pci_reset;
+    dc->props = s390_pci_dev_properties;
+    dc->vmsd = &s390_pci_vmstate;
+    dc->desc = "s390-based PCI device assignment";
+    pdc->init = s390_initfn;
+    pdc->exit = s390_exitfn;
+    pdc->is_express = 1;
+}
+
+static const TypeInfo s390_pci_dev_info = {
+    .name = "s390-pci",
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(S390PCIDevice),
+    .class_init = s390_pci_dev_class_init,
+};
+
+static void register_s390_pci_dev_type(void)
+{
+    type_register_static(&s390_pci_dev_info);
+}
+
+type_init(register_s390_pci_dev_type)
--- /dev/null
+++ b/hw/s390x/s390_pci.h
@@ -0,0 +1,31 @@
+/*
+ * s390 PCI pass-through device assignment definitions
+ *
+ * Copyright 2014 IBM Corp.
+ * Author(s): Frank Blaschka <frank.blaschka@de.ibm.com>
+ *            Hong Bo Li <lihbbj@cn.ibm.com>
+ *            Yi Min Zhao <zyimin@cn.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_PCI_H
+#define HW_S390_PCI_H
+
+#include <hw/pci/pci.h>
+
+typedef struct S390PCIDevice {
+    PCIDevice pdev;
+    PCIHostDeviceAddress host;
+    QLIST_ENTRY(s390PCIDevice) next;
+    uint32_t dev_id;
+    uint32_t fid;
+    uint32_t hostirq;
+} S390PCIDevice;
+
+uint32_t s390_pci_get_fh(PCIHostDeviceAddress host);
+uint32_t s390_pci_get_fid(PCIHostDeviceAddress host);
+
+#endif
