From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 5/5] s390x/virtio-ccw: Wire up irq routing and irqfds.
Date: Fri, 21 Mar 2014 13:52:37 +0100
Message-ID: <1395406357-14766-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Make use of the new s390 adapter irq routing support to enable real
in-kernel irqfds for virtio-ccw with adapter interrupts.

Note that s390 doesn't provide the common KVM_CAP_IRQCHIP capability, but
rather needs KVM_CAP_S390_IRQCHIP to be enabled. This is to ensure backward
compatibility.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c      |  167 ++++++++++++++++++++++++++++++++++++++++----
 hw/s390x/virtio-ccw.h      |    2 +
 include/hw/s390x/adapter.h |   23 ++++++
 include/qemu/typedefs.h    |    1 +
 include/sysemu/kvm.h       |    2 +
 kvm-all.c                  |   38 +++++++++-
 kvm-stub.c                 |    5 ++
 target-s390x/kvm.c         |    5 ++
 8 files changed, 230 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/s390x/adapter.h

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 69efa6c..acb3896 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/s390x/adapter.h"
 
 #include "ioinst.h"
 #include "css.h"
@@ -48,7 +49,7 @@ static IndAddr *get_indicator(hwaddr ind_addr, int len)
     return indicator;
 }
 
-static void release_indicator(IndAddr *indicator)
+static void release_indicator(uint32_t adapter_id, IndAddr *indicator)
 {
     assert(indicator->refcnt > 0);
     indicator->refcnt--;
@@ -56,9 +57,33 @@ static void release_indicator(IndAddr *indicator)
         return;
     }
     QTAILQ_REMOVE(&indicator_addresses, indicator, sibling);
+    if (indicator->map) {
+        s390_io_adapter_map(adapter_id,
+                            (uint64_t)(unsigned long)indicator->map, false);
+    }
     g_free(indicator);
 }
 
+static int map_indicator(uint32_t adapter_id, IndAddr *indicator)
+{
+    int ret;
+
+    if (indicator->map) {
+        return 0; /* already mapped is not an error */
+    }
+    indicator->map = (void *)indicator->addr;
+    ret = s390_io_adapter_map(adapter_id,
+                              (uint64_t)(unsigned long)indicator->map, true);
+    if ((ret != 0) && (ret != -ENOSYS)) {
+        goto out_err;
+    }
+    return 0;
+
+out_err:
+    indicator->map = 0;
+    return -EFAULT;
+}
+
 static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtioCcwDevice *dev);
 
@@ -733,7 +758,7 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
         g_free(sch);
     }
     if (dev->indicators) {
-        release_indicator(dev->indicators);
+        release_indicator(dev->adapter_id, dev->indicators);
         dev->indicators = NULL;
     }
     return 0;
@@ -1034,15 +1059,15 @@ static void virtio_ccw_reset(DeviceState *d)
     virtio_reset(vdev);
     css_reset_sch(dev->sch);
     if (dev->indicators) {
-        release_indicator(dev->indicators);
+        release_indicator(dev->adapter_id, dev->indicators);
         dev->indicators = NULL;
     }
     if (dev->indicators2) {
-        release_indicator(dev->indicators2);
+        release_indicator(dev->adapter_id, dev->indicators2);
         dev->indicators2 = NULL;
     }
     if (dev->summary_indicator) {
-        release_indicator(dev->summary_indicator);
+        release_indicator(dev->adapter_id, dev->summary_indicator);
         dev->summary_indicator = NULL;
     }
 }
@@ -1078,6 +1103,100 @@ static int virtio_ccw_set_host_notifier(DeviceState *d, int n, bool assign)
     return virtio_ccw_set_guest2host_notifier(dev, n, assign, false);
 }
 
