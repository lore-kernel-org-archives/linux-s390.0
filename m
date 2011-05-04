From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] virtio/vhost: support 64 bit features
Date: Thu, 5 May 2011 00:01:57 +0300
Message-ID: <57ef43151e0838ea332fa4d65783185a0e1782dc.1304542880.git.mst@redhat.com>
References: <cover.1304542880.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1304542880.git.mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Shirley Ma <xma@us.ibm.com>, lguest@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Krishna Kumar <krkumar2@in.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, steved@us.ibm.com, habanero@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Add support for extended feature bits: up to 64 bit.
Only virtio-pci is actually implemented,
s390 and syborg are stubbed out (and untested).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/qdev-properties.c   |   39 ++++++++++++++++----
 hw/qdev.h              |   10 +++++
 hw/s390-virtio-bus.c   |    5 ++-
 hw/s390-virtio-bus.h   |    2 +-
 hw/syborg_virtio.c     |    7 ++--
 hw/vhost_net.c         |    8 ++--
 hw/vhost_net.h         |    4 +-
 hw/virtio-9p.c         |    2 +-
 hw/virtio-balloon.c    |    2 +-
 hw/virtio-blk.c        |    2 +-
 hw/virtio-blk.h        |    2 +-
 hw/virtio-net.c        |   11 +++---
 hw/virtio-net.h        |   34 +++++++++---------
 hw/virtio-pci.c        |   91 +++++++++++++++++++++++++++++++++++-------------
 hw/virtio-serial-bus.c |    2 +-
 hw/virtio.c            |   24 ++++++++++---
 hw/virtio.h            |   17 +++++----
 17 files changed, 179 insertions(+), 83 deletions(-)

diff --git a/hw/qdev-properties.c b/hw/qdev-properties.c
index 1088a26..a933c9e 100644
--- a/hw/qdev-properties.c
+++ b/hw/qdev-properties.c
@@ -10,20 +10,35 @@ void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
     return ptr;
 }
 
-static uint32_t qdev_get_prop_mask(Property *prop)
+static uint64_t qdev_get_prop_mask(Property *prop)
 {
     assert(prop->info->type == PROP_TYPE_BIT);
-    return 0x1 << prop->bitnr;
+    return 0x1ULL << prop->bitnr;
+}
+
+static uint64_t qdev_get_prop_val(DeviceState *dev, Property *prop)
+{
+    assert(prop->info->type == PROP_TYPE_BIT);
+    if (prop->info->size == sizeof(uint32_t)) {
+        return *(uint32_t *)qdev_get_prop_ptr(dev, prop);
+    } else {
+        return *(uint64_t *)qdev_get_prop_ptr(dev, prop);
+    }
 }
 
 static void bit_prop_set(DeviceState *dev, Property *props, bool val)
 {
-    uint32_t *p = qdev_get_prop_ptr(dev, props);
-    uint32_t mask = qdev_get_prop_mask(props);
+    uint64_t p = qdev_get_prop_val(dev, props);
+    uint64_t mask = qdev_get_prop_mask(props);
     if (val)
-        *p |= mask;
+        p |= mask;
     else
-        *p &= ~mask;
+        p &= ~mask;
+    if (props->info->size == sizeof(uint32_t)) {
+        *(uint32_t *)qdev_get_prop_ptr(dev, props) = p;
+    } else {
+        *(uint64_t *)qdev_get_prop_ptr(dev, props) = p;
+    }
 }
 
 static void qdev_prop_cpy(DeviceState *dev, Property *props, void *src)
