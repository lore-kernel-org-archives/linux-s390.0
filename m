From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 4/5] s390x/virtio-ccw: reference-counted indicators
Date: Fri, 21 Mar 2014 13:52:36 +0100
Message-ID: <1395406357-14766-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Make code using the same indicators point to a single allocated structure
that is freed when the last user goes away.

This will be used by the irqfd code to unmap addresses after the last user
is gone.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c |   80 ++++++++++++++++++++++++++++++++++++++-----------
 hw/s390x/virtio-ccw.h |   13 ++++++--
 2 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 1193682..69efa6c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -27,6 +27,38 @@
 #include "virtio-ccw.h"
 #include "trace.h"
 
+static QTAILQ_HEAD(, IndAddr) indicator_addresses =
+    QTAILQ_HEAD_INITIALIZER(indicator_addresses);
+
+static IndAddr *get_indicator(hwaddr ind_addr, int len)
+{
+    IndAddr *indicator;
+
+    QTAILQ_FOREACH(indicator, &indicator_addresses, sibling) {
+        if (indicator->addr == ind_addr) {
+            indicator->refcnt++;
+            return indicator;
+        }
+    }
+    indicator = g_new0(IndAddr, 1);
+    indicator->addr = ind_addr;
+    indicator->len = len;
+    indicator->refcnt = 1;
+    QTAILQ_INSERT_TAIL(&indicator_addresses, indicator, sibling);
+    return indicator;
+}
+
+static void release_indicator(IndAddr *indicator)
+{
+    assert(indicator->refcnt > 0);
+    indicator->refcnt--;
+    if (indicator->refcnt > 0) {
+        return;
+    }
+    QTAILQ_REMOVE(&indicator_addresses, indicator, sibling);
+    g_free(indicator);
+}
+
 static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtioCcwDevice *dev);
 
@@ -445,7 +477,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EFAULT;
         } else {
             indicators = ldq_phys(&address_space_memory, ccw.cda);
-            dev->indicators = indicators;
+            dev->indicators = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
             ret = 0;
         }
@@ -465,7 +497,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EFAULT;
         } else {
             indicators = ldq_phys(&address_space_memory, ccw.cda);
-            dev->indicators2 = indicators;
+            dev->indicators2 = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
             ret = 0;
         }
@@ -517,8 +549,10 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 ret = -EFAULT;
             } else {
                 len = hw_len;
-                dev->summary_indicator = thinint->summary_indicator;
-                dev->indicators = thinint->device_indicator;
+                dev->summary_indicator =
+                    get_indicator(thinint->summary_indicator, sizeof(uint8_t));
+                dev->indicators = get_indicator(thinint->device_indicator,
+                                                thinint->ind_bit / 8 + 1);
                 dev->thinint_isc = thinint->isc;
                 dev->ind_bit = thinint->ind_bit;
                 cpu_physical_memory_unmap(thinint, hw_len, 0, hw_len);
@@ -526,8 +560,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                               dev->thinint_isc, true, false,
                                               &dev->adapter_id);
                 assert(ret == 0);
-                sch->thinint_active = ((dev->indicators != 0) &&
-                                       (dev->summary_indicator != 0));
+                sch->thinint_active = ((dev->indicators != NULL) &&
+                                       (dev->summary_indicator != NULL));
                 sch->curr_status.scsw.count = ccw.count - len;
                 ret = 0;
             }
@@ -558,7 +592,7 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     sch->driver_data = dev;
     dev->sch = sch;
 
-    dev->indicators = 0;
+    dev->indicators = NULL;
 
     /* Initialize subchannel structure. */
     sch->channel_prog = 0x0;
@@ -698,7 +732,10 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
         css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
         g_free(sch);
     }
-    dev->indicators = 0;
+    if (dev->indicators) {
+        release_indicator(dev->indicators);
+        dev->indicators = NULL;
+    }
     return 0;
 }
 
@@ -955,17 +992,17 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
              * ind_bit indicates the start of the indicators in a big
              * endian notation.
              */
-            virtio_set_ind_atomic(sch, dev->indicators +
+            virtio_set_ind_atomic(sch, dev->indicators->addr +
                                   (dev->ind_bit + vector) / 8,
                                   0x80 >> ((dev->ind_bit + vector) % 8));
-            if (!virtio_set_ind_atomic(sch, dev->summary_indicator,
+            if (!virtio_set_ind_atomic(sch, dev->summary_indicator->addr,
                                        0x01)) {
                 css_adapter_interrupt(dev->thinint_isc);
             }
         } else {
-            indicators = ldq_phys(&address_space_memory, dev->indicators);
+            indicators = ldq_phys(&address_space_memory, dev->indicators->addr);
             indicators |= 1ULL << vector;
-            stq_phys(&address_space_memory, dev->indicators, indicators);
+            stq_phys(&address_space_memory, dev->indicators->addr, indicators);
             css_conditional_io_interrupt(sch);
         }
     } else {
@@ -973,9 +1010,9 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
             return;
         }
         vector = 0;
-        indicators = ldq_phys(&address_space_memory, dev->indicators2);
+        indicators = ldq_phys(&address_space_memory, dev->indicators2->addr);
         indicators |= 1ULL << vector;
-        stq_phys(&address_space_memory, dev->indicators2, indicators);
+        stq_phys(&address_space_memory, dev->indicators2->addr, indicators);
         css_conditional_io_interrupt(sch);
     }
 }
@@ -996,9 +1033,18 @@ static void virtio_ccw_reset(DeviceState *d)
     virtio_ccw_stop_ioeventfd(dev);
     virtio_reset(vdev);
     css_reset_sch(dev->sch);
-    dev->indicators = 0;
-    dev->indicators2 = 0;
-    dev->summary_indicator = 0;
+    if (dev->indicators) {
+        release_indicator(dev->indicators);
+        dev->indicators = NULL;
+    }
+    if (dev->indicators2) {
+        release_indicator(dev->indicators2);
+        dev->indicators2 = NULL;
+    }
+    if (dev->summary_indicator) {
+        release_indicator(dev->summary_indicator);
+        dev->summary_indicator = NULL;
+    }
 }
 
 static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 0b70b91..d340bf4 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -75,6 +75,13 @@ typedef struct VirtIOCCWDeviceClass {
 #define VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT 1
 #define VIRTIO_CCW_FLAG_USE_IOEVENTFD   (1 << VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT)
 
+typedef struct IndAddr {
+    hwaddr addr;
+    unsigned long refcnt;
+    int len;
+    QTAILQ_ENTRY(IndAddr) sibling;
+} IndAddr;
+
 struct VirtioCcwDevice {
     DeviceState parent_obj;
     SubchDev *sch;
@@ -87,9 +94,9 @@ struct VirtioCcwDevice {
     uint8_t thinint_isc;
     uint32_t adapter_id;
     /* Guest provided values: */
-    hwaddr indicators;
-    hwaddr indicators2;
-    hwaddr summary_indicator;
+    IndAddr *indicators;
+    IndAddr *indicators2;
+    IndAddr *summary_indicator;
     uint64_t ind_bit;
 };
 
-- 
1.7.9.5