+static int virtio_ccw_get_adapter_info(VirtioCcwDevice *dev,
+                                       AdapterInfo *adapter)
+{
+    int r;
+
+    if (!dev->sch->thinint_active) {
+        return -EINVAL;
+    }
+
+    r = map_indicator(dev->adapter_id, dev->summary_indicator);
+    if (r) {
+        return r;
+    }
+    r = map_indicator(dev->adapter_id, dev->indicators);
+    if (r) {
+        return r;
+    }
+    adapter->summary_addr = (unsigned long)dev->summary_indicator->map;
+    adapter->ind_addr = (unsigned long)dev->indicators->map;
+    adapter->ind_offset = dev->ind_bit;
+    adapter->summary_offset = 7;
+    adapter->adapter_id = dev->adapter_id;
+
+    return 0;
+}
+
+static int virtio_ccw_setup_irqroutes(VirtioCcwDevice *dev, int nvqs)
+{
+    int i;
+    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+    int ret;
+    AdapterInfo adapter;
+
+    ret = virtio_ccw_get_adapter_info(dev, &adapter);
+    if (ret) {
+        return ret;
+    }
+    for (i = 0; i < nvqs; i++) {
+        if (!virtio_queue_get_num(vdev, i)) {
+            break;
+        }
+        ret = kvm_irqchip_add_adapter_route(kvm_state, &adapter);
+        if (ret < 0) {
+            goto out_undo;
+        }
+        dev->gsi[i] = ret;
+        adapter.ind_offset++;
+    }
+    return 0;
+out_undo:
+    while (--i >= 0) {
+        kvm_irqchip_release_virq(kvm_state, dev->gsi[i]);
+        dev->gsi[i] = -1;
+    }
+    return ret;
+}
+
+static void virtio_ccw_release_irqroutes(VirtioCcwDevice *dev, int nvqs)
+{
+    int i;
+    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+
+    for (i = 0; i < nvqs; i++) {
+        if (!virtio_queue_get_num(vdev, i)) {
+            break;
+        }
+        if (dev->gsi[i] >= 0) {
+            kvm_irqchip_release_virq(kvm_state, dev->gsi[i]);
+            dev->gsi[i] = -1;
+        }
+    }
+}
+
+static int virtio_ccw_add_irqfd(VirtioCcwDevice *dev, int n)
+{
+    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+    VirtQueue *vq = virtio_get_queue(vdev, n);
+    EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
+
+    return kvm_irqchip_add_irqfd_notifier(kvm_state, notifier, NULL,
+                                          dev->gsi[n]);
+}
+
+static void virtio_ccw_remove_irqfd(VirtioCcwDevice *dev, int n)
+{
+    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+    VirtQueue *vq = virtio_get_queue(vdev, n);
+    EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
+    int ret;
+
+    ret = kvm_irqchip_remove_irqfd_notifier(kvm_state, notifier, dev->gsi[n]);
+    assert(ret == 0);
+}
+
 static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
                                          bool assign, bool with_irqfd)
 {
@@ -1093,11 +1212,17 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
             return r;
         }
         virtio_queue_set_guest_notifier_fd_handler(vq, true, with_irqfd);
-        /* We do not support irqfd for classic I/O interrupts, because the
-         * classic interrupts are intermixed with the subchannel status, that
-         * is queried with test subchannel. We want to use vhost, though.
-         * Lets make sure to have vhost running and wire up the irq fd to
-         * land in qemu (and only the irq fd) in this code.
+        if (with_irqfd) {
+            r = virtio_ccw_add_irqfd(dev, n);
+            if (r) {
+                virtio_queue_set_guest_notifier_fd_handler(vq, false,
+                                                           with_irqfd);
+                return r;
+            }
+        }
+        /*
+         * We do not support individual masking for channel devices, so we
+         * need to manually trigger any guest masking callbacks here.
          */
         if (k->guest_notifier_mask) {
             k->guest_notifier_mask(vdev, n, false);
@@ -1111,6 +1236,9 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
         if (k->guest_notifier_mask) {
             k->guest_notifier_mask(vdev, n, true);
         }
+        if (with_irqfd) {
+            virtio_ccw_remove_irqfd(dev, n);
+        }
         virtio_queue_set_guest_notifier_fd_handler(vq, false, with_irqfd);
         event_notifier_cleanup(notifier);
     }
