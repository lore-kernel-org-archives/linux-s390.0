From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 01/12] s390: Add a hypercall registration interface.
Date: Thu, 17 Jan 2013 15:23:46 +0100
Message-ID: <1358432637-42512-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Allow virtio machines to register for different diag500 function
codes and convert s390-virtio to use it.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390-virtio.c             | 90 +++++++++++++++++++++++---------------------
 hw/s390-virtio.h             | 22 +++++++++++
 hw/s390x/Makefile.objs       |  1 +
 hw/s390x/s390-virtio-hcall.c | 36 ++++++++++++++++++
 target-s390x/cpu.h           |  2 +-
 target-s390x/kvm.c           |  2 +-
 target-s390x/misc_helper.c   |  2 +-
 7 files changed, 110 insertions(+), 45 deletions(-)
 create mode 100644 hw/s390-virtio.h
 create mode 100644 hw/s390x/s390-virtio-hcall.c

diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
index 0e93cc3..bded30b 100644
--- a/hw/s390-virtio.c
+++ b/hw/s390-virtio.c
@@ -33,6 +33,7 @@
 
 #include "hw/s390-virtio-bus.h"
 #include "hw/s390x/sclp.h"
+#include "hw/s390-virtio.h"
 
 //#define DEBUG_S390
 
@@ -44,10 +45,6 @@
     do { } while (0)
 #endif
 
-#define KVM_S390_VIRTIO_NOTIFY          0
-#define KVM_S390_VIRTIO_RESET           1
-#define KVM_S390_VIRTIO_SET_STATUS      2
-
 #define KERN_IMAGE_START                0x010000UL
 #define KERN_PARM_AREA                  0x010480UL
 #define INITRD_START                    0x800000UL
@@ -73,56 +70,63 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
     return ipi_states[cpu_addr];
 }
 
-int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
+static int s390_virtio_hcall_notify(const uint64_t *args)
 {
+    uint64_t mem = args[0];
     int r = 0, i;
 
-    dprintf("KVM hypercall: %ld\n", hypercall);
-    switch (hypercall) {
-    case KVM_S390_VIRTIO_NOTIFY:
-        if (mem > ram_size) {
-            VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
-                                                               mem, &i);
-            if (dev) {
-                virtio_queue_notify(dev->vdev, i);
-            } else {
-                r = -EINVAL;
-            }
-        } else {
-            /* Early printk */
-        }
-        break;
-    case KVM_S390_VIRTIO_RESET:
-    {
-        VirtIOS390Device *dev;
-
-        dev = s390_virtio_bus_find_mem(s390_bus, mem);
-        virtio_reset(dev->vdev);
-        stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
-        s390_virtio_device_sync(dev);
-        s390_virtio_reset_idx(dev);
-        break;
-    }
-    case KVM_S390_VIRTIO_SET_STATUS:
-    {
-        VirtIOS390Device *dev;
-
-        dev = s390_virtio_bus_find_mem(s390_bus, mem);
+    if (mem > ram_size) {
+        VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus, mem, &i);
         if (dev) {
-            s390_virtio_device_update_status(dev);
+            virtio_queue_notify(dev->vdev, i);
         } else {
             r = -EINVAL;
         }
-        break;
+    } else {
+        /* Early printk */
     }
-    default:
+    return r;
+}
+
+static int s390_virtio_hcall_reset(const uint64_t *args)
+{
+    uint64_t mem = args[0];
+    VirtIOS390Device *dev;
+
+    dev = s390_virtio_bus_find_mem(s390_bus, mem);
+    virtio_reset(dev->vdev);
+    stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
+    s390_virtio_device_sync(dev);
+    s390_virtio_reset_idx(dev);
+
+    return 0;
+}
+
+static int s390_virtio_hcall_set_status(const uint64_t *args)
+{
+    uint64_t mem = args[0];
+    int r = 0;
+    VirtIOS390Device *dev;
+
+    dev = s390_virtio_bus_find_mem(s390_bus, mem);
+    if (dev) {
+        s390_virtio_device_update_status(dev);
+    } else {
         r = -EINVAL;
-        break;
     }
-
     return r;
 }
 