@@ -51,8 +66,8 @@ static int parse_bit(DeviceState *dev, Property *prop, const char *str)
 
 static int print_bit(DeviceState *dev, Property *prop, char *dest, size_t len)
 {
-    uint32_t *p = qdev_get_prop_ptr(dev, prop);
-    return snprintf(dest, len, (*p & qdev_get_prop_mask(prop)) ? "on" : "off");
+    uint64_t val = qdev_get_prop_val(dev, prop);
+    return snprintf(dest, len, (val & qdev_get_prop_mask(prop)) ? "on" : "off");
 }
 
 PropertyInfo qdev_prop_bit = {
@@ -63,6 +78,14 @@ PropertyInfo qdev_prop_bit = {
     .print = print_bit,
 };
 
+PropertyInfo qdev_prop_bit64 = {
+    .name  = "on/off",
+    .type  = PROP_TYPE_BIT,
+    .size  = sizeof(uint64_t),
+    .parse = parse_bit,
+    .print = print_bit,
+};
+
 /* --- 8bit integer --- */
 
 static int parse_uint8(DeviceState *dev, Property *prop, const char *str)
diff --git a/hw/qdev.h b/hw/qdev.h
index 8a13ec9..e65cab0 100644
--- a/hw/qdev.h
+++ b/hw/qdev.h
@@ -219,6 +219,7 @@ int do_device_del(Monitor *mon, const QDict *qdict, QObject **ret_data);
 /*** qdev-properties.c ***/
 
 extern PropertyInfo qdev_prop_bit;
+extern PropertyInfo qdev_prop_bit64;
 extern PropertyInfo qdev_prop_uint8;
 extern PropertyInfo qdev_prop_uint16;
 extern PropertyInfo qdev_prop_uint32;
@@ -257,6 +258,15 @@ extern PropertyInfo qdev_prop_pci_devfn;
         .defval    = (bool[]) { (_defval) },                     \
         }
 
+#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {  \
+        .name      = (_name),                                    \
+        .info      = &(qdev_prop_bit64),                           \
+        .bitnr    = (_bit),                                      \
+        .offset    = offsetof(_state, _field)                    \
+            + type_check(uint64_t,typeof_field(_state, _field)), \
+        .defval    = (bool[]) { (_defval) },                     \
+        }
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
diff --git a/hw/s390-virtio-bus.c b/hw/s390-virtio-bus.c
index 175e5cb..89e8c8e 100644
--- a/hw/s390-virtio-bus.c
+++ b/hw/s390-virtio-bus.c
@@ -310,10 +310,11 @@ static void virtio_s390_notify(void *opaque, uint16_t vector)
     kvm_s390_virtio_irq(s390_cpu_addr2state(0), 0, token);
 }
 
-static unsigned virtio_s390_get_features(void *opaque)
+static uint64_t virtio_s390_get_features(void *opaque)
 {
     VirtIOS390Device *dev = (VirtIOS390Device*)opaque;
-    return dev->host_features;
+    /* TODO: support high 32 bit features */
+    return dev->host_features & 0xFFFFFFFFULL;
 }
 
 /**************** S390 Virtio Bus Device Descriptions *******************/
diff --git a/hw/s390-virtio-bus.h b/hw/s390-virtio-bus.h
index edf6d04..5c851e3 100644
--- a/hw/s390-virtio-bus.h
+++ b/hw/s390-virtio-bus.h
@@ -43,7 +43,7 @@ typedef struct VirtIOS390Device {
     VirtIODevice *vdev;
     BlockConf block;
     NICConf nic;
-    uint32_t host_features;
+    uint64_t host_features;
     virtio_serial_conf serial;
     virtio_net_conf net;
 } VirtIOS390Device;
diff --git a/hw/syborg_virtio.c b/hw/syborg_virtio.c
index ee08c49..b64c357 100644
--- a/hw/syborg_virtio.c
+++ b/hw/syborg_virtio.c
@@ -67,7 +67,7 @@ typedef struct {
     uint32_t int_enable;
     uint32_t id;
     NICConf nic;
-    uint32_t host_features;
+    uint64_t host_features;
     virtio_net_conf net;
 } SyborgVirtIOProxy;
 
@@ -244,10 +244,11 @@ static void syborg_virtio_update_irq(void *opaque, uint16_t vector)
     qemu_set_irq(proxy->irq, level != 0);
 }
 
