From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 1/5] s390x/ap-matrix: Adjunct Processor (AP) matrix object model
Date: Thu, 26 Oct 2017 11:54:50 -0400
Message-ID: <1509033294-4945-2-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch introduces the base object model for an AP matrix device. An AP
matrix is comprised of the AP adapters, usage domains and control domains
assigned to a KVM guest. The matrix is represented in three bit masks:

* The AP Mask (APM) specifies the AP adapters assigned to the
  KVM guest. The APM controls which adapters are valid for the KVM guest.
  The bits in the mask, from left to right, correspond to APIDs
  0 up to the number of adapters that can be assigned to the LPAR. If a bit
  is set, the corresponding adapter is valid for use by the KVM guest.

* The AP Queue Mask (AQM) specifies the AP usage domains assigned
  to the KVM guest. The bits in the mask, from left to right, correspond
  to the usage domains, from 0 up to the number of domains that can be
  assigned to the LPAR. If a bit is set, the corresponding usage domain is
  valid for use by the KVM guest.

* The AP Domain Mask specifies the AP control domains assigned to the
  KVM guest. The ADM bitmask controls which domains can be changed by an AP
  command-request message sent to a usage domain from the guest. The bits in
  the mask, from left to right, correspond to domain 0 up to the number of
  domains that can be assigned to the LPAR. If a bit is set, the
  corresponding domain can be modified by an AP command-request message
  sent to a usage domain configured for the KVM guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 hw/s390x/Makefile.objs            |    2 +
 hw/s390x/ap-matrix-device.c       |   33 +++++++++++++++++++++++
 hw/s390x/ap-matrix-device.h       |   53 +++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-ap-matrix.c         |   52 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/s390-ap-matrix.h |   39 +++++++++++++++++++++++++++
 5 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 hw/s390x/ap-matrix-device.c
 create mode 100644 hw/s390x/ap-matrix-device.h
 create mode 100644 hw/s390x/s390-ap-matrix.c
 create mode 100644 include/hw/s390x/s390-ap-matrix.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index dc704b5..a50f908 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -17,3 +17,5 @@ obj-y += s390-stattrib.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
