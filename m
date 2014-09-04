From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 5/6] s390: Add PCI bus support
Date: Thu, 04 Sep 2014 12:52:28 +0200
Message-ID: <20140904105337.321453823@de.ibm.com>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=101-qemu_bus.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch implements a pci bus for s390x together with some infrastructure
to generate and handle hotplug events. It also provides device 
configuration/unconfiguration via sclp instruction interception.
    
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 default-configs/s390x-softmmu.mak |    1 
 hw/s390x/Makefile.objs            |    1 
 hw/s390x/css.c                    |    5 
 hw/s390x/css.h                    |    1 
 hw/s390x/s390-pci-bus.c           |  287 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-bus.h           |  139 ++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c        |    2 
 hw/s390x/sclp.c                   |   10 +
 include/hw/s390x/sclp.h           |    8 +
 target-s390x/Makefile.objs        |    2 
 target-s390x/ioinst.c             |   52 ++++++
 target-s390x/ioinst.h             |    1 
 target-s390x/kvm.c                |    5 
 target-s390x/pci_ic.c             |  230 ++++++++++++++++++++++++++++++
 target-s390x/pci_ic.h             |  214 ++++++++++++++++++++++++++++
 15 files changed, 956 insertions(+), 2 deletions(-)

--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,4 +1,5 @@
 CONFIG_VIRTIO=y
+CONFIG_PCI=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -8,3 +8,4 @@ obj-y += ipl.o
 obj-y += css.o
 obj-y += s390-virtio-ccw.o
 obj-y += virtio-ccw.o
+obj-$(CONFIG_KVM) += s390-pci-bus.o
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1281,6 +1281,11 @@ void css_generate_chp_crws(uint8_t cssid
     /* TODO */
 }
 
