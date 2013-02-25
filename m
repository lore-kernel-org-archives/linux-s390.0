From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 2/2] virtio-ccw: Wire up ioeventfd.
Date: Mon, 25 Feb 2013 16:28:03 +0100
Message-ID: <1361806083-62838-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1361806083-62838-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361806083-62838-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On hosts that support ioeventfd, make use of it for host-to-guest
notifications via diagnose 500.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c        |   2 +-
 hw/s390x/css.h        |   1 +
 hw/s390x/virtio-ccw.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h |   7 ++++
 target-s390x/cpu.h    |  16 +++++++
 target-s390x/kvm.c    |  19 +++++++++
 6 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 85f6f22..82e6746 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -68,7 +68,7 @@ int css_create_css_image(uint8_t cssid, bool default_image)
     return 0;
 }
 
-static uint16_t css_build_subchannel_id(SubchDev *sch)
+uint16_t css_build_subchannel_id(SubchDev *sch)
 {
     if (channel_subsys->max_cssid > 0) {
         return (sch->cssid << 8) | (1 << 3) | (sch->ssid << 1) | 1;
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index 85ed05d..b536ab5 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -90,6 +90,7 @@ bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch);
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
+uint16_t css_build_subchannel_id(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d92e427..23b8092 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -63,6 +63,84 @@ VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch)
     return vdev;
 }
 
+static int virtio_ccw_set_guest2host_notifier(VirtioCcwDevice *dev, int n,
+                                              bool assign, bool set_handler)
+{
+    VirtQueue *vq = virtio_get_queue(dev->vdev, n);
+    EventNotifier *notifier = virtio_queue_get_host_notifier(vq);
+    int r = 0;
+    SubchDev *sch = dev->sch;
+    uint32_t sch_id = (css_build_subchannel_id(sch) << 16) | sch->schid;
+
+    if (assign) {
+        r = event_notifier_init(notifier, 1);
+        if (r < 0) {
+            error_report("%s: unable to init event notifier: %d", __func__, r);
+            return r;
+        }
+        virtio_queue_set_host_notifier_fd_handler(vq, true, set_handler);
+        s390_assign_subch_ioeventfd(event_notifier_get_fd(notifier), sch_id,
+                                    n, assign);
+    } else {
+        virtio_queue_set_host_notifier_fd_handler(vq, false, false);
+        s390_assign_subch_ioeventfd(event_notifier_get_fd(notifier), sch_id,
+                                    n, assign);
+        event_notifier_cleanup(notifier);
+    }
+    return r;
+}
+
+static void virtio_ccw_start_ioeventfd(VirtioCcwDevice *dev)
+{
+    int n, r;
+
+    if (!(dev->flags & VIRTIO_CCW_FLAG_USE_IOEVENTFD) ||
+        dev->ioeventfd_started) {
+        return;
+    }
+    for (n = 0; n < VIRTIO_PCI_QUEUE_MAX; n++) {
+        if (!virtio_queue_get_num(dev->vdev, n)) {
+            continue;
+        }
+        r = virtio_ccw_set_guest2host_notifier(dev, n, true, true);
+        if (r < 0) {
+            goto assign_error;
+        }
+    }
+    dev->ioeventfd_started = true;
+    return;
+
+  assign_error:
+    while (--n >= 0) {
+        if (!virtio_queue_get_num(dev->vdev, n)) {
+            continue;
+        }
+        r = virtio_ccw_set_guest2host_notifier(dev, n, false, false);
+        assert(r >= 0);
+    }
+    dev->ioeventfd_started = false;
+    /* Disable ioeventfd for this device. */
+    dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
+    error_report("%s: failed. Fallback to userspace (slower).", __func__);
+}
+
+static void virtio_ccw_stop_ioeventfd(VirtioCcwDevice *dev)
+{
+    int n, r;
+
+    if (!dev->ioeventfd_started) {
+        return;
+    }
+    for (n = 0; n < VIRTIO_PCI_QUEUE_MAX; n++) {
+        if (!virtio_queue_get_num(dev->vdev, n)) {
+            continue;
+        }
+        r = virtio_ccw_set_guest2host_notifier(dev, n, false, false);
+        assert(r >= 0);
+    }
+    dev->ioeventfd_started = false;
+}
+
 VirtualCssBus *virtual_css_bus_init(void)
 {
     VirtualCssBus *cbus;
@@ -187,6 +265,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         }
         break;
     case CCW_CMD_VDEV_RESET:
