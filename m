From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC] s390/virtio-ccw: Adapter interrupt support.
Date: Fri,  7 Jun 2013 12:37:08 +0200
Message-ID: <1370601428-23447-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1370601428-23447-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1370601428-23447-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Handle the new CCW_CMD_SET_IND_ADAPTER command enabling adapter interrupts
on guest request. When active, host->guest notifications will be handled
via global_indicator -> queue indicators instead of queue indicators +
subchannel I/O interrupt. Indicators for virtqueues may be present at an
offset.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c        |   10 ++++++++
 hw/s390x/css.h        |    2 ++
 hw/s390x/virtio-ccw.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/virtio-ccw.h |    4 +++
 target-s390x/ioinst.h |    2 ++
 target-s390x/kvm.c    |    8 ++++--
 trace-events          |    1 +
 7 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f82abfe..323c232 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -115,6 +115,15 @@ void css_conditional_io_interrupt(SubchDev *sch)
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
@@ -1256,6 +1265,7 @@ void css_reset_sch(SubchDev *sch)
     sch->channel_prog = 0x0;
     sch->last_cmd_valid = false;
     sch->orb = NULL;
+    sch->thinint_active = false;
 }
 
 void css_reset(void)
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index 85ed05d..ab5d4c4 100644
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
@@ -96,4 +97,5 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add);
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
+void css_adapter_interrupt(uint8_t isc);
 #endif
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 44f5772..ccebd11 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -101,6 +101,13 @@ typedef struct VirtioFeatDesc {
     uint8_t index;
 } QEMU_PACKED VirtioFeatDesc;
 
+typedef struct VirtioThinintInfo {
+    hwaddr summary_indicator;
+    hwaddr device_indicator;
+    uint16_t ind_shift;
+    uint8_t isc;
+} QEMU_PACKED VirtioThinintInfo;
+
 /* Specify where the virtqueues for the subchannel are in guest memory. */
 static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
                               uint16_t index, uint16_t num)
@@ -149,6 +156,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
     bool check_len;
     int len;
     hwaddr hw_len;
+    VirtioThinintInfo *thinint;
 
     if (!dev) {
         return -EINVAL;
@@ -328,6 +336,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
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
@@ -379,6 +392,42 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
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
+                dev->ind_shift = thinint->ind_shift;
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
@@ -411,6 +460,7 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     sch->channel_prog = 0x0;
     sch->last_cmd_valid = false;
     sch->orb = NULL;
+    sch->thinint_active = false;
     /*
      * Use a device number if provided. Otherwise, fall back to subchannel
      * number.
@@ -773,6 +823,9 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
             return;
         }
         indicators = ldq_phys(dev->indicators);
+        if (sch->thinint_active) {
+            vector += dev->ind_shift;
+        }
         indicators |= 1ULL << vector;
         stq_phys(dev->indicators, indicators);
     } else {
@@ -785,7 +838,15 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
         stq_phys(dev->indicators2, indicators);
     }
 
-    css_conditional_io_interrupt(sch);
+    if (sch->thinint_active) {
+        /* Set indicator for the device. */
+        if (!ldub_phys(dev->summary_indicator)) {
+            stb_phys(dev->summary_indicator, 1);
+            css_adapter_interrupt(dev->thinint_isc);
+        }
+    } else {
+        css_conditional_io_interrupt(sch);
+    }
 
 }
 
@@ -803,6 +864,9 @@ static void virtio_ccw_reset(DeviceState *d)
 
     virtio_reset(dev->vdev);
     css_reset_sch(dev->sch);
+    dev->indicators = 0;
+    dev->indicators2 = 0;
+    dev->summary_indicator = 0;
 }
 
 /**************** Virtio-ccw Bus Device Descriptions *******************/
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 121a5f8..808983d 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -38,6 +38,7 @@
 #define CCW_CMD_SET_IND      0x43
 #define CCW_CMD_SET_CONF_IND 0x53
 #define CCW_CMD_READ_VQ_CONF 0x32
+#define CCW_CMD_SET_IND_ADAPTER 0x63
 
 #define TYPE_VIRTIO_CCW_DEVICE "virtio-ccw-device"
 #define VIRTIO_CCW_DEVICE(obj) \
@@ -76,9 +77,12 @@ struct VirtioCcwDevice {
     char *bus_id;
     uint32_t host_features[VIRTIO_CCW_FEATURE_SIZE];
     VirtioBusState bus;
+    uint8_t thinint_isc;
     /* Guest provided values: */
     hwaddr indicators;
     hwaddr indicators2;
+    hwaddr summary_indicator;
+    uint16_t ind_shift;
 };
 
 /* virtual css bus type */
diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
index 7bed291..184466f 100644
--- a/target-s390x/ioinst.h
+++ b/target-s390x/ioinst.h
@@ -212,6 +212,8 @@ typedef struct IOIntCode {
 #define IO_INT_WORD_ISC(_int_word) ((_int_word & 0x38000000) >> 24)
 #define ISC_TO_ISC_BITS(_isc)      ((0x80 >> _isc) << 24)
 
+#define IO_INT_WORD_AI 0x80000000
+
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid);
 int ioinst_handle_xsch(CPUS390XState *env, uint64_t reg1);
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 862fb12..eebc228 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -905,8 +905,12 @@ void kvm_s390_io_interrupt(S390CPU *cpu, uint16_t subchannel_id,
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
index c5f1ccb..f6aa686 100644
--- a/trace-events
+++ b/trace-events
@@ -1144,6 +1144,7 @@ css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02
 css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
 css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
 css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
+css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
 
 # hw/s390x/virtio-ccw.c
 virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
-- 
1.7.9.5
