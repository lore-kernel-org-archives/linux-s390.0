From: frank.blaschka@de.ibm.com
Subject: [RFC patch 4/6] s390: Add PCI bus support
Date: Fri, 19 Sep 2014 13:54:33 +0200
Message-ID: <20140919115940.368400109@de.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=101-qemu_bus.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
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
 hw/s390x/s390-pci-bus.c           |  404 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-bus.h           |  166 +++++++++++++++
 hw/s390x/s390-virtio-ccw.c        |    2 
 hw/s390x/sclp.c                   |   10 
 include/hw/s390x/sclp.h           |    8 
 target-s390x/ioinst.c             |   52 ++++
 target-s390x/ioinst.h             |    1 
 11 files changed, 650 insertions(+), 1 deletion(-)

--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,3 +1,4 @@
+include pci.mak
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_S390_FLIC=y
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
@@ -0,0 +1,404 @@
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
+#include <hw/pci/msi.h>
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
+static const unsigned long be_to_le = BITS_PER_LONG - 1;
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
+void s390_msix_notify(PCIDevice *dev, unsigned vector)
+{
+    S390PCIBusDevice *pbdev;
+    unsigned long *aibv, *aisb;
+    int summary_set;
+    hwaddr aibv_len, aisb_len;
+    uint32_t io_int_word;
+
+    pbdev = s390_pci_find_dev_by_pdev(dev);
+    if (!pbdev) {
+        DPRINTF("msix_notify do dev\n");
+        return;
+    }
+    aibv_len = aisb_len = 8;
+    aibv = cpu_physical_memory_map(pbdev->routes.adapter.ind_addr,
+                                   &aibv_len, 1);
+    aisb = cpu_physical_memory_map(pbdev->routes.adapter.summary_addr,
+                                   &aisb_len, 1);
+
+    set_bit(vector ^ be_to_le, aibv);
+    summary_set = test_and_set_bit(pbdev->routes.adapter.summary_offset
+                                   ^ be_to_le, aisb);
+
+    if (!summary_set) {
+        io_int_word = (pbdev->isc << 27) | IO_INT_WORD_AI;
+        s390_io_interrupt(0, 0, 0, io_int_word);
+    }
+
+    cpu_physical_memory_unmap(aibv, aibv_len, 1, aibv_len);
+    cpu_physical_memory_unmap(aisb, aisb_len, 1, aisb_len);
+}
+
+int s390_irqchip_add_msi_route(PCIDevice *pdev, KVMState *s, MSIMessage msg)
+{
+    S390PCIBusDevice *pbdev;
+    int virq;
+
+    pbdev = s390_pci_find_dev_by_pdev(pdev);
+    if (!pbdev) {
+        DPRINTF("390_add_msi_virq no dev\n");
+        return -ENODEV;
+    }
+
+    pbdev->routes.adapter.ind_offset = msg.data;
+
+    virq = kvm_irqchip_add_adapter_route(s, &pbdev->routes.adapter);
+
+    return virq;
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
+static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *iommu, hwaddr addr,
+                                          bool is_write)
+{
+    IOMMUTLBEntry ret;
+
+    /* implement this the time we need it */
+    assert(0);
+    return ret;
+}
+
+static const MemoryRegionIOMMUOps s390_iommu_ops = {
+    .translate = s390_translate_iommu,
+};
+
+static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+{
+    S390pciState *s = opaque;
+
+    return &s->iommu[PCI_SLOT(devfn)].as;
+}
+
+static void s390_pcihost_init_iommu(S390pciState *s)
+{
+    int i;
+
+    for (i = 0; i < PCI_SLOT_MAX; i++) {
+        memory_region_init_iommu(&s->iommu[i].mr, OBJECT(s),
+                                 &s390_iommu_ops, "iommu-s390", UINT64_MAX);
+        address_space_init(&s->iommu[i].as, &s->iommu[i].mr, "iommu-pci");
+    }
+}
+
+static int s390_pcihost_init(SysBusDevice *dev)
+{
+    PCIBus *b;
+    BusState *bus;
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+    S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
+
+    DPRINTF("host_init\n");
+
+    b = pci_register_bus(DEVICE(dev), NULL,
+                         s390_pci_set_irq, s390_pci_map_irq, NULL,
+                         get_system_memory(), get_system_io(), 0, 64,
+                         TYPE_PCI_BUS);
+    s390_pcihost_init_iommu(s);
+    pci_setup_iommu(b, s390_pci_dma_iommu, s);
+
+    bus = BUS(b);
+    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
+    phb->bus = b;
+
+    return 0;
+}
+
+static int s390_pcihost_setup_msix(S390PCIBusDevice *pbdev)
+{
+    uint8_t pos;
+    uint16_t ctrl;
+    uint32_t table, pba;
+
+    pos = pci_find_capability(pbdev->pdev, PCI_CAP_ID_MSIX);
+    if (!pos) {
+        return 0;
+    }
+
+    ctrl = pci_host_config_read_common(pbdev->pdev, pos + PCI_CAP_FLAGS,
+             pci_config_size(pbdev->pdev), sizeof(ctrl));
+    table = pci_host_config_read_common(pbdev->pdev, pos + PCI_MSIX_TABLE,
+             pci_config_size(pbdev->pdev), sizeof(table));
+    pba = pci_host_config_read_common(pbdev->pdev, pos + PCI_MSIX_PBA,
+             pci_config_size(pbdev->pdev), sizeof(pba));
+
+    pbdev->msix_table_bar = table & PCI_MSIX_FLAGS_BIRMASK;
+    pbdev->msix_table_offset = table & ~PCI_MSIX_FLAGS_BIRMASK;
+    pbdev->msix_pba_bar = pba & PCI_MSIX_FLAGS_BIRMASK;
+    pbdev->msix_pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
+    pbdev->msix_entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
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
+    s390_pcihost_setup_msix(pbdev);
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
+    msi_supported = true;
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
@@ -0,0 +1,166 @@
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
+#include <hw/pci/pci.h>
+#include <hw/pci/pci_host.h>
+#include "hw/s390x/sclp.h"
+#include "hw/s390x/s390_flic.h"
+#include "hw/s390x/css.h"
+
+#define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
+#define FH_VIRT 0x00ff0000
+#define ENABLE_BIT_OFFSET 31
+#define S390_PCIPT_ADAPTER 2
+
+#define S390_PCI_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(S390pciState, (obj), TYPE_S390_PCI_HOST_BRIDGE)
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
+    struct {
+        AddressSpace as;
+        MemoryRegion mr;
+    } iommu[PCI_SLOT_MAX];
+} S390pciState;
+
+typedef struct S390PCIBusDevice {
+    PCIDevice *pdev;
+    bool is_virt;
+    bool configured;
+    uint32_t fh;
+    uint32_t fid;
+    uint64_t g_iota;
+    uint8_t isc;
+    uint8_t msix_table_bar;
+    uint8_t msix_pba_bar;
+    uint16_t msix_entries;
+    uint32_t msix_table_offset;
+    uint32_t msix_pba_offset;
+    AdapterRoutes routes;
+    QTAILQ_ENTRY(S390PCIBusDevice) next;
+} S390PCIBusDevice;
+
+#ifdef CONFIG_KVM
+void s390_msix_notify(PCIDevice *dev, unsigned vector);
+int s390_irqchip_add_msi_route(PCIDevice *pdev, KVMState *s, MSIMessage msg);
+int chsc_sei_nt2_get_event(void *res);
+int chsc_sei_nt2_have_event(void);
+void s390_pci_sclp_configure(int configure, SCCB *sccb);
+S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx);
+S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh);
+void s390_pci_bus_init(void);
+#else
+static void s390_msix_notify(PCIDevice *dev, unsigned vector)
+{
+    return;
+}
+
+static int s390_irqchip_add_msi_route(PCIDevice *pdev, KVMState *s,
+                                      MSIMessage msg)
+{
+    return 0;
+}
+
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
@@ -18,6 +18,7 @@
 #include "css.h"
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
+#include "s390-pci-bus.h"
 
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