+        virtio_ccw_stop_ioeventfd(dev);
         virtio_reset(dev->vdev);
         ret = 0;
         break;
@@ -313,10 +392,16 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EFAULT;
         } else {
             status = ldub_phys(ccw.cda);
+            if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+                virtio_ccw_stop_ioeventfd(dev);
+            }
             virtio_set_status(dev->vdev, status);
             if (dev->vdev->status == 0) {
                 virtio_reset(dev->vdev);
             }
+            if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+                virtio_ccw_start_ioeventfd(dev);
+            }
             sch->curr_status.scsw.count = ccw.count - sizeof(status);
             ret = 0;
         }
@@ -566,6 +651,7 @@ static int virtio_ccw_net_init(VirtioCcwDevice *dev)
 
 static int virtio_ccw_net_exit(VirtioCcwDevice *dev)
 {
+    virtio_ccw_stop_ioeventfd(dev);
     virtio_net_exit(dev->vdev);
     return virtio_ccw_exit(dev);
 }
@@ -584,6 +670,7 @@ static int virtio_ccw_blk_init(VirtioCcwDevice *dev)
 
 static int virtio_ccw_blk_exit(VirtioCcwDevice *dev)
 {
+    virtio_ccw_stop_ioeventfd(dev);
     virtio_blk_exit(dev->vdev);
     blockdev_mark_auto_del(dev->blk.conf.bs);
     return virtio_ccw_exit(dev);
@@ -603,6 +690,7 @@ static int virtio_ccw_serial_init(VirtioCcwDevice *dev)
 
 static int virtio_ccw_serial_exit(VirtioCcwDevice *dev)
 {
+    virtio_ccw_stop_ioeventfd(dev);
     virtio_serial_exit(dev->vdev);
     return virtio_ccw_exit(dev);
 }
@@ -621,6 +709,7 @@ static int virtio_ccw_balloon_init(VirtioCcwDevice *dev)
 
 static int virtio_ccw_balloon_exit(VirtioCcwDevice *dev)
 {
+    virtio_ccw_stop_ioeventfd(dev);
     virtio_balloon_exit(dev->vdev);
     return virtio_ccw_exit(dev);
 }
@@ -639,6 +728,7 @@ static int virtio_ccw_scsi_init(VirtioCcwDevice *dev)
 
 static int virtio_ccw_scsi_exit(VirtioCcwDevice *dev)
 {
+    virtio_ccw_stop_ioeventfd(dev);
     virtio_scsi_exit(dev->vdev);
     return virtio_ccw_exit(dev);
 }
@@ -688,15 +778,28 @@ static void virtio_ccw_reset(DeviceState *d)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
 
+    virtio_ccw_stop_ioeventfd(dev);
     virtio_reset(dev->vdev);
     css_reset_sch(dev->sch);
 }
 
