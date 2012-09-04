From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 5/5] [HACK] Handle multiple virtio aliases.
Date: Tue,  4 Sep 2012 17:13:53 +0200
Message-ID: <1346771633-53081-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch enables using both virtio-xxx-s390 and virtio-xxx-ccw
by making the alias lookup code verify that a driver is actually
registered.

(Only included in order to allow testing of virtio-ccw; should be
replaced by cleaning up the virtio bus model.)

Not-signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 blockdev.c        |  6 +---
 hw/qdev-monitor.c | 85 +++++++++++++++++++++++++++++++++----------------------
 vl.c              |  6 +---
 3 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 7c83baa..a7c39b6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -560,11 +560,7 @@ DriveInfo *drive_init(QemuOpts *opts, int default_to_scsi)
     case IF_VIRTIO:
         /* add virtio block device */
         opts = qemu_opts_create(qemu_find_opts("device"), NULL, 0, NULL);
-        if (arch_type == QEMU_ARCH_S390X) {
-            qemu_opt_set(opts, "driver", "virtio-blk-s390");
-        } else {
-            qemu_opt_set(opts, "driver", "virtio-blk-pci");
-        }
+        qemu_opt_set(opts, "driver", "virtio-blk");
         qemu_opt_set(opts, "drive", dinfo->id);
         if (devaddr)
             qemu_opt_set(opts, "addr", devaddr);
diff --git a/hw/qdev-monitor.c b/hw/qdev-monitor.c
index 92b7c59..9245a1e 100644
--- a/hw/qdev-monitor.c
+++ b/hw/qdev-monitor.c
@@ -118,9 +118,53 @@ static int set_property(const char *name, const char *value, void *opaque)
     return 0;
 }
 
-static const char *find_typename_by_alias(const char *alias)
+static BusState *qbus_find_recursive(BusState *bus, const char *name,
+                                     const char *bus_typename)
+{
+    BusChild *kid;
+    BusState *child, *ret;
+    int match = 1;
+
+    if (name && (strcmp(bus->name, name) != 0)) {
+        match = 0;
+    }
+    if (bus_typename &&
+        (strcmp(object_get_typename(OBJECT(bus)), bus_typename) != 0)) {
+        match = 0;
+    }
+    if (match) {
+        return bus;
+    }
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        QLIST_FOREACH(child, &dev->child_bus, sibling) {
+            ret = qbus_find_recursive(child, name, bus_typename);
+            if (ret) {
+                return ret;
+            }
+        }
+    }
+    return NULL;
+}
+
+static bool qdev_verify_bus(DeviceClass *dc)
+{
+    BusState *bus;
+
+    if (dc) {
+        bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
+        if (bus) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static const char *find_typename_by_alias(const char *alias, bool check_bus)
 {
     int i;
+    ObjectClass *oc;
 
     for (i = 0; qdev_alias_table[i].alias; i++) {
         if (qdev_alias_table[i].arch_mask &&
@@ -129,7 +173,10 @@ static const char *find_typename_by_alias(const char *alias)
         }
 
         if (strcmp(qdev_alias_table[i].alias, alias) == 0) {
-            return qdev_alias_table[i].typename;
+            oc = object_class_by_name(qdev_alias_table[i].typename);
+            if (oc && (!check_bus || qdev_verify_bus(DEVICE_CLASS(oc)))) {
+                return qdev_alias_table[i].typename;
+            }
         }
     }
 
@@ -155,7 +202,7 @@ int qdev_device_help(QemuOpts *opts)
 
     klass = object_class_by_name(driver);
     if (!klass) {
-        const char *typename = find_typename_by_alias(driver);
+        const char *typename = find_typename_by_alias(driver, false);
 
         if (typename) {
             driver = typename;
@@ -283,36 +330,6 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
     return NULL;
 }
 
-static BusState *qbus_find_recursive(BusState *bus, const char *name,
-                                     const char *bus_typename)
-{
-    BusChild *kid;
-    BusState *child, *ret;
-    int match = 1;
-
-    if (name && (strcmp(bus->name, name) != 0)) {
-        match = 0;
-    }
-    if (bus_typename &&
-        (strcmp(object_get_typename(OBJECT(bus)), bus_typename) != 0)) {
-        match = 0;
-    }
-    if (match) {
-        return bus;
-    }
-
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
-        QLIST_FOREACH(child, &dev->child_bus, sibling) {
-            ret = qbus_find_recursive(child, name, bus_typename);
-            if (ret) {
-                return ret;
-            }
-        }
-    }
-    return NULL;
-}
-
 static BusState *qbus_find(const char *path)
 {
     DeviceState *dev;
@@ -417,7 +434,7 @@ DeviceState *qdev_device_add(QemuOpts *opts)
     /* find driver */
     obj = object_class_by_name(driver);
     if (!obj) {
-        const char *typename = find_typename_by_alias(driver);
+        const char *typename = find_typename_by_alias(driver, true);
 
         if (typename) {
             driver = typename;
diff --git a/vl.c b/vl.c
index 2b8cae6..788a536 100644
--- a/vl.c
+++ b/vl.c
@@ -2113,11 +2113,7 @@ static int virtcon_parse(const char *devname)
     }
 
     bus_opts = qemu_opts_create(device, NULL, 0, NULL);
-    if (arch_type == QEMU_ARCH_S390X) {
-        qemu_opt_set(bus_opts, "driver", "virtio-serial-s390");
-    } else {
-        qemu_opt_set(bus_opts, "driver", "virtio-serial-pci");
-    } 
+    qemu_opt_set(bus_opts, "driver", "virtio-serial");
 
     dev_opts = qemu_opts_create(device, NULL, 0, NULL);
     qemu_opt_set(dev_opts, "driver", "virtconsole");
-- 
1.7.11.5