+obj-y += ap-matrix-device.o
+obj-y += s390-ap-matrix.o
diff --git a/hw/s390x/ap-matrix-device.c b/hw/s390x/ap-matrix-device.c
new file mode 100644
index 0000000..d036ce2
--- /dev/null
+++ b/hw/s390x/ap-matrix-device.c
@@ -0,0 +1,33 @@
+/*
+ * Common device infrastructure for AP matrix devices
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Jing Liu <liujbjl@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include <ctype.h>
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "ap-matrix-device.h"
+
+static const TypeInfo ap_matrix_device_info = {
+    .name = TYPE_AP_MATRIX_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(APMatrixDevice),
+    .class_size = sizeof(APMatrixDeviceClass),
+    .abstract = true,
+};
+
+static void ap_matrix_device_register(void)
+{
+    type_register_static(&ap_matrix_device_info);
+}
+
+type_init(ap_matrix_device_register)
diff --git a/hw/s390x/ap-matrix-device.h b/hw/s390x/ap-matrix-device.h
new file mode 100644
index 0000000..af7ae2c
--- /dev/null
+++ b/hw/s390x/ap-matrix-device.h
@@ -0,0 +1,53 @@
+/*
+ * Adjunct Processor (AP) matrix device structures
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390X_AP_MATRIX_DEVICE_H
+#define HW_S390X_AP_MATRIX_DEVICE_H
+#include "qom/object.h"
+#include "hw/qdev.h"
+
+#define AP_MATRIX_MASK_INDICES 4
+#define AP_MATRIX_MAX_MASK_BITS 256
+
+typedef struct APMatrixMasks {
+    uint64_t apm[AP_MATRIX_MASK_INDICES];
+    uint64_t aqm[AP_MATRIX_MASK_INDICES];
+    uint64_t adm[AP_MATRIX_MASK_INDICES];
+} APMatrixMasks;
+
+typedef struct APMatrixDevice {
+    DeviceState parent_obj;
+    APMatrixMasks masks;
+} APMatrixDevice;
+
+extern const VMStateDescription vmstate_ap_matrix_dev;
+#define VMSTATE_AP_MATRIX_DEVICE(_field, _state)                     \
+    VMSTATE_STRUCT(_field, _state, 1, vmstate_ap_matrix_dev, APMatrixDevice)
+
+typedef struct APMatrixDeviceClass {
+    DeviceClass parent_class;
+} APMatrixDeviceClass;
+
+static inline APMatrixDevice *to_ap_matrix_dev(DeviceState *dev)
+{
+    return container_of(dev, APMatrixDevice, parent_obj);
+}
+
+#define TYPE_AP_MATRIX_DEVICE "ap-matrix-device"
+
+#define AP_MATRIX_DEVICE(obj) \
+    OBJECT_CHECK(APMatrixDevice, (obj), TYPE_AP_MATRIX_DEVICE)
+#define AP_MATRIX_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(AP_MATRIXDeviceClass, (obj), TYPE_AP_MATRIX_DEVICE)
+#define AP_MATRIX_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(AP_MATRIXDeviceClass, (klass), TYPE_AP_MATRIX_DEVICE)
+
+#endif
diff --git a/hw/s390x/s390-ap-matrix.c b/hw/s390x/s390-ap-matrix.c
new file mode 100644
index 0000000..6d2e234
--- /dev/null
+++ b/hw/s390x/s390-ap-matrix.c
@@ -0,0 +1,52 @@
+/*
+ * s390 AP Matrix Assignment Support
+ *
+ * Copyright 2017 IBM Corp
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or (at your option) any later version. See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "libgen.h"
+#include "hw/s390x/s390-ap-matrix.h"
+
+static void s390_ap_matrix_device_realize(S390APMatrixDevice *sapmdev,
+                                          APMatrixMasks *masks,
+                                          Error **errp)
+{
+    size_t i;
+    APMatrixDevice *apmdev = AP_MATRIX_DEVICE(sapmdev);
+
+    for (i = 0; i < AP_MATRIX_MASK_INDICES; i++) {
+        apmdev->masks.apm[i] = masks->apm[i];
+        apmdev->masks.aqm[i] = masks->aqm[i];
+        apmdev->masks.adm[i] = masks->adm[i];
+    }
+}
+
+static void s390_ap_matrix_class_init(ObjectClass *klass, void *data)
+{
+    S390APMatrixDeviceClass *apmc = S390_AP_MATRIX_DEVICE_CLASS(klass);
+
+    apmc->realize = s390_ap_matrix_device_realize;
+}
+
+static const TypeInfo s390_ap_matrix_info = {
+    .name          = TYPE_S390_AP_MATRIX_DEVICE,
+    .parent        = TYPE_AP_MATRIX_DEVICE,
+    .instance_size = sizeof(S390APMatrixDevice),
+    .class_size    = sizeof(S390APMatrixDeviceClass),
+    .class_init    = s390_ap_matrix_class_init,
+    .abstract      = true,
+};
+
+static void register_s390_ap_matrix_type(void)
+{
+    type_register_static(&s390_ap_matrix_info);
+}
+
+type_init(register_s390_ap_matrix_type)
diff --git a/include/hw/s390x/s390-ap-matrix.h b/include/hw/s390x/s390-ap-matrix.h
new file mode 100644
index 0000000..b088841
--- /dev/null
+++ b/include/hw/s390x/s390-ap-matrix.h
@@ -0,0 +1,39 @@
+/*
+ * s390 AP Matrix Assignment Support
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_AP_MATRIX_H
+#define HW_S390_AP_MATRIX_H
+
+#include "hw/s390x/ap-matrix-device.h"
+
+#define AP_MATRIX_ADAPTERS_PROP_NAME    "adapters"
+#define AP_MATRIX_DOMAINS_PROP_NAME     "domains"
+#define AP_MATRIX_CONTROLS_PROP_NAME    "controls"
+#define TYPE_S390_AP_MATRIX_DEVICE "s390-ap-matrix"
+#define S390_AP_MATRIX_DEVICE(obj) \
+    OBJECT_CHECK(S390APMatrixDevice, (obj), TYPE_S390_AP_MATRIX_DEVICE)
+#define S390_AP_MATRIX_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(S390APMatrixDeviceClass, (klass), \
+                       TYPE_S390_AP_MATRIX_DEVICE)
+#define S390_AP_MATRIX_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(S390APMatrixDeviceClass, (obj), TYPE_S390_AP_MATRIX_DEVICE)
+
+typedef struct S390APMatrixDevice {
+    APMatrixDevice parent_obj;
+} S390APMatrixDevice;
+
+typedef struct S390APMatrixDeviceClass {
+    APMatrixDeviceClass parent_class;
+    void (*realize)(S390APMatrixDevice *sapmdev, APMatrixMasks *masks,
+                    Error **errp);
+} S390APMatrixDeviceClass;
+
+#endif
-- 
1.7.1