+static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
+{
+    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
+
+    if (running) {
+        virtio_ccw_start_ioeventfd(dev);
+    } else {
+        virtio_ccw_stop_ioeventfd(dev);
+    }
+}
+
 /**************** Virtio-ccw Bus Device Descriptions *******************/
 
 static const VirtIOBindings virtio_ccw_bindings = {
     .notify = virtio_ccw_notify,
     .get_features = virtio_ccw_get_features,
+    .vmstate_change = virtio_ccw_vmstate_change,
 };
 
 static Property virtio_ccw_net_properties[] = {
@@ -708,6 +811,8 @@ static Property virtio_ccw_net_properties[] = {
     DEFINE_PROP_INT32("x-txburst", VirtioCcwDevice,
                       net.txburst, TX_BURST),
     DEFINE_PROP_STRING("tx", VirtioCcwDevice, net.tx),
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -737,6 +842,8 @@ static Property virtio_ccw_blk_properties[] = {
     DEFINE_PROP_BIT("scsi", VirtioCcwDevice, blk.scsi, 0, true),
 #endif
     DEFINE_VIRTIO_BLK_FEATURES(VirtioCcwDevice, host_features[0]),
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -763,6 +870,8 @@ static Property virtio_ccw_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtioCcwDevice,
                        serial.max_virtserial_ports, 31),
     DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwDevice, host_features[0]),
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -787,6 +896,8 @@ static const TypeInfo virtio_ccw_serial = {
 static Property virtio_ccw_balloon_properties[] = {
     DEFINE_PROP_STRING("devno", VirtioCcwDevice, bus_id),
     DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwDevice, host_features[0]),
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -811,6 +922,8 @@ static const TypeInfo virtio_ccw_balloon = {
 static Property virtio_ccw_scsi_properties[] = {
     DEFINE_PROP_STRING("devno", VirtioCcwDevice, bus_id),
     DEFINE_VIRTIO_SCSI_PROPERTIES(VirtioCcwDevice, host_features[0], scsi),
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -936,6 +1049,7 @@ static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
     bus_class->max_dev = 1;
     k->notify = virtio_ccw_notify;
     k->get_features = virtio_ccw_get_features;
+    k->vmstate_change = virtio_ccw_vmstate_change;
 }
 
 static const TypeInfo virtio_ccw_bus_info = {
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 48474b3..db83e0f 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -66,6 +66,11 @@ typedef struct VirtIOCCWDeviceClass {
 /* Change here if we want to support more feature bits. */
 #define VIRTIO_CCW_FEATURE_SIZE 1
 
+/* Performance improves when virtqueue kick processing is decoupled from the
+ * vcpu thread using ioeventfd for some devices. */
+#define VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT 1
+#define VIRTIO_CCW_FLAG_USE_IOEVENTFD   (1 << VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT)
+
 struct VirtioCcwDevice {
     DeviceState parent_obj;
     SubchDev *sch;
@@ -78,6 +83,8 @@ struct VirtioCcwDevice {
     virtio_net_conf net;
     VirtIOSCSIConf scsi;
     VirtioBusState bus;
+    bool ioeventfd_started;
+    uint32_t flags;
     /* Guest provided values: */
     hwaddr indicators;
     hwaddr indicators2;
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index e450db7..3e891d4 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -1068,6 +1068,7 @@ void kvm_s390_io_interrupt(S390CPU *cpu, uint16_t subchannel_id,
                            uint32_t io_int_word);
 void kvm_s390_crw_mchk(S390CPU *cpu);
 void kvm_s390_enable_css_support(S390CPU *cpu);
+int kvm_s390_assign_subch_ioeventfd(int fd, uint32_t sch, int vq, bool assign);
 #else
 static inline void kvm_s390_io_interrupt(S390CPU *cpu,
                                         uint16_t subchannel_id,
@@ -1082,6 +1083,11 @@ static inline void kvm_s390_crw_mchk(S390CPU *cpu)
 static inline void kvm_s390_enable_css_support(S390CPU *cpu)
 {
 }
+static inline int kvm_s390_assign_subch_ioeventfd(int fd, uint32_t sch, int vq,
+                                                  bool assign)
+{
+    return -ENOSYS;
+}
 #endif
 
 static inline void s390_io_interrupt(S390CPU *cpu,
@@ -1108,4 +1114,14 @@ static inline void s390_crw_mchk(S390CPU *cpu)
     }
 }
 
+static inline int s390_assign_subch_ioeventfd(int fd, uint32_t sch_id, int vq,
+                                              bool assign)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_assign_subch_ioeventfd(fd, sch_id, vq, assign);
+    } else {
+        return -ENOSYS;
+    }
+}
+
 #endif
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 3929771..4237374 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -847,3 +847,22 @@ void kvm_s390_enable_css_support(S390CPU *cpu)
     r = kvm_vcpu_ioctl(CPU(cpu), KVM_ENABLE_CAP, &cap);
     assert(r == 0);
 }
+
+int kvm_s390_assign_subch_ioeventfd(int fd, uint32_t sch, int vq, bool assign)
+{
+    struct kvm_ioeventfd kick = {
+        .flags = KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY |
+        KVM_IOEVENTFD_FLAG_DATAMATCH,
+        .fd = fd,
+        .datamatch = vq,
+        .addr = sch,
+        .len = 8,
+    };
+    if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
+        return -ENOSYS;
+    }
+    if (!assign) {
+        kick.flags |= KVM_IOEVENTFD_FLAG_DEASSIGN;
+    }
+    return kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &kick);
+}
-- 
1.7.12.4