+static void s390_virtio_register_hcalls(void)
+{
+    s390_register_virtio_hypercall(KVM_S390_VIRTIO_NOTIFY,
+                                   s390_virtio_hcall_notify);
+    s390_register_virtio_hypercall(KVM_S390_VIRTIO_RESET,
+                                   s390_virtio_hcall_reset);
+    s390_register_virtio_hypercall(KVM_S390_VIRTIO_SET_STATUS,
+                                   s390_virtio_hcall_set_status);
+}
+
 /*
  * The number of running CPUs. On s390 a shutdown is the state of all CPUs
  * being either stopped or disabled (for interrupts) waiting. We have to
@@ -186,6 +190,9 @@ static void s390_init(QEMUMachineInitArgs *args)
     s390_bus = s390_virtio_bus_init(&my_ram_size);
     s390_sclp_init();
 
+    /* register hypercalls */
+    s390_virtio_register_hcalls();
+
     /* allocate RAM */
     memory_region_init_ram(ram, "s390.ram", my_ram_size);
     vmstate_register_ram_global(ram);
@@ -339,4 +346,3 @@ static void s390_machine_init(void)
 }
 
 machine_init(s390_machine_init);
-
diff --git a/hw/s390-virtio.h b/hw/s390-virtio.h
new file mode 100644
index 0000000..25bb610
--- /dev/null
+++ b/hw/s390-virtio.h
@@ -0,0 +1,22 @@
+/*
+ * Virtio interfaces for s390
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_VIRTIO_H
+#define HW_S390_VIRTIO_H 1
+
+#define KVM_S390_VIRTIO_NOTIFY          0
+#define KVM_S390_VIRTIO_RESET           1
+#define KVM_S390_VIRTIO_SET_STATUS      2
+
+typedef int (*s390_virtio_fn)(const uint64_t *args);
+void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
+
+#endif
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 096dfcd..ae87a12 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y = s390-virtio-bus.o s390-virtio.o
 
 obj-y := $(addprefix ../,$(obj-y))
+obj-y += s390-virtio-hcall.o
 obj-y += sclp.o
 obj-y += event-facility.o
 obj-y += sclpquiesce.o sclpconsole.o
diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
new file mode 100644
index 0000000..d7938c0
--- /dev/null
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -0,0 +1,36 @@
+/*
+ * Support for virtio hypercalls on s390
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "cpu.h"
+#include "hw/s390-virtio.h"
+
+#define MAX_DIAG_SUBCODES 255
+
+static s390_virtio_fn s390_diag500_table[MAX_DIAG_SUBCODES];
+
+void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn)
+{
+    assert(code < MAX_DIAG_SUBCODES);
+    assert(!s390_diag500_table[code]);
+
+    s390_diag500_table[code] = fn;
+}
+
+int s390_virtio_hypercall(CPUS390XState *env)
+{
+    s390_virtio_fn fn = s390_diag500_table[env->regs[1]];
+
+    if (!fn) {
+        return -EINVAL;
+    }
+
+    return fn(&env->regs[2]);
+}
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index bc3fab2..6700fe9 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -302,7 +302,7 @@ int cpu_s390x_handle_mmu_fault (CPUS390XState *env, target_ulong address, int rw
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 
-int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall);
+int s390_virtio_hypercall(CPUS390XState *env);
 
 #ifdef CONFIG_KVM
 void kvm_s390_interrupt(S390CPU *cpu, int type, uint32_t code);
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 6ec5e6d..ae6ae07 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -386,7 +386,7 @@ static int handle_priv(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
 static int handle_hypercall(CPUS390XState *env, struct kvm_run *run)
 {
     cpu_synchronize_state(env);
-    env->regs[2] = s390_virtio_hypercall(env, env->regs[2], env->regs[1]);
+    env->regs[2] = s390_virtio_hypercall(env);
 
     return 0;
 }
diff --git a/target-s390x/misc_helper.c b/target-s390x/misc_helper.c
index 3015bfe..1937e0c 100644
--- a/target-s390x/misc_helper.c
+++ b/target-s390x/misc_helper.c
@@ -107,7 +107,7 @@ uint64_t HELPER(diag)(CPUS390XState *env, uint32_t num, uint64_t mem,
     switch (num) {
     case 0x500:
         /* KVM hypercall */
-        r = s390_virtio_hypercall(env, mem, code);
+        r = s390_virtio_hypercall(env);
         break;
     case 0x44:
         /* yield */
-- 
1.7.12.4
