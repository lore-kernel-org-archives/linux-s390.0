From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/6] s390x/virtio-ccw: Adapter interrupt support.
Date: Tue, 25 Feb 2014 18:25:15 +0100
Message-ID: <1393349120-18228-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Handle the new CCW_CMD_SET_IND_ADAPTER command enabling adapter interrupts
on guest request. When active, host->guest notifications will be handled
via global_indicator -> queue indicators instead of queue indicators +
subchannel I/O interrupt. Indicators for virtqueues may be present at an
offset.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c        |   10 +++++
 hw/s390x/css.h        |    2 +
 hw/s390x/virtio-ccw.c |  102 +++++++++++++++++++++++++++++++++++++++++++++----
 hw/s390x/virtio-ccw.h |    4 ++
 target-s390x/ioinst.h |    2 +
 target-s390x/kvm.c    |    8 +++-
 trace-events          |    1 +
 7 files changed, 120 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 75b04b4..7074d2b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -116,6 +116,15 @@ void css_conditional_io_interrupt(SubchDev *sch)
     }
 }
 
+void css_adapter_interrupt(uint8_t isc)
+{
+    S390CPU *cpu = s390_cpu_addr2state(0);
+    uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
+
+    trace_css_adapter_interrupt(isc);
+    s390_io_interrupt(cpu, 0, 0, 0, io_int_word);
+}
+
 static void sch_handle_clear_func(SubchDev *sch)
 {
     PMCW *p = &sch->curr_status.pmcw;
@@ -1259,6 +1268,7 @@ void css_reset_sch(SubchDev *sch)
     sch->channel_prog = 0x0;
     sch->last_cmd_valid = false;
     sch->orb = NULL;
+    sch->thinint_active = false;
 }
 
 void css_reset(void)
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index b536ab5..e9b4405 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -77,6 +77,7 @@ struct SubchDev {
     CCW1 last_cmd;
     bool last_cmd_valid;
     ORB *orb;
+    bool thinint_active;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     SenseId id;
@@ -97,4 +98,5 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add);
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
+void css_adapter_interrupt(uint8_t isc);
 #endif
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f6e0e3e..a01801e 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1,7 +1,7 @@
 /*
  * virtio ccw target implementation
  *
- * Copyright 2012 IBM Corp.
+ * Copyright 2012,2014 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
@@ -188,6 +188,13 @@ typedef struct VirtioFeatDesc {
     uint8_t index;
 } QEMU_PACKED VirtioFeatDesc;
 
+typedef struct VirtioThinintInfo {
+    hwaddr summary_indicator;
+    hwaddr device_indicator;
+    uint64_t ind_bit;
+    uint8_t isc;
+} QEMU_PACKED VirtioThinintInfo;
+
 /* Specify where the virtqueues for the subchannel are in guest memory. */
 static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
                               uint16_t index, uint16_t num)
@@ -237,6 +244,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
     bool check_len;
     int len;
     hwaddr hw_len;
+    VirtioThinintInfo *thinint;
 
     if (!dev) {
         return -EINVAL;
@@ -428,6 +436,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EINVAL;
             break;
         }
+        if (sch->thinint_active) {
+            /* Trigger a command reject. */
+            ret = -ENOSYS;
+            break;
+        }
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
@@ -480,6 +493,42 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = 0;
         }
         break;