+void css_generate_css_crws(uint8_t cssid)
+{
+    css_queue_crw(CRW_RSC_CSS, 0, 0, 0);
+}
+
 int css_enable_mcsse(void)
 {
     trace_css_enable_facility("mcsse");
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -99,6 +99,7 @@ void css_queue_crw(uint8_t rsc, uint8_t
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add);
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
+void css_generate_css_crws(uint8_t cssid);
 void css_adapter_interrupt(uint8_t isc);
 
 #define CSS_IO_ADAPTER_VIRTIO 1
--- /dev/null
+++ b/hw/s390x/s390-pci-bus.c
@@ -0,0 +1,287 @@
+/*
+ * s390 PCI BUS
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
+#include <hw/s390x/css.h>
+#include <hw/s390x/sclp.h>
+#include "qemu/error-report.h"
+#include "s390-pci-bus.h"
+
+/* #define DEBUG_S390PCI_BUS */
+#ifdef DEBUG_S390PCI_BUS
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+static QTAILQ_HEAD(, SeiContainer) pending_sei =
+    QTAILQ_HEAD_INITIALIZER(pending_sei);
+static QTAILQ_HEAD(, S390PCIBusDevice) device_list =
+    QTAILQ_HEAD_INITIALIZER(device_list);
+
+int chsc_sei_nt2_get_event(void *res)
+{
+    ChscSeiNt2Res *nt2_res = (ChscSeiNt2Res *)res;
+    PciCcdfAvail *accdf;
+    PciCcdfErr *eccdf;
+    int rc = 1;
+    SeiContainer *sei_cont;
+
+    sei_cont = QTAILQ_FIRST(&pending_sei);
+    if (sei_cont) {
+        QTAILQ_REMOVE(&pending_sei, sei_cont, link);
+        nt2_res->nt = 2;
+        nt2_res->cc = sei_cont->cc;
+        switch (sei_cont->cc) {
+        case 1: /* error event */
+            eccdf = (PciCcdfErr *)nt2_res->ccdf;
+            eccdf->fid = cpu_to_be32(sei_cont->fid);
+            eccdf->fh = cpu_to_be32(sei_cont->fh);
+            break;
+        case 2: /* availability event */
+            accdf = (PciCcdfAvail *)nt2_res->ccdf;
+            accdf->fid = cpu_to_be32(sei_cont->fid);
+            accdf->fh = cpu_to_be32(sei_cont->fh);
+            accdf->pec = cpu_to_be16(sei_cont->pec);
+            break;
+        default:
+            abort();
+        }
+        g_free(sei_cont);
+        rc = 0;
+    }
+
+    return rc;
+}
+
+int chsc_sei_nt2_have_event(void)
+{
+    return !QTAILQ_EMPTY(&pending_sei);
+}
+
+static S390PCIBusDevice *s390_pci_find_dev_by_fid(uint32_t fid)
+{
+    S390PCIBusDevice *pbdev;
+
+    QTAILQ_FOREACH(pbdev, &device_list, next) {
+        if (pbdev->fid == fid) {
+            return pbdev;
+        }
+    }
+    return NULL;
+}
+
+void s390_pci_sclp_configure(int configure, SCCB *sccb)
+{
+    PciCfgSccb *psccb = (PciCfgSccb *)sccb;
+    S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(be32_to_cpu(psccb->aid));
+    uint16_t rc;
+
+    if (pbdev) {
+        if ((configure == 1 && pbdev->configured == true) ||
+            (configure == 0 && pbdev->configured == false)) {
+            rc = SCLP_RC_NO_ACTION_REQUIRED;
+        } else {
+            pbdev->configured = !pbdev->configured;
+            rc = SCLP_RC_NORMAL_COMPLETION;
+        }
+    } else {
+        DPRINTF("sclp config %d no dev found\n", configure);
+        rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
+    }
+
+    psccb->header.response_code = cpu_to_be16(rc);
+    return;
+}
+
+static uint32_t s390_pci_get_pfid(PCIDevice *pdev)
+{
+    return PCI_SLOT(pdev->devfn);
+}
+
+static uint32_t s390_pci_get_pfh(PCIDevice *pdev)
+{
+    return PCI_SLOT(pdev->devfn) | FH_VIRT;
+}
+
+S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx)
+{
+    S390PCIBusDevice *dev;
+    int i = 0;
+
+    QTAILQ_FOREACH(dev, &device_list, next) {
+        if (i == idx) {
+            return dev;
+        }
+        i++;
+    }
+    return NULL;
+}
+
+S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh)
+{
+    S390PCIBusDevice *pbdev;
+
+    QTAILQ_FOREACH(pbdev, &device_list, next) {
+        if (pbdev->fh == fh) {
+            return pbdev;
+        }
+    }
+    return NULL;
+}
+
+static S390PCIBusDevice *s390_pci_find_dev_by_pdev(PCIDevice *pdev)
+{
+    S390PCIBusDevice *pbdev;
+
+    QTAILQ_FOREACH(pbdev, &device_list, next) {
+        if (pbdev->pdev == pdev) {
+            return pbdev;
+        }
+    }
+    return NULL;
+}
+
+static void s390_pci_generate_plug_event(uint16_t pec, uint32_t fh,
+                                         uint32_t fid)
+{
+    SeiContainer *sei_cont = g_malloc0(sizeof(SeiContainer));
+
+    sei_cont->fh = fh;
+    sei_cont->fid = fid;
+    sei_cont->cc = 2;
+    sei_cont->pec = pec;
+
+    QTAILQ_INSERT_TAIL(&pending_sei, sei_cont, link);
+    css_generate_css_crws(0);
+}
+
+static void s390_pci_set_irq(void *opaque, int irq, int level)
+{
+    /* nothing to do */
+}
+
+static int s390_pci_map_irq(PCIDevice *pci_dev, int irq_num)
+{
+    /* nothing to do */
+    return 0;
+}
+
+void s390_pci_bus_init(void)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
+    qdev_init_nofail(dev);
+}
+
+static int s390_pcihost_init(SysBusDevice *dev)
+{
+    PCIBus *b;
+    BusState *bus;
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+
+    DPRINTF("host_init\n");
+
+    b = pci_register_bus(DEVICE(dev), NULL,
+                         s390_pci_set_irq, s390_pci_map_irq, NULL,
+                         get_system_memory(), get_system_io(), 0, 64,
+                         TYPE_PCI_BUS);
+
+    bus = BUS(b);
+    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
+    phb->bus = b;
+
+    return 0;
+}
+
+static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
+                                  DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    S390PCIBusDevice *pbdev;
+
+    pbdev = g_malloc0(sizeof(*pbdev));
+
+    pbdev->fid = s390_pci_get_pfid(pci_dev);
+    pbdev->pdev = pci_dev;
+    pbdev->configured = true;
+
+    pbdev->fh = s390_pci_get_pfh(pci_dev);
+    pbdev->is_virt = 1;
+
+    QTAILQ_INSERT_TAIL(&device_list, pbdev, next);
+    if (dev->hotplugged) {
+        s390_pci_generate_plug_event(HP_EVENT_RESERVED_TO_STANDBY,
+                                     pbdev->fh, pbdev->fid);
+        s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED,
+                                     pbdev->fh, pbdev->fid);
+    }
+    return;
+}
+
+static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    S390PCIBusDevice *pbdev;
+
+    pbdev = s390_pci_find_dev_by_pdev(pci_dev);
+    if (!pbdev) {
+        DPRINTF("Error, can't find hot-unplug device in list\n");
+        return;
+    }
+
+    if (pbdev->configured) {
+        pbdev->configured = false;
+        s390_pci_generate_plug_event(HP_EVENT_CONFIGURED_TO_STBRES,
+                                     pbdev->fh, pbdev->fid);
+    }
+
+    QTAILQ_REMOVE(&device_list, pbdev, next);
+    s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED, 0, 0);
+    object_unparent(OBJECT(pci_dev));
+    g_free(pbdev);
+}
+
+static void s390_pcihost_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+
+    dc->cannot_instantiate_with_device_add_yet = true;
+    k->init = s390_pcihost_init;
+    hc->plug = s390_pcihost_hot_plug;
+    hc->unplug = s390_pcihost_hot_unplug;
+}
+
+static const TypeInfo s390_pcihost_info = {
+    .name          = TYPE_S390_PCI_HOST_BRIDGE,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(S390pciState),
+    .class_init    = s390_pcihost_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    }
+};
+
+static void s390_pci_register_types(void)
+{
+    type_register_static(&s390_pcihost_info);
+}
+
+type_init(s390_pci_register_types)
--- /dev/null
+++ b/hw/s390x/s390-pci-bus.h
@@ -0,0 +1,139 @@
+/*
+ * s390 PCI BUS definitions
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
+#ifndef HW_S390_PCI_BUS_H
+#define HW_S390_PCI_BUS_H
+
+#include <hw/pci/pci_host.h>
+#include "hw/s390x/sclp.h"
+
+#define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
+#define FH_VIRT 0x00ff0000
+#define ENABLE_BIT_OFFSET 31
+
+#define S390_PCI_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(s390pciState, (obj), TYPE_S390_PCI_HOST_BRIDGE)
+
+#define HP_EVENT_TO_CONFIGURED        0x0301
+#define HP_EVENT_RESERVED_TO_STANDBY  0x0302
+#define HP_EVENT_CONFIGURED_TO_STBRES 0x0304
+#define HP_EVENT_STANDBY_TO_RESERVED  0x0308
+
+typedef struct SeiContainer {
+    QTAILQ_ENTRY(SeiContainer) link;
+    uint32_t fid;
+    uint32_t fh;
+    uint8_t cc;
+    uint16_t pec;
+} SeiContainer;
+
+typedef struct PciCcdfErr {
+    uint32_t reserved1;
+    uint32_t fh;
+    uint32_t fid;
+    uint32_t reserved2;
+    uint64_t faddr;
+    uint32_t reserved3;
+    uint16_t reserved4;
+    uint16_t pec;
+} QEMU_PACKED PciCcdfErr;
+
+typedef struct PciCcdfAvail {
+    uint32_t reserved1;
+    uint32_t fh;
+    uint32_t fid;
+    uint32_t reserved2;
+    uint32_t reserved3;
+    uint32_t reserved4;
+    uint32_t reserved5;
+    uint16_t reserved6;
+    uint16_t pec;
+} QEMU_PACKED PciCcdfAvail;
+
+typedef struct ChscSeiNt2Res {
+    uint16_t length;
+    uint16_t code;
+    uint16_t reserved1;
+    uint8_t reserved2;
+    uint8_t nt;
+    uint8_t flags;
+    uint8_t reserved3;
+    uint8_t reserved4;
+    uint8_t cc;
+    uint32_t reserved5[13];
+    uint8_t ccdf[4016];
+} QEMU_PACKED ChscSeiNt2Res;
+
+typedef struct PciCfgSccb {
+        SCCBHeader header;
+        uint8_t atype;
+        uint8_t reserved1;
+        uint16_t reserved2;
+        uint32_t aid;
+} QEMU_PACKED PciCfgSccb;
+
+typedef struct S390pciState {
+    PCIHostState parent_obj;
+    MemoryRegion reg_mem;
+} S390pciState;
+
+typedef struct S390PCIBusDevice {
+    PCIDevice *pdev;
+    bool is_virt;
+    bool configured;
+    uint32_t fh;
+    uint32_t fid;
+    uint64_t g_iota;
+    QTAILQ_ENTRY(S390PCIBusDevice) next;
+} S390PCIBusDevice;
+
+#ifdef CONFIG_KVM
+int chsc_sei_nt2_get_event(void *res);
+int chsc_sei_nt2_have_event(void);
+void s390_pci_sclp_configure(int configure, SCCB *sccb);
+S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx);
+S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh);
+void s390_pci_bus_init(void);
+#else
+static inline int chsc_sei_nt2_get_event(void *res)
+{
+    return 1;
+}
+
+static inline int chsc_sei_nt2_have_event(void)
+{
+    return 0;
+}
+
+static inline void s390_pci_sclp_configure(int configure, SCCB *sccb)
+{
+    return;
+}
+
+static inline S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx)
+{
+    return NULL;
+}
+
+static inline S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh)
+{
+    return NULL;
+}
+
+static inline void s390_pci_bus_init(void)
+{
+    return;
+}
+#endif
+
+#endif
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -17,6 +17,7 @@
 #include "ioinst.h"
 #include "css.h"
 #include "virtio-ccw.h"
+#include "s390-pci-bus.h"
 #include "qemu/config-file.h"
 
 #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
@@ -126,6 +127,7 @@ static void ccw_init(MachineState *machi
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
                       machine->initrd_filename, "s390-ccw.img");
     s390_flic_init();
+    s390_pci_bus_init();
 
     /* register hypercalls */
     virtio_ccw_register_hcalls();
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -20,6 +20,7 @@
 #include "qemu/config-file.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/s390x/s390-pci-bus.h"
 
 static inline SCLPEventFacility *get_event_facility(void)
 {
@@ -62,7 +63,8 @@ static void read_SCP_info(SCCB *sccb)
         read_info->entries[i].type = 0;
     }
 