-static unsigned syborg_virtio_get_features(void *opaque)
+static uint32_t syborg_virtio_get_features(void *opaque)
 {
     SyborgVirtIOProxy *proxy = opaque;
-    return proxy->host_features;
+    /* TODO: support high 32 bit features */
+    return proxy->host_features & 0xFFFFFFFFULL;
 }
 
 static VirtIOBindings syborg_virtio_bindings = {
diff --git a/hw/vhost_net.c b/hw/vhost_net.c
index 420e05f..7e94f61 100644
--- a/hw/vhost_net.c
+++ b/hw/vhost_net.c
@@ -41,7 +41,7 @@ struct vhost_net {
     VLANClientState *vc;
 };
 
-unsigned vhost_net_get_features(struct vhost_net *net, unsigned features)
+uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
 {
     /* Clear features not supported by host kernel. */
     if (!(net->dev.features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))) {
@@ -56,7 +56,7 @@ unsigned vhost_net_get_features(struct vhost_net *net, unsigned features)
     return features;
 }
 
-void vhost_net_ack_features(struct vhost_net *net, unsigned features)
+void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
     net->dev.acked_features = net->dev.backend_features;
     if (features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY)) {
@@ -219,11 +219,11 @@ void vhost_net_cleanup(struct vhost_net *net)
 {
 }
 
-unsigned vhost_net_get_features(struct vhost_net *net, unsigned features)
+uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
 {
     return features;
 }
-void vhost_net_ack_features(struct vhost_net *net, unsigned features)
+void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
 }
 #endif
diff --git a/hw/vhost_net.h b/hw/vhost_net.h
index 91e40b1..4069258 100644
--- a/hw/vhost_net.h
+++ b/hw/vhost_net.h
@@ -14,7 +14,7 @@ void vhost_net_stop(VHostNetState *net, VirtIODevice *dev);
 
 void vhost_net_cleanup(VHostNetState *net);
 
-unsigned vhost_net_get_features(VHostNetState *net, unsigned features);
-void vhost_net_ack_features(VHostNetState *net, unsigned features);
+uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
+void vhost_net_ack_features(VHostNetState *net, uint64_t features);
 
 #endif
diff --git a/hw/virtio-9p.c b/hw/virtio-9p.c
index 7e29535..184691a 100644
--- a/hw/virtio-9p.c
+++ b/hw/virtio-9p.c
@@ -3624,7 +3624,7 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
     free_pdu(s, pdu);
 }
 
-static uint32_t virtio_9p_get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t virtio_9p_get_features(VirtIODevice *vdev, uint64_t features)
 {
     features |= 1 << VIRTIO_9P_MOUNT_TAG;
     return features;
diff --git a/hw/virtio-balloon.c b/hw/virtio-balloon.c
index f9add1c..b34adc1 100644
--- a/hw/virtio-balloon.c
+++ b/hw/virtio-balloon.c
@@ -195,7 +195,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     dev->actual = le32_to_cpu(config.actual);
 }
 
-static uint32_t virtio_balloon_get_features(VirtIODevice *vdev, uint32_t f)
+static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f)
 {
     f |= (1 << VIRTIO_BALLOON_F_STATS_VQ);
     return f;
diff --git a/hw/virtio-blk.c b/hw/virtio-blk.c
index 91e0394..442ce11 100644
--- a/hw/virtio-blk.c
+++ b/hw/virtio-blk.c
@@ -466,7 +466,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
 }
 
-static uint32_t virtio_blk_get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIOBlock *s = to_virtio_blk(vdev);
 
diff --git a/hw/virtio-blk.h b/hw/virtio-blk.h
index fff46da..61104ea 100644
--- a/hw/virtio-blk.h
+++ b/hw/virtio-blk.h
@@ -98,7 +98,7 @@ struct virtio_scsi_inhdr
 #ifdef __linux__
 #define DEFINE_VIRTIO_BLK_FEATURES(_state, _field) \
         DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
-        DEFINE_PROP_BIT("scsi", _state, _field, VIRTIO_BLK_F_SCSI, true)
+        DEFINE_PROP_BIT64("scsi", _state, _field, VIRTIO_BLK_F_SCSI, true)
 #else
 #define DEFINE_VIRTIO_BLK_FEATURES(_state, _field) \
         DEFINE_VIRTIO_COMMON_FEATURES(_state, _field)
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 6997e02..c242fd1 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -223,7 +223,7 @@ static int peer_has_ufo(VirtIONet *n)
     return n->has_ufo;
 }
 
