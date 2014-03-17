From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 3/5] s390x: Add I/O adapter registration.
Date: Mon, 17 Mar 2014 19:11:59 +0100
Message-ID: <1395079921-29325-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Register an I/O adapter interrupt source for when virtio-ccw devices start
using adapter interrupts.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/intc/s390_flic.c   |   66 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/css.c        |   51 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/css.h        |    4 +++
 hw/s390x/virtio-ccw.c |    4 +++
 hw/s390x/virtio-ccw.h |    1 +
 target-s390x/cpu.h    |   33 +++++++++++++++++++++++++
 6 files changed, 159 insertions(+)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index b2ef3e3..2232767 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -21,6 +21,18 @@
 #define FLIC_FAILED (-1UL)
 #define FLIC_SAVEVM_VERSION 1
 
+static KVMS390FLICState *s390_get_flic(void)
+{
+    ObjectProperty *op = object_property_find(qdev_get_machine(),
+                                              "s390-flic", NULL);
+
+    if (op) {
+        return op->opaque;
+    } else {
+        return NULL;
+    }
+}
+
 void s390_flic_init(void)
 {
     DeviceState *dev;
@@ -148,6 +160,60 @@ static int __get_all_irqs(KVMS390FLICState *flic,
     return r;
 }
 
+int kvm_s390_register_io_adapter(uint32_t id, uint8_t isc, bool swap,
+                                 bool is_maskable)
+{
+    struct kvm_s390_io_adapter adapter = {
+        .id = id,
+        .isc = isc,
+        .maskable = is_maskable,
+        .swap = swap,
+    };
+    KVMS390FLICState *flic = s390_get_flic();
+    int r, ret;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_FLIC_ADAPTER_REGISTER,
+        .addr = (uint64_t)&adapter,
+    };
+
+    if (!flic) {
+        return -ENOSYS;
+    }
+    if (!kvm_check_extension(kvm_state, KVM_CAP_IRQ_ROUTING)) {
+        return -ENOSYS;
+    }
+
+    r = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+
+    ret = r ? -errno : 0;
+    return ret;
+}
+
+int kvm_s390_io_adapter_map(uint32_t id, uint64_t map_addr, bool do_map)
+{
+    struct kvm_s390_io_adapter_req req = {
+        .id = id,
+        .type = do_map ? KVM_S390_IO_ADAPTER_MAP : KVM_S390_IO_ADAPTER_UNMAP,
+        .addr = map_addr,
+    };
+    KVMS390FLICState *flic = s390_get_flic();
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_FLIC_ADAPTER_MODIFY,
+        .addr = (uint64_t)&req,
+    };
+    int r;
+
+    if (!flic) {
+        return -ENOSYS;
+    }
+    if (!kvm_check_extension(kvm_state, KVM_CAP_IRQ_ROUTING)) {
+        return -ENOSYS;
+    }
+
+    r = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    return r ? -errno : 0;
+}
+
 /**
  * kvm_flic_save - Save pending floating interrupts
  * @f: QEMUFile containing migration state
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 7074d2b..a6d173f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -39,6 +39,13 @@ typedef struct CssImage {
     ChpInfo chpids[MAX_CHPID + 1];
 } CssImage;
 
+typedef struct IoAdapter {
+    uint32_t id;
+    uint8_t type;
+    uint8_t isc;
+    QTAILQ_ENTRY(IoAdapter) sibling;
+} IoAdapter;
+
 typedef struct ChannelSubSys {
     QTAILQ_HEAD(, CrwContainer) pending_crws;
     bool do_crw_mchk;
@@ -49,6 +56,7 @@ typedef struct ChannelSubSys {
     uint64_t chnmon_area;
     CssImage *css[MAX_CSSID + 1];
     uint8_t default_cssid;
+    QTAILQ_HEAD(, IoAdapter) io_adapters;
 } ChannelSubSys;
 
 static ChannelSubSys *channel_subsys;
@@ -69,6 +77,48 @@ int css_create_css_image(uint8_t cssid, bool default_image)
     return 0;
 }
 
+int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
+                            bool maskable, uint32_t *id)
+{
+    IoAdapter *adapter;
+    bool found = false;
+    int ret;
+
+    *id = 0;
+    QTAILQ_FOREACH(adapter, &channel_subsys->io_adapters, sibling) {
+        if ((adapter->type == type) && (adapter->isc == isc)) {
+            *id = adapter->id;
+            found = true;
+            ret = 0;
+            break;
+        }
+        if (adapter->id >= *id) {
+            *id = adapter->id + 1;
+        }
+    }
+    if (found) {
+        goto out;
+    }
+    adapter = g_new0(IoAdapter, 1);
+    ret = s390_register_io_adapter(*id, isc, swap, maskable);
+    if (ret == -ENOSYS) {
+        /* Keep adapter even if we didn't register it anywhere. */
+        ret = 0;
+    }
+    if (ret == 0) {
+        adapter->id = *id;
+        adapter->isc = isc;
+        adapter->type = type;
+        QTAILQ_INSERT_TAIL(&channel_subsys->io_adapters, adapter, sibling);
+    } else {
+        g_free(adapter);
+        fprintf(stderr, "Unexpected error %d when registering adapter %d\n",
+                ret, *id);
+    }
+out:
+    return ret;
+}
+
 uint16_t css_build_subchannel_id(SubchDev *sch)
 {
     if (channel_subsys->max_cssid > 0) {
@@ -1239,6 +1289,7 @@ static void css_init(void)
     channel_subsys->do_crw_mchk = true;
     channel_subsys->crws_lost = false;
     channel_subsys->chnmon_active = false;
+    QTAILQ_INIT(&channel_subsys->io_adapters);
 }
 machine_init(css_init);
 
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index e9b4405..380e8e7 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -99,4 +99,8 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add);
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_adapter_interrupt(uint8_t isc);
+
+#define CSS_IO_ADAPTER_VIRTIO 1
+int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
+                            bool maskable, uint32_t *id);
 #endif
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a01801e..4125100 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -522,6 +522,10 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 dev->thinint_isc = thinint->isc;
                 dev->ind_bit = thinint->ind_bit;
                 cpu_physical_memory_unmap(thinint, hw_len, 0, hw_len);