-    read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO);
+    read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
+                                        SCLP_HAS_PCI_RECONFIG);
 
     /*
      * The storage increment size is a multiple of 1M and is a power of 2.
@@ -350,6 +352,12 @@ static void sclp_execute(SCCB *sccb, uin
     case SCLP_UNASSIGN_STORAGE:
         unassign_storage(sccb);
         break;
+    case SCLP_CMDW_CONFIGURE_PCI:
+        s390_pci_sclp_configure(1, sccb);
+        break;
+    case SCLP_CMDW_DECONFIGURE_PCI:
+        s390_pci_sclp_configure(0, sccb);
+        break;
     default:
         efc->command_handler(ef, sccb, code);
         break;
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -45,14 +45,22 @@
 #define SCLP_CMDW_CONFIGURE_CPU                 0x00110001
 #define SCLP_CMDW_DECONFIGURE_CPU               0x00100001
 
+/* SCLP PCI codes */
+#define SCLP_HAS_PCI_RECONFIG                   0x0000000040000000ULL
+#define SCLP_CMDW_CONFIGURE_PCI                 0x001a0001
+#define SCLP_CMDW_DECONFIGURE_PCI               0x001b0001
+#define SCLP_RECONFIG_PCI_ATPYE                 2
+
 /* SCLP response codes */
 #define SCLP_RC_NORMAL_READ_COMPLETION          0x0010
 #define SCLP_RC_NORMAL_COMPLETION               0x0020
 #define SCLP_RC_SCCB_BOUNDARY_VIOLATION         0x0100