-static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = to_virtio_net(vdev);
 
@@ -258,9 +258,9 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
     return vhost_net_get_features(tap_get_vhost_net(n->nic->nc.peer), features);
 }
 
-static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
+static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
 {
-    uint32_t features = 0;
+    uint64_t features = 0;
 
     /* Linux kernel 2.6.25.  It understood MAC (as everyone must),
      * but also these: */
@@ -273,7 +273,7 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
     return features;
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
+static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = to_virtio_net(vdev);
 
@@ -628,7 +628,8 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
                 return -1;
             error_report("virtio-net unexpected empty queue: "
                     "i %zd mergeable %d offset %zd, size %zd, "
-                    "guest hdr len %zd, host hdr len %zd guest features 0x%x",
+                    "guest hdr len %zd, host hdr len %zd "
+                    "guest features 0x%" PRIx64,
                     i, n->mergeable_rx_bufs, offset, size,
                     guest_hdr_len, host_hdr_len, n->vdev.guest_features);
             exit(1);
diff --git a/hw/virtio-net.h b/hw/virtio-net.h
index 8af9a1c..8f8ac7f 100644
--- a/hw/virtio-net.h
+++ b/hw/virtio-net.h
@@ -169,21 +169,21 @@ struct virtio_net_ctrl_mac {
 
 #define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
         DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
-        DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_NET_F_CSUM, true), \
-        DEFINE_PROP_BIT("guest_csum", _state, _field, VIRTIO_NET_F_GUEST_CSUM, true), \
-        DEFINE_PROP_BIT("gso", _state, _field, VIRTIO_NET_F_GSO, true), \
-        DEFINE_PROP_BIT("guest_tso4", _state, _field, VIRTIO_NET_F_GUEST_TSO4, true), \
-        DEFINE_PROP_BIT("guest_tso6", _state, _field, VIRTIO_NET_F_GUEST_TSO6, true), \
-        DEFINE_PROP_BIT("guest_ecn", _state, _field, VIRTIO_NET_F_GUEST_ECN, true), \
-        DEFINE_PROP_BIT("guest_ufo", _state, _field, VIRTIO_NET_F_GUEST_UFO, true), \
-        DEFINE_PROP_BIT("host_tso4", _state, _field, VIRTIO_NET_F_HOST_TSO4, true), \
-        DEFINE_PROP_BIT("host_tso6", _state, _field, VIRTIO_NET_F_HOST_TSO6, true), \
-        DEFINE_PROP_BIT("host_ecn", _state, _field, VIRTIO_NET_F_HOST_ECN, true), \
-        DEFINE_PROP_BIT("host_ufo", _state, _field, VIRTIO_NET_F_HOST_UFO, true), \
-        DEFINE_PROP_BIT("mrg_rxbuf", _state, _field, VIRTIO_NET_F_MRG_RXBUF, true), \
-        DEFINE_PROP_BIT("status", _state, _field, VIRTIO_NET_F_STATUS, true), \
-        DEFINE_PROP_BIT("ctrl_vq", _state, _field, VIRTIO_NET_F_CTRL_VQ, true), \
-        DEFINE_PROP_BIT("ctrl_rx", _state, _field, VIRTIO_NET_F_CTRL_RX, true), \
-        DEFINE_PROP_BIT("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
-        DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true)
+        DEFINE_PROP_BIT64("csum", _state, _field, VIRTIO_NET_F_CSUM, true), \
+        DEFINE_PROP_BIT64("guest_csum", _state, _field, VIRTIO_NET_F_GUEST_CSUM, true), \
+        DEFINE_PROP_BIT64("gso", _state, _field, VIRTIO_NET_F_GSO, true), \
+        DEFINE_PROP_BIT64("guest_tso4", _state, _field, VIRTIO_NET_F_GUEST_TSO4, true), \
+        DEFINE_PROP_BIT64("guest_tso6", _state, _field, VIRTIO_NET_F_GUEST_TSO6, true), \
+        DEFINE_PROP_BIT64("guest_ecn", _state, _field, VIRTIO_NET_F_GUEST_ECN, true), \
+        DEFINE_PROP_BIT64("guest_ufo", _state, _field, VIRTIO_NET_F_GUEST_UFO, true), \
+        DEFINE_PROP_BIT64("host_tso4", _state, _field, VIRTIO_NET_F_HOST_TSO4, true), \
+        DEFINE_PROP_BIT64("host_tso6", _state, _field, VIRTIO_NET_F_HOST_TSO6, true), \
+        DEFINE_PROP_BIT64("host_ecn", _state, _field, VIRTIO_NET_F_HOST_ECN, true), \
+        DEFINE_PROP_BIT64("host_ufo", _state, _field, VIRTIO_NET_F_HOST_UFO, true), \
+        DEFINE_PROP_BIT64("mrg_rxbuf", _state, _field, VIRTIO_NET_F_MRG_RXBUF, true), \
+        DEFINE_PROP_BIT64("status", _state, _field, VIRTIO_NET_F_STATUS, true), \
+        DEFINE_PROP_BIT64("ctrl_vq", _state, _field, VIRTIO_NET_F_CTRL_VQ, true), \
+        DEFINE_PROP_BIT64("ctrl_rx", _state, _field, VIRTIO_NET_F_CTRL_RX, true), \
+        DEFINE_PROP_BIT64("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
+        DEFINE_PROP_BIT64("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true)
 #endif
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 5236470..eb86de2 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -64,15 +64,28 @@
 /* Config space size */
 #define VIRTIO_PCI_CONFIG_NOMSI         20
 #define VIRTIO_PCI_CONFIG_MSI           24
-#define VIRTIO_PCI_REGION_SIZE(dev)     (msix_present(dev) ? \
-                                         VIRTIO_PCI_CONFIG_MSI : \
-                                         VIRTIO_PCI_CONFIG_NOMSI)
+#define VIRTIO_PCI_CONFIG_HI            32
+/* An extended 32-bit r/o bitmask of the features supported by the host */
+#define VIRTIO_PCI_HOST_FEATURES_HI     24
+
+/* An extended 32-bit r/w bitmask of features activated by the guest */
+#define VIRTIO_PCI_GUEST_FEATURES_HI    28
+
+#define VIRTIO_PCI_REGION_SIZE(proxy)   (((proxy)->host_features & \
+                                          (1ULL << VIRTIO_F_FEATURES_HI)) ? \
+                                         VIRTIO_PCI_CONFIG_HI : \
+                                         (msix_present(&(proxy)->pci_dev) ? \
+                                          VIRTIO_PCI_CONFIG_MSI : \
+                                          VIRTIO_PCI_CONFIG_NOMSI))
 
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
-#define VIRTIO_PCI_CONFIG(dev)          (msix_enabled(dev) ? \
-                                         VIRTIO_PCI_CONFIG_MSI : \
-                                         VIRTIO_PCI_CONFIG_NOMSI)
+#define VIRTIO_PCI_CONFIG(proxy)        (((proxy)->vdev->guest_features & \
+                                          (1ULL << VIRTIO_F_FEATURES_HI)) ? \
+                                         VIRTIO_PCI_CONFIG_HI : \
+                                         (msix_enabled(&(proxy)->pci_dev) ? \
+                                          VIRTIO_PCI_CONFIG_MSI : \
+                                          VIRTIO_PCI_CONFIG_NOMSI))
 
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
@@ -106,7 +119,7 @@ typedef struct {
     uint32_t nvectors;
     BlockConf block;
     NICConf nic;
-    uint32_t host_features;
+    uint64_t host_features;
 #ifdef CONFIG_LINUX
     V9fsConf fsconf;
 #endif
@@ -314,11 +327,22 @@ static void virtio_pci_reset(DeviceState *d)
     proxy->flags &= ~VIRTIO_PCI_FLAG_BUS_MASTER_BUG;
 }
 