@@ -1122,24 +1250,39 @@ static int virtio_ccw_set_guest_notifiers(DeviceState *d, int nvqs,
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+    bool with_irqfd = dev->sch->thinint_active && kvm_irqfds_enabled();
     int r, n;
 
+    if (with_irqfd && assigned) {
+        /* irq routes need to be set up before assigning irqfds */
+        r = virtio_ccw_setup_irqroutes(dev, nvqs);
+        if (r < 0) {
+            goto irqroute_error;
+        }
+    }
     for (n = 0; n < nvqs; n++) {
         if (!virtio_queue_get_num(vdev, n)) {
             break;
         }
-        /* false -> true, as soon as irqfd works */
-        r = virtio_ccw_set_guest_notifier(dev, n, assigned, false);
+        r = virtio_ccw_set_guest_notifier(dev, n, assigned, with_irqfd);
         if (r < 0) {
             goto assign_error;
         }
     }
+    if (with_irqfd && !assigned) {
+        /* release irq routes after irqfds have been released */
+        virtio_ccw_release_irqroutes(dev, nvqs);
+    }
     return 0;
 
 assign_error:
     while (--n >= 0) {
         virtio_ccw_set_guest_notifier(dev, n, !assigned, false);
     }
+irqroute_error:
+    if (with_irqfd && assigned) {
+        virtio_ccw_release_irqroutes(dev, nvqs);
+    }
     return r;
 }
 
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index d340bf4..7977a3e 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -77,6 +77,7 @@ typedef struct VirtIOCCWDeviceClass {
 
 typedef struct IndAddr {
     hwaddr addr;
+    void *map;
     unsigned long refcnt;
     int len;
     QTAILQ_ENTRY(IndAddr) sibling;
@@ -93,6 +94,7 @@ struct VirtioCcwDevice {
     uint32_t flags;
     uint8_t thinint_isc;
     uint32_t adapter_id;
+    int gsi[VIRTIO_PCI_QUEUE_MAX];
     /* Guest provided values: */
     IndAddr *indicators;
     IndAddr *indicators2;
diff --git a/include/hw/s390x/adapter.h b/include/hw/s390x/adapter.h
new file mode 100644
index 0000000..7e56724
--- /dev/null
+++ b/include/hw/s390x/adapter.h
@@ -0,0 +1,23 @@
+/*
+ * s390 adapter definitions
+ *
+ * Copyright 2013 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390X_ADAPTER_H
+#define S390X_ADAPTER_H
+
+struct AdapterInfo {
+    uint64_t ind_addr;
+    uint64_t summary_addr;
+    uint64_t ind_offset;
+    uint32_t summary_offset;
+    uint32_t adapter_id;
+};
+
+#endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index bf8daac..1e36fc4 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -73,5 +73,6 @@ typedef struct SHPCDevice SHPCDevice;
 typedef struct FWCfgState FWCfgState;
 typedef struct PcGuestInfo PcGuestInfo;
 typedef struct Range Range;
+typedef struct AdapterInfo AdapterInfo;
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d89911c..324aec4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -339,6 +339,8 @@ int kvm_irqchip_add_msi_route(KVMState *s, MSIMessage msg);
 int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg);
 void kvm_irqchip_release_virq(KVMState *s, int virq);
 
+int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter);
+
 int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
                                    EventNotifier *rn, int virq);
 int kvm_irqchip_remove_irqfd_notifier(KVMState *s, EventNotifier *n, int virq);
diff --git a/kvm-all.c b/kvm-all.c
index 658690f..9734e14 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
+#include "hw/s390x/adapter.h"
 #include "exec/gdbstub.h"
 #include "sysemu/kvm.h"
 #include "qemu/bswap.h"
@@ -1264,6 +1265,35 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int rfd, int virq,
     return kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
 }
 
+int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
+{
+    struct kvm_irq_routing_entry kroute;
+    int virq;
+
+    if (!kvm_gsi_routing_enabled()) {
+        return -ENOSYS;
+    }
+
+    virq = kvm_irqchip_get_virq(s);
+    if (virq < 0) {
+        return virq;
+    }
+
+    kroute.gsi = virq;
+    kroute.type = KVM_IRQ_ROUTING_S390_ADAPTER;
+    kroute.flags = 0;
+    kroute.u.adapter.summary_addr = adapter->summary_addr;
+    kroute.u.adapter.ind_addr = adapter->ind_addr;
+    kroute.u.adapter.summary_offset = adapter->summary_offset;
+    kroute.u.adapter.ind_offset = adapter->ind_offset;
+    kroute.u.adapter.adapter_id = adapter->adapter_id;
+
+    kvm_add_routing_entry(s, &kroute);
+    kvm_irqchip_commit_routes(s);
+
+    return virq;
+}
+
 #else /* !KVM_CAP_IRQ_ROUTING */
 
 void kvm_init_irq_routing(KVMState *s)
@@ -1284,6 +1314,11 @@ int kvm_irqchip_add_msi_route(KVMState *s, MSIMessage msg)
     return -ENOSYS;
 }
 
+int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
+{
+    return -ENOSYS;
+}
+
 static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int virq, bool assign)
 {
     abort();
@@ -1313,7 +1348,8 @@ static int kvm_irqchip_create(KVMState *s)
     int ret;
 
     if (!qemu_opt_get_bool(qemu_get_machine_opts(), "kernel_irqchip", true) ||
-        !kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
+        (!kvm_check_extension(s, KVM_CAP_IRQCHIP) &&
+         (kvm_enable_cap_vm(s, KVM_CAP_S390_IRQCHIP) < 0))) {
         return 0;
     }
 
diff --git a/kvm-stub.c b/kvm-stub.c
index ccdba62..b83f56e 100644
--- a/kvm-stub.c
+++ b/kvm-stub.c
@@ -136,6 +136,11 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg)
     return -ENOSYS;
 }
 
+int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
+{
+    return -ENOSYS;
+}
+
 int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
                                    EventNotifier *rn, int virq)
 {
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 56b9af7..d12f180 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -921,6 +921,11 @@ void kvm_s390_enable_css_support(S390CPU *cpu)
 
 void kvm_arch_init_irq_routing(KVMState *s)
 {
+    if (kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
+        kvm_irqfds_allowed = true;
+        kvm_gsi_routing_allowed = true;
+        kvm_halt_in_kernel_allowed = false;
+    }
 }
 
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
-- 
1.7.9.5