+#define SCLP_RC_NO_ACTION_REQUIRED              0x0120
 #define SCLP_RC_INVALID_SCLP_COMMAND            0x01f0
 #define SCLP_RC_CONTAINED_EQUIPMENT_CHECK       0x0340
 #define SCLP_RC_INSUFFICIENT_SCCB_LENGTH        0x0300
 #define SCLP_RC_STANDBY_READ_COMPLETION         0x0410
+#define SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED       0x09f0
 #define SCLP_RC_INVALID_FUNCTION                0x40f0
 #define SCLP_RC_NO_EVENT_BUFFERS_STORED         0x60f0
 #define SCLP_RC_INVALID_SELECTION_MASK          0x70f0
--- a/target-s390x/Makefile.objs
+++ b/target-s390x/Makefile.objs
@@ -2,4 +2,4 @@ obj-y += translate.o helper.o cpu.o inte
 obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += ioinst.o arch_dump.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM) += kvm.o pci_ic.o
--- a/target-s390x/ioinst.c
+++ b/target-s390x/ioinst.c
@@ -14,6 +14,7 @@
 #include "cpu.h"
 #include "ioinst.h"
 #include "trace.h"
+#include "hw/s390x/s390-pci-bus.h"
 
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid)
@@ -398,6 +399,7 @@ typedef struct ChscResp {
 #define CHSC_SCPD 0x0002
 #define CHSC_SCSC 0x0010
 #define CHSC_SDA  0x0031
+#define CHSC_SEI  0x000e
 
 #define CHSC_SCPD_0_M 0x20000000
 #define CHSC_SCPD_0_C 0x10000000
@@ -566,6 +568,53 @@ out:
     res->param = 0;
 }
 