+static inline uint64_t virtio_replace_hi(uint64_t features, uint32_t hi)
+{
+	return (features & 0xffffffffull) | ((uint64_t)hi) << 32;
+}
+
+static inline uint64_t virtio_replace_lo(uint64_t features, uint32_t lo)
+{
+	return (features & 0xffffffff00000000ull) | lo;
+}
+
 static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
     VirtIODevice *vdev = proxy->vdev;
     target_phys_addr_t pa;
+    uint64_t f;
 
     switch (addr) {
     case VIRTIO_PCI_GUEST_FEATURES:
@@ -329,9 +353,15 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 	    else
 		val = 0;
 	}
+        /* Clearing VIRTIO_F_FEATURES_HI clears high 32 bit. */
+	if (val & (1ULL << VIRTIO_F_FEATURES_HI)) {
+	    f = virtio_replace_lo(vdev->guest_features, val);
+	} else {
+	    f = val;
+        }
         if (vdev->set_features)
-            vdev->set_features(vdev, val);
-        vdev->guest_features = val;
+            vdev->set_features(vdev, f);
+        vdev->guest_features = f;
         break;
     case VIRTIO_PCI_QUEUE_PFN:
         pa = (target_phys_addr_t)val << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
@@ -389,6 +419,12 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
             val = VIRTIO_NO_VECTOR;
         virtio_queue_set_vector(vdev, vdev->queue_sel, val);
         break;