+                ret = css_register_io_adapter(CSS_IO_ADAPTER_VIRTIO,
+                                              dev->thinint_isc, true, false,
+                                              &dev->adapter_id);
+                assert(ret == 0);
                 sch->thinint_active = ((dev->indicators != 0) &&
                                        (dev->summary_indicator != 0));
                 sch->curr_status.scsw.count = ccw.count - len;
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 4393e44..0b70b91 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -85,6 +85,7 @@ struct VirtioCcwDevice {
     bool ioeventfd_disabled;
     uint32_t flags;
     uint8_t thinint_isc;
+    uint32_t adapter_id;
     /* Guest provided values: */
     hwaddr indicators;
     hwaddr indicators2;
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index f332d41..53391fd 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -1062,6 +1062,9 @@ void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
 int kvm_s390_cpu_restart(S390CPU *cpu);
+int kvm_s390_register_io_adapter(uint32_t id, uint8_t isc, bool swap,
+                                 bool maskable);
+int kvm_s390_io_adapter_map(uint32_t id, uint64_t map_addr, bool do_map);
 #else
 static inline void kvm_s390_io_interrupt(S390CPU *cpu,
                                         uint16_t subchannel_id,
@@ -1086,6 +1089,16 @@ static inline int kvm_s390_cpu_restart(S390CPU *cpu)
 {
     return -ENOSYS;
 }
+static inline int kvm_s390_register_io_adapter(uint32_t id, uint8_t isc,
+                                               bool swap, bool maskable)
+{
+    return -ENOSYS;
+}
+static inline int kvm_s390_io_adapter_map(uint32_t id, uint64_t map_addr,
+                                          bool do_map)
+{
+    return -ENOSYS;
+}
 #endif
 
 static inline int s390_cpu_restart(S390CPU *cpu)
@@ -1131,4 +1144,24 @@ static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
     }
 }
 
+static inline int s390_register_io_adapter(uint32_t id, uint8_t isc, bool swap,
+                                           bool is_maskable)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_register_io_adapter(id, isc, swap, is_maskable);
+    } else {
+        return -ENOSYS;
+    }
+}
+
+static inline int s390_io_adapter_map(uint32_t id, uint64_t map_addr,
+                                      bool do_map)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_io_adapter_map(id, map_addr, do_map);
+    } else {
+        return -ENOSYS;
+    }
+}
+
 #endif
-- 
1.7.9.5