+static int chsc_sei_nt0_get_event(void *res)
+{
+    /* no events yet */
+    return 1;
+}
+
+static int chsc_sei_nt0_have_event(void)
+{
+    /* no events yet */
+    return 0;
+}
+
+#define CHSC_SEI_NT0    (1ULL << 63)
+#define CHSC_SEI_NT2    (1ULL << 61)
+static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
+{
+    uint64_t selection_mask = be64_to_cpu(*(uint64_t *)&req->param1);
+    uint8_t *res_flags = (uint8_t *)res->data;
+    int have_event = 0;
+    int have_more = 0;
+
+    /* regarding architecture nt0 can not be masked */
+    have_event = !chsc_sei_nt0_get_event(res);
+    have_more = chsc_sei_nt0_have_event();
+
+    if (selection_mask & CHSC_SEI_NT2) {
+        if (!have_event) {
+            have_event = !chsc_sei_nt2_get_event(res);
+        }
+
+        if (!have_more) {
+            have_more = chsc_sei_nt2_have_event();
+        }
+    }
+
+    if (have_event) {
+        res->code = cpu_to_be16(0x0001);
+        if (have_more) {
+            (*res_flags) |= 0x80;
+        } else {
+            (*res_flags) &= ~0x80;
+        }
+    } else {
+        res->code = cpu_to_be16(0x0004);
+    }
+}
+
 static void ioinst_handle_chsc_unimplemented(ChscResp *res)
 {
     res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
@@ -617,6 +666,9 @@ void ioinst_handle_chsc(S390CPU *cpu, ui
     case CHSC_SDA:
         ioinst_handle_chsc_sda(req, res);
         break;
+    case CHSC_SEI:
+        ioinst_handle_chsc_sei(req, res);
+        break;
     default:
         ioinst_handle_chsc_unimplemented(res);
         break;
--- a/target-s390x/ioinst.h
+++ b/target-s390x/ioinst.h
@@ -194,6 +194,7 @@ typedef struct CRW {
 
 #define CRW_RSC_SUBCH 0x3
 #define CRW_RSC_CHP   0x4
+#define CRW_RSC_CSS   0xb
 
 /* I/O interruption code */
 typedef struct IOIntCode {
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -40,6 +40,7 @@
 #include "exec/gdbstub.h"
 #include "trace.h"
 #include "qapi-event.h"
+#include "pci_ic.h"
 
 /* #define DEBUG_KVM */
 
@@ -78,6 +79,7 @@
 #define PRIV_EB_SQBS                    0x8a
 
 #define PRIV_B9_EQBS                    0x9c
+#define PRIV_B9_CLP                     0xa0
 
 #define DIAG_IPL                        0x308
 #define DIAG_KVM_HYPERCALL              0x500
@@ -813,6 +815,9 @@ static int handle_b9(S390CPU *cpu, struc
     int r = 0;
 
     switch (ipa1) {
+    case PRIV_B9_CLP:
+        r = kvm_clp_service_call(cpu, run);
+        break;
     case PRIV_B9_EQBS:
         /* just inject exception */
         r = -1;
--- /dev/null
+++ b/target-s390x/pci_ic.c
@@ -0,0 +1,230 @@
+/*
+ * s390 PCI intercepts
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
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/kvm.h>
+#include <asm/ptrace.h>
+#include <hw/pci/pci.h>
+#include <hw/pci/pci_host.h>
+#include <net/net.h>
+
+#include "qemu-common.h"
+#include "qemu/timer.h"
+#include "migration/qemu-file.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
+#include "cpu.h"
+#include "sysemu/device_tree.h"
+#include "monitor/monitor.h"
+#include "pci_ic.h"
+
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_host.h"
+#include "hw/s390x/s390-pci-bus.h"
+#include "exec/exec-all.h"
+
+/* #define DEBUG_S390PCI_IC */
+#ifdef DEBUG_S390PCI_IC
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "s390pci_ic: " fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+static uint64_t resume_token;
+
+static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
+{
+    S390PCIBusDevice *pbdev;
+    uint32_t res_code, initial_l2, g_l2, finish;
+    int rc, idx;
+
+    rc = 0;
+    if (be16_to_cpu(rrb->request.hdr.len) != 32) {
+        res_code = CLP_RC_LEN;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if ((be32_to_cpu(rrb->request.fmt) & CLP_MASK_FMT) != 0) {
+        res_code = CLP_RC_FMT;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if ((be32_to_cpu(rrb->request.fmt) & ~CLP_MASK_FMT) != 0 ||
+        rrb->request.reserved1 != 0 ||
+        rrb->request.reserved2 != 0) {
+        res_code = CLP_RC_RESNOT0;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if (be64_to_cpu(rrb->request.resume_token) == 0) {
+        resume_token = 0;
+    } else if (be64_to_cpu(rrb->request.resume_token) != resume_token) {
+        res_code = CLP_RC_LISTPCI_BADRT;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if (be16_to_cpu(rrb->response.hdr.len) < 48) {
+        res_code = CLP_RC_8K;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    initial_l2 = be16_to_cpu(rrb->response.hdr.len);
+    if ((initial_l2 - LIST_PCI_HDR_LEN) % sizeof(ClpFhListEntry)
+        != 0) {
+        rc = -EINVAL;
+        goto out;
+    }
+
+    rrb->response.fmt = 0;
+    rrb->response.reserved1 = rrb->response.reserved2 = 0;
+    rrb->response.mdd = cpu_to_be32(FH_VIRT);
+    rrb->response.max_fn = cpu_to_be16(PCI_MAX_FUNCTIONS);
+    rrb->response.entry_size = sizeof(ClpFhListEntry);
+    finish = 0;
+    idx = resume_token;
+    g_l2 = LIST_PCI_HDR_LEN;
+    do {
+        pbdev = s390_pci_find_dev_by_idx(idx);
+        if (!pbdev) {
+            finish = 1;
+            break;
+        }
+        rrb->response.fh_list[idx - resume_token].device_id =
+            pci_get_word(pbdev->pdev->config + PCI_DEVICE_ID);
+        rrb->response.fh_list[idx - resume_token].vendor_id =
+            pci_get_word(pbdev->pdev->config + PCI_VENDOR_ID);
+        rrb->response.fh_list[idx - resume_token].config =
+            cpu_to_be32(0x80000000);
+        rrb->response.fh_list[idx - resume_token].fid = cpu_to_be32(pbdev->fid);
+        rrb->response.fh_list[idx - resume_token].fh = cpu_to_be32(pbdev->fh);
+
+        g_l2 += sizeof(ClpFhListEntry);
+        DPRINTF("g_l2 %d vendor id 0x%x device id 0x%x fid 0x%x fh 0x%x\n",
+            g_l2,
+            rrb->response.fh_list[idx - resume_token].vendor_id,
+            rrb->response.fh_list[idx - resume_token].device_id,
+            rrb->response.fh_list[idx - resume_token].fid,
+            rrb->response.fh_list[idx - resume_token].fh);
+        idx++;
+    } while (g_l2 < initial_l2);
+
+    if (finish == 1) {
+        resume_token = 0;
+    } else {
+        resume_token = idx;
+    }
+    rrb->response.resume_token = cpu_to_be64(resume_token);
+    rrb->response.hdr.len = cpu_to_be16(g_l2);
+    rrb->response.hdr.rsp = cpu_to_be16(CLP_RC_OK);
+out:
+    if (rc) {
+        DPRINTF("list pci failed rc 0x%x\n", rc);
+        rrb->response.hdr.rsp = cpu_to_be16(res_code);
+        *cc = 3;
+    }
+    return rc;
+}
+
+int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    ClpReqHdr *reqh;
+    ClpRspHdr *resh;
+    S390PCIBusDevice *pbdev;
+    uint32_t req_len;
+    uint32_t res_len;
+    uint8_t *buffer;
+    uint8_t cc;
+    CPUS390XState *env = &cpu->env;
+    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
+    int rc = 0;
+
+    buffer = g_malloc0(4096 * 2);
+    cpu_synchronize_state(CPU(cpu));
+
+    cpu_physical_memory_rw(env->regs[r2], buffer, sizeof(reqh), 0);
+    reqh = (ClpReqHdr *)buffer;
+    req_len = be16_to_cpu(reqh->len);
+
+    cpu_physical_memory_rw(env->regs[r2], buffer, req_len + sizeof(resh), 0);
+    resh = (ClpRspHdr *)(buffer + req_len);
+    res_len = be16_to_cpu(resh->len);
+
+    cpu_physical_memory_rw(env->regs[r2], buffer, req_len + res_len, 0);
+
+    switch (reqh->cmd) {
+    case CLP_LIST_PCI: {
+        ClpReqRspListPci *rrb = (ClpReqRspListPci *)buffer;
+        rc = list_pci(rrb, &cc);
+        break;
+    }
+    case CLP_SET_PCI_FN: {
+        ClpReqSetPci *reqsetpci = (ClpReqSetPci *)reqh;
+        ClpRspSetPci *ressetpci = (ClpRspSetPci *)resh;
+
+        pbdev = s390_pci_find_dev_by_fh(be32_to_cpu(reqsetpci->fh));
+        if (!pbdev) {
+                ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_SETPCIFN_FH);
+                goto out;
+        }
+
+        switch (reqsetpci->oc) {
+        case CLP_SET_ENABLE_PCI_FN:
+            if (pbdev->is_virt) {
+                pbdev->fh = pbdev->fh | 1 << ENABLE_BIT_OFFSET;
+                ressetpci->fh = cpu_to_be32(pbdev->fh);
+                ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_OK);
+            } else {
+                pbdev->fh = be32_to_cpu(ressetpci->fh);
+            }
+            break;
+        case CLP_SET_DISABLE_PCI_FN:
+            if (pbdev->is_virt) {
+                pbdev->fh = pbdev->fh & ~(1 << ENABLE_BIT_OFFSET);
+                ressetpci->fh = cpu_to_be32(pbdev->fh);
+                ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_OK);
+            } else {
+                pbdev->fh = be32_to_cpu(ressetpci->fh);
+            }
+            break;
+        default:
+            DPRINTF("unknown set pci command\n");
+            ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_SETPCIFN_FHOP);
+            break;
+        }
+        break;
+    }
+    default:
+        DPRINTF("unknown clp command\n");
+        resh->rsp = cpu_to_be16(CLP_RC_CMD);
+        break;
+    }
+
+out:
+    cpu_physical_memory_rw(env->regs[r2], buffer, req_len + res_len, 1);
+    g_free(buffer);
+    setcc(cpu, 0);
+    return rc;
+}
--- /dev/null
+++ b/target-s390x/pci_ic.h
@@ -0,0 +1,214 @@
+/*
+ * s390 PCI intercept definitions
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
+#ifndef PCI_IC_S390X_H
+#define PCI_IC_S390X_H
+
+/* CLP common request & response block size */
+#define CLP_BLK_SIZE 4096
+#define PCI_BAR_COUNT 6
+#define PCI_MAX_FUNCTIONS 4096
+
+typedef struct ClpReqHdr {
+    __uint16_t len;
+    __uint16_t cmd;
+} QEMU_PACKED ClpReqHdr;
+
+typedef struct ClpRspHdr {
+    __uint16_t len;
+    __uint16_t rsp;
+} QEMU_PACKED ClpRspHdr;
+
+/* CLP Response Codes */
+#define CLP_RC_OK         0x0010  /* Command request successfully */
+#define CLP_RC_CMD        0x0020  /* Command code not recognized */
+#define CLP_RC_PERM       0x0030  /* Command not authorized */
+#define CLP_RC_FMT        0x0040  /* Invalid command request format */
+#define CLP_RC_LEN        0x0050  /* Invalid command request length */
+#define CLP_RC_8K         0x0060  /* Command requires 8K LPCB */
+#define CLP_RC_RESNOT0    0x0070  /* Reserved field not zero */
+#define CLP_RC_NODATA     0x0080  /* No data available */
+#define CLP_RC_FC_UNKNOWN 0x0100  /* Function code not recognized */
+
+/*
+ * Call Logical Processor - Command Codes
+ */
+#define CLP_LIST_PCI            0x0002
+#define CLP_QUERY_PCI_FN        0x0003
+#define CLP_QUERY_PCI_FNGRP     0x0004
+#define CLP_SET_PCI_FN          0x0005
+
+/* PCI function handle list entry */
+typedef struct ClpFhListEntry {
+    __uint16_t device_id;
+    __uint16_t vendor_id;
+#define CLP_FHLIST_MASK_CONFIG 0x80000000
+    __uint32_t config;
+    __uint32_t fid;
+    __uint32_t fh;
+} QEMU_PACKED ClpFhListEntry;
+
+#define CLP_RC_SETPCIFN_FH      0x0101 /* Invalid PCI fn handle */
+#define CLP_RC_SETPCIFN_FHOP    0x0102 /* Fn handle not valid for op */
+#define CLP_RC_SETPCIFN_DMAAS   0x0103 /* Invalid DMA addr space */
+#define CLP_RC_SETPCIFN_RES     0x0104 /* Insufficient resources */
+#define CLP_RC_SETPCIFN_ALRDY   0x0105 /* Fn already in requested state */
+#define CLP_RC_SETPCIFN_ERR     0x0106 /* Fn in permanent error state */
+#define CLP_RC_SETPCIFN_RECPND  0x0107 /* Error recovery pending */
+#define CLP_RC_SETPCIFN_BUSY    0x0108 /* Fn busy */
+#define CLP_RC_LISTPCI_BADRT    0x010a /* Resume token not recognized */
+#define CLP_RC_QUERYPCIFG_PFGID 0x010b /* Unrecognized PFGID */
+
+/* request or response block header length */
+#define LIST_PCI_HDR_LEN 32
+
+/* Number of function handles fitting in response block */
+#define CLP_FH_LIST_NR_ENTRIES \
+    ((CLP_BLK_SIZE - 2 * LIST_PCI_HDR_LEN) \
+        / sizeof(ClpFhListEntry))
+
+#define CLP_SET_ENABLE_PCI_FN  0 /* Yes, 0 enables it */
+#define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
+
+#define CLP_UTIL_STR_LEN 64
+
+#define CLP_MASK_FMT 0xf0000000
+
+/* List PCI functions request */
+typedef struct ClpReqListPci {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint64_t resume_token;
+    __uint64_t reserved2;
+} QEMU_PACKED ClpReqListPci;
+
+/* List PCI functions response */
+typedef struct ClpRspListPci {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint64_t resume_token;
+    __uint32_t mdd;
+    __uint16_t max_fn;
+    __uint8_t reserved2;
+    __uint8_t entry_size;
+    ClpFhListEntry fh_list[CLP_FH_LIST_NR_ENTRIES];
+} QEMU_PACKED ClpRspListPci;
+
+/* Query PCI function request */
+typedef struct ClpReqQueryPci {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint32_t fh; /* function handle */
+    __uint32_t reserved2;
+    __uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPci;
+
+/* Query PCI function response */
+typedef struct ClpRspQueryPci {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint16_t vfn; /* virtual fn number */
+#define CLP_RSP_QPCI_MASK_UTIL  0x100
+#define CLP_RSP_QPCI_MASK_PFGID 0xff
+    __uint16_t ug;
+    __uint32_t fid; /* pci function id */
+    __uint8_t bar_size[PCI_BAR_COUNT];
+    __uint16_t pchid;
+    __uint32_t bar[PCI_BAR_COUNT];
+    __uint64_t reserved2;
+    __uint64_t sdma; /* start dma as */
+    __uint64_t edma; /* end dma as */
+    __uint64_t reserved3[6];
+    __uint8_t util_str[CLP_UTIL_STR_LEN]; /* utility string */
+} QEMU_PACKED ClpRspQueryPci;
+
+/* Query PCI function group request */
+typedef struct ClpReqQueryPciGrp {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+#define CLP_REQ_QPCIG_MASK_PFGID 0xff
+    __uint32_t g;
+    __uint32_t reserved2;
+    __uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPciGrp;
+
+/* Query PCI function group response */
+typedef struct ClpRspQueryPciGrp {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+#define CLP_RSP_QPCIG_MASK_NOI 0xfff
+    __uint16_t i;
+    __uint8_t version;
+#define CLP_RSP_QPCIG_MASK_FRAME   0x2
+#define CLP_RSP_QPCIG_MASK_REFRESH 0x1
+    __uint8_t fr;
+    __uint16_t reserved2;
+    __uint16_t mui;
+    __uint64_t reserved3;
+    __uint64_t dasm; /* dma address space mask */
+    __uint64_t msia; /* MSI address */
+    __uint64_t reserved4;
+    __uint64_t reserved5;
+} QEMU_PACKED ClpRspQueryPciGrp;
+
+/* Set PCI function request */
+typedef struct ClpReqSetPci {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint32_t fh; /* function handle */
+    __uint16_t reserved2;
+    __uint8_t oc; /* operation controls */
+    __uint8_t ndas; /* number of dma spaces */
+    __uint64_t reserved3;
+} QEMU_PACKED ClpReqSetPci;
+
+/* Set PCI function response */
+typedef struct ClpRspSetPci {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint32_t fh; /* function handle */
+    __uint32_t reserved3;
+    __uint64_t reserved4;
+} QEMU_PACKED ClpRspSetPci;
+
+typedef struct ClpReqRspListPci {
+    ClpReqListPci request;
+    ClpRspListPci response;
+} QEMU_PACKED ClpReqRspListPci;
+
+typedef struct ClpReqRspSetPci {
+    ClpReqSetPci request;
+    ClpRspSetPci response;
+} QEMU_PACKED ClpReqRspSetPci;
+
+typedef struct ClpReqRspQueryPci {
+    ClpReqQueryPci request;
+    ClpRspQueryPci response;
+} QEMU_PACKED ClpReqRspQueryPci;
+
+typedef struct ClpReqRspQueryPciGrp {
+    ClpReqQueryPciGrp request;
+    ClpRspQueryPciGrp response;
+} QEMU_PACKED ClpReqRspQueryPciGrp;
+
+int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run);
+
+#endif