+    case CCW_CMD_SET_IND_ADAPTER:
+        if (check_len) {
+            if (ccw.count != sizeof(*thinint)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(*thinint)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        len = sizeof(*thinint);
+        hw_len = len;
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else if (dev->indicators && !sch->thinint_active) {
+            /* Trigger a command reject. */
+            ret = -ENOSYS;
+        } else {
+            thinint = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
+            if (!thinint) {
+                ret = -EFAULT;
+            } else {
+                len = hw_len;
+                dev->summary_indicator = thinint->summary_indicator;
+                dev->indicators = thinint->device_indicator;
+                dev->thinint_isc = thinint->isc;
+                dev->ind_bit = thinint->ind_bit;
+                cpu_physical_memory_unmap(thinint, hw_len, 0, hw_len);
+                sch->thinint_active = ((dev->indicators != 0) &&
+                                       (dev->summary_indicator != 0));
+                sch->curr_status.scsw.count = ccw.count - len;
+                ret = 0;
+            }
+        }
+        break;
     default:
         ret = -ENOSYS;
         break;
@@ -511,6 +560,7 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     sch->channel_prog = 0x0;
     sch->last_cmd_valid = false;
     sch->orb = NULL;
+    sch->thinint_active = false;
     /*
      * Use a device number if provided. Otherwise, fall back to subchannel
      * number.
@@ -858,6 +908,28 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
     return container_of(d, VirtioCcwDevice, parent_obj);
 }
 
+static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
+                                     uint8_t to_be_set)
+{
+    uint8_t ind_old, ind_new;
+    hwaddr len = 1;
+    uint8_t *ind_addr;
+
+    ind_addr = cpu_physical_memory_map(ind_loc, &len, 1);
+    if (!ind_addr) {
+        error_report("%s(%x.%x.%04x): unable to access indicator",
+                     __func__, sch->cssid, sch->ssid, sch->schid);
+        return -1;
+    }
+    do {
+        ind_old = *ind_addr;
+        ind_new = ind_old | to_be_set;
+    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
+    cpu_physical_memory_unmap(ind_addr, len, 1, len);
+
+    return ind_old;
+}
+
 static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
 {
     VirtioCcwDevice *dev = to_virtio_ccw_dev_fast(d);
@@ -872,9 +944,26 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
         if (!dev->indicators) {
             return;
         }
-        indicators = ldq_phys(&address_space_memory, dev->indicators);
-        indicators |= 1ULL << vector;
-        stq_phys(&address_space_memory, dev->indicators, indicators);
+        if (sch->thinint_active) {
+            /*
+             * In the adapter interrupt case, indicators points to a
+             * memory area that may be (way) larger than 64 bit and
+             * ind_bit indicates the start of the indicators in a big
+             * endian notation.
+             */
+            virtio_set_ind_atomic(sch, dev->indicators +
+                                  (dev->ind_bit + vector) / 8,
+                                  0x80 >> ((dev->ind_bit + vector) % 8));
+            if (!virtio_set_ind_atomic(sch, dev->summary_indicator,
+                                       0x01)) {
+                css_adapter_interrupt(dev->thinint_isc);
+            }
+        } else {
+            indicators = ldq_phys(&address_space_memory, dev->indicators);
+            indicators |= 1ULL << vector;
+            stq_phys(&address_space_memory, dev->indicators, indicators);
+            css_conditional_io_interrupt(sch);
+        }
     } else {
         if (!dev->indicators2) {
             return;
@@ -883,10 +972,8 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
         indicators = ldq_phys(&address_space_memory, dev->indicators2);
         indicators |= 1ULL << vector;
         stq_phys(&address_space_memory, dev->indicators2, indicators);
+        css_conditional_io_interrupt(sch);
     }
-
-    css_conditional_io_interrupt(sch);
-
 }
 
 static unsigned virtio_ccw_get_features(DeviceState *d)
@@ -907,6 +994,7 @@ static void virtio_ccw_reset(DeviceState *d)
     css_reset_sch(dev->sch);
     dev->indicators = 0;
     dev->indicators2 = 0;
+    dev->summary_indicator = 0;
 }
 
 static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 00932c7..4393e44 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -38,6 +38,7 @@
 #define CCW_CMD_SET_IND      0x43
 #define CCW_CMD_SET_CONF_IND 0x53
 #define CCW_CMD_READ_VQ_CONF 0x32
+#define CCW_CMD_SET_IND_ADAPTER 0x73
 
 #define TYPE_VIRTIO_CCW_DEVICE "virtio-ccw-device"
 #define VIRTIO_CCW_DEVICE(obj) \
@@ -83,9 +84,12 @@ struct VirtioCcwDevice {
     bool ioeventfd_started;
     bool ioeventfd_disabled;
     uint32_t flags;
+    uint8_t thinint_isc;
     /* Guest provided values: */
     hwaddr indicators;
     hwaddr indicators2;
+    hwaddr summary_indicator;
+    uint64_t ind_bit;
 };
 
 /* virtual css bus type */
diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
index 613da49..5bbc67d 100644
--- a/target-s390x/ioinst.h
+++ b/target-s390x/ioinst.h
@@ -212,6 +212,8 @@ typedef struct IOIntCode {
 #define IO_INT_WORD_ISC(_int_word) ((_int_word & 0x38000000) >> 24)
 #define ISC_TO_ISC_BITS(_isc)      ((0x80 >> _isc) << 24)
 
+#define IO_INT_WORD_AI 0x80000000
+
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid);
 void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1);
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index d3f0d4a..7e8321e 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -868,8 +868,12 @@ void kvm_s390_io_interrupt(S390CPU *cpu, uint16_t subchannel_id,
 {
     uint32_t type;
 
-    type = ((subchannel_id & 0xff00) << 24) |
-        ((subchannel_id & 0x00060) << 22) | (subchannel_nr << 16);
+    if (io_int_word & IO_INT_WORD_AI) {
+        type = KVM_S390_INT_IO(1, 0, 0, 0);
+    } else {
+        type = ((subchannel_id & 0xff00) << 24) |
+            ((subchannel_id & 0x00060) << 22) | (subchannel_nr << 16);
+    }
     kvm_s390_interrupt_internal(cpu, type,
                                 ((uint32_t)subchannel_id << 16) | subchannel_nr,
                                 ((uint64_t)io_int_parm << 32) | io_int_word, 1);
diff --git a/trace-events b/trace-events
index 8bc7cc4..372ea64 100644
--- a/trace-events
+++ b/trace-events
@@ -1157,6 +1157,7 @@ css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02
 css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
 css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
 css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
+css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
 
 # hw/s390x/virtio-ccw.c
 virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
-- 
1.7.9.5