+    case VIRTIO_PCI_GUEST_FEATURES_HI:
+	f = virtio_replace_hi(vdev->guest_features, val);
+        if (vdev->set_features)
+            vdev->set_features(vdev, f);
+        vdev->guest_features = f;
+        break;
     default:
         error_report("%s: unexpected address 0x%x value 0x%x",
                      __func__, addr, val);
@@ -433,6 +469,11 @@ static uint32_t virtio_ioport_read(VirtIOPCIProxy *proxy, uint32_t addr)
     case VIRTIO_MSI_QUEUE_VECTOR:
         ret = virtio_queue_vector(vdev, vdev->queue_sel);
         break;
+    case VIRTIO_PCI_HOST_FEATURES_HI:
+        ret = proxy->host_features >> 32;
+        break;
+    case VIRTIO_PCI_GUEST_FEATURES_HI:
+        ret = vdev->guest_features >> 32;
     default:
         break;
     }
@@ -443,7 +484,7 @@ static uint32_t virtio_ioport_read(VirtIOPCIProxy *proxy, uint32_t addr)
 static uint32_t virtio_pci_config_readb(void *opaque, uint32_t addr)
 {
     VirtIOPCIProxy *proxy = opaque;
-    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    uint32_t config = VIRTIO_PCI_CONFIG(proxy);
     addr -= proxy->addr;
     if (addr < config)
         return virtio_ioport_read(proxy, addr);
@@ -454,7 +495,7 @@ static uint32_t virtio_pci_config_readb(void *opaque, uint32_t addr)
 static uint32_t virtio_pci_config_readw(void *opaque, uint32_t addr)
 {
     VirtIOPCIProxy *proxy = opaque;
-    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    uint32_t config = VIRTIO_PCI_CONFIG(proxy);
     addr -= proxy->addr;
     if (addr < config)
         return virtio_ioport_read(proxy, addr);
@@ -465,7 +506,7 @@ static uint32_t virtio_pci_config_readw(void *opaque, uint32_t addr)
 static uint32_t virtio_pci_config_readl(void *opaque, uint32_t addr)
 {
     VirtIOPCIProxy *proxy = opaque;
-    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    uint32_t config = VIRTIO_PCI_CONFIG(proxy);
     addr -= proxy->addr;
     if (addr < config)
         return virtio_ioport_read(proxy, addr);
@@ -476,7 +517,7 @@ static uint32_t virtio_pci_config_readl(void *opaque, uint32_t addr)
 static void virtio_pci_config_writeb(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
-    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    uint32_t config = VIRTIO_PCI_CONFIG(proxy);
     addr -= proxy->addr;
     if (addr < config) {
         virtio_ioport_write(proxy, addr, val);
@@ -489,7 +530,7 @@ static void virtio_pci_config_writeb(void *opaque, uint32_t addr, uint32_t val)
 static void virtio_pci_config_writew(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
-    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    uint32_t config = VIRTIO_PCI_CONFIG(proxy);
     addr -= proxy->addr;
     if (addr < config) {
         virtio_ioport_write(proxy, addr, val);
@@ -502,7 +543,7 @@ static void virtio_pci_config_writew(void *opaque, uint32_t addr, uint32_t val)
 static void virtio_pci_config_writel(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
-    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    uint32_t config = VIRTIO_PCI_CONFIG(proxy);
     addr -= proxy->addr;
     if (addr < config) {
         virtio_ioport_write(proxy, addr, val);
@@ -517,7 +558,7 @@ static void virtio_map(PCIDevice *pci_dev, int region_num,
 {
     VirtIOPCIProxy *proxy = container_of(pci_dev, VirtIOPCIProxy, pci_dev);
     VirtIODevice *vdev = proxy->vdev;
-    unsigned config_len = VIRTIO_PCI_REGION_SIZE(pci_dev) + vdev->config_len;
+    unsigned config_len = VIRTIO_PCI_REGION_SIZE(proxy) + vdev->config_len;
 
     proxy->addr = addr;
 
@@ -551,7 +592,7 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
     msix_write_config(pci_dev, address, val, len);
 }
 
-static unsigned virtio_pci_get_features(void *opaque)
+static uint64_t virtio_pci_get_features(void *opaque)
 {
     VirtIOPCIProxy *proxy = opaque;
     return proxy->host_features;
@@ -788,13 +829,6 @@ static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
 
     proxy->pci_dev.config_write = virtio_write_config;
 
-    size = VIRTIO_PCI_REGION_SIZE(&proxy->pci_dev) + vdev->config_len;
-    if (size & (size-1))
-        size = 1 << qemu_fls(size);
-
-    pci_register_bar(&proxy->pci_dev, 0, size, PCI_BASE_ADDRESS_SPACE_IO,
-                           virtio_map);
-
     if (!kvm_has_many_ioeventfds()) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
     }
@@ -803,6 +837,15 @@ static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
     proxy->host_features |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
     proxy->host_features |= 0x1 << VIRTIO_F_BAD_FEATURE;
     proxy->host_features = vdev->get_features(vdev, proxy->host_features);
+    if (proxy->host_features & 0xffffffff00000000ull) {
+        proxy->host_features |= 0x1ULL << VIRTIO_F_FEATURES_HI;
+    }
+    size = VIRTIO_PCI_REGION_SIZE(proxy) + vdev->config_len;
+    if (size & (size-1))
+        size = 1 << qemu_fls(size);
+
+    pci_register_bar(&proxy->pci_dev, 0, size, PCI_BASE_ADDRESS_SPACE_IO,
+                           virtio_map);
 }
 
 static int virtio_blk_init_pci(PCIDevice *pci_dev)
diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index 6227379..76acd02 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -461,7 +461,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
 
-static uint32_t get_features(VirtIODevice *vdev, uint32_t features)
+static uint64_t get_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIOSerial *vser;
 
diff --git a/hw/virtio.c b/hw/virtio.c
index 31bd9e3..b9acbd4 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -653,6 +653,8 @@ void virtio_notify_config(VirtIODevice *vdev)
 
 void virtio_save(VirtIODevice *vdev, QEMUFile *f)
 {
+    uint32_t guest_features_hi = vdev->guest_features >> 32;
+    uint32_t guest_features_lo = vdev->guest_features;
     int i;
 
     if (vdev->binding->save_config)
@@ -661,7 +663,10 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     qemu_put_8s(f, &vdev->status);
     qemu_put_8s(f, &vdev->isr);
     qemu_put_be16s(f, &vdev->queue_sel);
-    qemu_put_be32s(f, &vdev->guest_features);
+    qemu_put_be32s(f, &guest_features_lo);
+    if (guest_features_lo & (1ULL << VIRTIO_F_FEATURES_HI)) {
+        qemu_put_be32s(f, &guest_features_hi);
+    }
     qemu_put_be32(f, vdev->config_len);
     qemu_put_buffer(f, vdev->config, vdev->config_len);
 
@@ -687,8 +692,9 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
 int virtio_load(VirtIODevice *vdev, QEMUFile *f)
 {
     int num, i, ret;
-    uint32_t features;
-    uint32_t supported_features =
+    uint32_t features_hi, features_lo;
+    uint64_t features;
+    uint64_t supported_features =
         vdev->binding->get_features(vdev->binding_opaque);
 
     if (vdev->binding->load_config) {
@@ -700,9 +706,17 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f)
     qemu_get_8s(f, &vdev->status);
     qemu_get_8s(f, &vdev->isr);
     qemu_get_be16s(f, &vdev->queue_sel);
-    qemu_get_be32s(f, &features);
+    qemu_get_be32s(f, &features_lo);
+    if (features_lo & (1ULL << VIRTIO_F_FEATURES_HI)) {
+        qemu_get_be32s(f, &features_hi);
+    } else {
+        features_hi = 0;
+    }
+    features = ((uint64_t)features_hi) << 32 | features_lo;
+    
     if (features & ~supported_features) {
-        error_report("Features 0x%x unsupported. Allowed features: 0x%x",
+        error_report("Features 0x%" PRIx64 " unsupported. "
+                     "Allowed features: 0x%" PRIx64,
                      features, supported_features);
         return -1;
     }
diff --git a/hw/virtio.h b/hw/virtio.h
index bc72289..9517b97 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -49,6 +49,9 @@
 /* A guest should never accept this.  It implies negotiation is broken. */
 #define VIRTIO_F_BAD_FEATURE		30
 
+/* Enables feature bits 32 to 63 (only really required for virtio_pci). */
+#define VIRTIO_F_FEATURES_HI		31
+
 /* from Linux's linux/virtio_ring.h */
 
 /* This marks a buffer as continuing via the next field. */
@@ -93,7 +96,7 @@ typedef struct {
     int (*load_config)(void * opaque, QEMUFile *f);
     int (*load_queue)(void * opaque, int n, QEMUFile *f);
     int (*load_done)(void * opaque, QEMUFile *f);
-    unsigned (*get_features)(void * opaque);
+    uint64_t (*get_features)(void * opaque);
     bool (*query_guest_notifiers)(void * opaque);
     int (*set_guest_notifiers)(void * opaque, bool assigned);
     int (*set_host_notifier)(void * opaque, int n, bool assigned);
@@ -110,14 +113,14 @@ struct VirtIODevice
     uint8_t status;
     uint8_t isr;
     uint16_t queue_sel;
-    uint32_t guest_features;
+    uint64_t guest_features;
     size_t config_len;
     void *config;
     uint16_t config_vector;
     int nvectors;
-    uint32_t (*get_features)(VirtIODevice *vdev, uint32_t requested_features);
-    uint32_t (*bad_features)(VirtIODevice *vdev);
-    void (*set_features)(VirtIODevice *vdev, uint32_t val);
+    uint64_t (*get_features)(VirtIODevice *vdev, uint64_t requested_features);
+    uint64_t (*bad_features)(VirtIODevice *vdev);
+    void (*set_features)(VirtIODevice *vdev, uint64_t val);
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
@@ -209,8 +212,8 @@ void virtio_blk_exit(VirtIODevice *vdev);
 void virtio_serial_exit(VirtIODevice *vdev);
 
 #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
-	DEFINE_PROP_BIT("indirect_desc", _state, _field, \
-			VIRTIO_RING_F_INDIRECT_DESC, true)
+	DEFINE_PROP_BIT64("indirect_desc", _state, _field, \
+			  VIRTIO_RING_F_INDIRECT_DESC, true)
 
 target_phys_addr_t virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 target_phys_addr_t virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
-- 
1.7.5.53.gc233e
